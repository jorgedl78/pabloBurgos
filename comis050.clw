

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS050.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS010.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS011.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS018.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdatePROVEEDORES PROCEDURE                                ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
loc:SumaCUIT         DECIMAL(7,2)                          !
loc:DigitoVerificador BYTE                                 !
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
History::PROV:Record LIKE(PROV:RECORD),THREAD
QuickWindow          WINDOW('Update the PROVEEDORES File'),AT(,,282,193),FONT('MS Sans Serif',8,,),CENTER,IMM,SYSTEM,GRAY,DOUBLE
                       PROMPT('Código:'),AT(16,27),USE(?PROV:CodProveedor:Prompt),TRN
                       ENTRY(@n4),AT(68,27,40,10),USE(PROV:CodProveedor),SKIP,RIGHT(1),FONT(,,,FONT:bold),COLOR(080FF80H),REQ
                       PROMPT('Nombre:'),AT(16,40),USE(?PROV:Nombre:Prompt),TRN
                       ENTRY(@s40),AT(68,40,164,10),USE(PROV:Nombre),REQ,UPR
                       SHEET,AT(8,4,266,163),USE(?CurrentTab),ABOVE(68)
                         TAB('&General'),USE(?Tab:1)
                           PROMPT('Dirección:'),AT(16,53),USE(?PROV:Direccion:Prompt),TRN
                           ENTRY(@s30),AT(68,53,124,10),USE(PROV:Direccion),UPR
                           PROMPT('Código Postal:'),AT(16,66),USE(?PROV:CodPostal:Prompt),TRN
                           ENTRY(@s8),AT(68,66,40,10),USE(PROV:CodPostal),UPR
                           STRING('Localidad:'),AT(16,79),USE(?String1),TRN
                           COMBO(@s30),AT(68,79,105,10),USE(LOC:Localidad),IMM,UPR,FORMAT('120L(2)@s30@'),DROP(5),FROM(Queue:FileDropCombo)
                           PROMPT('Provincia:'),AT(16,92),USE(?PROV:Provincia:Prompt),TRN
                           ENTRY(@s1),AT(68,92,15,10),USE(PROV:Provincia),CENTER,UPR
                           BUTTON,AT(87,92,12,11),USE(?CallLookup),SKIP,FLAT,TIP('Seleccionar Provincia'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s20),AT(103,92,85,10),USE(PCIA:Denominacion),TRN,FONT(,,0A00000H,)
                           PROMPT('Teléfono:'),AT(16,105),USE(?PROV:Telefono:Prompt),TRN
                           ENTRY(@s35),AT(68,105,144,10),USE(PROV:Telefono),UPR
                           PROMPT('Email:'),AT(16,118),USE(?PROV:Email:Prompt),TRN
                           ENTRY(@s50),AT(68,118,197,10),USE(PROV:Email)
                           PROMPT('Contacto:'),AT(16,131),USE(?PROV:Contacto:Prompt),TRN
                           ENTRY(@s30),AT(68,131,124,10),USE(PROV:Contacto)
                           PROMPT('Posición IVA:'),AT(16,144),USE(?PROV:PosicionIVA:Prompt),TRN
                           ENTRY(@n3b),AT(68,144,15,10),USE(PROV:PosicionIVA),RIGHT(1)
                           BUTTON,AT(87,144,12,11),USE(?CallLookup:2),SKIP,FLAT,TIP('Seleccionar Categoría de IVA'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s25),AT(103,144,81,10),USE(IVA:Descripcion),TRN,FONT(,,0A00000H,)
                           PROMPT('CUIT:'),AT(187,144),USE(?PROV:CUIT:Prompt),TRN
                           ENTRY(@P##-########-#Pb),AT(209,144,56,10),USE(PROV:CUIT),RIGHT(1)
                         END
                         TAB('&Observaciones'),USE(?Tab:3)
                           TEXT,AT(57,77,168,56),USE(PROV:Notas),BOXED
                           PANEL,AT(33,64,215,82),USE(?Panel1),BEVEL(-1)
                         END
                       END
                       BUTTON('Grabar'),AT(82,173,55,16),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(144,173,55,16),USE(?Cancel),LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\Cancel1.ico')
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
? DEBUGHOOK(PROVEEDORES:Record)
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
    ActionMessage = 'Agregando PROVEEDOR'
  OF ChangeRecord
    ActionMessage = 'Modificando PROVEEDOR'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdatePROVEEDORES')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PROV:CodProveedor:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(PROV:Record,History::PROV:Record)
  SELF.AddHistoryField(?PROV:CodProveedor,1)
  SELF.AddHistoryField(?PROV:Nombre,3)
  SELF.AddHistoryField(?PROV:Direccion,5)
  SELF.AddHistoryField(?PROV:CodPostal,7)
  SELF.AddHistoryField(?PROV:Provincia,8)
  SELF.AddHistoryField(?PROV:Telefono,9)
  SELF.AddHistoryField(?PROV:Email,10)
  SELF.AddHistoryField(?PROV:Contacto,11)
  SELF.AddHistoryField(?PROV:PosicionIVA,12)
  SELF.AddHistoryField(?PROV:CUIT,13)
  SELF.AddHistoryField(?PROV:Notas,15)
  SELF.AddUpdateFile(Access:PROVEEDORES)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:LOCALIDA.Open                                     ! File PROVEEDORES used by this procedure, so make sure it's RelationManager is open
  Relate:PROVEEDORES.Open                                  ! File PROVEEDORES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:PROVEEDORES
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
  FDCB2.AddUpdateField(LOC:Localidad,PROV:Localidad)
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
    Relate:PROVEEDORES.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  IVA:CodCatIVA = PROV:PosicionIVA                         ! Assign linking field value
  Access:CATIVA.Fetch(IVA:Por_CodIVA)
  PCIA:CodProvincia = PROV:Provincia                       ! Assign linking field value
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
    CASE ACCEPTED()
    OF ?OK
      IF PROV:PosicionIVA <> 5 AND (NOT(PROV:CUIT) OR PROV:CUIT=0) THEN
        BEEP(BEEP:SystemHand)  ;  YIELD()
        MESSAGE('Debe completar el campo CUIT.','CUIT Incompleto !!!',ICON:Hand)
        SELECT(?PROV:CUIT)
        CYCLE
      END
      
      ! VALIDAR CUIT
      IF PROV:PosicionIVA <> 5 THEN
        I# = 1
        CLEAR(loc:SumaCUIT)
        LOOP C# = 10 TO 1 BY -1
          IF I# = 7 THEN I# = 1.
          I# += 1
          loc:SumaCUIT += SUB(PROV:CUIT,C#,1) * I#
        END
        loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
        IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
        IF loc:DigitoVerificador <> SUB(PROV:CUIT,11,1) THEN
          BEEP(BEEP:SystemHand)  ;  YIELD()
          MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
          SELECT(?PROV:CUIT)
          CYCLE
        END
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?PROV:Provincia
      IF PROV:Provincia OR ?PROV:Provincia{Prop:Req}
        PCIA:CodProvincia = PROV:Provincia
        IF Access:PROVINCI.TryFetch(PCIA:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            PROV:Provincia = PCIA:CodProvincia
          ELSE
            SELECT(?PROV:Provincia)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup
      ThisWindow.Update
      PCIA:CodProvincia = PROV:Provincia
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        PROV:Provincia = PCIA:CodProvincia
      END
      ThisWindow.Reset(1)
    OF ?PROV:PosicionIVA
      IF PROV:PosicionIVA OR ?PROV:PosicionIVA{Prop:Req}
        IVA:CodCatIVA = PROV:PosicionIVA
        IF Access:CATIVA.TryFetch(IVA:Por_CodIVA)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            PROV:PosicionIVA = IVA:CodCatIVA
          ELSE
            SELECT(?PROV:PosicionIVA)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup:2
      ThisWindow.Update
      IVA:CodCatIVA = PROV:PosicionIVA
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        PROV:PosicionIVA = IVA:CodCatIVA
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

