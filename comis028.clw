

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS028.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS018.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS036.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS045.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS046.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS048.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS091.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS119.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS131.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS132.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdateFACTURAS1 PROCEDURE                                  ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
loc:SumaCUIT         DECIMAL(7,2)                          !
loc:DigitoVerificador BYTE                                 !
loc:FormaPago        STRING(1)                             !
loc:RteEsCliente     STRING(1)                             !
loc:DesEsCliente     STRING(1)                             !
loc:TotalContado     DECIMAL(11,2)                         !
loc:TotalCtaCte      DECIMAL(11,2)                         !
loc:TotalFacturar    DECIMAL(11,2)                         !
loc:CategIVARemitente STRING(20)                           !
loc:CategIVADestino  BYTE                                  !
loc:mitadiva         BYTE                                  !
GRece                GROUP,PRE()                           !
Loc:Es_Servicio      BYTE                                  !
Loc:Fecha            DATE                                  !
Loc:Tipo_Comprobante SHORT                                 !
Loc:NumeroDesde      LONG                                  !
Loc:Tipo_Documento   SHORT                                 !
Loc:Cliente_Documento DECIMAL(11)                          !
Loc:Cliente_Nombre   STRING(30)                            !
L:Cliente_Domicilio  CSTRING(256)                          !
Loc:ImporteTotal     DECIMAL(11,2)                         !
Loc:ImporteGravado   DECIMAL(11,2)                         !
Loc:ImporteNoGravado DECIMAL(11,2)                         !
Loc:Monto_IVA_Inscripto DECIMAL(11,2)                      !
Loc:Monto_IVA_No_Inscripto DECIMAL(11,2)                   !
Loc:Importe_Exento   DECIMAL(11,2)                         !
Loc:Percep_Nac       STRING(20)                            !
Loc:Percep_IIBB      DECIMAL(20,2)                         !
Loc:Percep_Mun       STRING(20)                            !
Loc:Impuestos_Internos DECIMAL(10,2)                       !
Loc:Transaporte      DECIMAL(10,2)                         !
Loc:Cliente_TipoIVA  SHORT                                 !
Loc:CodigoMoneda     STRING(3)                             !
Loc:TipoCambio       DECIMAL(10,2)                         !
Loc:Cantidad_Alicuotas_IVA SHORT                           !
Loc:Servicio_FechaInicio DATE                              !
Loc:Servicio_FechaFin DATE                                 !
Loc:Servicio_FechaPago DATE                                !
Loc:Monto_IVA_Inscripto10 DECIMAL(11,2)                    !
                     END                                   !
Loc:Error1           SHORT                                 !
L:Tipo_Expo          BYTE                                  !
L:Idioma_Cbte        BYTE                                  !
L:Pais_DST           STRING(3)                             !
L:IncoTerms          STRING(3)                             !
L:CUIT_Dst           LONG                                  !
L:Forma_Pago         CSTRING(51)                           !
loc_CAE_Exitente     LONG                                  !
LOC:ImporteIVA       DECIMAL(20,2)                         !
LOC:CantReg          SHORT                                 !
LOC:Moneda           STRING(3)                             !
LOC:MonedaCotizacion DECIMAL(10,6)                         !
LOC:ImporteTributo   DECIMAL(20,2)                         !
LOC:Concepto         BYTE                                  !
LOC:Comando          CSTRING(101)                          !
loc_porcentaje       DECIMAL(7,2)                          !
neto_B               DECIMAL(11,2)                         !
iva21_B              DECIMAL(11,2)                         !
iva105_B             DECIMAL(11,2)                         !
loc_tipo_doc         STRING(3)                             !
loc_nro_doc          LONG                                  !
loc:baseimponible21  DECIMAL(11,2)                         !
loc:baseimponible105 DECIMAL(11,2)                         !
loc:FacturaElectronica BYTE                                !
loc:Tipo             STRING(20)                            !
loc:estado_fe        STRING(20)                            !
loc:descripcion_comprobante STRING(40)                     !
loc:mensaje_fe       STRING(200)                           !
loc:cae              STRING(30)                            !
loc:comprobante_autorizado STRING(10)                      !
loc_vencimiento_cae  STRING(10)                            !
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
Queue:FileDrop       QUEUE                            !Queue declaration for browse/combo box using ?IVAD:Descripcion
IVAD:Descripcion       LIKE(IVAD:Descripcion)         !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDrop:1     QUEUE                            !Queue declaration for browse/combo box using ?IVAR:Descripcion
IVAR:Descripcion       LIKE(IVAR:Descripcion)         !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW3::View:Browse    VIEW(GUIAS)
                       PROJECT(GUIA:Fecha)
                       PROJECT(GUIA:Letra)
                       PROJECT(GUIA:Lugar)
                       PROJECT(GUIA:Numero)
                       PROJECT(GUIA:Importe)
                       PROJECT(GUIA:RegGuia)
                       PROJECT(GUIA:ClienteFacturar)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
GUIA:Fecha             LIKE(GUIA:Fecha)               !List box control field - type derived from field
GUIA:Letra             LIKE(GUIA:Letra)               !List box control field - type derived from field
GUIA:Lugar             LIKE(GUIA:Lugar)               !List box control field - type derived from field
GUIA:Numero            LIKE(GUIA:Numero)              !List box control field - type derived from field
GUIA:Importe           LIKE(GUIA:Importe)             !List box control field - type derived from field
GUIA:RegGuia           LIKE(GUIA:RegGuia)             !Primary key field - type derived from field
GUIA:ClienteFacturar   LIKE(GUIA:ClienteFacturar)     !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW8::View:Browse    VIEW(APLIGUIA)
                       PROJECT(APGUIA:Factura)
                       PROJECT(APGUIA:Guia)
                       JOIN(GUIA:Por_Registro,APGUIA:Guia)
                         PROJECT(GUIA:Fecha)
                         PROJECT(GUIA:Letra)
                         PROJECT(GUIA:Lugar)
                         PROJECT(GUIA:Numero)
                         PROJECT(GUIA:Importe)
                         PROJECT(GUIA:RegGuia)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
GUIA:Fecha             LIKE(GUIA:Fecha)               !List box control field - type derived from field
GUIA:Letra             LIKE(GUIA:Letra)               !List box control field - type derived from field
GUIA:Lugar             LIKE(GUIA:Lugar)               !List box control field - type derived from field
GUIA:Numero            LIKE(GUIA:Numero)              !List box control field - type derived from field
GUIA:Importe           LIKE(GUIA:Importe)             !List box control field - type derived from field
APGUIA:Factura         LIKE(APGUIA:Factura)           !Primary key field - type derived from field
APGUIA:Guia            LIKE(APGUIA:Guia)              !Primary key field - type derived from field
GUIA:RegGuia           LIKE(GUIA:RegGuia)             !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW10::View:Browse   VIEW(ITEMFAC)
                       PROJECT(ITFAC:Cantidad)
                       PROJECT(ITFAC:Descripcion)
                       PROJECT(ITFAC:Importe)
                       PROJECT(ITFAC:RegFactura)
                       PROJECT(ITFAC:Item)
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
ITFAC:Cantidad         LIKE(ITFAC:Cantidad)           !List box control field - type derived from field
ITFAC:Descripcion      LIKE(ITFAC:Descripcion)        !List box control field - type derived from field
ITFAC:Importe          LIKE(ITFAC:Importe)            !List box control field - type derived from field
ITFAC:RegFactura       LIKE(ITFAC:RegFactura)         !Primary key field - type derived from field
ITFAC:Item             LIKE(ITFAC:Item)               !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
FDCB13::View:FileDropCombo VIEW(LOCALIDA)
                       PROJECT(LOC:Localidad)
                     END
FDCB15::View:FileDropCombo VIEW(LOCALIDAD2)
                       PROJECT(LOC2:Localidad)
                     END
FDB7::View:FileDrop  VIEW(CATIVADES)
                       PROJECT(IVAD:Descripcion)
                     END
FDB9::View:FileDrop  VIEW(CATIVAREM)
                       PROJECT(IVAR:Descripcion)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
History::FAC:Record  LIKE(FAC:RECORD),THREAD
WS_Window WINDOW,AT(,,358,132),FONT('MS Sans Serif',8,,FONT:regular),CENTER,WALLPAPER('fondo.jpg'),CENTERED, |
         GRAY
       STRING(@s50),AT(53,12,251,14),USE(glo_nombre_usuario),TRN,CENTER,FONT(,12,COLOR:White,FONT:bold,CHARSET:ANSI)
       TEXT,AT(15,36,323,60),USE(glo:mensage),SKIP,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI),COLOR(0C7DEDBH), |
           READONLY
     END
QuickWindow          WINDOW('Update the FACTURAS File'),AT(,,529,353),FONT('MS Sans Serif',8,,),COLOR(0BFDFDFH),CENTER,IMM,GRAY,DOUBLE,MDI
                       STRING('FACTURA'),AT(213,18,41,10),USE(?String12),TRN,FONT('Arial',10,COLOR:White,FONT:bold)
                       STRING('Cobrar a:'),AT(17,1),USE(?String8),TRN,FONT(,,,FONT:bold)
                       OPTION('Facturar A'),AT(58,0,115,14),USE(FAC:FacturarA)
                         RADIO('Remitente'),AT(64,1),USE(?FAC:FacturarA:Radio1),TRN,VALUE('R')
                         RADIO('Destinatario'),AT(118,1),USE(?FAC:FacturarA:Radio2),TRN,VALUE('D')
                       END
                       STRING('Forma Pago:'),AT(203,1),USE(?String8:2),TRN,FONT(,,,FONT:bold)
                       OPTION,AT(256,0,95,14),USE(loc:FormaPago),SKIP,TRN
                         RADIO('Contado'),AT(260,1),USE(?loc:FormaPago:Radio1),TRN,VALUE('C')
                         RADIO('Cta.Cte.'),AT(308,1),USE(?loc:FormaPago:Radio2),TRN,VALUE('F')
                       END
                       PANEL,AT(0,11,524,33),USE(?Panel1),FILL(0804000H),BEVEL(-1)
                       STRING('Número:'),AT(11,15),USE(?String1),TRN,FONT(,,COLOR:White,FONT:bold)
                       ENTRY(@s1),AT(45,15,12,10),USE(FAC:Letra),SKIP,TRN,CENTER,FONT(,,COLOR:White,FONT:bold),REQ,UPR,READONLY
                       ENTRY(@n04),AT(60,15,23,10),USE(FAC:Lugar),SKIP,TRN,RIGHT(1),FONT(,,COLOR:White,FONT:bold),REQ,READONLY
                       ENTRY(@n08),AT(85,15,40,10),USE(FAC:Numero),SKIP,TRN,RIGHT(1),FONT(,,COLOR:White,FONT:bold),REQ
                       PROMPT('Fecha:'),AT(382,15),USE(?FAC:Fecha:Prompt),TRN,FONT(,,COLOR:White,FONT:bold)
                       ENTRY(@d6b),AT(416,15,49,10),USE(FAC:Fecha),SKIP,RIGHT(1),COLOR(0F5F5F5H),REQ
                       OPTION,AT(191,15,107,26),USE(loc:Tipo)
                         RADIO,AT(199,18),USE(?loc:Tipo:Radio6),TRN,VALUE('FAC')
                         RADIO,AT(199,29),USE(?loc:Tipo:Radio7),TRN,VALUE('NC')
                       END
                       CHECK('Factura Electrónica'),AT(10,29),USE(loc:FacturaElectronica),TRN,FONT(,,COLOR:White,FONT:bold,CHARSET:ANSI)
                       STRING('NOTA DE CREDITO'),AT(211,28,79,10),USE(?String12:2),TRN,FONT('Arial',10,COLOR:White,FONT:bold)
                       PROMPT('Remitente:'),AT(47,50),USE(?FAC:Remitente:Prompt),TRN,FONT(,,,FONT:bold)
                       CHECK('Es Cliente?'),AT(93,50),USE(loc:RteEsCliente),TRN,LEFT,VALUE('S','N')
                       BUTTON,AT(153,49,12,11),USE(?SelectRemitente),DISABLE,FLAT,TIP('Seleccionar Remitente'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                       ENTRY(@n6.b),AT(167,50,33,10),USE(FAC:Remitente),SKIP,DISABLE,RIGHT(1),COLOR(0F5F5F5H)
                       BOX,AT(47,61,173,64),USE(?BoxRemitente),ROUND,COLOR(COLOR:Black)
                       PROMPT('Nombre:'),AT(53,64),USE(?FAC:NombreRemitente:Prompt),TRN
                       ENTRY(@s40),AT(91,64,126,10),USE(FAC:NombreRemitente),COLOR(0F5F5F5H),UPR
                       PROMPT('CUIT:'),AT(53,76),USE(?FAC:CUITRemitente:Prompt),TRN
                       ENTRY(@P##-########-#Pb),AT(91,76,54,10),USE(FAC:CUITRemitente),COLOR(0F5F5F5H),UPR
                       LIST,AT(147,76,69,10),USE(IVAR:Descripcion),COLOR(0F5F5F5H),FORMAT('100L(2)|@s25@'),DROP(5),FROM(Queue:FileDrop:1)
                       PROMPT('Dirección:'),AT(53,88),USE(?FAC:DireccionRemitente:Prompt),TRN
                       ENTRY(@s30),AT(91,88,126,10),USE(FAC:DireccionRemitente),COLOR(0F5F5F5H),UPR
                       STRING('Localidad:'),AT(53,100),USE(?Localidad),TRN
                       COMBO(@s30),AT(91,100,126,10),USE(LOC:Localidad),IMM,COLOR(0F5F5F5H),UPR,FORMAT('120L(2)@s30@'),DROP(5),FROM(Queue:FileDropCombo)
                       PROMPT('Teléfono:'),AT(53,112),USE(?FAC:TelefonoRemitente:Prompt),TRN
                       ENTRY(@s35),AT(91,112,126,10),USE(FAC:TelefonoRemitente),COLOR(0F5F5F5H),UPR
                       CHECK('50 % de IVA'),AT(197,128),USE(loc:mitadiva)
                       BOX,AT(280,61,173,64),USE(?BoxDestino),ROUND,COLOR(COLOR:Black)
                       PROMPT('Destinatario:'),AT(280,50),USE(?FAC:Destinatario:Prompt),TRN,FONT(,,,FONT:bold)
                       CHECK('Es Cliente?'),AT(330,50),USE(loc:DesEsCliente),TRN,LEFT,VALUE('S','N')
                       BUTTON,AT(390,50,12,12),USE(?SelectDestinatario),DISABLE,FLAT,TIP('Seleccionar Destinatario'),ICON('C:\Comisiones\ComisionesSRL\botones\lookup.ico')
                       ENTRY(@n6.b),AT(406,50,33,10),USE(FAC:Destinatario),SKIP,DISABLE,RIGHT(1),COLOR(0F5F5F5H)
                       PROMPT('Nombre:'),AT(286,64),USE(?FAC:NombreDestino:Prompt),TRN
                       ENTRY(@s40),AT(322,64,126,10),USE(FAC:NombreDestino),COLOR(0F5F5F5H),UPR
                       PROMPT('CUIT:'),AT(286,77),USE(?FAC:CUITDestino:Prompt),TRN
                       ENTRY(@P##-########-#Pb),AT(322,77,54,10),USE(FAC:CUITDestino),COLOR(0F5F5F5H)
                       LIST,AT(380,77,69,10),USE(IVAD:Descripcion),COLOR(0F5F5F5H),FORMAT('100L(2)|@s25@'),DROP(5),FROM(Queue:FileDrop)
                       PROMPT('Dirección:'),AT(286,88),USE(?FAC:DireccionDestino:Prompt),TRN
                       ENTRY(@s30),AT(322,88,126,10),USE(FAC:DireccionDestino),COLOR(0F5F5F5H),UPR
                       STRING('Localidad:'),AT(286,101),USE(?Localidad:2),TRN
                       COMBO(@s30),AT(322,101,126,10),USE(LOC2:Localidad),IMM,COLOR(0F5F5F5H),UPR,FORMAT('120L(2)@s30@'),DROP(5),FROM(Queue:FileDropCombo:1)
                       PROMPT('Teléfono:'),AT(286,112),USE(?FAC:TelefonoDestino:Prompt),TRN
                       ENTRY(@s35),AT(322,112,126,10),USE(FAC:TelefonoDestino),COLOR(0F5F5F5H),UPR
                       SHEET,AT(10,128,478,95),USE(?Sheet1),ABOVE(68)
                         TAB('Contado'),USE(?Contado)
                           LIST,AT(65,147,301,49),USE(?List:3),IMM,COLOR(0F5F5F5H),FORMAT('40R(3)|F~Cantidad~L(2)@n10.2@160L(2)|F~Descripción~@s40@40R(3)|F~Importe~L(2)@n1' &|
   '5.2@'),FROM(Queue:Browse:2)
                           BUTTON('Agregar'),AT(65,201,42,12),USE(?Insert),SKIP
                           BUTTON('Modificar'),AT(107,201,42,12),USE(?Change),SKIP
                           BUTTON('Borrar'),AT(149,201,42,12),USE(?Delete),SKIP
                           STRING(@n-12.2),AT(315,201),USE(loc:TotalContado),TRN,RIGHT(1),FONT(,,,FONT:bold)
                         END
                         TAB('Cuenta Corriente'),USE(?CuentaCorriente)
                           STRING('Remitos-Guía en Cta. Cte.'),AT(17,144),USE(?String3),TRN,FONT(,,COLOR:Green,FONT:bold)
                           STRING('Remitos a Facturar'),AT(257,146),USE(?String4),TRN,FONT(,,COLOR:Maroon,FONT:bold)
                           LIST,AT(17,153,202,50),USE(?List),IMM,NOBAR,VSCROLL,COLOR(0F5F5F5H,COLOR:Black,0FFFF80H),FORMAT('47R(3)|F~Fecha~L(2)@d6@[8CF@s1@21R(2)F@n04@33R(2)|F@n08@](65)|F~Comprobante~L(2)' &|
   '48R(3)|F~Importe~C(0)@n12.2@'),FROM(Queue:Browse)
                           LIST,AT(257,155,199,49),USE(?List:2),IMM,NOBAR,VSCROLL,COLOR(0F5F5F5H,COLOR:Black,0FFFF80H),FORMAT('47R(3)|F~Fecha~L(2)@d6@[8CF@s1@21R(2)F@n04@39R(2)|F@n08@](65)|F~Comprobante~L(2)' &|
   '48R(3)|F~Importe~C(0)@n12.2@'),FROM(Queue:Browse:1)
                           BUTTON,AT(231,164,17,14),USE(?Facturar),SKIP,FLAT,TIP('Facturar'),ICON('C:\Comisiones\ComisionesSRL\botones\aplica.ico')
                           BUTTON,AT(231,180,17,14),USE(?Volver),SKIP,FLAT,TIP('Volver a Cta. Cte.'),ICON('C:\Comisiones\ComisionesSRL\botones\desaplica.ico')
                           STRING(@n-12.2),AT(163,205),USE(loc:TotalCtaCte),TRN,RIGHT(1),FONT(,,,FONT:bold)
                           STRING(@n-15.2),AT(387,207),USE(loc:TotalFacturar),TRN,RIGHT(1),FONT(,,,FONT:bold)
                         END
                       END
                       OPTION('Tipo de Servicio'),AT(136,232,63,31),USE(FAC:TipoServicio),BOXED
                         RADIO('Transporte'),AT(147,242),USE(?FAC:TipoServicio:Radio1),TRN,VALUE('T')
                         RADIO('Comisión'),AT(147,250),USE(?FAC:TipoServicio:Radio2),TRN,VALUE('C')
                       END
                       PROMPT('Valor Declarado:'),AT(142,264),USE(?FAC:ValorDeclarado:Prompt),TRN
                       ENTRY(@n10.2),AT(142,272,53,10),USE(FAC:ValorDeclarado),RIGHT(1),COLOR(0F5F5F5H)
                       OPTION('Flete'),AT(231,232,53,51),USE(FAC:Flete),BOXED
                         RADIO('Origen'),AT(237,246),USE(?FAC:Flete:Radio1),TRN,VALUE('R')
                         RADIO('Intermedio'),AT(237,258),USE(?FAC:Flete:Radio2),TRN,VALUE('I')
                         RADIO('Destino'),AT(237,270),USE(?FAC:Flete:Radio3),TRN,VALUE('D')
                       END
                       BOX,AT(332,233,154,50),USE(?Box1),ROUND,COLOR(COLOR:Black),FILL(0E2E2E2H)
                       PROMPT('Flete Básico:'),AT(336,235),USE(?FAC:Neto:Prompt),TRN
                       ENTRY(@n-15.2),AT(383,235,88,10),USE(FAC:Neto),SKIP,RIGHT(1),READONLY
                       PROMPT('Seguro:'),AT(352,247),USE(?FAC:Seguro:Prompt),TRN
                       ENTRY(@n15.2),AT(383,247,88,10),USE(FAC:Seguro),RIGHT(1),COLOR(0F5F5F5H)
                       PROMPT('IVA:'),AT(363,259),USE(?FAC:IVA:Prompt),TRN
                       ENTRY(@n-15.2),AT(383,259,88,10),USE(FAC:IVA),SKIP,RIGHT(2),READONLY
                       PROMPT('TOTAL:'),AT(347,271),USE(?FAC:Importe:Prompt),TRN,FONT(,,,FONT:bold)
                       ENTRY(@n-15.2),AT(383,271,88,10),USE(FAC:Importe),SKIP,RIGHT(1),FONT(,,,FONT:bold),COLOR(0C8FFC8H),READONLY
                       STRING('Observación:'),AT(13,232),USE(?String5),TRN
                       TEXT,AT(12,241,117,42),USE(FAC:Observacion),SKIP,BOXED,VSCROLL,FONT(,,COLOR:Red,FONT:bold),COLOR(COLOR:Silver),UPR
                       LINE,AT(10,287,481,0),USE(?Line1),COLOR(COLOR:Gray),LINEWIDTH(2)
                       BUTTON('  OK'),AT(205,304,56,15),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(269,304,56,15),USE(?Cancel),LEFT,KEY(EscKey),ICON('C:\Comisiones\ComisionesSRL\botones\Cancel1.ico')
                     END

Report               REPORT,AT(1000,2000,6250,7688),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',10,,FONT:regular,CHARSET:ANSI),THOUS
                       HEADER,AT(1000,1000,6250,1000),USE(?Header)
                       END
Detail                 DETAIL,USE(?Detail)
                       END
                       FOOTER,AT(1000,9688,6250,1000),USE(?Footer)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
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
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW2                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW5                 CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

FDCB13               CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo           !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

FDCB15               CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo:1         !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

FDB7                 CLASS(FileDropClass)                  ! File drop manager
Q                      &Queue:FileDrop                !Reference to display queue
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

FDB9                 CLASS(FileDropClass)                  ! File drop manager
Q                      &Queue:FileDrop:1              !Reference to display queue
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(APLIGUIA:Record)
? DEBUGHOOK(CATIVADES:Record)
? DEBUGHOOK(CATIVAREM:Record)
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(FACTURAS:Record)
? DEBUGHOOK(GUIAS:Record)
? DEBUGHOOK(ITEMFAC:Record)
? DEBUGHOOK(LOCALIDA:Record)
? DEBUGHOOK(LOCALIDAD2:Record)
? DEBUGHOOK(PARAMFE:Record)
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------
SolicitarNroCAE ROUTINE

  PARFE:IDParametrosFE=1
  GET(PARAMFE,PARFE:ParametrosFE_x_ID)

  Glo:NroCAE=0
  Glo:FechaCAE=0

  ! Genero archivo nuevo wsfe01
  GLO:ArchivoRECE = '.\Rece.txt'
  IF EXISTS(CLIP(GLO:ArchivoRECE)) THEN REMOVE(CLIP(GLO:ArchivoRECE)).

  if FAC:Letra='A' then
    if loc:Tipo='FAC' THEN
        loc:descripcion_comprobante='Factura'
        Loc:Tipo_Comprobante=1
        Loc:NumeroDesde=PARFE:FA + 1

    else
        loc:descripcion_comprobante='Nota de Credito'
        Loc:Tipo_Comprobante=3
        Loc:NumeroDesde=PARFE:NCA + 1
    end
  else
    if loc:Tipo='FAC' THEN
        loc:descripcion_comprobante='Factura'
        Loc:Tipo_Comprobante=6
        Loc:NumeroDesde=PARFE:FB + 1
    else
        loc:descripcion_comprobante='Nota de Credito'
        Loc:Tipo_Comprobante=8
        Loc:NumeroDesde=PARFE:NCB + 1
    end
  end

  Glo:PuntoVentaElectronico=PARFE:Puesto

  Loc:Tipo_Documento         = 80
  Loc:Cliente_Documento      = FAC:CUITRemitente
  !Loc:ImporteTotal           = Total
  Loc:ImporteNoGravado       = 0
  !Loc:ImporteGravado         = neto !+ loc_flete
  Loc:Importe_Exento         = 0
  !Loc:Monto_IVA_Inscripto    = iva21!+loc_iva_flete
  !Loc:Monto_IVA_Inscripto10  = iva105
  Loc:Monto_IVA_No_Inscripto = 0             
  Loc:Percep_Nac             = 0                        
  Loc:Percep_IIBB            = 0
  Loc:Percep_Mun             = 0

  Loc:ImporteTotal=FAC:Importe

  IF loc:mitadiva=0 THEN
    loc:baseimponible21=FAC:Neto
    Loc:Monto_IVA_Inscripto=FAC:IVA
  ELSE
    loc:baseimponible105=FAC:Neto
    Loc:Monto_IVA_Inscripto10=FAC:IVA
  END


  !se calculan las bases imponibles e iva por separado tomando el valor del iva registrado

  IF FAC:CategIVARemitente=4 THEN !EXENTO
      IF loc:mitadiva=0 THEN
        loc:baseimponible21=Loc:ImporteTotal / 1.21
        Loc:Monto_IVA_Inscripto=Loc:ImporteTotal - loc:baseimponible21
      ELSE
        loc:baseimponible105=Loc:ImporteTotal / 1.105
        Loc:Monto_IVA_Inscripto10=Loc:ImporteTotal - loc:baseimponible105

      END
  END

  Loc:ImporteTotal= loc:baseimponible21 + loc:baseimponible105 + Loc:Monto_IVA_Inscripto + Loc:Monto_IVA_Inscripto10
  Loc:ImporteGravado=loc:baseimponible21 + loc:baseimponible105


  Loc:Fecha            = TODAY()
  Loc:CodigoMoneda     = 'PES'
  Loc:TipoCambio       = 1


  LOC:CantReg        = 1
  LOC:Concepto       = 2
  LOC:ImporteIVA     = Loc:Monto_IVA_Inscripto + Loc:Monto_IVA_Inscripto10
  LOC:ImporteTributo = 0

!    message(Loc:ImporteTotal)
!    message(loc:baseimponible21 )
!    message(loc:baseimponible105)
!    message(Loc:Monto_IVA_Inscripto )
!    message(Loc:Monto_IVA_Inscripto10)

  loc_porcentaje=0

  GLO:LineaRECE = '1'                                   &| ! Tipo de registro
                  FORMAT(LOC:CantReg,@n04)              &| ! Cantidad de registros de tipo 2
                  FORMAT(LOC:Tipo_Comprobante,@n03)     &| !  3  Tipo Comprobante
                  FORMAT(Glo:PuntoVentaElectronico,@n04)   !  5  Punto de Venta
  Generar_Archivo_RECE    ! Genero el registro  del tipo 1
  Glo:LineaRECE = '2'                                      &| ! Tipo de registro
                  FORMAT(Loc:NumeroDesde,@n08)             & | !  6  numero de comprobante
                  FORMAT(Loc:NumeroDesde,@n08)             & | !  7  numero de comprobante hasta - En este ejemplo no se aplica
                  FORMAT(LOC:Concepto,@n02)                & | !  Concepto
                  Format(Loc:Tipo_Documento,@n02)          & | !  9  Tipo de Documento del Cliente
                  Format(Loc:Cliente_Documento,@n011)      & | ! 10  Nro de Documento o CUIP del Cliente
                  Format(Loc:Fecha,@d012)                  & | !  2  Fecha (AAAAMMDD)
                  Format(Loc:ImporteTotal*100,@n015)       & | ! 12  Total Operacion con 2 decimales y sin punto (igual en los campos siguiente)
                  Format(Loc:ImporteNoGravado*100,@n015)   & | ! 13  Tot. Conc. No Gravados
                  Format(Loc:ImporteGravado*100,@n015)     & | ! 14  Neto Gravado
                  Format(Loc:Importe_Exento*100,@n015)     & | ! 17  Imp. Exento
                  FORMAT(LOC:ImporteIVA*100,@n015)         & |
                  FORMAT(LOC:ImporteTributo*100,@n015)     & |
                  Format(Loc:Fecha,@d012)                  & | !  2  Fecha (AAAAMMDD)
                  Format(Loc:Fecha,@d012)                  & | !  2  Fecha (AAAAMMDD)
                  Format(Loc:Fecha,@d012)                  & | !  2  Fecha (AAAAMMDD)
                  Loc:CodigoMoneda                               & |
                  FORMAT(Loc:TipoCambio,@n010v6)     & |
                  ALL(' ',14)
  Generar_Archivo_RECE    ! Genero el registro  del tipo 2
  !GLO:LineaRECE = '3'                                    &| ! Tipo de registro
  !                FORMAT(Loc:NumeroDesde,@n08)           & | !  6  numero de comprobante
  !                FORMAT(Loc:NumeroDesde,@n08)           & | !  7  numero de comprobante hasta - En este ejemplo no se aplica
  !                FORMAT(Loc:Tipo_Comprobante,@n03)      & | !  3  Tipo Comprobante
  !                FORMAT(Glo:PuntoVentaElectronico,@n04) & |  !  5  Punto de Venta
  !                FORMAT(Loc:NumeroDesde,@n08)              !  7  numero de comprobante hasta - En este ejemplo no se aplica
  !Generar_Archivo_RECE    ! Genero el registro  del tipo 3

  if Loc:Monto_IVA_Inscripto > 0
      GLO:LineaRECE = '4'                                   &| ! Tipo de registro
                      FORMAT(Loc:NumeroDesde,@n08)             & | !  6  numero de comprobante
                      FORMAT(Loc:NumeroDesde,@n08)             & | !  7  numero de comprobante hasta - En este ejemplo no se aplica
                      '05'  & | !  IVA 21
                      Format(loc:baseimponible21*100,@n015)   & | ! 13  Tot. Conc. No Gravados
                      Format(Loc:Monto_IVA_Inscripto*100,@n015)  ! 13  Tot. Conc. No Gravados
      Generar_Archivo_RECE    ! Genero el registro  del tipo 4
  end!if

  if Loc:Monto_IVA_Inscripto10 > 0
      GLO:LineaRECE = '4'                                   &| ! Tipo de registro
                      FORMAT(Loc:NumeroDesde,@n08)             & | !  6  numero de comprobante
                      FORMAT(Loc:NumeroDesde,@n08)             & | !  7  numero de comprobante hasta - En este ejemplo no se aplica
                      '04'  & | !  IVA 10.5
                      Format(loc:baseimponible105*100,@n015)   & | ! 13  Tot. Conc. No Gravados
                      Format(Loc:Monto_IVA_Inscripto10*100,@n015)  ! 13  Tot. Conc. No Gravados
      Generar_Archivo_RECE    ! Genero el registro  del tipo 4
  end!if

  IF Loc:Percep_IIBB<>0
    GLO:LineaRECE = '5'                                      & | ! Tipo de registro
                    FORMAT(Loc:NumeroDesde,@n08)             & | !  6  numero de comprobante
                    FORMAT(Loc:NumeroDesde,@n08)             & | !  7  numero de comprobante hasta - En este ejemplo no se aplica
                    '02'                                     & | !  IVA 21
                    Format(Loc:ImporteGravado*100,@n015)       & | ! Base imponible la fijo a 1000 para las pruebas
                    Format(loc_porcentaje*100,@n05)           & | ! Alicuota la fijo al 5% para las pruebas
                    Format(Loc:Percep_IIBB*100,@n015)          & | ! 13  Tot. Conc. No Gravados
                    'Impuestos provinciales'
    Generar_Archivo_RECE    ! Genero el registro  del tipo 5
  end!if

  LOC:Comando = 'FECAESolicitar ' & path() &'\Rece.txt'

!desde aca comento la facturacion electronica anterior

!  DO EnvioComando
!
!  !Verifico el resultado
!  IF EXISTS(CLIP('.\Respuesta.txt'))
!     Leer_Respuesta_RECE
!                                                             
!     if Glo:NroCAE>0
!        !FAC:Fecha       = today()
!        !FAC:Es_FE       = 1
!        !FAC:CAE         = Glo:NroCAE
!        !FAC:Fecha_CAE   = Glo:FechaCAE
!!        if glo_quees='Factura'
!!           FAC:Factura_Nro = (PUE_FE:Puesto*100000000)+PUE_FE:Factura
!!        else
!!           FAC:Factura_Nro = (PUE_FE:Puesto*100000000)+PUE_FE:Credito
!!        end!if
!     end!if
!  ELSE
!     MESSAGE('Ocurrió un error al obtener el Resultado','Error',icon:hand)
!  end!if

  loc:estado_fe=''
  !message('IFE.exe ' & clip(loc:descripcion_comprobante) & '|' & FAC:Letra & '|' & FAC:CUITRemitente & '|' &  loc:baseimponible21 & '|' & loc:baseimponible105 & '|' & Loc:Monto_IVA_Inscripto & '|' & Loc:Monto_IVA_Inscripto10 & '|' & Loc:ImporteTotal & '|' & '0' & '|' & Format(Loc:Fecha,@d012),1)
  
  run('IFE.exe ' & clip(loc:descripcion_comprobante) & '|' & FAC:Letra & '|' & FAC:CUITRemitente & '|' &  loc:baseimponible21 & '|' & loc:baseimponible105 & '|' & Loc:Monto_IVA_Inscripto & '|' & Loc:Monto_IVA_Inscripto10 & '|' & Loc:ImporteTotal & '|' & '0' & '|' & Format(Loc:Fecha,@d012) & '|' & RTE:PosicionIVA ,1)

  loc:estado_fe=GETINI('RESPUESTA','ESTADO',,'.\IFERespuesta.INI')
  loc:mensaje_fe=GETINI('RESPUESTA','MENSAJE',,'.\IFERespuesta.INI')
  IF loc:estado_fe='1' THEN
     loc:cae=GETINI('RESPUESTA','CAE',,'.\IFERespuesta.INI')
     loc_vencimiento_cae=GETINI('RESPUESTA','VENCIMIENTO',,'.\IFERespuesta.INI')
     loc:comprobante_autorizado=GETINI('RESPUESTA','COMPROBANTE',,'.\IFERespuesta.INI')
  END
  IF loc:estado_fe='0' THEN
    BEEP(BEEP:SystemExclamation)
    MESSAGE(loc:mensaje_fe)
    !CYCLE
  END
EnvioComando ROUTINE
  remove('ticket.XML')
  !PARFE:IDParametrosFE=1
  !get(PARAMFE,PARFE:ParametrosFE_x_ID)

  Glo:Ejecutable = PATH() & '\wsfe.exe'
  Glo:Parametros = CLIP(LOC:Comando) &' -c ' & PARFE:CUIP               &| ! Asigna el CUIT
                                      ' -r ' & CLIP(PARFE:Certificado)  &| ! Asigna el certificado
                                      ' -k ' & CLIP(PARFE:Clave)        &| ! Asigna la clave
                                      ' -t ticket.XML '                 &| ! Si el ticket no existe lo genera
                                      ' -o Respuesta.txt '              &| ! Guarda la respuesta en el archivo
                                      ' -l log.log '                       ! Si el ticket no existe lo genera

  SETCLIPBOARD(CLIP(GLO:Ejecutable) & ' ' & CLIP(GLO:Parametros))    ! Lo guardo en el portapapeles

  !MESSAGE('Comando enviado: |' & CLIP(GLO:Ejecutable) & ' ' & CLIP(GLO:Parametros))

  !También se puede agilizar enviando el parámetro --ticket xxxx.xml en vez de utilizar "-r .... -k ...". Lea el manual para mayor orientación.

  !Llamo al Web Services
  IF EXISTS(CLIP('.\Respuesta.txt')) ! Si existe el archivo donde guardo las respuestas, lo borro
    REMOVE(CLIP('.\Respuesta.txt'))
  end!if

  glo:mensage='<13,10>Solicitando C.A.E.<13,10>Conectando con los Servicios de la AFIP.<13,10>Espere por favor...'

  setcursor(cursor:wait)
  OPEN(WS_Window)
     ACCEPT
        IF EVENT() = Event:OpenWindow

           Ejecuta_WS

           POST(EVENT:CloseWindow)
        END
     END
  CLOSE(WS_Window)
  setcursor(0)

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
  GlobalErrors.SetProcedureName('UpdateFACTURAS1')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String12
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(FAC:Record,History::FAC:Record)
  SELF.AddHistoryField(?FAC:FacturarA,8)
  SELF.AddHistoryField(?FAC:Letra,5)
  SELF.AddHistoryField(?FAC:Lugar,6)
  SELF.AddHistoryField(?FAC:Numero,7)
  SELF.AddHistoryField(?FAC:Fecha,2)
  SELF.AddHistoryField(?FAC:Remitente,10)
  SELF.AddHistoryField(?FAC:NombreRemitente,11)
  SELF.AddHistoryField(?FAC:CUITRemitente,12)
  SELF.AddHistoryField(?FAC:DireccionRemitente,14)
  SELF.AddHistoryField(?FAC:TelefonoRemitente,16)
  SELF.AddHistoryField(?FAC:Destinatario,17)
  SELF.AddHistoryField(?FAC:NombreDestino,18)
  SELF.AddHistoryField(?FAC:CUITDestino,19)
  SELF.AddHistoryField(?FAC:DireccionDestino,21)
  SELF.AddHistoryField(?FAC:TelefonoDestino,23)
  SELF.AddHistoryField(?FAC:TipoServicio,25)
  SELF.AddHistoryField(?FAC:ValorDeclarado,27)
  SELF.AddHistoryField(?FAC:Flete,26)
  SELF.AddHistoryField(?FAC:Neto,28)
  SELF.AddHistoryField(?FAC:Seguro,29)
  SELF.AddHistoryField(?FAC:IVA,30)
  SELF.AddHistoryField(?FAC:Importe,31)
  SELF.AddHistoryField(?FAC:Observacion,35)
  SELF.AddUpdateFile(Access:FACTURAS)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:APLIGUIA.SetOpenRelated()
  Relate:APLIGUIA.Open                                     ! File PARAMFE used by this procedure, so make sure it's RelationManager is open
  Relate:CATIVADES.Open                                    ! File PARAMFE used by this procedure, so make sure it's RelationManager is open
  Relate:CATIVAREM.Open                                    ! File PARAMFE used by this procedure, so make sure it's RelationManager is open
  Relate:LOCALIDA.Open                                     ! File PARAMFE used by this procedure, so make sure it's RelationManager is open
  Relate:LOCALIDAD2.Open                                   ! File PARAMFE used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMFE.Open                                      ! File PARAMFE used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:CLIENTES.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
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
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW3::View:Browse,Queue:Browse,Relate:GUIAS,SELF) ! Initialize the browse manager
  BRW2.Init(?List:2,Queue:Browse:1.ViewPosition,BRW8::View:Browse,Queue:Browse:1,Relate:APLIGUIA,SELF) ! Initialize the browse manager
  BRW5.Init(?List:3,Queue:Browse:2.ViewPosition,BRW10::View:Browse,Queue:Browse:2,Relate:ITEMFAC,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,GUIA:Por_Cliente_FechaA)              ! Add the sort order for GUIA:Por_Cliente_FechaA for sort order 1
  BRW1.AddRange(GUIA:ClienteFacturar,FAC:ClienteFacturar)  ! Add single value range limit for sort order 1
  BRW1.SetFilter('(GUIA:Empresa = 1 AND NOT GUIA:Facturada AND GUIA:ClienteFacturar <<> 0 AND GUIA:Impresa <<> ''A'')') ! Apply filter expression to browse
  BRW1.AddField(GUIA:Fecha,BRW1.Q.GUIA:Fecha)              ! Field GUIA:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Letra,BRW1.Q.GUIA:Letra)              ! Field GUIA:Letra is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Lugar,BRW1.Q.GUIA:Lugar)              ! Field GUIA:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Numero,BRW1.Q.GUIA:Numero)            ! Field GUIA:Numero is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Importe,BRW1.Q.GUIA:Importe)          ! Field GUIA:Importe is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:RegGuia,BRW1.Q.GUIA:RegGuia)          ! Field GUIA:RegGuia is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:ClienteFacturar,BRW1.Q.GUIA:ClienteFacturar) ! Field GUIA:ClienteFacturar is a hot field or requires assignment from browse
  BRW2.Q &= Queue:Browse:1
  BRW2.AddSortOrder(,APGUIA:Por_Factura)                   ! Add the sort order for APGUIA:Por_Factura for sort order 1
  BRW2.AddRange(APGUIA:Factura,Relate:APLIGUIA,Relate:FACTURAS) ! Add file relationship range limit for sort order 1
  BRW2.AddField(GUIA:Fecha,BRW2.Q.GUIA:Fecha)              ! Field GUIA:Fecha is a hot field or requires assignment from browse
  BRW2.AddField(GUIA:Letra,BRW2.Q.GUIA:Letra)              ! Field GUIA:Letra is a hot field or requires assignment from browse
  BRW2.AddField(GUIA:Lugar,BRW2.Q.GUIA:Lugar)              ! Field GUIA:Lugar is a hot field or requires assignment from browse
  BRW2.AddField(GUIA:Numero,BRW2.Q.GUIA:Numero)            ! Field GUIA:Numero is a hot field or requires assignment from browse
  BRW2.AddField(GUIA:Importe,BRW2.Q.GUIA:Importe)          ! Field GUIA:Importe is a hot field or requires assignment from browse
  BRW2.AddField(APGUIA:Factura,BRW2.Q.APGUIA:Factura)      ! Field APGUIA:Factura is a hot field or requires assignment from browse
  BRW2.AddField(APGUIA:Guia,BRW2.Q.APGUIA:Guia)            ! Field APGUIA:Guia is a hot field or requires assignment from browse
  BRW2.AddField(GUIA:RegGuia,BRW2.Q.GUIA:RegGuia)          ! Field GUIA:RegGuia is a hot field or requires assignment from browse
  BRW5.Q &= Queue:Browse:2
  BRW5.AddSortOrder(,ITFAC:Por_Factura)                    ! Add the sort order for ITFAC:Por_Factura for sort order 1
  BRW5.AddRange(ITFAC:RegFactura,Relate:ITEMFAC,Relate:FACTURAS) ! Add file relationship range limit for sort order 1
  BRW5.AddField(ITFAC:Cantidad,BRW5.Q.ITFAC:Cantidad)      ! Field ITFAC:Cantidad is a hot field or requires assignment from browse
  BRW5.AddField(ITFAC:Descripcion,BRW5.Q.ITFAC:Descripcion) ! Field ITFAC:Descripcion is a hot field or requires assignment from browse
  BRW5.AddField(ITFAC:Importe,BRW5.Q.ITFAC:Importe)        ! Field ITFAC:Importe is a hot field or requires assignment from browse
  BRW5.AddField(ITFAC:RegFactura,BRW5.Q.ITFAC:RegFactura)  ! Field ITFAC:RegFactura is a hot field or requires assignment from browse
  BRW5.AddField(ITFAC:Item,BRW5.Q.ITFAC:Item)              ! Field ITFAC:Item is a hot field or requires assignment from browse
  SELF.AddItem(ToolbarForm)
  BRW5.AskProcedure = 3
  FDCB13.Init(LOC:Localidad,?LOC:Localidad,Queue:FileDropCombo.ViewPosition,FDCB13::View:FileDropCombo,Queue:FileDropCombo,Relate:LOCALIDA,ThisWindow,GlobalErrors,1,1,0)
  FDCB13.AskProcedure = 4
  FDCB13.Q &= Queue:FileDropCombo
  FDCB13.AddSortOrder(LOC:Por_Localidad)
  FDCB13.AddField(LOC:Localidad,FDCB13.Q.LOC:Localidad)
  FDCB13.AddUpdateField(LOC:Localidad,FAC:LocalidadRemitente)
  ThisWindow.AddItem(FDCB13.WindowComponent)
  FDCB13.DefaultFill = 0
  FDCB15.Init(LOC2:Localidad,?LOC2:Localidad,Queue:FileDropCombo:1.ViewPosition,FDCB15::View:FileDropCombo,Queue:FileDropCombo:1,Relate:LOCALIDAD2,ThisWindow,GlobalErrors,1,1,0)
  FDCB15.AskProcedure = 5
  FDCB15.Q &= Queue:FileDropCombo:1
  FDCB15.AddSortOrder(LOC2:Por_Localidad)
  FDCB15.AddField(LOC2:Localidad,FDCB15.Q.LOC2:Localidad)
  FDCB15.AddUpdateField(LOC2:Localidad,FAC:LocalidadDestino)
  ThisWindow.AddItem(FDCB15.WindowComponent)
  FDCB15.DefaultFill = 0
  FDB7.Init(?IVAD:Descripcion,Queue:FileDrop.ViewPosition,FDB7::View:FileDrop,Queue:FileDrop,Relate:CATIVADES,ThisWindow)
  FDB7.Q &= Queue:FileDrop
  FDB7.AddSortOrder(IVAD:Por_CodIVA)
  FDB7.AddField(IVAD:Descripcion,FDB7.Q.IVAD:Descripcion)
  FDB7.AddUpdateField(IVAD:CodCatIVA,FAC:CategIVADestino)
  ThisWindow.AddItem(FDB7.WindowComponent)
  FDB7.DefaultFill = 0
  FDB9.Init(?IVAR:Descripcion,Queue:FileDrop:1.ViewPosition,FDB9::View:FileDrop,Queue:FileDrop:1,Relate:CATIVAREM,ThisWindow)
  FDB9.Q &= Queue:FileDrop:1
  FDB9.AddSortOrder(IVAR:Por_CodIVA)
  FDB9.AddField(IVAR:Descripcion,FDB9.Q.IVAR:Descripcion)
  FDB9.AddUpdateField(IVAR:CodCatIVA,FAC:CategIVARemitente)
  ThisWindow.AddItem(FDB9.WindowComponent)
  FDB9.DefaultFill = 0
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW2.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW5.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
  EnterByTabManager.ExcludeControl(?Cancel)
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
    Relate:APLIGUIA.Close
    Relate:CATIVADES.Close
    Relate:CATIVAREM.Close
    Relate:LOCALIDA.Close
    Relate:LOCALIDAD2.Close
    Relate:PARAMFE.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
    FAC:FacturarA = 'R'
    loc:FormaPago = 'F'
    FAC:Fecha = TODAY()
    FAC:Empresa = 1
    FAC:Comprobante = 'FAC'
    FAC:Letra = glo:LetraFactura
    FAC:Lugar = glo:LugarFactura
    FAC:Numero = glo:NumeraFactura
    FAC:TipoServicio = 'T'
    FAC:Flete = 'R'
    FAC:Impresa = 'N'
    glo:Dia = 0
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  RTE:CodCliente = FAC:Remitente                           ! Assign linking field value
  Access:REMITENTE.Fetch(RTE:Por_Codigo)
  DES:CodCliente = FAC:Destinatario                        ! Assign linking field value
  Access:DESTINATARIO.Fetch(DES:Por_Codigo)
  DIS:CodDistribuidor = FAC:Distribuidor                   ! Assign linking field value
  Access:DISTRIBUIDORES.Fetch(DIS:Por_Codigo)
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
      UpdateITEMFAC
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
        ?FAC:NombreRemitente{Prop:ReadOnly} = True
        ?FAC:CUITRemitente{Prop:ReadOnly} = True
        ?FAC:DireccionRemitente{Prop:ReadOnly} = True
        ?LOC:Localidad{Prop:ReadOnly} = True
        ?FAC:TelefonoRemitente{Prop:ReadOnly} = True
        ENABLE(?SelectRemitente)
      END
      IF ?loc:RteEsCliente{Prop:Checked} = False
        ?FAC:NombreRemitente{Prop:ReadOnly} = False
        ?FAC:CUITRemitente{Prop:ReadOnly} = False
        ?FAC:DireccionRemitente{Prop:ReadOnly} = False
        ?LOC:Localidad{Prop:ReadOnly} = False
        ?FAC:TelefonoRemitente{Prop:ReadOnly} = False
        CLEAR(FAC:Remitente)
        DISABLE(?SelectRemitente)
      END
      ThisWindow.Reset(TRUE)
    OF ?loc:DesEsCliente
      IF ?loc:DesEsCliente{Prop:Checked} = True
        ?FAC:NombreDestino{Prop:ReadOnly} = True
        ?FAC:CUITDestino{Prop:ReadOnly} = True
        ?FAC:DireccionDestino{Prop:ReadOnly} = True
        ?LOC2:Localidad{Prop:ReadOnly} = True
        ?FAC:TelefonoDestino{Prop:ReadOnly} = True
        ENABLE(?SelectDestinatario)
      END
      IF ?loc:DesEsCliente{Prop:Checked} = False
        ?FAC:NombreDestino{Prop:ReadOnly} = False
        ?FAC:CUITDestino{Prop:ReadOnly} = False
        ?FAC:DireccionDestino{Prop:ReadOnly} = False
        ?LOC2:Localidad{Prop:ReadOnly} = False
        ?FAC:TelefonoDestino{Prop:ReadOnly} = False
        CLEAR(FAC:Destinatario)
        DISABLE(?SelectDestinatario)
      END
      ThisWindow.Reset(TRUE)
    OF ?Facturar
      BRW1.UpdateViewRecord
      glo:Guia = GUIA:RegGuia
      glo:ImporteFacturar = GUIA:Importe
    OF ?OK
      IF ((FAC:Letra='A' AND FAC:CategIVARemitente<>1) OR (FAC:Letra='B' AND FAC:CategIVARemitente=1)) AND FAC:FacturarA='R' AND FAC:NombreRemitente <> 'ANULADA' THEN
        BEEP(BEEP:SystemExclamation)
        MESSAGE('La Categoría de IVA del Cliente seleccionado|no corresponde al Tipo de Comprobante','Atención !!!',ICON:Exclamation)
        SELECT(?IVAR:Descripcion)
        CYCLE
      END
      IF ((FAC:Letra='A' AND FAC:CategIVADestino<>1) OR (FAC:Letra='B' AND FAC:CategIVADestino=1)) AND FAC:FacturarA='D' AND FAC:NombreDestino <> 'ANULADA' THEN
        BEEP(BEEP:SystemExclamation)
        MESSAGE('La Categoría de IVA del Cliente seleccionado|no corresponde al Tipo de Comprobante','Atención !!!',ICON:Exclamation)
        SELECT(?IVAD:Descripcion)
        CYCLE
      END
      
      IF FAC:Letra = 'A' THEN
        IF FAC:FacturarA = 'R' AND FAC:NombreRemitente <> 'ANULADA' THEN
          IF NOT(FAC:CUITRemitente) OR FAC:CUITRemitente = 0 THEN
            BEEP(BEEP:SystemHand)  ;  YIELD()
            MESSAGE('Debe ingresar el número de CUIT.','CUIT Incompleto !!!',ICON:Hand)
            SELECT(?FAC:CUITRemitente)
            CYCLE
          END
          I# = 1
          CLEAR(loc:SumaCUIT)
          LOOP C# = 10 TO 1 BY -1
            IF I# = 7 THEN I# = 1.
            I# += 1
            loc:SumaCUIT += SUB(FAC:CUITRemitente,C#,1) * I#
          END
          loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
          IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
          IF loc:DigitoVerificador <> SUB(FAC:CUITRemitente,11,1) THEN
            BEEP(BEEP:SystemHand)  ;  YIELD()
            MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
            SELECT(?FAC:CUITRemitente)
            CYCLE
          END
        END
        IF FAC:FacturarA = 'D' AND FAC:NombreDestino <> 'ANULADA' THEN
          IF NOT(FAC:CUITDestino) OR FAC:CUITDestino = 0 THEN
            BEEP(BEEP:SystemHand)  ;  YIELD()
            MESSAGE('Debe ingresar el número de CUIT.','CUIT Incompleto !!!',ICON:Hand)
            SELECT(?FAC:CUITDestino)
            CYCLE
          END
          I# = 1
          CLEAR(loc:SumaCUIT)
          LOOP C# = 10 TO 1 BY -1
            IF I# = 7 THEN I# = 1.
            I# += 1
            loc:SumaCUIT += SUB(FAC:CUITDestino,C#,1) * I#
          END
          loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
          IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
          IF loc:DigitoVerificador <> SUB(FAC:CUITDestino,11,1) THEN
            BEEP(BEEP:SystemHand)  ;  YIELD()
            MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
            SELECT(?FAC:CUITDestino)
            CYCLE
          END
        END
      ELSE
        IF FAC:FacturarA = 'R'  AND FAC:NombreRemitente <> 'ANULADA' THEN
          IF FAC:CategIVARemitente <> 5 THEN
            IF NOT(FAC:CUITRemitente) OR FAC:CUITRemitente = 0 THEN
              BEEP(BEEP:SystemHand)  ;  YIELD()
              MESSAGE('Debe ingresar el número de CUIT.','CUIT Incompleto !!!',ICON:Hand)
              SELECT(?FAC:CUITRemitente)
              CYCLE
            END
            I# = 1
            CLEAR(loc:SumaCUIT)
            LOOP C# = 10 TO 1 BY -1
              IF I# = 7 THEN I# = 1.
              I# += 1
              loc:SumaCUIT += SUB(FAC:CUITRemitente,C#,1) * I#
            END
            loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
            IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
            IF loc:DigitoVerificador <> SUB(FAC:CUITRemitente,11,1) THEN
              BEEP(BEEP:SystemHand)  ;  YIELD()
              MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
              SELECT(?FAC:CUITRemitente)
              CYCLE
            END
          END
        END
        IF FAC:FacturarA = 'D'  AND FAC:NombreDestino <> 'ANULADA' THEN
          IF FAC:CategIVADestino <> 5 THEN
            IF NOT(FAC:CUITDestino) OR FAC:CUITDestino = 0 THEN
              BEEP(BEEP:SystemHand)  ;  YIELD()
              MESSAGE('Debe ingresar el número de CUIT.','CUIT Incompleto !!!',ICON:Hand)
              SELECT(?FAC:CUITDestino)
              CYCLE
            END
            I# = 1
            CLEAR(loc:SumaCUIT)
            LOOP C# = 10 TO 1 BY -1
              IF I# = 7 THEN I# = 1.
              I# += 1
              loc:SumaCUIT += SUB(FAC:CUITDestino,C#,1) * I#
            END
            loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
            IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
            IF loc:DigitoVerificador <> SUB(FAC:CUITDestino,11,1) THEN
              BEEP(BEEP:SystemHand)  ;  YIELD()
              MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
              SELECT(?FAC:CUITDestino)
              CYCLE
            END
          END
        END
      END
      
      if loc:FacturaElectronica=1 then
          do SolicitarNroCAE
          IF loc:estado_fe='0' THEN
          !if Glo:NroCAE=0
              cycle     ! si no obtengo el nro de cae... vuelvo a la FC
          else
              FAC:FE = 1
              !FAC:CAE = Glo:NroCAE
              FAC:CAE = loc:cae
              !FAC:FechaCAE = Glo:FechaCAE
              FAC:FechaCAE = date(sub(loc_vencimiento_cae,4,2),sub(loc_vencimiento_cae,1,2),sub(loc_vencimiento_cae,7,4))
              IF loc:Tipo='FAC' THEN
                  FAC:Comprobante='FAC'
              ELSE
                  FAC:Comprobante='NC'
              END
      
              PARFE:IDParametrosFE=1
              GET(PARAMFE,PARFE:ParametrosFE_x_ID)
              FAC:Lugar=PARFE:Puesto
      
              IF FAC:Letra='A' then
                  IF loc:Tipo='FAC' THEN
                      PARFE:FA=loc:comprobante_autorizado
                      FAC:Numero=loc:comprobante_autorizado
                  ELSE
                      PARFE:NCA=loc:comprobante_autorizado
                      FAC:Numero=loc:comprobante_autorizado
                  END
              else
                  IF loc:Tipo='FAC' THEN
                      PARFE:FB=loc:comprobante_autorizado
                      FAC:Numero=loc:comprobante_autorizado
                  ELSE
                      PARFE:NCB=loc:comprobante_autorizado
                      FAC:Numero=loc:comprobante_autorizado
                  END
              end
              put(PARAMFE)
          end!if
      END
    OF ?Cancel
      IF ThisWindow.Request = InsertRecord AND RECORDS(BRW2) THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('Si realmente desea cancelar la Factura,|debe volver a Cta. Cte. los Remitos aplicados.',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?List:2)
        CYCLE
      END
      
      IF ThisWindow.Request = InsertRecord AND RECORDS(BRW5) THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('Si realmente desea cancelar la Factura,|debe borrar los Items ingresados.',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?List:3)
        CYCLE
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?FAC:FacturarA
      IF FAC:Flete <> 'I' THEN
        IF FAC:FacturarA = 'R' THEN FAC:Flete = 'R'.
        IF FAC:FacturarA = 'D' THEN FAC:Flete = 'D'.
      END
      IF FAC:FacturarA = 'R' THEN FAC:ClienteFacturar = FAC:Remitente.
      IF FAC:FacturarA = 'D' THEN FAC:ClienteFacturar = FAC:Destinatario.
      ThisWindow.Reset(1)
    OF ?SelectRemitente
      ThisWindow.Update
      RTE:CodCliente = FAC:Remitente
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        FAC:Remitente = RTE:CodCliente
      END
      ThisWindow.Reset(1)
      IF FAC:FacturarA = 'R' THEN
        ! VALIDAR CUIT
        e# = 0
        IF RTE:PosicionIVA <> 5 THEN
          I# = 1
          CLEAR(loc:SumaCUIT)
          LOOP C# = 10 TO 1 BY -1
            IF I# = 7 THEN I# = 1.
            I# += 1
            loc:SumaCUIT += SUB(RTE:CUIT,C#,1) * I#
          END
          loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
          IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
          IF loc:DigitoVerificador <> SUB(RTE:CUIT,11,1) THEN
            e# = 1
            BEEP(BEEP:SystemHand)  ;  YIELD()
            MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
            SELECT(?FAC:Remitente)
          END
        END
        IF (e# <> 1 OR RTE:PosicionIVA = 5) AND FAC:Remitente THEN
          IF (FAC:Letra = 'A' AND RTE:PosicionIVA <> 1) OR (FAC:Letra = 'B' AND RTE:PosicionIVA = 1) THEN
            BEEP(BEEP:SystemExclamation)
            MESSAGE('La Categoría de IVA del Cliente seleccionado|no corresponde al Tipo de Comprobante','Atención !!!',ICON:Exclamation)
            SELECT(?FAC:Remitente)
          ELSE
            FAC:NombreRemitente = RTE:Nombre
            FAC:CUITRemitente = RTE:CUIT
      
            FAC:CategIVARemitente = RTE:PosicionIVA
            IVAR:CodCatIVA = RTE:PosicionIVA
            GET(CATIVAREM,IVAR:Por_CodIVA)
      
            FAC:DireccionRemitente = RTE:Direccion
            LOC:Localidad = RTE:Localidad
            FAC:LocalidadRemitente = RTE:Localidad
            FAC:TelefonoRemitente = RTE:Telefono
            IF FAC:FacturarA = 'R' THEN FAC:ClienteFacturar = FAC:Remitente.
            ThisWindow.Reset(TRUE)
            !DISPLAY
            SELECT(?loc:DesEsCliente)
          END
        END
      ELSE
        FAC:NombreRemitente = RTE:Nombre
        FAC:CUITRemitente = RTE:CUIT
      
        FAC:CategIVARemitente = RTE:PosicionIVA
        IVAR:CodCatIVA = RTE:PosicionIVA
        GET(CATIVAREM,IVAR:Por_CodIVA)
      
        FAC:DireccionRemitente = RTE:Direccion
        LOC:Localidad = RTE:Localidad
        FAC:LocalidadRemitente = RTE:Localidad
        FAC:TelefonoRemitente = RTE:Telefono
        IF FAC:FacturarA = 'R' THEN FAC:ClienteFacturar = FAC:Remitente.
        ThisWindow.Reset(TRUE)
        !DISPLAY
        SELECT(?loc:DesEsCliente)
      END
    OF ?FAC:Remitente
      IF FAC:Remitente OR ?FAC:Remitente{Prop:Req}
        RTE:CodCliente = FAC:Remitente
        IF Access:REMITENTE.TryFetch(RTE:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            FAC:Remitente = RTE:CodCliente
          ELSE
            SELECT(?FAC:Remitente)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(0)
      IF FAC:FacturarA = 'R' THEN
        ! VALIDAR CUIT
        e# = 0
        IF RTE:PosicionIVA <> 5 THEN
          I# = 1
          CLEAR(loc:SumaCUIT)
          LOOP C# = 10 TO 1 BY -1
            IF I# = 7 THEN I# = 1.
            I# += 1
            loc:SumaCUIT += SUB(RTE:CUIT,C#,1) * I#
          END
          loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
          IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
          IF loc:DigitoVerificador <> SUB(RTE:CUIT,11,1) THEN
            e# = 1
            BEEP(BEEP:SystemHand)  ;  YIELD()
            MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
            SELECT(?FAC:Remitente)
          END
        END
        IF (e# <> 1 OR RTE:PosicionIVA = 5) AND FAC:Remitente THEN
          IF (FAC:Letra='A' AND RTE:PosicionIVA<>1) OR (FAC:Letra='B' AND RTE:PosicionIVA=1) THEN
            BEEP(BEEP:SystemExclamation)
            MESSAGE('La Categoría de IVA del Cliente seleccionado|no corresponde al Tipo de Comprobante','Atención !!!',ICON:Exclamation)
            SELECT(?FAC:Remitente)
          ELSE
            IF ThisWindow.Request = InsertRecord THEN
              IF ?loc:RteEsCliente{Prop:Checked} = True
                FAC:NombreRemitente = RTE:Nombre
                FAC:CUITRemitente = RTE:CUIT
      
                FAC:CategIVARemitente = RTE:PosicionIVA
                IVAR:CodCatIVA = RTE:PosicionIVA
                GET(CATIVAREM,IVAR:Por_CodIVA)
      
                FAC:DireccionRemitente = RTE:Direccion
                LOC:Localidad = RTE:Localidad
                FAC:LocalidadRemitente = RTE:Localidad
                FAC:TelefonoRemitente = RTE:Telefono
              END
            END
            IF ThisWindow.Request = ChangeRecord AND loc:RteEsCliente = 'S' THEN
              FAC:NombreRemitente = RTE:Nombre
              FAC:CUITRemitente = RTE:CUIT
      
              FAC:CategIVARemitente = RTE:PosicionIVA
              IVAR:CodCatIVA = RTE:PosicionIVA
              GET(CATIVAREM,IVAR:Por_CodIVA)
      
              FAC:DireccionRemitente = RTE:Direccion
              LOC:Localidad = RTE:Localidad
              FAC:LocalidadRemitente = RTE:Localidad
              FAC:TelefonoRemitente = RTE:Telefono
            END
            ThisWindow.Reset(TRUE)
            !DISPLAY
            SELECT(?loc:DesEsCliente)
          END
        END
      ELSE
        IF ThisWindow.Request = InsertRecord THEN
          IF ?loc:RteEsCliente{Prop:Checked} = True
            FAC:NombreRemitente = RTE:Nombre
            FAC:CUITRemitente = RTE:CUIT
      
            FAC:CategIVARemitente = RTE:PosicionIVA
            IVAR:CodCatIVA = RTE:PosicionIVA
            GET(CATIVAREM,IVAR:Por_CodIVA)
      
            FAC:DireccionRemitente = RTE:Direccion
            LOC:Localidad = RTE:Localidad
            FAC:LocalidadRemitente = RTE:Localidad
            FAC:TelefonoRemitente = RTE:Telefono
          END
        END
        IF ThisWindow.Request = ChangeRecord AND loc:RteEsCliente = 'S' THEN
          FAC:NombreRemitente = RTE:Nombre
          FAC:CUITRemitente = RTE:CUIT
      
          FAC:CategIVARemitente = RTE:PosicionIVA
          IVAR:CodCatIVA = RTE:PosicionIVA
          GET(CATIVAREM,IVAR:Por_CodIVA)
      
          LOC:Localidad = RTE:Localidad
          FAC:LocalidadRemitente = RTE:Localidad
          FAC:TelefonoRemitente = RTE:Telefono
        END
        ThisWindow.Reset(TRUE)
        !DISPLAY
        SELECT(?loc:DesEsCliente)
      END
    OF ?SelectDestinatario
      ThisWindow.Update
      DES:CodCliente = FAC:Destinatario
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        FAC:Destinatario = DES:CodCliente
      END
      ThisWindow.Reset(1)
    OF ?FAC:Destinatario
      IF FAC:Destinatario OR ?FAC:Destinatario{Prop:Req}
        DES:CodCliente = FAC:Destinatario
        IF Access:DESTINATARIO.TryFetch(DES:Por_Codigo)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            FAC:Destinatario = DES:CodCliente
          ELSE
            SELECT(?FAC:Destinatario)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
      IF FAC:FacturarA = 'D' THEN
        ! VALIDAR CUIT
        e# = 0
        IF DES:PosicionIVA <> 5 THEN
          I# = 1
          CLEAR(loc:SumaCUIT)
          LOOP C# = 10 TO 1 BY -1
            IF I# = 7 THEN I# = 1.
            I# += 1
            loc:SumaCUIT += SUB(DES:CUIT,C#,1) * I#
          END
          loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
          IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
          IF loc:DigitoVerificador <> SUB(DES:CUIT,11,1) THEN
            e# = 1
            BEEP(BEEP:SystemHand)  ;  YIELD()
            MESSAGE('Verifique el número de CUIT.','CUIT Erroneo !!!',ICON:Hand)
            SELECT(?FAC:Destinatario)
          END
        END
        IF (e# <> 1 OR DES:PosicionIVA = 5) AND FAC:Destinatario THEN
          IF (FAC:Letra = 'A' AND DES:PosicionIVA <> 1) OR (FAC:Letra = 'B' AND DES:PosicionIVA = 1) THEN
            BEEP(BEEP:SystemExclamation)
            MESSAGE('La Categoría de IVA del Cliente seleccionado|no corresponde al Tipo de Comprobante','Atención !!!',ICON:Exclamation)
            SELECT(?FAC:Destinatario)
          ELSE
            IF ThisWindow.Request = InsertRecord THEN
              IF ?loc:DesEsCliente{Prop:Checked} = True
                FAC:NombreDestino = DES:Nombre
                FAC:CUITDestino = DES:CUIT
      
                FAC:CategIVADestino = DES:PosicionIVA
                IVAD:CodCatIVA = DES:PosicionIVA
                GET(CATIVADES,IVAD:Por_CodIVA)
      
                FAC:DireccionDestino = DES:Direccion
                LOC2:Localidad = DES:Localidad
                FAC:LocalidadDestino = DES:Localidad
                FAC:TelefonoDestino = DES:Telefono
              END
            END
            IF ThisWindow.Request = ChangeRecord AND loc:DesEsCliente = 'S' THEN
              FAC:NombreDestino = DES:Nombre
              FAC:CUITDestino = DES:CUIT
      
              FAC:CategIVADestino = DES:PosicionIVA
              IVAD:CodCatIVA = DES:PosicionIVA
              GET(CATIVADES,IVAD:Por_CodIVA)
      
              FAC:DireccionDestino = DES:Direccion
              LOC2:Localidad = DES:Localidad
              FAC:LocalidadDestino = DES:Localidad
              FAC:TelefonoDestino = DES:Telefono
            END
            SELECT(?FAC:TipoServicio)
            DISPLAY
          END
        END
      ELSE
        IF ThisWindow.Request = InsertRecord THEN
          IF ?loc:DesEsCliente{Prop:Checked} = True
            FAC:NombreDestino = DES:Nombre
            FAC:CUITDestino = DES:CUIT
      
            FAC:CategIVADestino = DES:PosicionIVA
            IVAD:CodCatIVA = DES:PosicionIVA
            GET(CATIVADES,IVAD:Por_CodIVA)
      
            FAC:DireccionDestino = DES:Direccion
            LOC2:Localidad = DES:Localidad
            FAC:LocalidadDestino = DES:Localidad
            FAC:TelefonoDestino = DES:Telefono
          END
        END
        IF ThisWindow.Request = ChangeRecord AND loc:DesEsCliente = 'S' THEN
          FAC:NombreDestino = DES:Nombre
          FAC:CUITDestino = DES:CUIT
      
          FAC:CategIVADestino = DES:PosicionIVA
          IVAD:CodCatIVA = DES:PosicionIVA
          GET(CATIVADES,IVAD:Por_CodIVA)
      
          FAC:DireccionDestino = DES:Direccion
          LOC2:Localidad = DES:Localidad
          FAC:LocalidadDestino = DES:Localidad
          FAC:TelefonoDestino = DES:Telefono
        END
        SELECT(?FAC:TipoServicio)
        DISPLAY
      END
    OF ?Facturar
      ThisWindow.Update
      AplicaGuias
      ThisWindow.Reset
      BRW1.ResetFromFile
      ThisWindow.Reset(TRUE)
      !SELECT(
    OF ?Volver
      ThisWindow.Update
      BRW2.UpdateViewRecord
      
      GUIA:RegGuia = APGUIA:Guia
      GET(GUIAS,GUIA:Por_Registro)
      GUIA:Facturada = ''
      PUT(GUIAS)
      
      DELETE(APLIGUIA)
      
      ThisWindow.Reset
    OF ?FAC:Seguro
      
      if loc:mitadiva=1 then
          iva$=0.105
      else
          iva$=0.21
      end!if
      
      !IF (FAC:FacturarA='R' AND RTE:PosicionIVA=4) OR (FAC:FacturarA='D' AND DES:PosicionIVA=4) THEN
      !  FAC:IVA = 0
      !  FAC:Importe = FAC:Neto + FAC:Seguro
      !ELSE
        FAC:IVA = (FAC:Neto+FAC:Seguro) * iva$
        FAC:Importe = FAC:Neto + FAC:Seguro + FAC:IVA
      !END
      !D
    OF ?OK
      ThisWindow.Update
      IF ThisWindow.Request = InsertRecord AND loc:FormaPago = 'C' THEN
        EmisionRecibo
        IF glo:Dia = 1 THEN FAC:Aplicado = FAC:Importe * -1.
      END
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
    CASE FIELD()
    OF ?List
      IF NOT RECORDS(BRW1) THEN
        DISABLE(?Facturar)
      ELSE
        ENABLE(?Facturar)
      END
    OF ?List:2
      IF NOT RECORDS(BRW2) THEN
        DISABLE(?Volver)
        ENABLE(?FAC:FacturarA)
      ELSE
        ENABLE(?Volver)
        DISABLE(?FAC:FacturarA)
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
    CASE EVENT()
    OF EVENT:OpenWindow
      IF ThisWindow.Request = ChangeRecord THEN
        IF FAC:Remitente THEN
          loc:RteEsCliente = 'S'
          ?FAC:NombreRemitente{Prop:ReadOnly} = True
          ?FAC:CUITRemitente{Prop:ReadOnly} = True
          ?FAC:DireccionRemitente{Prop:ReadOnly} = True
          ?LOC:Localidad{Prop:ReadOnly} = True
          ?FAC:TelefonoRemitente{Prop:ReadOnly} = True
          ENABLE(?FAC:Remitente)
          ENABLE(?SelectRemitente)
        ELSE
          ?FAC:NombreRemitente{Prop:ReadOnly} = False
          ?FAC:CUITRemitente{Prop:ReadOnly} = False
          ?FAC:DireccionRemitente{Prop:ReadOnly} = False
          ?LOC:Localidad{Prop:ReadOnly} = False
          ?FAC:TelefonoRemitente{Prop:ReadOnly} = False
          DISABLE(?FAC:Remitente)
          DISABLE(?SelectRemitente)
        END
        IF FAC:Destinatario THEN
          loc:DesEsCliente = 'S'
          ?FAC:NombreDestino{Prop:ReadOnly} = True
          ?FAC:CUITDestino{Prop:ReadOnly} = True
          ?FAC:DireccionDestino{Prop:ReadOnly} = True
          ?LOC2:Localidad{Prop:ReadOnly} = True
          ?FAC:TelefonoDestino{Prop:ReadOnly} = True
          ENABLE(?FAC:Destinatario)
          ENABLE(?SelectDestinatario)
        ELSE
          ?FAC:NombreDestino{Prop:ReadOnly} = False
          ?FAC:CUITDestino{Prop:ReadOnly} = False
          ?FAC:DireccionDestino{Prop:ReadOnly} = False
          ?LOC2:Localidad{Prop:ReadOnly} = False
          ?FAC:TelefonoDestino{Prop:ReadOnly} = False
          DISABLE(?FAC:Destinatario)
          DISABLE(?SelectDestinatario)
        END
        IVAR:CodCatIVA = FAC:CategIVARemitente
        GET(CATIVAREM,IVAR:Por_CodIVA)
        IVAD:CodCatIVA = FAC:CategIVADestino
        GET(CATIVADES,IVAD:Por_CodIVA)
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
    CASE EVENT()
    OF EVENT:OpenWindow
      IF ThisWindow.Request = ChangeRecord THEN
        IF loc:TotalContado = 0 THEN SELECT(?CuentaCorriente).
      END
      
      loc:FacturaElectronica=1
      loc:Tipo='FAC'
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW1.ResetFromView PROCEDURE

loc:TotalCtaCte:Sum  REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:GUIAS.SetQuickScan(1)
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
    loc:TotalCtaCte:Sum += GUIA:Importe
  END
  loc:TotalCtaCte = loc:TotalCtaCte:Sum
  PARENT.ResetFromView
  Relate:GUIAS.SetQuickScan(0)
  SETCURSOR()


BRW2.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW2.ResetFromView PROCEDURE

loc:TotalFacturar:Sum REAL                                 ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:APLIGUIA.SetQuickScan(1)
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
    loc:TotalFacturar:Sum += GUIA:Importe
  END
  loc:TotalFacturar = loc:TotalFacturar:Sum
  PARENT.ResetFromView
  if loc:mitadiva=1 then
      iva$=0.105
  else
      iva$=0.21
  end!if
  
  
  FAC:Neto = loc:TotalFacturar
  !IF (FAC:FacturarA='R' AND RTE:PosicionIVA=4) OR (FAC:FacturarA='D' AND DES:PosicionIVA=4) THEN
  !  FAC:IVA = 0
  !  FAC:Importe = FAC:Neto + FAC:Seguro
  !ELSE
    FAC:IVA = (FAC:Neto+FAC:Seguro) * iva$
    FAC:Importe = FAC:Neto + FAC:Seguro + FAC:IVA
  !END
  
  IF loc:TotalFacturar <> 0 THEN
    DISABLE(?Contado)
  ELSE
    ENABLE(?Contado)
  END
  Relate:APLIGUIA.SetQuickScan(0)
  SETCURSOR()


BRW5.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW5.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW5.ResetFromView PROCEDURE

loc:TotalContado:Sum REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:ITEMFAC.SetQuickScan(1)
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
    loc:TotalContado:Sum += ITFAC:Importe
  END
  loc:TotalContado = loc:TotalContado:Sum
  PARENT.ResetFromView
  if loc:mitadiva=1 then
      iva$=0.105
  else
      iva$=0.21
  end!if
  
  FAC:Neto = loc:TotalContado
  !IF (FAC:FacturarA='R' AND RTE:PosicionIVA=4) OR (FAC:FacturarA='D' AND DES:PosicionIVA=4) THEN
  !  FAC:IVA = 0
  !  FAC:Importe = FAC:Neto + FAC:Seguro
  !ELSE
    FAC:IVA = (FAC:Neto+FAC:Seguro) * iva$
    FAC:Importe = FAC:Neto + FAC:Seguro + FAC:IVA
  !END
  
  IF loc:TotalContado <> 0 THEN
    DISABLE(?CuentaCorriente)
  ELSE
    ENABLE(?CuentaCorriente)
  END
  Relate:ITEMFAC.SetQuickScan(0)
  SETCURSOR()


FDCB13.ResetQueue PROCEDURE(BYTE Force=0)

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


FDB7.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue


FDB9.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue

