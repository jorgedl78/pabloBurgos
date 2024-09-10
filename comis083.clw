

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS083.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS016.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS031.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS084.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS133.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS139.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS140.INC'),ONCE        !Req'd for module callout resolution
                     END


FACTURAS_EMPRESA3 PROCEDURE                                ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
loc:NombreCliente    STRING(40)                            !
loc:SaldoPendiente   DECIMAL(9,2)                          !
BRW1::View:Browse    VIEW(FACTURAS)
                       PROJECT(FAC:Fecha)
                       PROJECT(FAC:Letra)
                       PROJECT(FAC:Lugar)
                       PROJECT(FAC:Numero)
                       PROJECT(FAC:ClienteFacturar)
                       PROJECT(FAC:FacturarA)
                       PROJECT(FAC:Importe)
                       PROJECT(FAC:Cobrada)
                       PROJECT(FAC:RegFactura)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
FAC:Fecha              LIKE(FAC:Fecha)                !List box control field - type derived from field
FAC:Fecha_NormalFG     LONG                           !Normal forground color
FAC:Fecha_NormalBG     LONG                           !Normal background color
FAC:Fecha_SelectedFG   LONG                           !Selected forground color
FAC:Fecha_SelectedBG   LONG                           !Selected background color
FAC:Fecha_Icon         LONG                           !Entry's icon ID
FAC:Letra              LIKE(FAC:Letra)                !List box control field - type derived from field
FAC:Letra_NormalFG     LONG                           !Normal forground color
FAC:Letra_NormalBG     LONG                           !Normal background color
FAC:Letra_SelectedFG   LONG                           !Selected forground color
FAC:Letra_SelectedBG   LONG                           !Selected background color
FAC:Lugar              LIKE(FAC:Lugar)                !List box control field - type derived from field
FAC:Lugar_NormalFG     LONG                           !Normal forground color
FAC:Lugar_NormalBG     LONG                           !Normal background color
FAC:Lugar_SelectedFG   LONG                           !Selected forground color
FAC:Lugar_SelectedBG   LONG                           !Selected background color
FAC:Numero             LIKE(FAC:Numero)               !List box control field - type derived from field
FAC:Numero_NormalFG    LONG                           !Normal forground color
FAC:Numero_NormalBG    LONG                           !Normal background color
FAC:Numero_SelectedFG  LONG                           !Selected forground color
FAC:Numero_SelectedBG  LONG                           !Selected background color
FAC:ClienteFacturar    LIKE(FAC:ClienteFacturar)      !List box control field - type derived from field
FAC:ClienteFacturar_NormalFG LONG                     !Normal forground color
FAC:ClienteFacturar_NormalBG LONG                     !Normal background color
FAC:ClienteFacturar_SelectedFG LONG                   !Selected forground color
FAC:ClienteFacturar_SelectedBG LONG                   !Selected background color
loc:NombreCliente      LIKE(loc:NombreCliente)        !List box control field - type derived from local data
loc:NombreCliente_NormalFG LONG                       !Normal forground color
loc:NombreCliente_NormalBG LONG                       !Normal background color
loc:NombreCliente_SelectedFG LONG                     !Selected forground color
loc:NombreCliente_SelectedBG LONG                     !Selected background color
FAC:FacturarA          LIKE(FAC:FacturarA)            !List box control field - type derived from field
FAC:FacturarA_NormalFG LONG                           !Normal forground color
FAC:FacturarA_NormalBG LONG                           !Normal background color
FAC:FacturarA_SelectedFG LONG                         !Selected forground color
FAC:FacturarA_SelectedBG LONG                         !Selected background color
FAC:Importe            LIKE(FAC:Importe)              !List box control field - type derived from field
FAC:Importe_NormalFG   LONG                           !Normal forground color
FAC:Importe_NormalBG   LONG                           !Normal background color
FAC:Importe_SelectedFG LONG                           !Selected forground color
FAC:Importe_SelectedBG LONG                           !Selected background color
FAC:Cobrada            LIKE(FAC:Cobrada)              !List box control field - type derived from field
FAC:Cobrada_NormalFG   LONG                           !Normal forground color
FAC:Cobrada_NormalBG   LONG                           !Normal background color
FAC:Cobrada_SelectedFG LONG                           !Selected forground color
FAC:Cobrada_SelectedBG LONG                           !Selected background color
FAC:RegFactura         LIKE(FAC:RegFactura)           !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('FACTURAS'),AT(,,424,237),FONT('MS Sans Serif',8,COLOR:Black,),COLOR(0E4EBEFH),CENTER,IMM,ICON('C:\Comisiones\ComisionesSRL\botones\facturacion.ico'),SYSTEM,GRAY,DOUBLE,MDI
                       PANEL,AT(-4,5,428,21),USE(?Panel1),FILL(COLOR:Green),BEVEL(-1)
                       STRING('3'),AT(4,8,19,15),USE(?String4),TRN,CENTER,FONT('Arial Black',12,COLOR:White,FONT:bold)
                       STRING('PABLO'),AT(205,6,56,20),USE(?String1:2),TRN,FONT('Arial Black',16,COLOR:White,FONT:regular+FONT:italic)
                       STRING('Trans'),AT(166,5),USE(?String1),TRN,FONT('Brush Script MT',20,COLOR:White,FONT:regular)
                       LIST,AT(13,48,398,123),USE(?Browse:1),IMM,VSCROLL,COLOR(0F8F8F8H,COLOR:White,COLOR:Green),FORMAT('53R(3)|F*J~Fecha~C(0)@d6@[22CF*~Letra~@s1@23R(4)F*~Lugar~C(0)@n04@28R(4)|F*~Núme' &|
   'ro~C(0)@n08@](81)|F~Comprobante~[32R(3)|F*~Código~C(0)@n6.b@?158L(2)|F*~Nombre~@' &|
   's40@7C|F*@s1@](203)|F~Cliente~46R(4)|*~Importe~C(0)@n-11.2@40R(3)|M*~Cobrada~C(0' &|
   ')@d6b@'),FROM(Queue:Browse:1)
                       BUTTON('Alta'),AT(301,175,53,32),USE(?Insert:2),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\agregar.ico')
                       BUTTON('Modificar'),AT(358,175,53,15),USE(?Change:2),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\modificar.ico')
                       BUTTON('Borrar'),AT(358,192,53,15),USE(?Delete:2),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\borrar.ico')
                       BUTTON('Imprimir'),AT(104,192,52,15),USE(?Imprimir),SKIP,LEFT,KEY(F2Key),ICON('C:\1L\Comisiones\botones\imprimir.ICO')
                       BUTTON('Guías...'),AT(104,175,52,15),USE(?Aplicaciones),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\ventana.ico')
                       SHEET,AT(7,30,409,182),USE(?CurrentTab),ABOVE(54)
                         TAB('Por &Fecha'),USE(?Tab:1)
                           PROMPT('Fecha:'),AT(18,177),USE(?FAC:Fecha:Prompt),TRN
                           ENTRY(@d6),AT(48,177,49,10),USE(FAC:Fecha),RIGHT(1),FONT(,,COLOR:Green,,CHARSET:ANSI)
                           BUTTON('Electrónica'),AT(159,192,60,15),USE(?Imprimir:2),SKIP,LEFT,KEY(F2Key),ICON('C:\1L\Comisiones\botones\imprimir.ICO')
                         END
                         TAB('Por &Número'),USE(?Tab:2)
                           PROMPT('Número:'),AT(18,177),USE(?FAC:Numero:Prompt),TRN
                           ENTRY(@n_8b),AT(48,177,49,10),USE(FAC:Numero),RIGHT(1),FONT(,,COLOR:Green,,CHARSET:ANSI)
                         END
                         TAB('Por &Cliente'),USE(?Tab:3)
                           BUTTON('Cliente...'),AT(159,175,52,15),USE(?SelecCLIENTE),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\buscar.ico')
                         END
                       END
                       PANEL,AT(13,192,84,15),USE(?Panel2),FILL(0EDECE2H),BEVEL(-1)
                       PROMPT('Saldo:'),AT(18,195),USE(?loc:SaldoPendiente:Prompt),TRN
                       ENTRY(@n-13.2),AT(48,195,43,10),USE(loc:SaldoPendiente),SKIP,RIGHT(2),FONT(,,COLOR:Red,,CHARSET:ANSI),READONLY
                       STRING('F2 - Imprime Factura'),AT(9,215),USE(?String2),TRN
                       BUTTON('Cobrada'),AT(223,192,52,15),USE(?Cobrada),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\cobrado2.ico')
                       BUTTON('   Cerrar'),AT(185,217,53,15),USE(?Close),SKIP,RIGHT,ICON('C:\1L\Comisiones\botones\sale.ico')
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW1::Sort1:Locator  EntryLocatorClass                     ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
BRW1::Sort1:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort2:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 3

  CODE
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(DISTRIBUIDORES:Record)
? DEBUGHOOK(FACTURAS:Record)
? DEBUGHOOK(PARAMETRO:Record)
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('FACTURAS_EMPRESA3')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('loc:NombreCliente',loc:NombreCliente)              ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCompleted)                    ! Add the close control to the window amanger
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Access:DISTRIBUIDORES.UseFile                            ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:FACTURAS,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon FAC:Numero for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,FAC:Por_NroComprobante) ! Add the sort order for FAC:Por_NroComprobante for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?FAC:Numero,FAC:Numero,1,BRW1)  ! Initialize the browse locator using ?FAC:Numero using key: FAC:Por_NroComprobante , FAC:Numero
  BRW1.SetFilter('(FAC:Empresa = 3 AND FAC:Comprobante = ''FAC'')') ! Apply filter expression to browse
  BRW1::Sort2:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon FAC:ClienteFacturar for sort order 2
  BRW1.AddSortOrder(BRW1::Sort2:StepClass,FAC:Por_Cliente) ! Add the sort order for FAC:Por_Cliente for sort order 2
  BRW1.AddRange(FAC:ClienteFacturar,glo:Cliente)           ! Add single value range limit for sort order 2
  BRW1.SetFilter('(FAC:Empresa = 3 AND FAC:Comprobante = ''FAC'')') ! Apply filter expression to browse
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha+ScrollSort:Descending) ! Moveable thumb based upon FAC:Fecha for sort order 3
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,FAC:Por_FechaD)  ! Add the sort order for FAC:Por_FechaD for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(?FAC:Fecha,FAC:Fecha,1,BRW1)    ! Initialize the browse locator using ?FAC:Fecha using key: FAC:Por_FechaD , FAC:Fecha
  BRW1.AppendOrder('-FAC:Numero')                          ! Append an additional sort order
  BRW1.SetFilter('(FAC:Empresa = 3 AND FAC:Comprobante = ''FAC'')') ! Apply filter expression to browse
  ?Browse:1{PROP:IconList,1} = '~botones\cobrado.ico'
  BRW1.AddField(FAC:Fecha,BRW1.Q.FAC:Fecha)                ! Field FAC:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Letra,BRW1.Q.FAC:Letra)                ! Field FAC:Letra is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Lugar,BRW1.Q.FAC:Lugar)                ! Field FAC:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Numero,BRW1.Q.FAC:Numero)              ! Field FAC:Numero is a hot field or requires assignment from browse
  BRW1.AddField(FAC:ClienteFacturar,BRW1.Q.FAC:ClienteFacturar) ! Field FAC:ClienteFacturar is a hot field or requires assignment from browse
  BRW1.AddField(loc:NombreCliente,BRW1.Q.loc:NombreCliente) ! Field loc:NombreCliente is a hot field or requires assignment from browse
  BRW1.AddField(FAC:FacturarA,BRW1.Q.FAC:FacturarA)        ! Field FAC:FacturarA is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Importe,BRW1.Q.FAC:Importe)            ! Field FAC:Importe is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Cobrada,BRW1.Q.FAC:Cobrada)            ! Field FAC:Cobrada is a hot field or requires assignment from browse
  BRW1.AddField(FAC:RegFactura,BRW1.Q.FAC:RegFactura)      ! Field FAC:RegFactura is a hot field or requires assignment from browse
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
  EnterByTabManager.Init(False)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:CLIENTES.Close
    Relate:PARAMETRO.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    UpdateFACTURAS3
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
    OF ?Insert:2
      remove('ticket.XML')
      CLEAR(glo:NumeraFactura)
      PAR:Registro = 3
      GET(PARAMETRO,PAR:Por_Registro)
      
      FAC:Empresa = 3
      SET(FAC:Por_Comprobante,FAC:Por_Comprobante)
      LOOP UNTIL EOF(FACTURAS)
        NEXT(FACTURAS)
        IF ERRORCODE() THEN BREAK.
        IF FAC:Empresa <> 3 THEN BREAK.
        IF FAC:Letra = PAR:LetraFactura AND FAC:Lugar = PAR:LugarFactura AND glo:NumeraFactura < FAC:Numero THEN
          glo:NumeraFactura = FAC:Numero
        END
      END
      glo:NumeraFactura += 1
    OF ?Change:2
      BRW1.UpdateViewRecord
      IF FAC:Cobrada THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' No es posible modificar la Factura,| la misma se encuentra Cobrada.',|
                'Atención !!!',ICON:Exclamation)
        CYCLE
      .
      IF FAC:Impresa = 'S' THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' No es posible modificar la Factura,| la misma se encuentra Impresa.',|
                'Atención !!!',ICON:Exclamation)
        CYCLE
      .
    OF ?Delete:2
      BRW1.UpdateViewRecord
      IF FAC:Cobrada THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' No es posible borrar la Factura,| la misma se encuentra Cobrada.',|
                'Atención !!!',ICON:Exclamation)
        CYCLE
      .
    OF ?Imprimir:2
      BRW1.UpdateViewRecord
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Imprimir
      ThisWindow.Update
      ImpresionFactura3
      ThisWindow.Reset
      BRW1.UpdateViewRecord
      FAC:Impresa = 'S'
      Access:Facturas.Update()
      ThisWindow.Reset(TRUE)
    OF ?Aplicaciones
      ThisWindow.Update
      VistaGuias
      ThisWindow.Reset
    OF ?Imprimir:2
      ThisWindow.Update
      ImpresionFacturaElectronica3
      ThisWindow.Reset
    OF ?SelecCLIENTE
      ThisWindow.Update
      GlobalRequest = SelectRecord
      SelectCLIENTES
      ThisWindow.Reset
      IF CHOICE(?CurrentTab) = 3 THEN
        IF NOT(RECORDS(BRW1)) THEN
          BEEP(BEEP:SystemQuestion)  ;  YIELD()
          MESSAGE('El Cliente seleccionado no registra movimientos.',|
                  'Sin Movimientos',ICON:Question)
        END
      END
    OF ?Cobrada
      ThisWindow.Update
      BRW1.UpdateViewRecord
      FAC:Cobrada = TODAY()
      FAC:Aplicado = FAC:Importe * -1
      Access:Facturas.Update()
      ThisWindow.Reset(TRUE)
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
    CASE FIELD()
    OF ?Browse:1
      BRW1.UpdateViewRecord
      glo:Cliente = FAC:ClienteFacturar
      loc:SaldoPendiente = FAC:Importe + FAC:Aplicado
      
      IF NOT RECORDS(BRW1) THEN
        DISABLE(?Aplicaciones)
        DISABLE(?Imprimir)
        DISABLE(?Cobrada)
      ELSE
        ENABLE(?Aplicaciones)
        ENABLE(?Imprimir)
        ENABLE(?Cobrada)
      END
      
      IF FAC:Impresa = 'S' OR FAC:FE=1 THEN
        DISABLE(?Imprimir)
      ELSE
        ENABLE(?Imprimir)
      END
      
      IF FAC:FE=1 THEN
          ENABLE(?Imprimir:2)
      ELSE
          DISABLE(?Imprimir:2)
      END
      
      IF FAC:Cobrada OR FAC:ClienteFacturar THEN
        DISABLE(?Cobrada)
      ELSE
        ENABLE(?Cobrada)
      END
    END
  ReturnValue = PARENT.TakeNewSelection()
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


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?CurrentTab) = 3
    RETURN SELF.SetSort(2,Force)
  ELSE
    RETURN SELF.SetSort(3,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW1.SetQueueRecord PROCEDURE

  CODE
  CASE FAC:FacturarA
  OF 'R'
    loc:NombreCliente = FAC:NombreRemitente
  OF 'D'
    loc:NombreCliente = FAC:NombreDestino
  ELSE
    loc:NombreCliente = ''
  END
  PARENT.SetQueueRecord
  
  SELF.Q.FAC:Fecha_NormalFG = -1                           ! Set color values for FAC:Fecha
  SELF.Q.FAC:Fecha_NormalBG = -1
  SELF.Q.FAC:Fecha_SelectedFG = -1
  SELF.Q.FAC:Fecha_SelectedBG = -1
  IF (FAC:Cobrada)
    SELF.Q.FAC:Fecha_Icon = 1                              ! Set icon from icon list
  ELSE
    SELF.Q.FAC:Fecha_Icon = 0
  END
  SELF.Q.FAC:Letra_NormalFG = -1                           ! Set color values for FAC:Letra
  SELF.Q.FAC:Letra_NormalBG = -1
  SELF.Q.FAC:Letra_SelectedFG = -1
  SELF.Q.FAC:Letra_SelectedBG = -1
  SELF.Q.FAC:Lugar_NormalFG = -1                           ! Set color values for FAC:Lugar
  SELF.Q.FAC:Lugar_NormalBG = -1
  SELF.Q.FAC:Lugar_SelectedFG = -1
  SELF.Q.FAC:Lugar_SelectedBG = -1
  SELF.Q.FAC:Numero_NormalFG = -1                          ! Set color values for FAC:Numero
  SELF.Q.FAC:Numero_NormalBG = -1
  SELF.Q.FAC:Numero_SelectedFG = -1
  SELF.Q.FAC:Numero_SelectedBG = -1
  SELF.Q.FAC:ClienteFacturar_NormalFG = -1                 ! Set color values for FAC:ClienteFacturar
  SELF.Q.FAC:ClienteFacturar_NormalBG = -1
  SELF.Q.FAC:ClienteFacturar_SelectedFG = -1
  SELF.Q.FAC:ClienteFacturar_SelectedBG = -1
  SELF.Q.loc:NombreCliente_NormalFG = -1                   ! Set color values for loc:NombreCliente
  SELF.Q.loc:NombreCliente_NormalBG = -1
  SELF.Q.loc:NombreCliente_SelectedFG = -1
  SELF.Q.loc:NombreCliente_SelectedBG = -1
  SELF.Q.FAC:FacturarA_NormalFG = -1                       ! Set color values for FAC:FacturarA
  SELF.Q.FAC:FacturarA_NormalBG = -1
  SELF.Q.FAC:FacturarA_SelectedFG = -1
  SELF.Q.FAC:FacturarA_SelectedBG = -1
  SELF.Q.FAC:Importe_NormalFG = -1                         ! Set color values for FAC:Importe
  SELF.Q.FAC:Importe_NormalBG = -1
  SELF.Q.FAC:Importe_SelectedFG = -1
  SELF.Q.FAC:Importe_SelectedBG = -1
  SELF.Q.FAC:Cobrada_NormalFG = -1                         ! Set color values for FAC:Cobrada
  SELF.Q.FAC:Cobrada_NormalBG = -1
  SELF.Q.FAC:Cobrada_SelectedFG = -1
  SELF.Q.FAC:Cobrada_SelectedBG = -1

