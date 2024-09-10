

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS098.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS015.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS016.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS060.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS088.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdateRECIBOS3 PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
loc:RteEsCliente     STRING(1)                             !
loc:DesEsCliente     STRING(1)                             !
loc:TotalValores     DECIMAL(8,2)                          !
loc:TotalPendiente   DECIMAL(8,2)                          !
loc:TotalAplicado    DECIMAL(8,2)                          !
loc:SaldoComprobante DECIMAL(9,2)                          !
loc:ImporteRecibo    DECIMAL(9,2)                          !
mem:TotalAplicaciones DECIMAL(9,2)                         !
BRW3::View:Browse    VIEW(RECIBOS)
                       PROJECT(REC:Fecha)
                       PROJECT(REC:Letra)
                       PROJECT(REC:Lugar)
                       PROJECT(REC:Numero)
                       PROJECT(REC:Importe)
                       PROJECT(REC:ClienteFacturar)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
REC:Fecha              LIKE(REC:Fecha)                !List box control field - type derived from field
REC:Letra              LIKE(REC:Letra)                !List box control field - type derived from field
REC:Lugar              LIKE(REC:Lugar)                !List box control field - type derived from field
REC:Numero             LIKE(REC:Numero)               !List box control field - type derived from field
loc:SaldoComprobante   LIKE(loc:SaldoComprobante)     !List box control field - type derived from local data
REC:Importe            LIKE(REC:Importe)              !List box control field - type derived from field
REC:ClienteFacturar    LIKE(REC:ClienteFacturar)      !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW8::View:Browse    VIEW(APLIFAC)
                       PROJECT(APFAC:Fecha)
                       PROJECT(APFAC:Comprobante)
                       PROJECT(APFAC:ImporteAplicado)
                       PROJECT(APFAC:Recibo)
                       PROJECT(APFAC:Factura)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
APFAC:Fecha            LIKE(APFAC:Fecha)              !List box control field - type derived from field
APFAC:Comprobante      LIKE(APFAC:Comprobante)        !List box control field - type derived from field
APFAC:ImporteAplicado  LIKE(APFAC:ImporteAplicado)    !List box control field - type derived from field
APFAC:Recibo           LIKE(APFAC:Recibo)             !Browse key field - type derived from field
APFAC:Factura          LIKE(APFAC:Factura)            !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW9::View:Browse    VIEW(VALORES)
                       PROJECT(VAL:Tipo)
                       PROJECT(VAL:Numero)
                       PROJECT(VAL:Fecha)
                       PROJECT(VAL:Importe)
                       PROJECT(VAL:CodigoInterno)
                       PROJECT(VAL:Recibo)
                       PROJECT(VAL:Banco)
                       JOIN(BCO:Por_Codigo,VAL:Banco)
                         PROJECT(BCO:Denominacion)
                         PROJECT(BCO:Codigo)
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
VAL:Tipo               LIKE(VAL:Tipo)                 !List box control field - type derived from field
BCO:Denominacion       LIKE(BCO:Denominacion)         !List box control field - type derived from field
VAL:Numero             LIKE(VAL:Numero)               !List box control field - type derived from field
VAL:Fecha              LIKE(VAL:Fecha)                !List box control field - type derived from field
VAL:Importe            LIKE(VAL:Importe)              !List box control field - type derived from field
VAL:CodigoInterno      LIKE(VAL:CodigoInterno)        !Primary key field - type derived from field
VAL:Recibo             LIKE(VAL:Recibo)               !Browse key field - type derived from field
BCO:Codigo             LIKE(BCO:Codigo)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
History::FAC:Record  LIKE(FAC:RECORD),THREAD
QuickWindow          WINDOW('Update the FACTURAS File'),AT(,,377,237),FONT('MS Sans Serif',8,,),COLOR(0BFDFDFH),CENTER,IMM,GRAY,DOUBLE,MDI
                       STRING('RECIBO'),AT(172,1),USE(?String12),TRN,FONT('Arial',10,COLOR:Green,FONT:bold)
                       STRING('Trans PABLO'),AT(311,2,57,10),USE(?String9),TRN,FONT(,,,FONT:bold+FONT:italic)
                       PANEL,AT(-25,13,403,23),USE(?Panel1),FILL(COLOR:Green),BEVEL(-1)
                       STRING('NUMERO:'),AT(13,19),USE(?String1),TRN,FONT(,,COLOR:White,FONT:bold)
                       ENTRY(@s1),AT(60,19,15,10),USE(FAC:Letra),SKIP,TRN,CENTER,FONT(,,COLOR:White,FONT:bold),REQ,UPR,READONLY
                       ENTRY(@n04),AT(79,19,23,10),USE(FAC:Lugar),SKIP,TRN,RIGHT(1),FONT(,,COLOR:White,FONT:bold),REQ,READONLY
                       ENTRY(@n08),AT(106,19,40,10),USE(FAC:Numero),SKIP,TRN,RIGHT(1),FONT(,,COLOR:White,FONT:bold),REQ
                       PROMPT('FECHA:'),AT(276,19),USE(?FAC:Fecha:Prompt),TRN,FONT(,,COLOR:White,FONT:bold)
                       ENTRY(@d6b),AT(315,19,49,10),USE(FAC:Fecha),SKIP,RIGHT(1),COLOR(0F5F5F5H),REQ
                       PROMPT('Cliente:'),AT(11,46),USE(?FAC:ClienteFacturar:Prompt),TRN,FONT(,,,FONT:bold)
                       BUTTON,AT(82,45,12,11),USE(?SelectCliente),FLAT,TIP('Seleccionar Cliente'),ICON('C:\1L\Comisiones\botones\lookup.ico')
                       ENTRY(@n6.b),AT(45,46,33,10),USE(FAC:ClienteFacturar),RIGHT(1),COLOR(0F5F5F5H),REQ
                       BOX,AT(101,45,195,11),USE(?Box1),ROUND,COLOR(COLOR:Black),FILL(08EEEECH)
                       STRING(@s40),AT(104,46,191,10),USE(CLI:Nombre),TRN,FONT(,,,FONT:bold)
                       PROMPT('Distribuidor:'),AT(11,63),USE(?FAC:Distribuidor:Prompt),TRN
                       ENTRY(@n3b),AT(57,63,21,10),USE(FAC:Distribuidor),SKIP,RIGHT(1),COLOR(0E0EFEFH)
                       BUTTON,AT(82,62,12,11),USE(?CallLookup),SKIP,FLAT,TIP('Seleccionar Distribuidor'),ICON('C:\1L\Comisiones\botones\lookup.ico')
                       STRING(@s35),AT(104,63,145,10),USE(DIS:Nombre),TRN
                       SHEET,AT(7,81,364,84),USE(?Sheet1),ABOVE(64)
                         TAB(' &Valores'),USE(?Valores)
                           LIST,AT(30,103,317,42),USE(?List:3),IMM,VSCROLL,COLOR(0F5F5F5H),FORMAT('41L(2)|FM~Tipo~@s8@110L(2)|FM~Banco~@s25@47R(3)|FM~Número~L(2)@n10.b@53R(3)|FM~F' &|
   'echa~L(2)@d6b@52R(3)|FM~Importe~L(2)@n-13.2@'),FROM(Queue:Browse:2)
                           BUTTON,AT(70,148,14,12),USE(?Insert),SKIP,FLAT,TIP('Agregar'),ICON('C:\1L\Comisiones\botones\Insert.ico')
                           BUTTON,AT(50,148,14,12),USE(?Change),SKIP,FLAT,TIP('Modificar'),ICON('C:\1L\Comisiones\botones\Edit.ico')
                           BUTTON,AT(30,148,14,12),USE(?Delete),SKIP,FLAT,TIP('Borrar'),ICON('C:\1L\Comisiones\botones\Delete.ico')
                         END
                         TAB(' &Aplicaciones'),USE(?Aplicaciones)
                           STRING('Comprobantes Pendientes'),AT(12,98),USE(?String3),TRN,FONT(,,COLOR:Maroon,FONT:bold)
                           STRING('Comprobantes Aplicados'),AT(202,98),USE(?String4),TRN,FONT(,,COLOR:Green,FONT:bold)
                           LIST,AT(12,108,164,43),USE(?List),IMM,NOBAR,COLOR(0F5F5F5H,COLOR:Black,0FFFF80H),FORMAT('46R(2)|F~Fecha~L@d6@[8CF@s1@21R(2)F@n04@35R(2)|F@n08@](67)|F~Comprobante~L(2)47R' &|
   '(3)|~Saldo~L(2)@n-13.2@49R(3)|~Imp. Orig.~L(2)@n-11.2@'),FROM(Queue:Browse)
                           LIST,AT(202,108,164,43),USE(?List:2),IMM,NOBAR,COLOR(0F5F5F5H,COLOR:Black,0FFFF80H),FORMAT('45R(2)|FM~Fecha~L@d6@72L(2)|FM~Comprobante~@s20@50R(3)|FM~Importe~L(2)@n-13.2@'),FROM(Queue:Browse:1)
                           BUTTON,AT(179,117,17,14),USE(?Aplica),SKIP,FLAT,TIP('Aplicar'),ICON('C:\1L\Comisiones\botones\aplica.ico')
                           BUTTON,AT(179,133,17,14),USE(?Desaplica),SKIP,FLAT,TIP('Sacar de Aplicación'),ICON('C:\1L\Comisiones\botones\desaplica.ico')
                           STRING(@n-11.2),AT(122,154),USE(loc:TotalPendiente),TRN,RIGHT(1),FONT(,,,FONT:bold)
                           STRING(@n-11.2),AT(310,154),USE(loc:TotalAplicado),TRN,RIGHT(1),FONT(,,,FONT:bold)
                         END
                       END
                       STRING('Observación:'),AT(12,170),USE(?String5),TRN
                       TEXT,AT(11,179,212,26),USE(FAC:Observacion),SKIP,BOXED,VSCROLL,FONT(,,COLOR:Red,FONT:bold),COLOR(COLOR:Silver),UPR
                       PROMPT('IMPORTE:'),AT(260,190),USE(?FAC:Importe:Prompt),TRN,FONT(,,,FONT:bold)
                       ENTRY(@n-13.2),AT(310,190,52,10),USE(loc:ImporteRecibo),SKIP,RIGHT(1),FONT(,,,FONT:bold),COLOR(0F5F5F5H),READONLY
                       LINE,AT(9,212,357,0),USE(?Line1),COLOR(COLOR:Gray),LINEWIDTH(2)
                       BUTTON('  OK'),AT(247,217,57,16),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\1L\Comisiones\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(310,217,57,16),USE(?Cancel),LEFT,KEY(EscKey),ICON('C:\1L\Comisiones\botones\Cancel1.ico')
                       STRING('Saldo del Recibo:'),AT(15,221),USE(?String11),TRN,FONT(,,COLOR:White,,CHARSET:ANSI)
                       STRING(@n-13.2),AT(71,221),USE(glo:SaldoaAplicar),TRN,RIGHT(1),FONT(,,COLOR:White,,CHARSET:ANSI)
                       BOX,AT(11,219,111,12),USE(?Box2),ROUND,COLOR(04B4B4BH),FILL(04B4B4BH)
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
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
BRW2                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW3                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW1                 CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(APLIFAC:Record)
? DEBUGHOOK(FACTURAS:Record)
? DEBUGHOOK(RECIBOS:Record)
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
  GlobalErrors.SetProcedureName('UpdateRECIBOS3')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String12
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('loc:SaldoComprobante',loc:SaldoComprobante)        ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(FAC:Record,History::FAC:Record)
  SELF.AddHistoryField(?FAC:Letra,5)
  SELF.AddHistoryField(?FAC:Lugar,6)
  SELF.AddHistoryField(?FAC:Numero,7)
  SELF.AddHistoryField(?FAC:Fecha,2)
  SELF.AddHistoryField(?FAC:ClienteFacturar,9)
  SELF.AddHistoryField(?FAC:Distribuidor,24)
  SELF.AddHistoryField(?FAC:Observacion,35)
  SELF.AddUpdateFile(Access:FACTURAS)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:APLIFAC.SetOpenRelated()
  Relate:APLIFAC.Open                                      ! File RECIBOS used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:RECIBOS.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:FACTURAS
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
  BRW2.Init(?List,Queue:Browse.ViewPosition,BRW3::View:Browse,Queue:Browse,Relate:RECIBOS,SELF) ! Initialize the browse manager
  BRW3.Init(?List:2,Queue:Browse:1.ViewPosition,BRW8::View:Browse,Queue:Browse:1,Relate:APLIFAC,SELF) ! Initialize the browse manager
  BRW1.Init(?List:3,Queue:Browse:2.ViewPosition,BRW9::View:Browse,Queue:Browse:2,Relate:VALORES,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  ?List{Prop:LineHeight} = 0
  ?List:2{Prop:LineHeight} = 0
  ?List:3{Prop:LineHeight} = 0
  Do DefineListboxStyle
  BRW2.Q &= Queue:Browse
  BRW2.AddSortOrder(,REC:Por_Cliente)                      ! Add the sort order for REC:Por_Cliente for sort order 1
  BRW2.AddRange(REC:ClienteFacturar,FAC:ClienteFacturar)   ! Add single value range limit for sort order 1
  BRW2.SetFilter('(REC:Empresa = 3 AND (REC:Importe + REC:Aplicado) <<> 0 AND REC:Comprobante = ''FAC'')') ! Apply filter expression to browse
  BRW2.AddField(REC:Fecha,BRW2.Q.REC:Fecha)                ! Field REC:Fecha is a hot field or requires assignment from browse
  BRW2.AddField(REC:Letra,BRW2.Q.REC:Letra)                ! Field REC:Letra is a hot field or requires assignment from browse
  BRW2.AddField(REC:Lugar,BRW2.Q.REC:Lugar)                ! Field REC:Lugar is a hot field or requires assignment from browse
  BRW2.AddField(REC:Numero,BRW2.Q.REC:Numero)              ! Field REC:Numero is a hot field or requires assignment from browse
  BRW2.AddField(loc:SaldoComprobante,BRW2.Q.loc:SaldoComprobante) ! Field loc:SaldoComprobante is a hot field or requires assignment from browse
  BRW2.AddField(REC:Importe,BRW2.Q.REC:Importe)            ! Field REC:Importe is a hot field or requires assignment from browse
  BRW2.AddField(REC:ClienteFacturar,BRW2.Q.REC:ClienteFacturar) ! Field REC:ClienteFacturar is a hot field or requires assignment from browse
  BRW3.Q &= Queue:Browse:1
  BRW3.AddSortOrder(,APFAC:Por_Recibo)                     ! Add the sort order for APFAC:Por_Recibo for sort order 1
  BRW3.AddRange(APFAC:Recibo,Relate:APLIFAC,Relate:FACTURAS) ! Add file relationship range limit for sort order 1
  BRW3.AddField(APFAC:Fecha,BRW3.Q.APFAC:Fecha)            ! Field APFAC:Fecha is a hot field or requires assignment from browse
  BRW3.AddField(APFAC:Comprobante,BRW3.Q.APFAC:Comprobante) ! Field APFAC:Comprobante is a hot field or requires assignment from browse
  BRW3.AddField(APFAC:ImporteAplicado,BRW3.Q.APFAC:ImporteAplicado) ! Field APFAC:ImporteAplicado is a hot field or requires assignment from browse
  BRW3.AddField(APFAC:Recibo,BRW3.Q.APFAC:Recibo)          ! Field APFAC:Recibo is a hot field or requires assignment from browse
  BRW3.AddField(APFAC:Factura,BRW3.Q.APFAC:Factura)        ! Field APFAC:Factura is a hot field or requires assignment from browse
  BRW1.Q &= Queue:Browse:2
  BRW1.AddSortOrder(,VAL:Por_Recibo)                       ! Add the sort order for VAL:Por_Recibo for sort order 1
  BRW1.AddRange(VAL:Recibo,FAC:RegFactura)                 ! Add single value range limit for sort order 1
  BRW1.AddField(VAL:Tipo,BRW1.Q.VAL:Tipo)                  ! Field VAL:Tipo is a hot field or requires assignment from browse
  BRW1.AddField(BCO:Denominacion,BRW1.Q.BCO:Denominacion)  ! Field BCO:Denominacion is a hot field or requires assignment from browse
  BRW1.AddField(VAL:Numero,BRW1.Q.VAL:Numero)              ! Field VAL:Numero is a hot field or requires assignment from browse
  BRW1.AddField(VAL:Fecha,BRW1.Q.VAL:Fecha)                ! Field VAL:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(VAL:Importe,BRW1.Q.VAL:Importe)            ! Field VAL:Importe is a hot field or requires assignment from browse
  BRW1.AddField(VAL:CodigoInterno,BRW1.Q.VAL:CodigoInterno) ! Field VAL:CodigoInterno is a hot field or requires assignment from browse
  BRW1.AddField(VAL:Recibo,BRW1.Q.VAL:Recibo)              ! Field VAL:Recibo is a hot field or requires assignment from browse
  BRW1.AddField(BCO:Codigo,BRW1.Q.BCO:Codigo)              ! Field BCO:Codigo is a hot field or requires assignment from browse
  SELF.AddItem(ToolbarForm)
  BRW1.AskProcedure = 3
  BRW2.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW3.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
  EnterByTabManager.ExcludeControl(?Cancel)
  EnterByTabManager.ExcludeControl(?OK)
  EnterByTabManager.ExcludeControl(?SelectCliente)
  EnterByTabManager.Init(False)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:APLIFAC.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
    FAC:Fecha = TODAY()
    FAC:Empresa = 3
    FAC:Comprobante = 'REC'
    FAC:Letra = 'X'
    FAC:Lugar = PAR:LugarFactura
    FAC:Numero = glo:NumeraFactura
    FAC:Impresa = 'N'
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  CLI:CodCliente = FAC:ClienteFacturar                     ! Assign linking field value
  Access:CLIENTES.Fetch(CLI:Por_Codigo)
  DIS:CodDistribuidor = FAC:Distribuidor                   ! Assign linking field value
  Access:DISTRIBUIDORES.Fetch(DIS:Por_Codigo)
  glo:SaldoaAplicar = loc:ImporteRecibo + loc:TotalAplicado
  IF RECORDS(BRW1) AND RECORDS(BRW2) AND glo:SaldoaAplicar <> 0 THEN
    ENABLE(?Aplica)
  ELSE
    DISABLE(?Aplica)
  .
  
  IF RECORDS(BRW3) THEN
    ENABLE(?Desaplica)
    DISABLE(?FAC:ClienteFacturar)
    DISABLE(?SelectCliente)
  ELSE
    DISABLE(?Desaplica)
    ENABLE(?FAC:ClienteFacturar)
    ENABLE(?SelectCliente)
  .
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
      SelectCLIENTES
      SelectDISTRIBUIDORES
      UpdateVALORES
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
      BRW3.ResetFromView
      IF ABS(loc:TotalAplicado) > loc:ImporteRecibo THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('El Importe Aplicado no puede ser mayor que el Importe Recibido.|Para solucionarlo retire las Aplicaciones y vuelva a realizarlas.',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?List:2)
        CYCLE
      .
    OF ?Cancel
      IF (ThisWindow.Request = InsertRecord) AND (RECORDS(BRW1) OR RECORDS(BRW3)) THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('Si realmente desea cancelar el Recibo|Debe borrar los valores y/o aplicaciones ingresados.',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?List:3)
        CYCLE
      .
      
      IF ABS(loc:TotalAplicado) > loc:ImporteRecibo THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('El Importe Aplicado no puede ser mayor que el Importe Recibido.|Para solucionarlo retire las Aplicaciones y vuelva a realizarlas.',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?List:2)
        CYCLE
      .
      
      IF ThisWindow.Request = ChangeRecord AND mem:TotalAplicaciones <> loc:TotalAplicado THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('Ha realizado modificaciones en las Aplicaciones del Recibo.|Si realmente desea cancelarlo|deberá volver hacia atrás las modificaciones realizadas.',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?List:2)
        CYCLE
      .
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?SelectCliente
      ThisWindow.Update
      CLI:CodCliente = FAC:ClienteFacturar
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        FAC:ClienteFacturar = CLI:CodCliente
      END
      ThisWindow.Reset(1)
      SELECT(?List:3)
    OF ?FAC:ClienteFacturar
      IF FAC:ClienteFacturar OR ?FAC:ClienteFacturar{Prop:Req}
        CLI:CodCliente = FAC:ClienteFacturar
        IF Access:CLIENTES.TryFetch(CLI:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            FAC:ClienteFacturar = CLI:CodCliente
          ELSE
            SELECT(?FAC:ClienteFacturar)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(0)
      IF FAC:ClienteFacturar THEN
        ENABLE(?Insert)
      ELSE
        DISABLE(?Insert)
      .
      IF NOT(FAC:Distribuidor) THEN FAC:Distribuidor = CLI:Distribuidor.
    OF ?FAC:Distribuidor
      IF FAC:Distribuidor OR ?FAC:Distribuidor{Prop:Req}
        DIS:CodDistribuidor = FAC:Distribuidor
        IF Access:DISTRIBUIDORES.TryFetch(DIS:Por_Codigo)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            FAC:Distribuidor = DIS:CodDistribuidor
          ELSE
            SELECT(?FAC:Distribuidor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup
      ThisWindow.Update
      DIS:CodDistribuidor = FAC:Distribuidor
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        FAC:Distribuidor = DIS:CodDistribuidor
      END
      ThisWindow.Reset(1)
    OF ?Aplica
      ThisWindow.Update
      AplicaFactura
      ThisWindow.Reset
      BRW2.ResetFromFile
      ThisWindow.Reset(TRUE)
      SELECT(?List)
    OF ?Desaplica
      ThisWindow.Update
      BRW3.UpdateViewRecord
      REC:RegFactura = APFAC:Factura
      GET(Recibos,REC:Por_Registro)
      REC:Aplicado -= APFAC:ImporteAplicado
      PUT(Recibos)
      
      DELETE(APLIFAC)
      
      ThisWindow.Reset(TRUE)
    OF ?OK
      ThisWindow.Update
      FAC:Importe = loc:ImporteRecibo * -1
      FAC:Aplicado = loc:TotalAplicado * -1
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


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE FIELD()
    OF ?List
      IF b# = 0 THEN
        mem:TotalAplicaciones = loc:TotalAplicado
        b# = 1
      .
    END
  ReturnValue = PARENT.TakeSelected()
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
    CASE EVENT()
    OF EVENT:OpenWindow
      IF ThisWindow.Request = ChangeRecord THEN
        DISABLE(?FAC:ClienteFacturar)
        DISABLE(?SelectCliente)
        IF FAC:Impresa = 'S' THEN DISABLE(?Valores).
        SELECT(?List)
      .
      
      IF ThisWindow.Request = InsertRecord THEN DISABLE(?Insert).
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW2.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW2.ResetFromView PROCEDURE

loc:TotalPendiente:Sum REAL                                ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:RECIBOS.SetQuickScan(1)
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
    loc:TotalPendiente:Sum += loc:SaldoComprobante
  END
  loc:TotalPendiente = loc:TotalPendiente:Sum
  PARENT.ResetFromView
  Relate:RECIBOS.SetQuickScan(0)
  SETCURSOR()


BRW2.SetQueueRecord PROCEDURE

  CODE
  loc:SaldoComprobante = REC:Importe + REC:Aplicado
  PARENT.SetQueueRecord
  
  SELF.Q.loc:SaldoComprobante = loc:SaldoComprobante       !Assign formula result to display queue


BRW3.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW3.ResetFromView PROCEDURE

loc:TotalAplicado:Sum REAL                                 ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:APLIFAC.SetQuickScan(1)
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
    loc:TotalAplicado:Sum += APFAC:ImporteAplicado
  END
  loc:TotalAplicado = loc:TotalAplicado:Sum
  PARENT.ResetFromView
  Relate:APLIFAC.SetQuickScan(0)
  SETCURSOR()


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

loc:ImporteRecibo:Sum REAL                                 ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:VALORES.SetQuickScan(1)
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
    loc:ImporteRecibo:Sum += VAL:Importe
  END
  loc:ImporteRecibo = loc:ImporteRecibo:Sum
  PARENT.ResetFromView
  Relate:VALORES.SetQuickScan(0)
  SETCURSOR()
  glo:SaldoaAplicar = loc:ImporteRecibo + loc:TotalAplicado
  IF RECORDS(BRW1) AND glo:SaldoaAplicar <> 0 THEN
    ENABLE(?Aplica)
  ELSE
    DISABLE(?Aplica)
  END
  
  !IF RECORDS(BRW3) THEN  !(ThisWindow.Request = InsertRecord) AND (RECORDS(BRW1) OR
  !  DISABLE(?FAC:ClienteFacturar)
  !  DISABLE(?SelectCliente)
  !ELSE
  !  ENABLE(?FAC:ClienteFacturar)
  !  ENABLE(?SelectCliente)
  !.
  
  IF FAC:ClienteFacturar THEN
    ENABLE(?Insert)
  ELSE
    DISABLE(?Insert)
  .

