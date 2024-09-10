

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS088.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS093.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdateVALORES PROCEDURE                                    ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
History::VAL:Record  LIKE(VAL:RECORD),THREAD
QuickWindow          WINDOW('Form VALORES'),AT(,,396,64),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,SYSTEM,DOUBLE,MDI
                       SHEET,AT(7,4,381,37),USE(?CurrentTab),WIZARD
                         TAB('General'),USE(?Tab:1)
                           PROMPT('Tipo:'),AT(14,13),USE(?VAL:Tipo:Prompt),TRN
                           COMBO(@s8),AT(14,23,52,10),USE(VAL:Tipo),DROP(2),FROM('Efectivo|#Efectivo|Cheque|#Cheque')
                           PROMPT('Banco:'),AT(70,13),USE(?VAL:Banco:Prompt),TRN
                           ENTRY(@s25),AT(124,23,100,10),USE(BCO:Denominacion),SKIP,READONLY
                           ENTRY(@s5),AT(70,23,35,10),USE(VAL:Banco),DISABLE,UPR
                           BUTTON,AT(108,22,12,11),USE(?SelectBanco),DISABLE,FLAT,TIP('Seleccionar Banco'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           PROMPT('Número:'),AT(228,13),USE(?VAL:Numero:Prompt),TRN
                           ENTRY(@n10.b),AT(228,23,44,10),USE(VAL:Numero),DISABLE,RIGHT(1)
                           PROMPT('Fecha:'),AT(276,13),USE(?VAL:Fecha:Prompt),TRN
                           ENTRY(@d6b),AT(276,23,50,10),USE(VAL:Fecha),DISABLE,RIGHT(1)
                           PROMPT('Importe:'),AT(330,13),USE(?VAL:Importe:Prompt),TRN
                           ENTRY(@n-13.2),AT(330,23,51,10),USE(VAL:Importe),RIGHT(2),REQ
                         END
                       END
                       BUTTON(' OK'),AT(282,46,51,14),USE(?OK),FLAT,LEFT,FONT(,,,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\ok.gif')
                       BUTTON('Cancelar'),AT(337,46,51,14),USE(?Cancel),FLAT,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\cancel.gif')
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
PrimeFields            PROCEDURE(),PROC,DERIVED            ! Method added to host embed code
Reset                  PROCEDURE(BYTE Force=0),DERIVED     ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(VALORES:Record)
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Agregando'
  OF ChangeRecord
    ActionMessage = 'Modificando'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateVALORES')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?VAL:Tipo:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(VAL:Record,History::VAL:Record)
  SELF.AddHistoryField(?VAL:Tipo,3)
  SELF.AddHistoryField(?VAL:Banco,4)
  SELF.AddHistoryField(?VAL:Numero,5)
  SELF.AddHistoryField(?VAL:Fecha,6)
  SELF.AddHistoryField(?VAL:Importe,7)
  SELF.AddUpdateFile(Access:VALORES)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:VALORES.Open                                      ! File VALORES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:VALORES
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.InsertAction = Insert:Batch
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    DISABLE(?VAL:Tipo)
    ?BCO:Denominacion{PROP:ReadOnly} = True
    ?VAL:Banco{PROP:ReadOnly} = True
    DISABLE(?SelectBanco)
    ?VAL:Numero{PROP:ReadOnly} = True
    ?VAL:Fecha{PROP:ReadOnly} = True
    ?VAL:Importe{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
  EnterByTabManager.ExcludeControl(?Cancel)
  EnterByTabManager.ExcludeControl(?OK)
  EnterByTabManager.Init(False)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:VALORES.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
    VAL:Recibo = FAC:RegFactura
    VAL:Tipo = 'Efectivo'
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  BCO:Codigo = VAL:Banco                                   ! Assign linking field value
  Access:BANCOS.Fetch(BCO:Por_Codigo)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    SelectBANCO
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?OK
      IF VAL:Tipo <> 'Efectivo' AND VAL:Tipo <> 'Cheque' THEN
        SELECT(?VAL:Tipo)
        CYCLE
      .
      IF VAL:Tipo = 'Cheque' AND NOT(VAL:Banco) THEN
        SELECT(?VAL:Banco)
        CYCLE
      .
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?VAL:Banco
      IF VAL:Banco OR ?VAL:Banco{Prop:Req}
        BCO:Codigo = VAL:Banco
        IF Access:BANCOS.TryFetch(BCO:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            VAL:Banco = BCO:Codigo
          ELSE
            SELECT(?VAL:Banco)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?SelectBanco
      ThisWindow.Update
      BCO:Codigo = VAL:Banco
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        VAL:Banco = BCO:Codigo
      END
      ThisWindow.Reset(1)
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  EnhancedFocusManager.TakeEvent()
  IF EnterByTabManager.TakeEvent()
     RETURN(Level:Notify)
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeNewSelection PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all NewSelection events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeNewSelection()
    CASE FIELD()
    OF ?VAL:Tipo
      CASE VAL:Tipo
      OF 'Cheque'
        Enable(?VAL:Banco)
        Enable(?SelectBanco)
        Enable(?VAL:Fecha)
        Enable(?VAL:Numero)
      OF 'Efectivo'
        Disable(?VAL:Banco)
        Disable(?SelectBanco)
        Disable(?VAL:Fecha)
        Disable(?VAL:Numero)
        CLEAR(VAL:Banco)
        CLEAR(BCO:Denominacion)
        CLEAR(VAL:Fecha)
        CLEAR(VAL:Numero)
      END
      DISPLAY
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
  If EVENT() = EVENT:CLOSEWINDOW
  IF Running          !Se você está terminando a instância que está executando
     ThreadNo = 0     !reinicializa a variável ThreadNo
  END
  END
  If EVENT() = EVENT:OPENWINDOW
  IF NOT ThreadNo                      !Se esta é a primeira instância
     ThreadNo = THREAD()               ! salva o número da Thread
     Running = TRUE                    ! e marca que está executando
  ELSE                                 !Senão
     POST(EVENT:GainFocus, , ThreadNo) !dá o foco para a instância que está executando
     RETURN(Level:Fatal)
  END
  END
  If EVENT() = EVENT:GainFocus 
   TARGET{PROP:Active} = TRUE     !Ativa a Thread
   IF TARGET{PROP:Iconize} = TRUE !Se o usuário iconizou a janela
      TARGET{PROP:Iconize} = ''   ! ..restaura
   END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

