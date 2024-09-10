

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS112.INC'),ONCE        !Local module procedure declarations
                     END


UpdateTRANS_DESTINOS PROCEDURE                             ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
Queue:FileDropCombo:1 QUEUE                           !Queue declaration for browse/combo box using ?LOC:Localidad
LOC:Localidad          LIKE(LOC:Localidad)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
FDCB7::View:FileDropCombo VIEW(LOCALIDA)
                       PROJECT(LOC:Localidad)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
History::TRL:Record  LIKE(TRL:RECORD),THREAD
QuickWindow          WINDOW('Form TRANSLOC'),AT(,,241,132),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,SYSTEM,GRAY,DOUBLE
                       SHEET,AT(7,7,227,102),USE(?CurrentTab),WIZARD
                         TAB('&General'),USE(?Tab:1)
                           STRING('Localidad:'),AT(19,22),USE(?String2),TRN
                           COMBO(@s20),AT(64,22,132,10),USE(LOC:Localidad),IMM,REQ,UPR,FORMAT('120L(2)|@s30@'),DROP(5),FROM(Queue:FileDropCombo:1)
                           STRING('Días:'),AT(35,45),USE(?String3)
                           CHECK('L'),AT(64,45),USE(TRL:Lunes),VALUE('X','')
                           CHECK('M'),AT(87,45),USE(TRL:Martes),VALUE('X','')
                           CHECK('M'),AT(112,45),USE(TRL:Miercoles),VALUE('X','')
                           CHECK('J'),AT(137,45),USE(TRL:Jueves),VALUE('X','')
                           CHECK('V'),AT(159,45),USE(TRL:Viernes),VALUE('X','')
                           CHECK('S'),AT(183,45),USE(TRL:Sabado),VALUE('X','')
                           CHECK('D'),AT(207,45),USE(TRL:Domingo),VALUE('X','')
                           PROMPT('Observación:'),AT(16,64),USE(?TRL:Observacion:Prompt),TRN
                           TEXT,AT(15,73,211,28),USE(TRL:Observacion),SKIP,FONT(,,0A00000H,,CHARSET:ANSI),COLOR(0E0EFEFH)
                         END
                       END
                       BUTTON(' OK'),AT(66,114,52,15),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\1L\Comisiones\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(122,114,52,15),USE(?Cancel),LEFT,ICON('C:\1L\Comisiones\botones\Cancel1.ico')
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
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

FDCB7                CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo:1         !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(LOCALIDA:Record)
? DEBUGHOOK(TRANSLOC:Record)
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
    ActionMessage = 'Vista de Ficha'
  OF InsertRecord
    ActionMessage = 'Agregando Destino'
  OF ChangeRecord
    ActionMessage = 'Modificando Destino'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateTRANS_DESTINOS')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String2
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(TRL:Record,History::TRL:Record)
  SELF.AddHistoryField(?TRL:Lunes,3)
  SELF.AddHistoryField(?TRL:Martes,4)
  SELF.AddHistoryField(?TRL:Miercoles,5)
  SELF.AddHistoryField(?TRL:Jueves,6)
  SELF.AddHistoryField(?TRL:Viernes,7)
  SELF.AddHistoryField(?TRL:Sabado,8)
  SELF.AddHistoryField(?TRL:Domingo,9)
  SELF.AddHistoryField(?TRL:Observacion,10)
  SELF.AddUpdateFile(Access:TRANSLOC)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:LOCALIDA.Open                                     ! File LOCALIDA used by this procedure, so make sure it's RelationManager is open
  Relate:TRANSLOC.SetOpenRelated()
  Relate:TRANSLOC.Open                                     ! File LOCALIDA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:TRANSLOC
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    DISABLE(?LOC:Localidad)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  FDCB7.Init(LOC:Localidad,?LOC:Localidad,Queue:FileDropCombo:1.ViewPosition,FDCB7::View:FileDropCombo,Queue:FileDropCombo:1,Relate:LOCALIDA,ThisWindow,GlobalErrors,0,1,0)
  FDCB7.Q &= Queue:FileDropCombo:1
  FDCB7.AddSortOrder()
  FDCB7.AddField(LOC:Localidad,FDCB7.Q.LOC:Localidad)
  FDCB7.AddUpdateField(LOC:Localidad,TRL:Localidad)
  ThisWindow.AddItem(FDCB7.WindowComponent)
  FDCB7.DefaultFill = 0
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
    Relate:LOCALIDA.Close
    Relate:TRANSLOC.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
    TRL:Transporte = TRA:CodTransporte
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  TRA:CodTransporte = TRL:Transporte                       ! Assign linking field value
  Access:TRANSPOR.Fetch(TRA:Por_Codigo)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
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


FDCB7.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue

