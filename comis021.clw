

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS021.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS011.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS012.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS018.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdateDISTRIBUIDORES PROCEDURE                             ! Generated from procedure template - Window

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
History::DIS:Record  LIKE(DIS:RECORD),THREAD
QuickWindow          WINDOW('Update the DISTRIBUIDORES File'),AT(,,280,185),FONT('MS Sans Serif',8,,),CENTER,IMM,SYSTEM,GRAY,DOUBLE,MDI
                       SHEET,AT(7,4,267,156),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('Código:'),AT(18,27),USE(?DIS:CodDistribuidor:Prompt),TRN
                           ENTRY(@n3),AT(71,27,40,10),USE(DIS:CodDistribuidor),SKIP,RIGHT(1),FONT(,,,FONT:bold),COLOR(080FF80H),REQ
                           PROMPT('Nombre:'),AT(18,41),USE(?DIS:Nombre:Prompt),TRN
                           ENTRY(@s35),AT(71,41,144,10),USE(DIS:Nombre),REQ,UPR
                           PROMPT('Dirección:'),AT(18,55),USE(?DIS:Direccion:Prompt),TRN
                           ENTRY(@s30),AT(71,55,124,10),USE(DIS:Direccion),UPR
                           STRING('Localidad:'),AT(18,69),USE(?String1),TRN
                           COMBO(@s30),AT(71,69,103,10),USE(LOC:Localidad),IMM,UPR,FORMAT('120L(2)@s30@'),DROP(5),FROM(Queue:FileDropCombo)
                           PROMPT('C. Postal:'),AT(187,69),USE(?DIS:CodPostal:Prompt),TRN
                           ENTRY(@s8),AT(224,69,40,10),USE(DIS:CodPostal),UPR
                           BUTTON,AT(89,82,12,11),USE(?CallLookup),SKIP,FLAT,TIP('Seleccionar Provincia'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s20),AT(105,83,86,10),USE(PCIA:Denominacion),TRN,FONT(,,0A00000H,)
                           PROMPT('Provincia:'),AT(18,83),USE(?DIS:Provincia:Prompt),TRN
                           ENTRY(@s1),AT(71,83,15,10),USE(DIS:Provincia),CENTER,UPR
                           PROMPT('Teléfono:'),AT(18,97),USE(?DIS:Telefono:Prompt),TRN
                           ENTRY(@s30),AT(71,97,124,10),USE(DIS:Telefono),UPR
                           PROMPT('Email:'),AT(18,111),USE(?DIS:Email:Prompt),TRN
                           ENTRY(@s50),AT(71,111,193,10),USE(DIS:Email)
                           PROMPT('Zona:'),AT(18,125),USE(?DIS:Zona:Prompt),TRN
                           ENTRY(@n3b),AT(71,125,20,10),USE(DIS:Zona),RIGHT(1)
                           BUTTON,AT(94,124,12,11),USE(?CallLookup:2),SKIP,FLAT,TIP('Seleccionar Zona'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s40),AT(110,125,155,10),USE(ZON:Nombre),TRN,FONT(,,0A00000H,)
                           PROMPT('Comisión:'),AT(18,139),USE(?DIS:Comision:Prompt),TRN
                           ENTRY(@n6.2),AT(71,139,31,10),USE(DIS:Comision),RIGHT(1)
                           STRING(' % '),AT(106,139),USE(?String2),TRN
                         END
                       END
                       BUTTON('Grabar'),AT(81,166,55,15),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(144,166,55,15),USE(?Cancel),LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\Cancel1.ico')
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
? DEBUGHOOK(DISTRIBUIDORES:Record)
? DEBUGHOOK(LOCALIDA:Record)
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
    ActionMessage = 'Agregando Distribuidor'
  OF ChangeRecord
    ActionMessage = 'Modificando Distribuidor'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateDISTRIBUIDORES')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?DIS:CodDistribuidor:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(DIS:Record,History::DIS:Record)
  SELF.AddHistoryField(?DIS:CodDistribuidor,1)
  SELF.AddHistoryField(?DIS:Nombre,2)
  SELF.AddHistoryField(?DIS:Direccion,3)
  SELF.AddHistoryField(?DIS:CodPostal,4)
  SELF.AddHistoryField(?DIS:Provincia,6)
  SELF.AddHistoryField(?DIS:Telefono,7)
  SELF.AddHistoryField(?DIS:Email,8)
  SELF.AddHistoryField(?DIS:Zona,9)
  SELF.AddHistoryField(?DIS:Comision,10)
  SELF.AddUpdateFile(Access:DISTRIBUIDORES)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:DISTRIBUIDORES.Open                               ! File DISTRIBUIDORES used by this procedure, so make sure it's RelationManager is open
  Relate:LOCALIDA.Open                                     ! File DISTRIBUIDORES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:DISTRIBUIDORES
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
  FDCB2.AddUpdateField(LOC:Localidad,DIS:Localidad)
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
    Relate:DISTRIBUIDORES.Close
    Relate:LOCALIDA.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  ZON:CodZona = DIS:Zona                                   ! Assign linking field value
  Access:ZONAS.Fetch(ZON:Por_Codigo)
  PCIA:CodProvincia = DIS:Provincia                        ! Assign linking field value
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
      SelectZONAS
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
    OF ?CallLookup
      ThisWindow.Update
      PCIA:CodProvincia = DIS:Provincia
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        DIS:Provincia = PCIA:CodProvincia
      END
      ThisWindow.Reset(1)
    OF ?DIS:Provincia
      IF DIS:Provincia OR ?DIS:Provincia{Prop:Req}
        PCIA:CodProvincia = DIS:Provincia
        IF Access:PROVINCI.TryFetch(PCIA:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            DIS:Provincia = PCIA:CodProvincia
          ELSE
            SELECT(?DIS:Provincia)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?DIS:Zona
      IF DIS:Zona OR ?DIS:Zona{Prop:Req}
        ZON:CodZona = DIS:Zona
        IF Access:ZONAS.TryFetch(ZON:Por_Codigo)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            DIS:Zona = ZON:CodZona
          ELSE
            SELECT(?DIS:Zona)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup:2
      ThisWindow.Update
      ZON:CodZona = DIS:Zona
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        DIS:Zona = ZON:CodZona
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

