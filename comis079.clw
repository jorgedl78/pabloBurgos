

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS079.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS014.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS015.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS018.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS030.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS036.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS045.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS046.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS105.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdateGUIAS3 PROCEDURE                                     ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
loc:RteEsCliente     STRING(1)                             !
loc:DesEsCliente     STRING(1)                             !
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?LOC:Localidad
LOC:Localidad          LIKE(LOC:Localidad)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDropCombo:1 QUEUE                           !Queue declaration for browse/combo box using ?LOC2:Localidad
LOC2:Localidad         LIKE(LOC2:Localidad)           !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW11::View:Browse   VIEW(ITEMGUIA)
                       PROJECT(ITGUIA:Cantidad)
                       PROJECT(ITGUIA:Descripcion)
                       PROJECT(ITGUIA:Aforo)
                       PROJECT(ITGUIA:RegGuia)
                       PROJECT(ITGUIA:Item)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ITGUIA:Cantidad        LIKE(ITGUIA:Cantidad)          !List box control field - type derived from field
ITGUIA:Descripcion     LIKE(ITGUIA:Descripcion)       !List box control field - type derived from field
ITGUIA:Aforo           LIKE(ITGUIA:Aforo)             !List box control field - type derived from field
ITGUIA:RegGuia         LIKE(ITGUIA:RegGuia)           !Primary key field - type derived from field
ITGUIA:Item            LIKE(ITGUIA:Item)              !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
FDCB7::View:FileDropCombo VIEW(LOCALIDA)
                       PROJECT(LOC:Localidad)
                     END
FDCB15::View:FileDropCombo VIEW(LOCALIDAD2)
                       PROJECT(LOC2:Localidad)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
History::GUIA:Record LIKE(GUIA:RECORD),THREAD
QuickWindow          WINDOW('Update the GUIAS File'),AT(,,374,254),FONT('MS Sans Serif',8,COLOR:Black,),COLOR(0BFDFDFH),CENTER,IMM,GRAY,DOUBLE,MDI
                       STRING('REMITO-GUIA'),AT(7,0),USE(?String1),TRN,FONT('Arial',10,COLOR:Green,FONT:bold)
                       STRING('Facturar a:'),AT(93,1),USE(?String9),TRN,FONT(,,COLOR:Black,FONT:bold)
                       OPTION,AT(137,-1,117,13),USE(GUIA:FacturarA),TRN
                         RADIO('Remitente'),AT(145,1),USE(?GUIA:FacturarA:Radio1),TRN,VALUE('R')
                         RADIO('Destinatario'),AT(199,1),USE(?GUIA:FacturarA:Radio2),TRN,VALUE('D')
                       END
                       STRING('Trans PABLO'),AT(303,1,61,10),USE(?String8),FONT(,,COLOR:Black,FONT:bold+FONT:italic)
                       PANEL,AT(-7,11,381,18),USE(?Panel1),FILL(COLOR:Green),BEVEL(-1)
                       STRING('NUMERO:'),AT(7,15),USE(?String6),TRN,FONT(,,COLOR:White,FONT:bold)
                       ENTRY(@s1),AT(55,15,11,10),USE(GUIA:Letra),SKIP,TRN,FONT(,,COLOR:White,FONT:bold),REQ,UPR,READONLY
                       ENTRY(@n04),AT(71,15,23,10),USE(GUIA:Lugar),SKIP,TRN,RIGHT(1),FONT(,,COLOR:White,FONT:bold),REQ,READONLY
                       ENTRY(@n08),AT(99,15,42,10),USE(GUIA:Numero),SKIP,TRN,RIGHT(1),FONT(,,COLOR:White,FONT:bold),REQ
                       PROMPT('FECHA:'),AT(276,15),USE(?GUIA:Fecha:Prompt),TRN,FONT(,,COLOR:White,FONT:bold)
                       ENTRY(@d6B),AT(313,14,51,10),USE(GUIA:Fecha),SKIP,RIGHT(1),COLOR(0F5F5F5H),REQ
                       PROMPT('Remitente:'),AT(12,32),USE(?GUIA:Cliente:Prompt),TRN,FONT(,,COLOR:Black,FONT:bold)
                       CHECK('Es Cliente ?'),AT(56,32),USE(loc:RteEsCliente),TRN,LEFT,VALUE('S','N')
                       ENTRY(@n6.b),AT(130,32,35,10),USE(GUIA:Remitente),SKIP,DISABLE,RIGHT(1),COLOR(0F5F5F5H)
                       BUTTON,AT(115,31,12,11),USE(?SelectRemitente),DISABLE,FLAT,TIP('Seleccionar Remitente'),ICON('C:\1L\Comisiones\botones\lookup.ico')
                       BOX,AT(10,44,173,58),USE(?Box1),ROUND,COLOR(COLOR:Black)
                       PROMPT('Nombre:'),AT(15,48),USE(?GUIA:NombreRemitente:Prompt),TRN
                       ENTRY(@s40),AT(52,48,125,10),USE(GUIA:NombreRemitente),COLOR(0F5F5F5H),UPR
                       PROMPT('Dirección:'),AT(15,61),USE(?GUIA:DireccionRemitente:Prompt),TRN
                       ENTRY(@s30),AT(52,61,125,10),USE(GUIA:DireccionRemitente),COLOR(0F5F5F5H),UPR
                       STRING('Localidad:'),AT(15,74),USE(?String3:2),TRN
                       COMBO(@s30),AT(52,74,125,10),USE(LOC:Localidad),IMM,COLOR(0F5F5F5H),UPR,FORMAT('120L(2)@s30@'),DROP(5),FROM(Queue:FileDropCombo)
                       PROMPT('Teléfono:'),AT(15,87),USE(?GUIA:TelefonoRemitente:Prompt),TRN
                       ENTRY(@s35),AT(52,87,125,10),USE(GUIA:TelefonoRemitente),COLOR(0F5F5F5H),UPR
                       STRING('Destinatario:'),AT(194,32),USE(?String4:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                       CHECK('Es Cliente ?'),AT(245,32),USE(loc:DesEsCliente),TRN,LEFT,VALUE('S','N')
                       BUTTON,AT(304,31,12,11),USE(?SelectDestinatario),DISABLE,FLAT,TIP('Seleccionar Destinatario'),ICON('C:\1L\Comisiones\botones\lookup.ico')
                       ENTRY(@n6.b),AT(319,32,35,10),USE(GUIA:Destinatario),SKIP,DISABLE,RIGHT(1),COLOR(0F5F5F5H)
                       BOX,AT(193,44,173,58),USE(?Box1:2),ROUND,COLOR(COLOR:Black)
                       PROMPT('Nombre:'),AT(198,48),USE(?GUIA:NombreDestino:Prompt),TRN
                       ENTRY(@s40),AT(236,48,125,10),USE(GUIA:NombreDestino),COLOR(0F5F5F5H),UPR
                       PROMPT('Dirección:'),AT(198,61),USE(?GUIA:DireccionDestino:Prompt),TRN
                       ENTRY(@s30),AT(236,61,125,10),USE(GUIA:DireccionDestino),COLOR(0F5F5F5H),UPR
                       STRING('Localidad:'),AT(198,74),USE(?String3),TRN
                       COMBO(@s30),AT(236,74,125,10),USE(LOC2:Localidad),IMM,COLOR(0F5F5F5H),UPR,FORMAT('120L(2)@s30@'),DROP(5),FROM(Queue:FileDropCombo:1)
                       PROMPT('Teléfono:'),AT(198,87),USE(?GUIA:TelefonoDestino:Prompt),TRN
                       ENTRY(@s35),AT(236,87,125,10),USE(GUIA:TelefonoDestino),COLOR(0F5F5F5H),UPR
                       PROMPT('Distribuidor:'),AT(12,112),USE(?GUIA:Distribuidor:Prompt),TRN
                       ENTRY(@n3b),AT(59,112,19,10),USE(GUIA:Distribuidor),RIGHT(1),COLOR(0F5F5F5H)
                       BUTTON,AT(81,112,12,11),USE(?SelecDistribuidor),SKIP,FLAT,TIP('Seleccionar Distribuidor'),ICON('C:\1L\Comisiones\botones\lookup.ico')
                       STRING(@s35),AT(96,112,135,10),USE(DIS:Nombre),TRN,FONT(,,0A00000H,)
                       PROMPT('Redespacho:'),AT(12,129),USE(?GUIA:Redespacho:Prompt),TRN
                       ENTRY(@n3b),AT(59,129,19,10),USE(GUIA:Redespacho),RIGHT(1),COLOR(0F5F5F5H)
                       BUTTON,AT(81,129,12,11),USE(?SelecTransporte),SKIP,FLAT,TIP('Seleccionar Transporte'),KEY(F3Key),ICON('C:\1L\Comisiones\botones\lookup.ico')
                       STRING(@s30),AT(96,129,125,10),USE(TRA:Denominacion),TRN,FONT(,,0A00000H,)
                       PROMPT('Contra Reembolso:'),AT(237,106),USE(?GUIA:ContraReembolso:Prompt),TRN
                       ENTRY(@n10.2),AT(237,115,60,10),USE(GUIA:ContraReembolso),RIGHT(1),COLOR(0F5F5F5H)
                       PROMPT('Remito Cliente:'),AT(237,129),USE(?GUIA:RemitoCliente:Prompt),TRN
                       ENTRY(@s10),AT(237,138,60,10),USE(GUIA:RemitoCliente),RIGHT(1),COLOR(0F5F5F5H)
                       PROMPT('Observación:'),AT(12,144),USE(?GUIA:Observacion:Prompt),TRN,FONT(,,COLOR:Black,FONT:bold)
                       OPTION('Flete'),AT(305,105,58,44),USE(GUIA:Flete),BOXED
                         RADIO('Origen'),AT(313,116),USE(?GUIA:Flete:Radio1),TRN,VALUE('R')
                         RADIO('Intermedio'),AT(313,126),USE(?GUIA:Flete:Radio2),TRN,VALUE('I')
                         RADIO('Destino'),AT(313,137),USE(?GUIA:Flete:Radio3),TRN,VALUE('D')
                       END
                       TEXT,AT(10,154,353,26),USE(GUIA:Observacion),SKIP,BOXED,VSCROLL,FONT(,,COLOR:Red,FONT:bold),COLOR(COLOR:Silver),UPR
                       PANEL,AT(10,184,353,51),USE(?Panel2)
                       BUTTON('Agregar'),AT(20,188,13,12),USE(?Insert),FLAT,LEFT,TIP('Agregar Item'),ICON('C:\1L\Comisiones\botones\Insert.ico')
                       BUTTON('Modificar'),AT(20,203,13,12),USE(?Change),SKIP,FLAT,LEFT,TIP('Modificar Item'),ICON('C:\1L\Comisiones\botones\Edit.ico')
                       BUTTON('Borrar'),AT(20,218,13,12),USE(?Delete),SKIP,FLAT,LEFT,TIP('Borrar Item'),ICON('C:\1L\Comisiones\botones\Delete.ico')
                       LIST,AT(37,187,239,43),USE(?List),IMM,NOBAR,COLOR(0F1F1F1H),FORMAT('34R(4)|F~Cantidad~C(0)@n7.@161L(2)|FM~Descripción~@s40@40R(3)|FM~Aforo~L(2)@n10.' &|
   '2@'),FROM(Queue:Browse)
                       PROMPT('Valor Declarado:'),AT(295,188),USE(?GUIA:ValorDeclarado:Prompt),TRN
                       ENTRY(@n9.2),AT(295,198,53,10),USE(GUIA:ValorDeclarado),RIGHT(2),COLOR(0F5F5F5H)
                       PROMPT('Importe:'),AT(295,211),USE(?GUIA:Importe:Prompt),TRN
                       ENTRY(@n12.2),AT(295,220,53,10),USE(GUIA:Importe),RIGHT(2),COLOR(0F5F5F5H)
                       BUTTON(' OK'),AT(127,238,55,15),USE(?OK),LEFT,FONT(,,COLOR:Black,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(191,238,55,15),USE(?Cancel),LEFT,KEY(EscKey),ICON('C:\Comisiones\ComisionesSRL\botones\Cancel1.ico')
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
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
FDCB7                CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo           !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

FDCB15               CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo:1         !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(GUIAS:Record)
? DEBUGHOOK(ITEMGUIA:Record)
? DEBUGHOOK(LOCALIDA:Record)
? DEBUGHOOK(LOCALIDAD2:Record)
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
  GlobalErrors.SetProcedureName('UpdateGUIAS3')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(GUIA:Record,History::GUIA:Record)
  SELF.AddHistoryField(?GUIA:FacturarA,7)
  SELF.AddHistoryField(?GUIA:Letra,4)
  SELF.AddHistoryField(?GUIA:Lugar,5)
  SELF.AddHistoryField(?GUIA:Numero,6)
  SELF.AddHistoryField(?GUIA:Fecha,2)
  SELF.AddHistoryField(?GUIA:Remitente,9)
  SELF.AddHistoryField(?GUIA:NombreRemitente,10)
  SELF.AddHistoryField(?GUIA:DireccionRemitente,11)
  SELF.AddHistoryField(?GUIA:TelefonoRemitente,13)
  SELF.AddHistoryField(?GUIA:Destinatario,14)
  SELF.AddHistoryField(?GUIA:NombreDestino,15)
  SELF.AddHistoryField(?GUIA:DireccionDestino,16)
  SELF.AddHistoryField(?GUIA:TelefonoDestino,18)
  SELF.AddHistoryField(?GUIA:Distribuidor,20)
  SELF.AddHistoryField(?GUIA:Redespacho,25)
  SELF.AddHistoryField(?GUIA:ContraReembolso,22)
  SELF.AddHistoryField(?GUIA:RemitoCliente,26)
  SELF.AddHistoryField(?GUIA:Flete,23)
  SELF.AddHistoryField(?GUIA:Observacion,30)
  SELF.AddHistoryField(?GUIA:ValorDeclarado,21)
  SELF.AddHistoryField(?GUIA:Importe,24)
  SELF.AddUpdateFile(Access:GUIAS)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  Relate:LOCALIDA.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  Relate:LOCALIDAD2.Open                                   ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:GUIAS
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
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW11::View:Browse,Queue:Browse,Relate:ITEMGUIA,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,ITGUIA:Por_Guia)                      ! Add the sort order for ITGUIA:Por_Guia for sort order 1
  BRW1.AddRange(ITGUIA:RegGuia,GUIA:RegGuia)               ! Add single value range limit for sort order 1
  BRW1.AddField(ITGUIA:Cantidad,BRW1.Q.ITGUIA:Cantidad)    ! Field ITGUIA:Cantidad is a hot field or requires assignment from browse
  BRW1.AddField(ITGUIA:Descripcion,BRW1.Q.ITGUIA:Descripcion) ! Field ITGUIA:Descripcion is a hot field or requires assignment from browse
  BRW1.AddField(ITGUIA:Aforo,BRW1.Q.ITGUIA:Aforo)          ! Field ITGUIA:Aforo is a hot field or requires assignment from browse
  BRW1.AddField(ITGUIA:RegGuia,BRW1.Q.ITGUIA:RegGuia)      ! Field ITGUIA:RegGuia is a hot field or requires assignment from browse
  BRW1.AddField(ITGUIA:Item,BRW1.Q.ITGUIA:Item)            ! Field ITGUIA:Item is a hot field or requires assignment from browse
  BRW1.AskProcedure = 5
  SELF.AddItem(ToolbarForm)
  FDCB7.Init(LOC:Localidad,?LOC:Localidad,Queue:FileDropCombo.ViewPosition,FDCB7::View:FileDropCombo,Queue:FileDropCombo,Relate:LOCALIDA,ThisWindow,GlobalErrors,1,1,0)
  FDCB7.AskProcedure = 6
  FDCB7.Q &= Queue:FileDropCombo
  FDCB7.AddSortOrder(LOC:Por_Localidad)
  FDCB7.AddField(LOC:Localidad,FDCB7.Q.LOC:Localidad)
  FDCB7.AddUpdateField(LOC:Localidad,GUIA:LocalidadRemitente)
  ThisWindow.AddItem(FDCB7.WindowComponent)
  FDCB7.DefaultFill = 0
  FDCB15.Init(LOC2:Localidad,?LOC2:Localidad,Queue:FileDropCombo:1.ViewPosition,FDCB15::View:FileDropCombo,Queue:FileDropCombo:1,Relate:LOCALIDAD2,ThisWindow,GlobalErrors,1,1,0)
  FDCB15.AskProcedure = 7
  FDCB15.Q &= Queue:FileDropCombo:1
  FDCB15.AddSortOrder(LOC2:Por_Localidad)
  FDCB15.AddField(LOC2:Localidad,FDCB15.Q.LOC2:Localidad)
  FDCB15.AddUpdateField(LOC2:Localidad,GUIA:LocalidadDestino)
  ThisWindow.AddItem(FDCB15.WindowComponent)
  FDCB15.DefaultFill = 0
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
  EnterByTabManager.ExcludeControl(?Cancel)
  EnterByTabManager.ExcludeControl(?Insert)
  EnterByTabManager.ExcludeControl(?OK)
  EnterByTabManager.ExcludeControl(?SelectDestinatario)
  EnterByTabManager.ExcludeControl(?SelectRemitente)
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
    Relate:LOCALIDAD2.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
    GUIA:Fecha = TODAY()
    GUIA:Empresa = 3
    GUIA:Letra = PAR:LetraGuia
    GUIA:Lugar = PAR:LugarGuia
    GUIA:Numero = glo:NumeraGuia
    GUIA:FacturarA = 'R'
    GUIA:FormaPago = 1
    TRA:Denominacion = ''
    GUIA:Flete = 'R'
    GUIA:Cumplida = 'N'
    GUIA:Impresa = 'N'
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  RTE:CodCliente = GUIA:Remitente                          ! Assign linking field value
  Access:REMITENTE.Fetch(RTE:Por_Codigo)
  DES:CodCliente = GUIA:Destinatario                       ! Assign linking field value
  Access:DESTINATARIO.Fetch(DES:Por_Codigo)
  DIS:CodDistribuidor = GUIA:Distribuidor                  ! Assign linking field value
  Access:DISTRIBUIDORES.Fetch(DIS:Por_Codigo)
  TRA:CodTransporte = GUIA:Redespacho                      ! Assign linking field value
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


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      SelectREMITENTE
      SelectDESTINO
      SelectDISTRIBUIDORES
      SelectTRANSPORTE
      UpdateITEMGUIA
      UpdateLOCALIDAD
      UpdateLOCALIDAD2
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
    OF ?loc:RteEsCliente
      IF ?loc:RteEsCliente{Prop:Checked} = True
        ?GUIA:NombreRemitente{Prop:ReadOnly} = True
        ?GUIA:DireccionRemitente{Prop:ReadOnly} = True
        ?LOC:Localidad{Prop:ReadOnly} = True
        ?GUIA:TelefonoRemitente{Prop:ReadOnly} = True
        ENABLE(?SelectRemitente)
      END
      IF ?loc:RteEsCliente{Prop:Checked} = False
        ?GUIA:NombreRemitente{Prop:ReadOnly} = False
        ?GUIA:DireccionRemitente{Prop:ReadOnly} = False
        ?LOC:Localidad{Prop:ReadOnly} = False
        ?GUIA:TelefonoRemitente{Prop:ReadOnly} = False
        CLEAR(GUIA:Remitente)
        DISABLE(?SelectRemitente)
      END
      ThisWindow.Reset
    OF ?loc:DesEsCliente
      IF ?loc:DesEsCliente{Prop:Checked} = True
        ?GUIA:NombreDestino{Prop:ReadOnly} = True
        ?GUIA:DireccionDestino{Prop:ReadOnly} = True
        ?LOC2:Localidad{Prop:ReadOnly} = True
        ?GUIA:TelefonoDestino{Prop:ReadOnly} = True
        ENABLE(?SelectDestinatario)
      END
      IF ?loc:DesEsCliente{Prop:Checked} = False
        ?GUIA:NombreDestino{Prop:ReadOnly} = False
        ?GUIA:DireccionDestino{Prop:ReadOnly} = False
        ?LOC2:Localidad{Prop:ReadOnly} = False
        ?GUIA:TelefonoDestino{Prop:ReadOnly} = False
        CLEAR(GUIA:Destinatario)
        DISABLE(?SelectDestinatario)
      END
      ThisWindow.Reset
      
    OF ?OK
      IF GUIA:FacturarA = 'R' AND NOT(GUIA:Remitente) THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' Para poder facturarle al Remitente,| tiene que seleccionar un Cliente como Remitente.',|
                'Atención !!!',ICON:Exclamation)
        CYCLE
      .
      IF GUIA:FacturarA = 'D' AND NOT(GUIA:Destinatario) THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' Para poder facturarle al Destinatario,| tiene que seleccionar un Cliente como Destinatario.',|
                'Atención !!!',ICON:Exclamation)
        CYCLE
      .
    OF ?Cancel
      IF (ThisWindow.Request = InsertRecord) AND RECORDS(BRW1) THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('Si realmente desea cancelar la Guía|Debe borrar los Items ingresados.',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?List)
        CYCLE
      .
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?GUIA:FacturarA
      IF GUIA:Flete <> 'I' THEN
        IF GUIA:FacturarA = 'R' THEN GUIA:Flete = 'R'.
        IF GUIA:FacturarA = 'D' THEN GUIA:Flete = 'D'.
        ThisWindow.Reset(TRUE)
      END
    OF ?GUIA:Remitente
      IF GUIA:Remitente OR ?GUIA:Remitente{Prop:Req}
        RTE:CodCliente = GUIA:Remitente
        IF Access:REMITENTE.TryFetch(RTE:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            GUIA:Remitente = RTE:CodCliente
          ELSE
            SELECT(?GUIA:Remitente)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(0)
      IF ThisWindow.Request = InsertRecord THEN
        IF ?loc:RteEsCliente{Prop:Checked} = True
          IF NOT(GUIA:Distribuidor) THEN GUIA:Distribuidor = RTE:Distribuidor.
          GUIA:NombreRemitente = RTE:Nombre
          GUIA:DireccionRemitente = RTE:Direccion
          LOC:Localidad = RTE:Localidad
          GUIA:LocalidadRemitente = RTE:Localidad
          GUIA:TelefonoRemitente = RTE:Telefono
        END
      END
      IF ThisWindow.Request = ChangeRecord AND loc:RteEsCliente = 'S' THEN
        IF NOT(GUIA:Distribuidor) THEN GUIA:Distribuidor = RTE:Distribuidor.
        GUIA:NombreRemitente = RTE:Nombre
        GUIA:DireccionRemitente = RTE:Direccion
        LOC:Localidad = RTE:Localidad
        GUIA:LocalidadRemitente = RTE:Localidad
        GUIA:TelefonoRemitente = RTE:Telefono
      END
      DISPLAY
      SELECT(?loc:DesEsCliente)
    OF ?SelectRemitente
      ThisWindow.Update
      RTE:CodCliente = GUIA:Remitente
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        GUIA:Remitente = RTE:CodCliente
      END
      ThisWindow.Reset(1)
      GUIA:NombreRemitente = RTE:Nombre
      GUIA:DireccionRemitente = RTE:Direccion
      LOC:Localidad = RTE:Localidad
      GUIA:LocalidadRemitente = RTE:Localidad
      GUIA:TelefonoRemitente = RTE:Telefono
      IF ThisWindow.Request = InsertRecord THEN
        IF NOT(GUIA:Distribuidor) THEN GUIA:Distribuidor = RTE:Distribuidor.
      END
      DISPLAY
      SELECT(?loc:DesEsCliente)
    OF ?SelectDestinatario
      ThisWindow.Update
      DES:CodCliente = GUIA:Destinatario
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        GUIA:Destinatario = DES:CodCliente
      END
      ThisWindow.Reset(1)
      GUIA:NombreDestino = DES:Nombre
      GUIA:DireccionDestino = DES:Direccion
      LOC2:Localidad = DES:Localidad
      GUIA:LocalidadDestino = DES:Localidad
      GUIA:TelefonoDestino = DES:Telefono
      DISPLAY
      SELECT(?GUIA:Distribuidor)
    OF ?GUIA:Destinatario
      IF GUIA:Destinatario OR ?GUIA:Destinatario{Prop:Req}
        DES:CodCliente = GUIA:Destinatario
        IF Access:DESTINATARIO.TryFetch(DES:Por_Codigo)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            GUIA:Destinatario = DES:CodCliente
          ELSE
            SELECT(?GUIA:Destinatario)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(0)
      IF ThisWindow.Request = InsertRecord THEN
        IF ?loc:DesEsCliente{Prop:Checked} = True
          GUIA:NombreDestino = DES:Nombre
          GUIA:DireccionDestino = DES:Direccion
          LOC2:Localidad = DES:Localidad
          GUIA:LocalidadDestino = DES:Localidad
          GUIA:TelefonoDestino = DES:Telefono
        END
      END
      IF ThisWindow.Request = ChangeRecord AND loc:DesEsCliente = 'S' THEN
        GUIA:NombreDestino = DES:Nombre
        GUIA:DireccionDestino = DES:Direccion
        LOC2:Localidad = DES:Localidad
        GUIA:LocalidadDestino = DES:Localidad
        GUIA:TelefonoDestino = DES:Telefono
      END
      SELECT(?GUIA:FacturarA)
      DISPLAY
    OF ?GUIA:Distribuidor
      IF GUIA:Distribuidor OR ?GUIA:Distribuidor{Prop:Req}
        DIS:CodDistribuidor = GUIA:Distribuidor
        IF Access:DISTRIBUIDORES.TryFetch(DIS:Por_Codigo)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            GUIA:Distribuidor = DIS:CodDistribuidor
          ELSE
            SELECT(?GUIA:Distribuidor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?SelecDistribuidor
      ThisWindow.Update
      DIS:CodDistribuidor = GUIA:Distribuidor
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        GUIA:Distribuidor = DIS:CodDistribuidor
      END
      ThisWindow.Reset(1)
    OF ?GUIA:Redespacho
      IF GUIA:Redespacho OR ?GUIA:Redespacho{Prop:Req}
        TRA:CodTransporte = GUIA:Redespacho
        IF Access:TRANSPOR.TryFetch(TRA:Por_Codigo)
          IF SELF.Run(4,SelectRecord) = RequestCompleted
            GUIA:Redespacho = TRA:CodTransporte
          ELSE
            SELECT(?GUIA:Redespacho)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?SelecTransporte
      ThisWindow.Update
      SELECT(?GUIA:ContraReembolso)
      TRA:CodTransporte = GUIA:Redespacho
      IF SELF.Run(4,SelectRecord) = RequestCompleted
        GUIA:Redespacho = TRA:CodTransporte
      END
      ThisWindow.Reset(1)
    OF ?OK
      ThisWindow.Update
      IF GUIA:FacturarA = 'R' THEN GUIA:ClienteFacturar = GUIA:Remitente.
      IF GUIA:FacturarA = 'D' THEN GUIA:ClienteFacturar = GUIA:Destinatario.
      IF ThisWindow.Request = InsertRecord AND GUIA:Redespacho THEN ImporteRedespacho.
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
    CASE EVENT()
    OF EVENT:OpenWindow
      IF ThisWindow.Request = ChangeRecord THEN
        IF GUIA:Remitente THEN
          loc:RteEsCliente = 'S'
          ?GUIA:NombreRemitente{Prop:ReadOnly} = True
          ?GUIA:DireccionRemitente{Prop:ReadOnly} = True
          ?LOC:Localidad{Prop:ReadOnly} = True
          ?GUIA:TelefonoRemitente{Prop:ReadOnly} = True
          ENABLE(?GUIA:Remitente)
          ENABLE(?SelectRemitente)
        ELSE
          ?GUIA:NombreRemitente{Prop:ReadOnly} = False
          ?GUIA:DireccionRemitente{Prop:ReadOnly} = False
          ?LOC:Localidad{Prop:ReadOnly} = False
          ?GUIA:TelefonoRemitente{Prop:ReadOnly} = False
          DISABLE(?GUIA:Remitente)
          DISABLE(?SelectRemitente)
        END
        IF GUIA:Destinatario THEN
          loc:DesEsCliente = 'S'
          ?GUIA:NombreDestino{Prop:ReadOnly} = True
          ?GUIA:DireccionDestino{Prop:ReadOnly} = True
          ?LOC2:Localidad{Prop:ReadOnly} = True
          ?GUIA:TelefonoDestino{Prop:ReadOnly} = True
          ENABLE(?GUIA:Destinatario)
          ENABLE(?SelectDestinatario)
        ELSE
          ?GUIA:NombreDestino{Prop:ReadOnly} = False
          ?GUIA:DireccionDestino{Prop:ReadOnly} = False
          ?LOC2:Localidad{Prop:ReadOnly} = False
          ?GUIA:TelefonoDestino{Prop:ReadOnly} = False
          DISABLE(?GUIA:Destinatario)
          DISABLE(?SelectDestinatario)
        END
      END
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


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.ResetFromView PROCEDURE

GUIA:Importe:Sum     REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:ITEMGUIA.SetQuickScan(1)
  SELF.Reset
  LOOP
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    GUIA:Importe:Sum += ITGUIA:Aforo
  END
  GUIA:Importe = GUIA:Importe:Sum
  PARENT.ResetFromView
  Relate:ITEMGUIA.SetQuickScan(0)
  SETCURSOR()


FDCB7.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue


FDCB15.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue

