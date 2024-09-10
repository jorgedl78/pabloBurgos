

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS013.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS010.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS011.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS012.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS015.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS018.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS032.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdateCLIENTES PROCEDURE                                   ! Generated from procedure template - Window

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
FDCB10::View:FileDropCombo VIEW(LOCALIDA)
                       PROJECT(LOC:Localidad)
                     END
BRW12::View:Browse   VIEW(VISITAS)
                       PROJECT(VIS:Hora)
                       PROJECT(VIS:Cliente)
                       PROJECT(VIS:Dia)
                       JOIN(DIA:Por_Codigo,VIS:Dia)
                         PROJECT(DIA:Descripcion)
                         PROJECT(DIA:Codigo)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
DIA:Descripcion        LIKE(DIA:Descripcion)          !List box control field - type derived from field
VIS:Hora               LIKE(VIS:Hora)                 !List box control field - type derived from field
VIS:Cliente            LIKE(VIS:Cliente)              !Primary key field - type derived from field
VIS:Dia                LIKE(VIS:Dia)                  !Primary key field - type derived from field
DIA:Codigo             LIKE(DIA:Codigo)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
History::CLI:Record  LIKE(CLI:RECORD),THREAD
QuickWindow          WINDOW('Update the CLIENTES File'),AT(,,286,227),FONT('MS Sans Serif',8,,),CENTER,IMM,SYSTEM,GRAY,DOUBLE,MDI
                       PROMPT('Código:'),AT(14,27),USE(?CLI:CodCliente:Prompt),TRN
                       ENTRY(@n6.),AT(70,27,40,10),USE(CLI:CodCliente),SKIP,RIGHT(1),FONT(,,,FONT:bold),COLOR(080FF80H),REQ
                       PROMPT('Nombre:'),AT(14,41),USE(?CLI:Nombre:Prompt),TRN
                       ENTRY(@s40),AT(70,41,164,10),USE(CLI:Nombre),REQ,UPR
                       SHEET,AT(6,4,274,196),USE(?CurrentTab),ABOVE(68)
                         TAB(' &General'),USE(?General)
                           PROMPT('Dirección:'),AT(14,55),USE(?CLI:Direccion:Prompt),TRN
                           ENTRY(@s30),AT(70,55,124,10),USE(CLI:Direccion),UPR
                           PROMPT('Código Postal:'),AT(14,69),USE(?CLI:CodPostal:Prompt),TRN
                           ENTRY(@s8),AT(70,69,40,10),USE(CLI:CodPostal),RIGHT(1),UPR
                           STRING('Localidad:'),AT(14,83),USE(?String4),TRN
                           COMBO(@s30),AT(70,83,108,10),USE(LOC:Localidad),IMM,UPR,FORMAT('120L(2)@s30@'),DROP(5),FROM(Queue:FileDropCombo)
                           PROMPT('Provincia:'),AT(14,97),USE(?CLI:Provincia:Prompt),TRN
                           ENTRY(@s1),AT(70,97,15,10),USE(CLI:Provincia),CENTER,UPR
                           BUTTON,AT(88,96,12,11),USE(?CallLookup),SKIP,FLAT,TIP('Seleccionar Provincia'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s20),AT(105,97,84,10),USE(PCIA:Denominacion),TRN,FONT(,,0A00000H,)
                           PROMPT('Telefono:'),AT(14,111),USE(?CLI:Telefono:Prompt),TRN
                           ENTRY(@s35),AT(70,111,144,10),USE(CLI:Telefono)
                           PROMPT('Email:'),AT(14,125),USE(?CLI:Email:Prompt),TRN
                           ENTRY(@s50),AT(70,125,201,10),USE(CLI:Email)
                           PROMPT('Contacto:'),AT(14,139),USE(?CLI:Contacto:Prompt),TRN
                           ENTRY(@s25),AT(70,139,104,10),USE(CLI:Contacto),UPR
                           PROMPT('Posición IVA:'),AT(14,153),USE(?CLI:PosicionIVA:Prompt)
                           ENTRY(@n3B),AT(70,153,15,10),USE(CLI:PosicionIVA),RIGHT(1)
                           BUTTON,AT(88,152,12,11),USE(?CallLookup:2),SKIP,FLAT,TIP('Seleccionar Categoría de IVA'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s25),AT(105,153,79,10),USE(IVA:Descripcion),TRN,FONT(,,0A00000H,)
                           PROMPT('CUIT:'),AT(191,153),USE(?CLI:CUIT:Prompt),TRN
                           ENTRY(@P##-########-#PB),AT(215,153,56,10),USE(CLI:CUIT),RIGHT(1)
                           PROMPT('Zona:'),AT(14,167),USE(?CLI:Zona:Prompt),TRN
                           ENTRY(@n3B),AT(70,167,15,10),USE(CLI:Zona),RIGHT(1)
                           BUTTON,AT(88,166,12,11),USE(?CallLookup:3),SKIP,FLAT,TIP('Seleccionar Zona'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s40),AT(105,167,165,10),USE(ZON:Nombre),TRN,FONT(,,0A00000H,)
                           PROMPT('Distribuidor:'),AT(14,181),USE(?CLI:Distribuidor:Prompt),TRN
                           ENTRY(@n3B),AT(70,181,15,10),USE(CLI:Distribuidor),RIGHT(1)
                           BUTTON,AT(88,180,12,11),USE(?CallLookup:4),SKIP,FLAT,TIP('Seleccionar Distribuidor'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                           STRING(@s35),AT(105,181,145,10),USE(DIS:Nombre),TRN,FONT(,,0A00000H,)
                         END
                         TAB(' &Visitas'),USE(?Visitas)
                           PANEL,AT(30,67,225,98),USE(?Panel2),BEVEL(-1)
                           LIST,AT(102,76,81,67),USE(?List),IMM,MSG('Browsing Records'),FORMAT('49L(2)|F~Día~L(0)@s9@20R(2)|F~Hora~L@T1b@'),FROM(Queue:Browse)
                           BUTTON('Agregar'),AT(103,145,40,12),USE(?Insert),LEFT
                           BUTTON('Borrar'),AT(143,145,40,12),USE(?Delete),LEFT
                         END
                         TAB(' &Observaciones'),USE(?Observacion)
                           PANEL,AT(30,67,225,98),USE(?Panel1),BEVEL(-1)
                           TEXT,AT(49,83,187,64),USE(CLI:Notas),BOXED
                         END
                       END
                       BUTTON('Grabar'),AT(83,206,55,16),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(147,206,55,16),USE(?Cancel),LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\Cancel1.ico')
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
FDCB10               CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo           !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

BRW12                CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(LOCALIDA:Record)
? DEBUGHOOK(VISITAS:Record)
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
    ActionMessage = 'Agregando CLIENTE'
  OF ChangeRecord
    ActionMessage = 'Modificando CLIENTE'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateCLIENTES')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?CLI:CodCliente:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(CLI:Record,History::CLI:Record)
  SELF.AddHistoryField(?CLI:CodCliente,1)
  SELF.AddHistoryField(?CLI:Nombre,2)
  SELF.AddHistoryField(?CLI:Direccion,3)
  SELF.AddHistoryField(?CLI:CodPostal,4)
  SELF.AddHistoryField(?CLI:Provincia,6)
  SELF.AddHistoryField(?CLI:Telefono,7)
  SELF.AddHistoryField(?CLI:Email,8)
  SELF.AddHistoryField(?CLI:Contacto,9)
  SELF.AddHistoryField(?CLI:PosicionIVA,10)
  SELF.AddHistoryField(?CLI:CUIT,11)
  SELF.AddHistoryField(?CLI:Zona,12)
  SELF.AddHistoryField(?CLI:Distribuidor,13)
  SELF.AddHistoryField(?CLI:Notas,16)
  SELF.AddUpdateFile(Access:CLIENTES)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  Relate:LOCALIDA.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:CLIENTES
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
  BRW12.Init(?List,Queue:Browse.ViewPosition,BRW12::View:Browse,Queue:Browse,Relate:VISITAS,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW12.Q &= Queue:Browse
  BRW12.AddSortOrder(,VIS:Por_Cliente)                     ! Add the sort order for VIS:Por_Cliente for sort order 1
  BRW12.AddRange(VIS:Cliente,Relate:VISITAS,Relate:CLIENTES) ! Add file relationship range limit for sort order 1
  BRW12.AddField(DIA:Descripcion,BRW12.Q.DIA:Descripcion)  ! Field DIA:Descripcion is a hot field or requires assignment from browse
  BRW12.AddField(VIS:Hora,BRW12.Q.VIS:Hora)                ! Field VIS:Hora is a hot field or requires assignment from browse
  BRW12.AddField(VIS:Cliente,BRW12.Q.VIS:Cliente)          ! Field VIS:Cliente is a hot field or requires assignment from browse
  BRW12.AddField(VIS:Dia,BRW12.Q.VIS:Dia)                  ! Field VIS:Dia is a hot field or requires assignment from browse
  BRW12.AddField(DIA:Codigo,BRW12.Q.DIA:Codigo)            ! Field DIA:Codigo is a hot field or requires assignment from browse
  SELF.AddItem(ToolbarForm)
  FDCB10.Init(LOC:Localidad,?LOC:Localidad,Queue:FileDropCombo.ViewPosition,FDCB10::View:FileDropCombo,Queue:FileDropCombo,Relate:LOCALIDA,ThisWindow,GlobalErrors,1,1,0)
  FDCB10.AskProcedure = 5
  FDCB10.Q &= Queue:FileDropCombo
  FDCB10.AddSortOrder(LOC:Por_Localidad)
  FDCB10.AddField(LOC:Localidad,FDCB10.Q.LOC:Localidad)
  FDCB10.AddUpdateField(LOC:Localidad,CLI:Localidad)
  ThisWindow.AddItem(FDCB10.WindowComponent)
  FDCB10.DefaultFill = 0
  BRW12.AskProcedure = 6
  BRW12.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
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
    Relate:CLIENTES.Close
    Relate:LOCALIDA.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  DIS:CodDistribuidor = CLI:Distribuidor                   ! Assign linking field value
  Access:DISTRIBUIDORES.Fetch(DIS:Por_Codigo)
  IVA:CodCatIVA = CLI:PosicionIVA                          ! Assign linking field value
  Access:CATIVA.Fetch(IVA:Por_CodIVA)
  ZON:CodZona = CLI:Zona                                   ! Assign linking field value
  Access:ZONAS.Fetch(ZON:Por_Codigo)
  PCIA:CodProvincia = CLI:Provincia                        ! Assign linking field value
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
      SelectZONAS
      SelectDISTRIBUIDORES
      UpdateLOCALIDAD
      UpdateVISITA_CLI
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
      IF CLI:PosicionIVA <> 5 AND (NOT(CLI:CUIT) OR CLI:CUIT=0) THEN
        BEEP(BEEP:SystemHand)  ;  YIELD()
        MESSAGE('Debe completar el campo CUIT.','CUIT Incompleto !!!',ICON:Hand)
        SELECT(?CLI:CUIT)
        CYCLE
      END
      
      ! VALIDAR CUIT
      IF CLI:PosicionIVA <> 5 THEN
        I# = 1
        CLEAR(loc:SumaCUIT)
        LOOP C# = 10 TO 1 BY -1
          IF I# = 7 THEN I# = 1.
          I# += 1
          loc:SumaCUIT += SUB(CLI:CUIT,C#,1) * I#
        END
        loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
        IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
        IF loc:DigitoVerificador <> SUB(CLI:CUIT,11,1) THEN
          BEEP(BEEP:SystemHand)  ;  YIELD()
          MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
          SELECT(?CLI:CUIT)
          CYCLE
        END
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?CLI:Provincia
      IF CLI:Provincia OR ?CLI:Provincia{Prop:Req}
        PCIA:CodProvincia = CLI:Provincia
        IF Access:PROVINCI.TryFetch(PCIA:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            CLI:Provincia = PCIA:CodProvincia
          ELSE
            SELECT(?CLI:Provincia)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup
      ThisWindow.Update
      PCIA:CodProvincia = CLI:Provincia
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        CLI:Provincia = PCIA:CodProvincia
      END
      ThisWindow.Reset(1)
    OF ?CLI:PosicionIVA
      IF CLI:PosicionIVA OR ?CLI:PosicionIVA{Prop:Req}
        IVA:CodCatIVA = CLI:PosicionIVA
        IF Access:CATIVA.TryFetch(IVA:Por_CodIVA)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            CLI:PosicionIVA = IVA:CodCatIVA
          ELSE
            SELECT(?CLI:PosicionIVA)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup:2
      ThisWindow.Update
      IVA:CodCatIVA = CLI:PosicionIVA
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        CLI:PosicionIVA = IVA:CodCatIVA
      END
      ThisWindow.Reset(1)
    OF ?CLI:Zona
      IF CLI:Zona OR ?CLI:Zona{Prop:Req}
        ZON:CodZona = CLI:Zona
        IF Access:ZONAS.TryFetch(ZON:Por_Codigo)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            CLI:Zona = ZON:CodZona
          ELSE
            SELECT(?CLI:Zona)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup:3
      ThisWindow.Update
      ZON:CodZona = CLI:Zona
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        CLI:Zona = ZON:CodZona
      END
      ThisWindow.Reset(1)
    OF ?CLI:Distribuidor
      IF CLI:Distribuidor OR ?CLI:Distribuidor{Prop:Req}
        DIS:CodDistribuidor = CLI:Distribuidor
        IF Access:DISTRIBUIDORES.TryFetch(DIS:Por_Codigo)
          IF SELF.Run(4,SelectRecord) = RequestCompleted
            CLI:Distribuidor = DIS:CodDistribuidor
          ELSE
            SELECT(?CLI:Distribuidor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup:4
      ThisWindow.Update
      DIS:CodDistribuidor = CLI:Distribuidor
      IF SELF.Run(4,SelectRecord) = RequestCompleted
        CLI:Distribuidor = DIS:CodDistribuidor
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


FDCB10.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue


BRW12.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW12.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.DeleteControl=?Delete
  END

