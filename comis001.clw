

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS004.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS007.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS009.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS024.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS027.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS033.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS037.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS039.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS042.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS043.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS044.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS049.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS052.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS055.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS056.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS057.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS059.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS061.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS065.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS069.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS071.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS076.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS078.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS082.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS083.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS086.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS094.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS095.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS096.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS100.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS101.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS102.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS103.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS106.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS109.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS114.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS117.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS118.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS125.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS126.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS127.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS128.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS138.INC'),ONCE        !Req'd for module callout resolution
                     END


Main PROCEDURE                                             ! Generated from procedure template - Frame

FilesOpened          BYTE                                  !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
AppFrame             APPLICATION('COMISIONES   GamaSoft'),AT(,,527,314),FONT('MS Sans Serif',8,,),ICON('C:\Comisiones\ComisionesSRL\botones\camion.ICO'),STATUS(-1,150,45),WALLPAPER('fondo.jpg'),SYSTEM,MAX,MAXIMIZE,RESIZE,IMM
                       MENUBAR
                         MENU('&Archivo'),USE(?FileMenu)
                           ITEM('Configurar Impresora...'),USE(?PrintSetup),STD(STD:PrintSetup)
                           ITEM,SEPARATOR
                           MENU('Parametros'),USE(?ArchivoParametros)
                             ITEM('Empresa N<186> 1'),USE(?ArchivoParametros1)
                             ITEM('Empresa N<186> 3'),USE(?ArchivoParametros3)
                           END
                           MENU('Administración'),USE(?ArchivoAdministración)
                             ITEM('Anula Impresión'),USE(?ArchivoAdministracionAnulaImpresión)
                             ITEM('Anula Cobranza'),USE(?ArchivoAdministracionAnulaCobranza)
                             ITEM('Anula Remito-Guía'),USE(?ArchivoAdministracionAnulaRemitoGuía)
                             ITEM,SEPARATOR
                             ITEM('Genera Facturas Anuladas'),USE(?ArchivoAdministraciónGeneraFacturasAnuladas)
                             ITEM,SEPARATOR
                             ITEM('Generar Archivo CITI Ventas'),USE(?ArchivoAdministracionGenerarArchivoCITIVentas)
                             ITEM('Regimen de Compras y Ventas'),USE(?ArchivoAdministracionRegimenComprasYVentas)
                           END
                           ITEM,SEPARATOR
                           ITEM('Salir'),USE(?Exit),STD(STD:Close)
                         END
                         MENU('&Tablas'),USE(?BrowseMenu)
                           ITEM('Distribuidores'),USE(?TablasDistribuidores)
                           ITEM('Transportes'),USE(?TablasTransportes)
                           ITEM,SEPARATOR
                           ITEM('Bancos'),USE(?TablasBancos)
                           ITEM('Valores'),USE(?TablasValores)
                           ITEM,SEPARATOR
                           ITEM('Destinos'),USE(?TablasDestinos)
                           ITEM('Localidades'),USE(?TablasLocalidades)
                           ITEM('Provincias'),USE(?TablasProvincias)
                           ITEM('Zonas'),USE(?TablasZonas)
                         END
                         MENU('&Listados'),USE(?Listados)
                           MENU('Hoja de Ruta'),USE(?ListadosHojadeRuta)
                             ITEM('General'),USE(?ListadosHojadeRutaGeneral)
                             ITEM('Por Distribuidor'),USE(?ListadosHojadeRutaPorDistribuidor)
                             ITEM('Por Empresa'),USE(?ListadosHojadeRutaPorEmpresa)
                           END
                           ITEM,SEPARATOR
                           MENU('Clientes'),USE(?ListadosClientes)
                             ITEM('Padrón por Nombre'),USE(?ListadosClientesPadrnporNombre)
                             ITEM,SEPARATOR
                             ITEM('Movimiento General'),USE(?ListadosClientesMovimientoGeneral)
                             ITEM('Guías Sin Facturar'),USE(?ListadosClientesGuíasSinFacturar)
                             ITEM('Resumen de Cuenta'),USE(?ListadosClientesResumendeCuenta)
                           END
                           ITEM,SEPARATOR
                           MENU('Facturación'),USE(?ListadosFacturacion)
                             ITEM('Facturas Impagas'),USE(?ListadosFacturacionFacturasImpagas)
                             ITEM('Facturas Impagas por Cliente'),USE(?ListadosFacturacionFacturasImpagasporCliente)
                             ITEM,SEPARATOR
                             ITEM('Subdiario IVA Compras'),USE(?ListadosFacturacionIVACompras)
                             ITEM('Subdiario IVA Ventas'),USE(?ListadosFacturacionIVAVentas)
                           END
                           ITEM,SEPARATOR
                           MENU('Contra Reembolsos'),USE(?ListadosContraReembolsos)
                             ITEM('Cobrados por Fecha'),USE(?ListadosContraReembolsosCobrados)
                             ITEM,SEPARATOR
                             ITEM('Impagos General'),USE(?ListadosContraReembolsosImpagosGeneral)
                             ITEM('Impagos por Transporte'),USE(?ListadosContraReembolsosImpagosporTransporte)
                           END
                           ITEM('Guías Sin Facturar'),USE(?ListadosGuasSinFacturar)
                           ITEM('Redespachos'),USE(?ListadosRedespachos)
                           ITEM,SEPARATOR
                           ITEM('Visitas Programadas'),USE(?ListadosVisitasProgramadas)
                         END
                         MENU('&Reimpresiones'),USE(?Reimpresiones)
                           ITEM('Remito-Guía'),USE(?ReimpresionesRemitoGua)
                           ITEM('Recibo Contra Reembolso'),USE(?ReimpresionesReciboContraReembolso)
                         END
                         ITEM('A&utor'),USE(?Autor)
                       END
                       TOOLBAR,AT(0,0,400,27),CURSOR(CURSOR:None),WALLPAPER('fondo.gif'),TILED
                         LINE,AT(28,0,0,27),USE(?Line1:4),COLOR(04B4B4BH),LINEWIDTH(2)
                         BUTTON,AT(0,0,27,27),USE(?Button01),FLAT,LEFT,TIP('Clientes'),ICON('C:\Comisiones\ComisionesSRL\botones\clientes.ico')
                         BUTTON,AT(189,0,30,27),USE(?Button06),FONT('Arial',6,COLOR:Navy,FONT:regular),TIP('Remitos-Guía'),ICON('C:\Comisiones\ComisionesSRL\botones\movi.ico')
                         LINE,AT(86,0,0,27),USE(?Line1:2),COLOR(04B4B4BH),LINEWIDTH(2)
                         BUTTON,AT(87,0,27,27),USE(?Button04),FLAT,TIP('Proveedores'),ICON('C:\Comisiones\ComisionesSRL\botones\proveedor.ico')
                         LINE,AT(115,0,0,27),USE(?Line1:3),COLOR(04B4B4BH),LINEWIDTH(2)
                         BUTTON,AT(116,0,27,27),USE(?Button05),FLAT,TIP('Compras'),ICON('C:\Comisiones\ComisionesSRL\botones\anotador.ico')
                         LINE,AT(143,0,0,27),USE(?Line1:5),COLOR(04B4B4BH),LINEWIDTH(2)
                         BUTTON,AT(58,0,27,27),USE(?Button03),FLAT,TIP('Redespachos'),ICON('C:\Comisiones\ComisionesSRL\botones\camion2.ico')
                         BOX,AT(178,0,12,27),USE(?Box1),FILL(0804000H)
                         BUTTON,AT(220,0,30,27),USE(?Button07),FONT('Arial',6,COLOR:Navy,FONT:regular),TIP('Facturas'),ICON('C:\Comisiones\ComisionesSRL\botones\facturacion.ico')
                         BUTTON,AT(303,0,30,27),USE(?Button09),FONT('Arial',6,COLOR:Green,FONT:regular),TIP('Remitos-Guía'),ICON('C:\Comisiones\ComisionesSRL\botones\movi.ico')
                         BOX,AT(291,0,12,27),USE(?Box3),FILL(COLOR:Green)
                         BUTTON,AT(334,0,30,27),USE(?Button10),FONT('Arial',6,COLOR:Green,FONT:regular),TIP('Facturas'),ICON('C:\Comisiones\ComisionesSRL\botones\facturacion.ico')
                         BUTTON,AT(455,0,30,27),USE(?Salir),FLAT,TIP('Salir del Programa'),ICON('C:\Comisiones\ComisionesSRL\botones\salir.ICO'),STD(STD:Close)
                         BUTTON,AT(365,0,30,27),USE(?Button11),FONT('Arial',6,COLOR:Green,FONT:regular),TIP('Recibos'),ICON('C:\Comisiones\ComisionesSRL\botones\cheque.ico')
                         BUTTON,AT(251,0,30,27),USE(?Button08),FONT('Arial',6,COLOR:Navy,FONT:regular),TIP('Recibos'),ICON('C:\Comisiones\ComisionesSRL\botones\cheque.ico')
                         LINE,AT(57,0,0,27),USE(?Line1),COLOR(04B4B4BH),LINEWIDTH(2)
                         BUTTON,AT(29,0,27,27),USE(?Button02),FLAT,TIP('Agenda'),ICON('C:\Comisiones\ComisionesSRL\botones\agenda.ico')
                       END
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass

  CODE
? DEBUGHOOK(CLIENTES:Record)
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::ArchivoParametros ROUTINE                            ! Code for menu items on ?ArchivoParametros
  CASE ACCEPTED()
  OF ?ArchivoParametros1
    PARAMETRO_1
  OF ?ArchivoParametros3
    PARAMETRO_3
  END
Menu::ArchivoAdministración ROUTINE                        ! Code for menu items on ?ArchivoAdministración
  CASE ACCEPTED()
  OF ?ArchivoAdministracionAnulaImpresión
    AnulaImpresion
  OF ?ArchivoAdministracionAnulaCobranza
    AnulaCobranza
  OF ?ArchivoAdministracionAnulaRemitoGuía
    AnulaGuia
  OF ?ArchivoAdministraciónGeneraFacturasAnuladas
    GeneraFacturasAnuladas
  OF ?ArchivoAdministracionGenerarArchivoCITIVentas
    CITIVentas
  OF ?ArchivoAdministracionRegimenComprasYVentas
    Abrir_Regimen_Compras_y_Ventas
  END
Menu::BrowseMenu ROUTINE                                   ! Code for menu items on ?BrowseMenu
  CASE ACCEPTED()
  OF ?TablasDistribuidores
    START(DISTRIBUIDORES, 50000)
  OF ?TablasTransportes
    START(TRANSPORTES, 50000)
  OF ?TablasBancos
    START(BANCOS, 50000)
  OF ?TablasValores
    START(VALORES, 50000)
  OF ?TablasDestinos
    START(DESTINOS, 50000)
  OF ?TablasLocalidades
    START(LOCALIDADES, 050000)
  OF ?TablasProvincias
    START(PROVINCIAS, 050000)
  OF ?TablasZonas
    START(ZONAS, 050000)
  END
Menu::Listados ROUTINE                                     ! Code for menu items on ?Listados
  CASE ACCEPTED()
  OF ?ListadosGuasSinFacturar
    WinGuiasSinFacturar
  OF ?ListadosRedespachos
    WinRedespacho
  OF ?ListadosVisitasProgramadas
    WinVisitasProgramadas
  END
Menu::ListadosHojadeRuta ROUTINE                           ! Code for menu items on ?ListadosHojadeRuta
  CASE ACCEPTED()
  OF ?ListadosHojadeRutaGeneral
    WinHojaRuta
  OF ?ListadosHojadeRutaPorDistribuidor
    WinHojaRutaDistribuidor
  OF ?ListadosHojadeRutaPorEmpresa
    WinHojaRutaEmpresa
  END
Menu::ListadosClientes ROUTINE                             ! Code for menu items on ?ListadosClientes
  CASE ACCEPTED()
  OF ?ListadosClientesPadrnporNombre
    PadronClientesNombre
  OF ?ListadosClientesMovimientoGeneral
    START(WinMovimientosCliente, 25000)
  OF ?ListadosClientesGuíasSinFacturar
    START(WinGuiasPendientesFacturar, 25000)
  OF ?ListadosClientesResumendeCuenta
    START(WinResumenCtaCte, 25000)
  END
Menu::ListadosFacturacion ROUTINE                          ! Code for menu items on ?ListadosFacturacion
  CASE ACCEPTED()
  OF ?ListadosFacturacionFacturasImpagas
    WinFacturasImpagas
  OF ?ListadosFacturacionFacturasImpagasporCliente
    FacturasImpagasGeneral
  OF ?ListadosFacturacionIVACompras
    WinSubdiarioIVACompras
  OF ?ListadosFacturacionIVAVentas
    WinSubdiarioIVAVentas
  END
Menu::ListadosContraReembolsos ROUTINE                     ! Code for menu items on ?ListadosContraReembolsos
  CASE ACCEPTED()
  OF ?ListadosContraReembolsosCobrados
    WinContraReembolsoCobrados
  OF ?ListadosContraReembolsosImpagosGeneral
    WinContraReembolsoImpagos
  OF ?ListadosContraReembolsosImpagosporTransporte
    WinContraReembolsosTransporte
  END
Menu::Reimpresiones ROUTINE                                ! Code for menu items on ?Reimpresiones
  CASE ACCEPTED()
  OF ?ReimpresionesRemitoGua
    WinReimpresionGuia
  OF ?ReimpresionesReciboContraReembolso
    WinReciboContraReembolso
  END

ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(AppFrame{Prop:Timer},1,100)
    AppFrame{Prop:Timer} = 100
  END
    AppFrame{Prop:StatusText,2} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@d18)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
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
  END
  GlobalErrors.SetProcedureName
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
    ELSE
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::ArchivoParametros                           ! Process menu items on ?ArchivoParametros menu
      DO Menu::ArchivoAdministración                       ! Process menu items on ?ArchivoAdministración menu
      DO Menu::BrowseMenu                                  ! Process menu items on ?BrowseMenu menu
      DO Menu::Listados                                    ! Process menu items on ?Listados menu
      DO Menu::ListadosHojadeRuta                          ! Process menu items on ?ListadosHojadeRuta menu
      DO Menu::ListadosClientes                            ! Process menu items on ?ListadosClientes menu
      DO Menu::ListadosFacturacion                         ! Process menu items on ?ListadosFacturacion menu
      DO Menu::ListadosContraReembolsos                    ! Process menu items on ?ListadosContraReembolsos menu
      DO Menu::Reimpresiones                               ! Process menu items on ?Reimpresiones menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Autor
      START(Autor, 25000)
    OF ?Button01
      START(CLIENTES, 25000)
    OF ?Button06
      START(GUIAS_EMPRESA1, 25000)
    OF ?Button04
      START(PROVEEDORES, 50000)
    OF ?Button05
      START(COMPRAS, 50000)
    OF ?Button03
      START(REDESPACHOS, 25000)
    OF ?Button07
      START(FACTURAS_EMPRESA1, 25000)
    OF ?Button09
      START(GUIAS_EMPRESA3, 25000)
    OF ?Button10
      START(FACTURAS_EMPRESA3, 25000)
    OF ?Button11
      START(RECIBOS_EMPRESA3, 50000)
    OF ?Button08
      START(RECIBOS_EMPRESA1, 25000)
    OF ?Button02
      START(AGENDA, 25000)
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
    CASE EVENT()
    OF EVENT:OpenWindow
      ThisWindow{PROP:Statustext,3} = 'GamaSoft'
    OF Event:Timer
      AppFrame{Prop:StatusText,2} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@d18)
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

