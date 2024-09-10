

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS019.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS010.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS011.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS018.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdateTRANSPOR PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?LOC:Localidad
LOC:Localidad          LIKE(LOC:Localidad)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
FDCB2::View:FileDropCombo VIEW(LOCALIDA)
                       PROJECT(LOC:Localidad)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
History::TRA:Record  LIKE(TRA:RECORD),THREAD
QuickWindow          WINDOW('Update the TRANSPOR File'),AT(,,282,201),FONT('MS Sans Serif',8,,),CENTER,IMM,SYSTEM,GRAY,DOUBLE,MDI
                       SHEET,AT(6,4,269,171),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('Código:'),AT(16,28),USE(?TRA:CodTransporte:Prompt),TRN
                           ENTRY(@n3),AT(70,28,29,10),USE(TRA:CodTransporte),SKIP,RIGHT(1),FONT(,,,FONT:bold),COLOR(080FF80H),REQ
                           PROMPT('Nombre:'),AT(16,42),USE(?TRA:Denominacion:Prompt),TRN
                           ENTRY(@s30),AT(70,42,124,10),USE(TRA:Denominacion),REQ,UPR
                           PROMPT('Dirección:'),AT(16,56),USE(?TRA:Direccion:Prompt),TRN
                           ENTRY(@s30),AT(70,56,124,10),USE(TRA:Direccion)
                           STRING('Localidad:'),AT(16,70),USE(?String1),TRN
                           COMBO(@s30),AT(70,70,102,10),USE(LOC:Localidad),IMM,UPR,FORMAT('120L(2)@s30@'),DROP(5),FROM(Queue:FileDropCombo)
                           PROMPT('C. Postal:'),AT(186,70),USE(?TRA:CodPostal:Prompt),TRN
                           ENTRY(@s8),AT(224,70,40,10),USE(TRA:CodPostal),UPR
                           PROMPT('Provincia:'),AT(16,84),USE(?TRA:Provincia:Prompt),TRN
                           ENTRY(@s1),AT(70,84,13,10),USE(TRA:Provincia),CENTER,UPR
                           BUTTON,AT(86,83,12,11),USE(?CallLookup),SKIP,FLAT,TIP('Seleccionar Provincia'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s20),AT(103,84,85,10),USE(PCIA:Denominacion),TRN,FONT(,,0A00000H,)
                           PROMPT('Teléfono:'),AT(16,98),USE(?TRA:Telefono:Prompt),TRN
                           ENTRY(@s35),AT(70,98,144,10),USE(TRA:Telefono)
                           PROMPT('Contacto:'),AT(16,112),USE(?TRA:Contacto:Prompt),TRN
                           ENTRY(@s25),AT(70,112,124,10),USE(TRA:Contacto),UPR
                           PROMPT('Email:'),AT(16,126),USE(?TRA:Email:Prompt)
                           ENTRY(@s50),AT(70,126,194,10),USE(TRA:Email)
                           PROMPT('Posición IVA:'),AT(16,141),USE(?TRA:CatIVA:Prompt),TRN
                           ENTRY(@n3b),AT(70,141,19,10),USE(TRA:CatIVA),RIGHT(1)
                           BUTTON,AT(92,140,12,11),USE(?CallLookup:2),SKIP,FLAT,TIP('Seleccionar Categoría de IVA'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s25),AT(110,141,105,10),USE(IVA:Descripcion),TRN,FONT(,,0A00000H,)
                           PROMPT('C.U.I.T.:'),AT(16,155),USE(?TRA:CUIT:Prompt),TRN
                           ENTRY(@P##-########-#Pb),AT(70,155,56,10),USE(TRA:CUIT),RIGHT(1)
                         END
                       END
                       BUTTON('Grabar'),AT(82,181,55,15),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(144,181,55,15),USE(?Cancel),LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\Cancel1.ico')
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Reset                  PROCEDURE(BYTE Force=0),DERIVED     ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
FDCB2                CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo           !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(LOCALIDA:Record)
? DEBUGHOOK(TRANSPOR:Record)
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
    ActionMessage = 'Agregando Transporte'
  OF ChangeRecord
    ActionMessage = 'Modificando Transporte'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateTRANSPOR')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?TRA:CodTransporte:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(TRA:Record,History::TRA:Record)
  SELF.AddHistoryField(?TRA:CodTransporte,1)
  SELF.AddHistoryField(?TRA:Denominacion,2)
  SELF.AddHistoryField(?TRA:Direccion,3)
  SELF.AddHistoryField(?TRA:CodPostal,4)
  SELF.AddHistoryField(?TRA:Provincia,6)
  SELF.AddHistoryField(?TRA:Telefono,7)
  SELF.AddHistoryField(?TRA:Contacto,9)
  SELF.AddHistoryField(?TRA:Email,8)
  SELF.AddHistoryField(?TRA:CatIVA,10)
  SELF.AddHistoryField(?TRA:CUIT,11)
  SELF.AddUpdateFile(Access:TRANSPOR)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:LOCALIDA.Open                                     ! File TRANSPOR used by this procedure, so make sure it's RelationManager is open
  Relate:TRANSPOR.SetOpenRelated()
  Relate:TRANSPOR.Open                                     ! File TRANSPOR used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:TRANSPOR
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
  SELF.AddItem(ToolbarForm)
  FDCB2.Init(LOC:Localidad,?LOC:Localidad,Queue:FileDropCombo.ViewPosition,FDCB2::View:FileDropCombo,Queue:FileDropCombo,Relate:LOCALIDA,ThisWindow,GlobalErrors,1,1,0)
  FDCB2.AskProcedure = 3
  FDCB2.Q &= Queue:FileDropCombo
  FDCB2.AddSortOrder(LOC:Por_Localidad)
  FDCB2.AddField(LOC:Localidad,FDCB2.Q.LOC:Localidad)
  FDCB2.AddUpdateField(LOC:Localidad,TRA:Localidad)
  ThisWindow.AddItem(FDCB2.WindowComponent)
  FDCB2.DefaultFill = 0
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
    Relate:TRANSPOR.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  IVA:CodCatIVA = TRA:CatIVA                               ! Assign linking field value
  Access:CATIVA.Fetch(IVA:Por_CodIVA)
  PCIA:CodProvincia = TRA:Provincia                        ! Assign linking field value
  Access:PROVINCI.Fetch(PCIA:Por_Codigo)
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
    EXECUTE Number
      SelectPROVINCIA
      SelectCATIVA
      UpdateLOCALIDAD
    END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?TRA:Provincia
      IF TRA:Provincia OR ?TRA:Provincia{Prop:Req}
        PCIA:CodProvincia = TRA:Provincia
        IF Access:PROVINCI.TryFetch(PCIA:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            TRA:Provincia = PCIA:CodProvincia
          ELSE
            SELECT(?TRA:Provincia)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup
      ThisWindow.Update
      PCIA:CodProvincia = TRA:Provincia
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        TRA:Provincia = PCIA:CodProvincia
      END
      ThisWindow.Reset(1)
    OF ?TRA:CatIVA
      IF TRA:CatIVA OR ?TRA:CatIVA{Prop:Req}
        IVA:CodCatIVA = TRA:CatIVA
        IF Access:CATIVA.TryFetch(IVA:Por_CodIVA)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            TRA:CatIVA = IVA:CodCatIVA
          ELSE
            SELECT(?TRA:CatIVA)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup:2
      ThisWindow.Update
      IVA:CodCatIVA = TRA:CatIVA
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        TRA:CatIVA = IVA:CodCatIVA
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


FDCB2.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue

