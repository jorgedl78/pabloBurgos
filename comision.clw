   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('EFOCUS.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE

   MAP
     MODULE('Windows API')
SystemParametersInfo PROCEDURE (LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni),LONG,RAW,PROC,PASCAL,DLL(TRUE),NAME('SystemParametersInfoA')
     END
     MODULE('COMISBC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('COMIS001.CLW')
Main                   PROCEDURE   !
     END
     MODULE('COMIS129.CLW')
Ejecuta_Ws             PROCEDURE   !
     END
     MODULE('COMIS136.CLW')
Pie_mail               FUNCTION(),STRING   !Pie del email
     END
     Module('Windows.dll')
     Sleep(ULong),Pascal
     End
   END

glo:MontoLetra       STRING(255)
glo:FechaDesde       LONG
glo:FechaHasta       LONG
glo:Empresa          BYTE
glo:LetraFactura     STRING(1)
glo:LugarFactura     SHORT
glo:NumeraFactura    LONG
glo:NumeraGuia       LONG
glo:Cliente          SHORT
glo:Proveedor        LONG
glo:Distribuidor     BYTE
glo:Transporte       LONG
glo:Guia             LONG
glo:Dia              BYTE
glo:PorcentajeIB     DECIMAL(4,2)
glo:ImporteFacturar  DECIMAL(11,2)
glo:ImprimeTotal     STRING(1)
glo:SaldoaAplicar    DECIMAL(11,2)
GLO:Pragma           LONG
glo:HojaInicial      SHORT
glo_FE               BYTE
Glo:RutaArchivo_Certificado CSTRING(1024)
Glo:RutaArchivo_Clave CSTRING(1024)
Glo:ResultadoTXT     CSTRING(128)
Glo:CUIP             DECIMAL(11)
Glo:PuntoVentaElectronico SHORT
Glo:LineaRECE        STRING(290)
Glo:NroCAE           STRING(30)
Glo:Estado           CSTRING(21)
Glo:Error_CAE        SHORT
Glo:Descripcion_Error_CAE CSTRING(201)
Glo:FechaCAE         DATE
Glo:ejecutable       CSTRING(512)
Glo:Parametros       CSTRING(2048)
Glo:Test             BYTE
Glo:LineaRECE_Fex    STRING(4100)
glo:ArchivoTXT       CSTRING(1024)
GLO:ArchivoRECE      STRING(512)
Glo:Archivo_Respuesta_RECE STRING(512)
GLO_NumeroInternoTransaccion LONG
GLO_UltimoNumeroFactElectronica LONG
glo_error_FE         BYTE
glo_nombre_usuario   STRING(50)
glo:mensage          STRING(100)
glo:FEImprimir       SHORT
glo:condicionIvaReceptor LONG
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

CLIENTES             FILE,DRIVER('TOPSPEED'),OWNER('959gama'),NAME('CLIENTES.TPS'),PRE(CLI),BINDABLE,CREATE,THREAD
Por_Codigo               KEY(CLI:CodCliente),NOCASE,OPT,PRIMARY
Por_Nombre               KEY(CLI:Nombre),DUP,NOCASE,OPT
Por_Localidad            KEY(CLI:Localidad,CLI:Nombre),DUP,NOCASE,OPT
Por_Zona                 KEY(CLI:Zona,CLI:Localidad,CLI:Nombre),DUP,NOCASE,OPT
Por_Distribuidor         KEY(CLI:Distribuidor,CLI:Localidad,CLI:Nombre),DUP,NOCASE,OPT
Por_CategoriaIVA         KEY(CLI:PosicionIVA),DUP,NOCASE,OPT
Por_Provincia            KEY(CLI:Provincia),DUP,NOCASE,OPT
Notas                       MEMO(200)
Record                   RECORD,PRE()
CodCliente                  SHORT
Nombre                      STRING(40)
Direccion                   STRING(30)
CodPostal                   STRING(8)
Localidad                   STRING(30)
Provincia                   STRING(1)
Telefono                    STRING(35)
Email                       STRING(50)
Contacto                    STRING(25)
PosicionIVA                 BYTE
CUIT                        STRING(13)
Zona                        BYTE
Distribuidor                BYTE
SaldoInicial                DECIMAL(9,2)
Aviso                       STRING(1)
                         END
                     END                       

CITI                 FILE,DRIVER('ASCII'),NAME('C:\Afip\CITI.txt'),PRE(CITI),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
Registro                    STRING(398)
                         END
                     END                       

CITICA               FILE,DRIVER('ASCII'),NAME('C:\Afip\CITICA.txt'),PRE(CITICA),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
Registro                    STRING(398)
                         END
                     END                       

CITIC                FILE,DRIVER('ASCII'),NAME('C:\Afip\CITIC.txt'),PRE(CITIC),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
Registro                    STRING(398)
                         END
                     END                       

CITIA                FILE,DRIVER('ASCII'),NAME('C:\Afip\CITIA.txt'),PRE(CITIA),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
Registro                    STRING(398)
                         END
                     END                       

COMPROBANTES         FILE,DRIVER('TOPSPEED'),PRE(CPTE),BINDABLE,CREATE,THREAD
Por_Codigo               KEY(CPTE:Codigo),NOCASE,OPT,PRIMARY
Por_Descripcion          KEY(CPTE:Descripcion),DUP,NOCASE,OPT
Record                   RECORD,PRE()
Codigo                      BYTE
Descripcion                 STRING(25)
Abreviatura                 STRING(3)
Letra                       STRING(1)
Debito_Credito              STRING(1)
                         END
                     END                       

REDESPACHO           FILE,DRIVER('TOPSPEED'),PRE(RD),BINDABLE,CREATE,THREAD
Por_Guia                 KEY(RD:Guia),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
Guia                        LONG
Importe                     DECIMAL(9,2)
Estado                      LONG
                         END
                     END                       

PROVEEDORES          FILE,DRIVER('TOPSPEED'),OWNER('959gama'),PRE(PROV),BINDABLE,CREATE,THREAD
Por_CodProveedor         KEY(PROV:CodProveedor),NOCASE,OPT,PRIMARY
Por_Nombre               KEY(PROV:Nombre),DUP,NOCASE,OPT
Por_Localidad            KEY(PROV:Localidad,PROV:Nombre),DUP,NOCASE,OPT
Por_Tipo                 KEY(PROV:Tipo),DUP,NOCASE,OPT
Por_Provincia            KEY(PROV:Provincia),DUP,NOCASE,OPT
Por_TipoIVA              KEY(PROV:PosicionIVA),DUP,NOCASE,OPT
Notas                       MEMO(200)
Record                   RECORD,PRE()
CodProveedor                LONG
Tipo                        STRING(4)
Nombre                      STRING(40)
OrdenCheque                 STRING(40)
Direccion                   STRING(30)
Localidad                   STRING(25)
CodPostal                   STRING(8)
Provincia                   STRING(1)
Telefono                    STRING(35)
Email                       STRING(50)
Contacto                    STRING(30)
PosicionIVA                 BYTE
CUIT                        STRING(20)
SaldoInicial                DECIMAL(9,2)
                         END
                     END                       

PARAMETRO            FILE,DRIVER('TOPSPEED'),PRE(PAR),BINDABLE,THREAD
Por_Registro             KEY(PAR:Registro),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
Registro                    BYTE
RazonSocial                 STRING(35)
Direccion                   STRING(35)
CodPostal                   STRING(8)
Localidad                   STRING(30)
Provincia                   STRING(30)
CategoriaIVA                STRING(25)
CUIT                        STRING(13)
InicioActividad             LONG
IngresosBrutos              STRING(15)
LetraGuia                   STRING(1)
LugarGuia                   SHORT
LetraFactura                STRING(1)
LugarFactura                LONG
XPosFactura                 SHORT
YPosFactura                 SHORT
                         END
                     END                       

VISITAS              FILE,DRIVER('TOPSPEED'),PRE(VIS),CREATE,BINDABLE,THREAD
Por_Cliente              KEY(VIS:Cliente,VIS:Dia),NOCASE,OPT,PRIMARY
Por_Dia                  KEY(VIS:Dia,VIS:Hora),DUP,NOCASE,OPT
Record                   RECORD,PRE()
Cliente                     SHORT
Dia                         BYTE
Hora                        LONG
                         END
                     END                       

FACTURAS             FILE,DRIVER('TOPSPEED'),NAME('FACTURAS.TPS'),PRE(FAC),BINDABLE,CREATE,THREAD
Por_Registro             KEY(FAC:RegFactura),NOCASE,OPT,PRIMARY
Por_NroComprobante       KEY(FAC:Numero),DUP,NOCASE,OPT
Por_Comprobante          KEY(FAC:Empresa,FAC:Comprobante,FAC:Letra,FAC:Lugar,FAC:Numero),NOCASE,OPT
Por_FechaA               KEY(FAC:Fecha),DUP,NOCASE,OPT
Por_FechaD               KEY(-FAC:Fecha),DUP,NOCASE,OPT
Por_Cliente              KEY(FAC:ClienteFacturar,FAC:Fecha),DUP,NOCASE,OPT
Por_Remitente            KEY(FAC:Remitente),DUP,NOCASE,OPT
Por_Destinatario         KEY(FAC:Destinatario),DUP,NOCASE,OPT
Por_Distribuidor         KEY(FAC:Distribuidor),DUP,NOCASE,OPT
Record                   RECORD,PRE()
RegFactura                  LONG
Fecha                       LONG
Empresa                     BYTE
Comprobante                 STRING(3)
Letra                       STRING(1)
Lugar                       LONG
Numero                      LONG
FacturarA                   STRING(1)
ClienteFacturar             SHORT
Remitente                   LONG
NombreRemitente             STRING(40)
CUITRemitente               STRING(13)
CategIVARemitente           BYTE
DireccionRemitente          STRING(30)
LocalidadRemitente          STRING(30)
TelefonoRemitente           STRING(35)
Destinatario                SHORT
NombreDestino               STRING(40)
CUITDestino                 STRING(13)
CategIVADestino             BYTE
DireccionDestino            STRING(30)
LocalidadDestino            STRING(30)
TelefonoDestino             STRING(35)
Distribuidor                BYTE
TipoServicio                STRING(1)
Flete                       STRING(1)
ValorDeclarado              DECIMAL(7,2)
Neto                        DECIMAL(11,2)
Seguro                      DECIMAL(10,2)
IVA                         DECIMAL(9,2)
Importe                     DECIMAL(11,2)
Aplicado                    DECIMAL(9,2)
Impresa                     STRING(1)
Cobrada                     LONG
Observacion                 STRING(255)
FE                          BYTE
CAE                         STRING(20)
FechaCAE                    STRING(20)
                         END
                     END                       

GUIAS                FILE,DRIVER('TOPSPEED'),NAME('GUIAS.TPS'),PRE(GUIA),BINDABLE,CREATE,THREAD
Por_Registro             KEY(GUIA:RegGuia),NOCASE,OPT,PRIMARY
Por_Fecha                KEY(-GUIA:Fecha),DUP,NOCASE,OPT
Por_Cliente_FechaA       KEY(GUIA:ClienteFacturar,GUIA:Fecha),DUP,NOCASE,OPT
Por_Cliente_FechaD       KEY(GUIA:ClienteFacturar,-GUIA:Fecha),DUP,NOCASE,OPT
Por_Numero               KEY(GUIA:Numero),DUP,NOCASE,OPT
Por_Comprobante          KEY(GUIA:Empresa,GUIA:Lugar,GUIA:Numero),NOCASE,OPT
Por_Distribuidor         KEY(GUIA:Distribuidor),DUP,NOCASE,OPT
Por_Redespacho           KEY(GUIA:Redespacho),DUP,NOCASE,OPT
Por_Remitente            KEY(GUIA:Remitente),DUP,NOCASE,OPT
Por_Destinatario         KEY(GUIA:Destinatario),DUP,NOCASE,OPT
Observacion                 MEMO(1000)
Record                   RECORD,PRE()
RegGuia                     LONG
Fecha                       LONG
Empresa                     BYTE
Letra                       STRING(1)
Lugar                       SHORT
Numero                      LONG
FacturarA                   STRING(1)
ClienteFacturar             SHORT
Remitente                   SHORT
NombreRemitente             STRING(40)
DireccionRemitente          STRING(30)
LocalidadRemitente          STRING(30)
TelefonoRemitente           STRING(35)
Destinatario                SHORT
NombreDestino               STRING(40)
DireccionDestino            STRING(30)
LocalidadDestino            STRING(30)
TelefonoDestino             STRING(35)
FormaPago                   BYTE
Distribuidor                BYTE
ValorDeclarado              DECIMAL(13,2)
ContraReembolso             DECIMAL(13,2)
Flete                       STRING(1)
Importe                     DECIMAL(13,2)
Redespacho                  LONG
RemitoCliente               STRING(10)
Impresa                     STRING(1)
Cumplida                    LONG
Facturada                   LONG
                         END
                     END                       

FACPROV              FILE,DRIVER('TOPSPEED'),PRE(FCP),BINDABLE,CREATE,THREAD
Por_Fecha_Presentacion   KEY(FCP:FechaPresentacion,FCP:Numero),DUP,NOCASE,OPT
Por_FechaPresentacionD   KEY(-FCP:FechaPresentacion),DUP,NOCASE,OPT
Por_NroComprobante       KEY(FCP:Numero),DUP,NOCASE,OPT
Por_Proveedor_Fecha      KEY(FCP:CodProveedor,FCP:FechaEmision),DUP,NOCASE,OPT
Por_Comprobante          KEY(FCP:Empresa,FCP:Comprobante,FCP:Letra,FCP:Lugar,FCP:Numero),DUP,NOCASE,OPT
Por_Registro             KEY(FCP:RegFacturaProv),NOCASE,OPT,PRIMARY
Por_Fecha_Cpte           KEY(FCP:FechaPresentacion,FCP:Comprobante,FCP:Lugar,FCP:Numero),DUP,NOCASE,OPT
Por_Cuenta               KEY(FCP:Cuenta),DUP,NOCASE,OPT
Por_Caja                 KEY(FCP:Caja),DUP,NOCASE,OPT
Comentario                  MEMO(200)
Record                   RECORD,PRE()
RegFacturaProv              LONG
Empresa                     BYTE
CodProveedor                SHORT
FechaEmision                LONG
FechaPresentacion           LONG
FormaPago                   BYTE
Comprobante                 BYTE
Letra                       STRING(1)
Lugar                       LONG
Numero                      LONG
NetoGravado                 DECIMAL(9,2)
NoGravado                   DECIMAL(9,2)
Exento                      DECIMAL(9,2)
Iva10                       DECIMAL(9,2)
Iva21                       DECIMAL(9,2)
Iva27                       DECIMAL(9,2)
PercepIVA                   DECIMAL(9,2)
PercepOtros                 DECIMAL(9,2)
PercepIB                    DECIMAL(9,2)
PercepMunicipal             DECIMAL(9,2)
ImpuestosInternos           DECIMAL(9,2)
Moneda                      STRING(3)
TipoCambio                  DECIMAL(11,6)
Importe                     DECIMAL(9,2)
Aplicado                    DECIMAL(9,2)
CAI                         STRING(14)
VencimientoCAI              LONG
Cuenta                      LONG
Remito                      STRING(1)
Impresa                     STRING(1)
Caja                        LONG
                         END
                     END                       

LOCALIDA             FILE,DRIVER('TOPSPEED'),NAME('LOCALIDA.TPS'),PRE(LOC),BINDABLE,THREAD
Por_Localidad            KEY(LOC:Localidad),NOCASE,OPT
Record                   RECORD,PRE()
Localidad                   STRING(30)
                         END
                     END                       

FE_RECE              FILE,DRIVER('ASCII'),NAME(Glo:ArchivoRECE),PRE(FRECE),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
Linea                       STRING(290)
                         END
                     END                       

FE_Respuesta_RECE    FILE,DRIVER('ASCII'),NAME('Respuesta.txt'),PRE(FE_Resp),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
Linea                       STRING(290)
                         END
                     END                       

APLIFAC              FILE,DRIVER('TOPSPEED'),PRE(APFAC),CREATE,BINDABLE,THREAD
Por_Recibo               KEY(APFAC:Recibo,APFAC:Factura),NOCASE,OPT
Por_Factura              KEY(APFAC:Factura,APFAC:Recibo),DUP,NOCASE,OPT
Record                   RECORD,PRE()
Recibo                      LONG
Factura                     LONG
Fecha                       LONG
Comprobante                 STRING(20)
ImporteAplicado             DECIMAL(9,2)
                         END
                     END                       

APLIGUIA             FILE,DRIVER('TOPSPEED'),PRE(APGUIA),BINDABLE,CREATE,THREAD
Por_Factura              KEY(APGUIA:Factura,APGUIA:Guia),NOCASE,OPT,PRIMARY
Por_Guia                 KEY(APGUIA:Guia),DUP,NOCASE,OPT
Record                   RECORD,PRE()
Factura                     LONG
Guia                        LONG
                         END
                     END                       

ITEMFAC              FILE,DRIVER('TOPSPEED'),PRE(ITFAC),BINDABLE,CREATE,THREAD
Por_Factura              KEY(ITFAC:RegFactura,ITFAC:Item),NOCASE,OPT,PRIMARY
Por_Item                 KEY(ITFAC:Item),NOCASE,OPT
Record                   RECORD,PRE()
RegFactura                  LONG
Item                        LONG
Cantidad                    DECIMAL(7,2)
Descripcion                 STRING(40)
Importe                     DECIMAL(11,2)
                         END
                     END                       

ZONAS                FILE,DRIVER('TOPSPEED'),PRE(ZON),BINDABLE,CREATE,THREAD
Por_Codigo               KEY(ZON:CodZona),NOCASE,OPT,PRIMARY
Por_Nombre               KEY(ZON:Nombre),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CodZona                     BYTE
Nombre                      STRING(40)
                         END
                     END                       

PARAMFE              FILE,DRIVER('TOPSPEED'),PRE(PARFE),BINDABLE,CREATE,THREAD
ParametrosFE_x_ID        KEY(PARFE:IDParametrosFE),NOCASE,OPT
Record                   RECORD,PRE()
IDParametrosFE              LONG
Certificado                 STRING(100)
Clave                       STRING(100)
CUIP                        STRING(11)
Puesto                      LONG
FA                          LONG
FB                          LONG
NCA                         LONG
NCB                         LONG
NDA                         LONG
NDB                         LONG
                         END
                     END                       

PARAMFE3             FILE,DRIVER('TOPSPEED'),PRE(PARFE3),BINDABLE,CREATE,THREAD
ParametrosFE_x_ID        KEY(PARFE3:IDParametrosFE),NOCASE,OPT
Record                   RECORD,PRE()
IDParametrosFE              LONG
Certificado                 STRING(100)
Clave                       STRING(100)
CUIP                        STRING(11)
Puesto                      LONG
F                           LONG
NC                          LONG
ND                          LONG
                         END
                     END                       

ITEMGUIA             FILE,DRIVER('TOPSPEED'),PRE(ITGUIA),BINDABLE,CREATE,THREAD
Por_Guia                 KEY(ITGUIA:RegGuia,ITGUIA:Item),NOCASE,OPT,PRIMARY
Por_Item                 KEY(ITGUIA:Item),NOCASE,OPT
Record                   RECORD,PRE()
RegGuia                     LONG
Item                        LONG
Cantidad                    SHORT
Descripcion                 STRING(40)
Aforo                       DECIMAL(13,2)
                         END
                     END                       

PROVINCI             FILE,DRIVER('TOPSPEED'),PRE(PCIA),BINDABLE,THREAD
Por_Codigo               KEY(PCIA:CodProvincia),NOCASE,OPT,PRIMARY
Por_Denominacion         KEY(PCIA:Denominacion),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CodProvincia                STRING(1)
Denominacion                STRING(20)
                         END
                     END                       

TRANSPOR             FILE,DRIVER('TOPSPEED'),PRE(TRA),BINDABLE,CREATE,THREAD
Por_Codigo               KEY(TRA:CodTransporte),NOCASE,OPT,PRIMARY
Por_Denominacion         KEY(TRA:Denominacion),DUP,NOCASE,OPT
Por_Provincia            KEY(TRA:Provincia,TRA:Denominacion),DUP,NOCASE,OPT
Por_CategoriaIVA         KEY(TRA:CatIVA),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CodTransporte               LONG
Denominacion                STRING(30)
Direccion                   STRING(30)
CodPostal                   STRING(8)
Localidad                   STRING(30)
Provincia                   STRING(1)
Telefono                    STRING(35)
Email                       STRING(50)
Contacto                    STRING(25)
CatIVA                      BYTE
CUIT                        STRING(13)
                         END
                     END                       

CATIVA               FILE,DRIVER('TOPSPEED'),NAME('CATIVA.TPS'),PRE(IVA),BINDABLE,CREATE,THREAD
Por_CodIVA               KEY(IVA:CodCatIVA),NOCASE,OPT,PRIMARY
Por_Descripcion          KEY(IVA:Descripcion),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CodCatIVA                   BYTE
Descripcion                 STRING(25)
Porcentaje                  DECIMAL(5,2)
                         END
                     END                       

DIAS                 FILE,DRIVER('TOPSPEED'),PRE(DIA),CREATE,BINDABLE,THREAD
Por_Codigo               KEY(DIA:Codigo),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
Codigo                      BYTE
Descripcion                 STRING(9)
                         END
                     END                       

DISTRIBUIDORES       FILE,DRIVER('TOPSPEED'),OWNER('959gama'),PRE(DIS),BINDABLE,CREATE,THREAD
Por_Codigo               KEY(DIS:CodDistribuidor),NOCASE,OPT,PRIMARY
Por_Nombre               KEY(DIS:Nombre),DUP,NOCASE,OPT
Por_Provincia            KEY(DIS:Provincia),DUP,NOCASE,OPT
Por_Zona                 KEY(DIS:Zona,DIS:CodDistribuidor),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CodDistribuidor             BYTE
Nombre                      STRING(35)
Direccion                   STRING(30)
CodPostal                   STRING(8)
Localidad                   STRING(30)
Provincia                   STRING(1)
Telefono                    STRING(30)
Email                       STRING(50)
Zona                        BYTE
Comision                    DECIMAL(5,2)
SaldoInicial                DECIMAL(9,2)
                         END
                     END                       

VALORES              FILE,DRIVER('TOPSPEED'),PRE(VAL),CREATE,BINDABLE,THREAD
Por_CodigoInterno        KEY(VAL:CodigoInterno),NOCASE,OPT,PRIMARY
Por_Recibo               KEY(VAL:Recibo),DUP,NOCASE,OPT
Por_Banco                KEY(VAL:Banco,VAL:Numero),NOCASE,OPT
Por_Numero               KEY(VAL:Numero),DUP,NOCASE,OPT
Por_Fecha                KEY(VAL:Fecha),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CodigoInterno               LONG
Recibo                      LONG
Tipo                        STRING(8)
Banco                       STRING(5)
Numero                      LONG
Fecha                       LONG
Importe                     DECIMAL(9,2)
                         END
                     END                       

BANCOS               FILE,DRIVER('TOPSPEED'),PRE(BCO),BINDABLE,CREATE,THREAD
Por_Nombre               KEY(BCO:Denominacion),NOCASE,OPT
Por_Codigo               KEY(BCO:Codigo),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
Codigo                      STRING(5)
Denominacion                STRING(25)
CUIT                        STRING(13)
                         END
                     END                       

TRANSLOC             FILE,DRIVER('TOPSPEED'),PRE(TRL),CREATE,BINDABLE,THREAD
Por_Transporte           KEY(TRL:Transporte,TRL:Localidad,TRL:Lunes),NOCASE,OPT,PRIMARY
Por_Localidad            KEY(TRL:Localidad,TRL:Lunes),DUP,NOCASE,OPT
Observacion                 MEMO(1000)
Record                   RECORD,PRE()
Transporte                  LONG
Localidad                   STRING(30)
Lunes                       STRING(1)
Martes                      STRING(1)
Miercoles                   STRING(1)
Jueves                      STRING(1)
Viernes                     STRING(1)
Sabado                      STRING(1)
Domingo                     STRING(1)
                         END
                     END                       

CATIVADES            FILE,DRIVER('TOPSPEED'),NAME('CATIVA.TPS'),PRE(IVAD),BINDABLE,CREATE,THREAD
Por_CodIVA               KEY(IVAD:CodCatIVA),NOCASE,OPT,PRIMARY
Por_Descripcion          KEY(IVAD:Descripcion),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CodCatIVA                   BYTE
Descripcion                 STRING(25)
Porcentaje                  DECIMAL(5,2)
                         END
                     END                       

CATIVAREM            FILE,DRIVER('TOPSPEED'),NAME('CATIVA.TPS'),PRE(IVAR),BINDABLE,CREATE,THREAD
Por_CodIVA               KEY(IVAR:CodCatIVA),NOCASE,OPT,PRIMARY
Por_Descripcion          KEY(IVAR:Descripcion),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CodCatIVA                   BYTE
Descripcion                 STRING(25)
Porcentaje                  DECIMAL(5,2)
                         END
                     END                       

RECIBOS              FILE,DRIVER('TOPSPEED'),NAME('FACTURAS.TPS'),PRE(REC),BINDABLE,CREATE,THREAD
Por_Registro             KEY(REC:RegFactura),NOCASE,OPT,PRIMARY
Por_NroComprobante       KEY(REC:Numero),DUP,NOCASE,OPT
Por_Comprobante          KEY(REC:Empresa,REC:Comprobante,REC:Letra,REC:Lugar,REC:Numero),NOCASE,OPT
Por_FechaA               KEY(REC:Fecha),DUP,NOCASE,OPT
Por_FechaD               KEY(-REC:Fecha),DUP,NOCASE,OPT
Por_Cliente              KEY(REC:ClienteFacturar,REC:Fecha),DUP,NOCASE,OPT
Por_Remitente            KEY(REC:Remitente),DUP,NOCASE,OPT
Por_Destinatario         KEY(REC:Destinatario),DUP,NOCASE,OPT
Por_Distribuidor         KEY(REC:Distribuidor),DUP,NOCASE,OPT
Record                   RECORD,PRE()
RegFactura                  LONG
Fecha                       LONG
Empresa                     BYTE
Comprobante                 STRING(3)
Letra                       STRING(1)
Lugar                       LONG
Numero                      LONG
FacturarA                   STRING(1)
ClienteFacturar             SHORT
Remitente                   LONG
NombreRemitente             STRING(40)
CUITRemitente               STRING(13)
CategIVARemitente           BYTE
DireccionRemitente          STRING(30)
LocalidadRemitente          STRING(30)
TelefonoRemitente           STRING(35)
Destinatario                SHORT
NombreDestino               STRING(40)
CUITDestino                 STRING(13)
CategIVADestino             BYTE
DireccionDestino            STRING(30)
LocalidadDestino            STRING(30)
TelefonoDestino             STRING(35)
Distribuidor                BYTE
TipoServicio                STRING(1)
Flete                       STRING(1)
ValorDeclarado              DECIMAL(7,2)
Neto                        DECIMAL(11,2)
Seguro                      DECIMAL(10,2)
IVA                         DECIMAL(9,2)
Importe                     DECIMAL(11,2)
Aplicado                    DECIMAL(9,2)
Impresa                     STRING(1)
Cobrada                     LONG
Observacion                 STRING(255)
FE                          BYTE
CAE                         STRING(20)
FechaCAE                    STRING(20)
                         END
                     END                       

REMITENTE            FILE,DRIVER('TOPSPEED'),OWNER('959gama'),NAME('CLIENTES.TPS'),PRE(RTE),BINDABLE,CREATE,THREAD
Por_Codigo               KEY(RTE:CodCliente),NOCASE,OPT,PRIMARY
Por_Nombre               KEY(RTE:Nombre),DUP,NOCASE,OPT
Por_Localidad            KEY(RTE:Localidad,RTE:Nombre),DUP,NOCASE,OPT
Por_Zona                 KEY(RTE:Zona,RTE:Localidad,RTE:Nombre),DUP,NOCASE,OPT
Por_Distribuidor         KEY(RTE:Distribuidor,RTE:Localidad,RTE:Nombre),DUP,NOCASE,OPT
Por_CategoriaIVA         KEY(RTE:PosicionIVA),DUP,NOCASE,OPT
Por_Provincia            KEY(RTE:Provincia),DUP,NOCASE,OPT
Notas                       MEMO(200)
Record                   RECORD,PRE()
CodCliente                  SHORT
Nombre                      STRING(40)
Direccion                   STRING(30)
CodPostal                   STRING(8)
Localidad                   STRING(30)
Provincia                   STRING(1)
Telefono                    STRING(35)
Email                       STRING(50)
Contacto                    STRING(25)
PosicionIVA                 BYTE
CUIT                        STRING(13)
Zona                        BYTE
Distribuidor                BYTE
SaldoInicial                DECIMAL(9,2)
Aviso                       STRING(1)
                         END
                     END                       

DESTINATARIO         FILE,DRIVER('TOPSPEED'),OWNER('959gama'),NAME('CLIENTES.TPS'),PRE(DES),BINDABLE,CREATE,THREAD
Por_Codigo               KEY(DES:CodCliente),NOCASE,OPT,PRIMARY
Por_Nombre               KEY(DES:Nombre),DUP,NOCASE,OPT
Por_Localidad            KEY(DES:Localidad,DES:Nombre),DUP,NOCASE,OPT
Por_Zona                 KEY(DES:Zona,DES:Localidad,DES:Nombre),DUP,NOCASE,OPT
Por_Distribuidor         KEY(DES:Distribuidor,DES:Localidad,DES:Nombre),DUP,NOCASE,OPT
Por_CategoriaIVA         KEY(DES:PosicionIVA),DUP,NOCASE,OPT
Por_Provincia            KEY(DES:Provincia),DUP,NOCASE,OPT
Notas                       MEMO(200)
Record                   RECORD,PRE()
CodCliente                  SHORT
Nombre                      STRING(40)
Direccion                   STRING(30)
CodPostal                   STRING(8)
Localidad                   STRING(30)
Provincia                   STRING(1)
Telefono                    STRING(35)
Email                       STRING(50)
Contacto                    STRING(25)
PosicionIVA                 BYTE
CUIT                        STRING(13)
Zona                        BYTE
Distribuidor                BYTE
SaldoInicial                DECIMAL(9,2)
Aviso                       STRING(1)
                         END
                     END                       

LOCALIDAD2           FILE,DRIVER('TOPSPEED'),NAME('LOCALIDA.TPS'),PRE(LOC2),BINDABLE,THREAD
Por_Localidad            KEY(LOC2:Localidad),NOCASE,OPT
Record                   RECORD,PRE()
Localidad                   STRING(30)
                         END
                     END                       


Access:CLIENTES      &FileManager,THREAD                   ! FileManager for CLIENTES
Relate:CLIENTES      &RelationManager,THREAD               ! RelationManager for CLIENTES
Access:CITI          &FileManager,THREAD                   ! FileManager for CITI
Relate:CITI          &RelationManager,THREAD               ! RelationManager for CITI
Access:CITICA        &FileManager,THREAD                   ! FileManager for CITICA
Relate:CITICA        &RelationManager,THREAD               ! RelationManager for CITICA
Access:CITIC         &FileManager,THREAD                   ! FileManager for CITIC
Relate:CITIC         &RelationManager,THREAD               ! RelationManager for CITIC
Access:CITIA         &FileManager,THREAD                   ! FileManager for CITIA
Relate:CITIA         &RelationManager,THREAD               ! RelationManager for CITIA
Access:COMPROBANTES  &FileManager,THREAD                   ! FileManager for COMPROBANTES
Relate:COMPROBANTES  &RelationManager,THREAD               ! RelationManager for COMPROBANTES
Access:REDESPACHO    &FileManager,THREAD                   ! FileManager for REDESPACHO
Relate:REDESPACHO    &RelationManager,THREAD               ! RelationManager for REDESPACHO
Access:PROVEEDORES   &FileManager,THREAD                   ! FileManager for PROVEEDORES
Relate:PROVEEDORES   &RelationManager,THREAD               ! RelationManager for PROVEEDORES
Access:PARAMETRO     &FileManager,THREAD                   ! FileManager for PARAMETRO
Relate:PARAMETRO     &RelationManager,THREAD               ! RelationManager for PARAMETRO
Access:VISITAS       &FileManager,THREAD                   ! FileManager for VISITAS
Relate:VISITAS       &RelationManager,THREAD               ! RelationManager for VISITAS
Access:FACTURAS      &FileManager,THREAD                   ! FileManager for FACTURAS
Relate:FACTURAS      &RelationManager,THREAD               ! RelationManager for FACTURAS
Access:GUIAS         &FileManager,THREAD                   ! FileManager for GUIAS
Relate:GUIAS         &RelationManager,THREAD               ! RelationManager for GUIAS
Access:FACPROV       &FileManager,THREAD                   ! FileManager for FACPROV
Relate:FACPROV       &RelationManager,THREAD               ! RelationManager for FACPROV
Access:LOCALIDA      &FileManager,THREAD                   ! FileManager for LOCALIDA
Relate:LOCALIDA      &RelationManager,THREAD               ! RelationManager for LOCALIDA
Access:FE_RECE       &FileManager,THREAD                   ! FileManager for FE_RECE
Relate:FE_RECE       &RelationManager,THREAD               ! RelationManager for FE_RECE
Access:FE_Respuesta_RECE &FileManager,THREAD               ! FileManager for FE_Respuesta_RECE
Relate:FE_Respuesta_RECE &RelationManager,THREAD           ! RelationManager for FE_Respuesta_RECE
Access:APLIFAC       &FileManager,THREAD                   ! FileManager for APLIFAC
Relate:APLIFAC       &RelationManager,THREAD               ! RelationManager for APLIFAC
Access:APLIGUIA      &FileManager,THREAD                   ! FileManager for APLIGUIA
Relate:APLIGUIA      &RelationManager,THREAD               ! RelationManager for APLIGUIA
Access:ITEMFAC       &FileManager,THREAD                   ! FileManager for ITEMFAC
Relate:ITEMFAC       &RelationManager,THREAD               ! RelationManager for ITEMFAC
Access:ZONAS         &FileManager,THREAD                   ! FileManager for ZONAS
Relate:ZONAS         &RelationManager,THREAD               ! RelationManager for ZONAS
Access:PARAMFE       &FileManager,THREAD                   ! FileManager for PARAMFE
Relate:PARAMFE       &RelationManager,THREAD               ! RelationManager for PARAMFE
Access:PARAMFE3      &FileManager,THREAD                   ! FileManager for PARAMFE3
Relate:PARAMFE3      &RelationManager,THREAD               ! RelationManager for PARAMFE3
Access:ITEMGUIA      &FileManager,THREAD                   ! FileManager for ITEMGUIA
Relate:ITEMGUIA      &RelationManager,THREAD               ! RelationManager for ITEMGUIA
Access:PROVINCI      &FileManager,THREAD                   ! FileManager for PROVINCI
Relate:PROVINCI      &RelationManager,THREAD               ! RelationManager for PROVINCI
Access:TRANSPOR      &FileManager,THREAD                   ! FileManager for TRANSPOR
Relate:TRANSPOR      &RelationManager,THREAD               ! RelationManager for TRANSPOR
Access:CATIVA        &FileManager,THREAD                   ! FileManager for CATIVA
Relate:CATIVA        &RelationManager,THREAD               ! RelationManager for CATIVA
Access:DIAS          &FileManager,THREAD                   ! FileManager for DIAS
Relate:DIAS          &RelationManager,THREAD               ! RelationManager for DIAS
Access:DISTRIBUIDORES &FileManager,THREAD                  ! FileManager for DISTRIBUIDORES
Relate:DISTRIBUIDORES &RelationManager,THREAD              ! RelationManager for DISTRIBUIDORES
Access:VALORES       &FileManager,THREAD                   ! FileManager for VALORES
Relate:VALORES       &RelationManager,THREAD               ! RelationManager for VALORES
Access:BANCOS        &FileManager,THREAD                   ! FileManager for BANCOS
Relate:BANCOS        &RelationManager,THREAD               ! RelationManager for BANCOS
Access:TRANSLOC      &FileManager,THREAD                   ! FileManager for TRANSLOC
Relate:TRANSLOC      &RelationManager,THREAD               ! RelationManager for TRANSLOC
Access:CATIVADES     &FileManager,THREAD                   ! FileManager for CATIVADES
Relate:CATIVADES     &RelationManager,THREAD               ! RelationManager for CATIVADES
Access:CATIVAREM     &FileManager,THREAD                   ! FileManager for CATIVAREM
Relate:CATIVAREM     &RelationManager,THREAD               ! RelationManager for CATIVAREM
Access:RECIBOS       &FileManager,THREAD                   ! FileManager for RECIBOS
Relate:RECIBOS       &RelationManager,THREAD               ! RelationManager for RECIBOS
Access:REMITENTE     &FileManager,THREAD                   ! FileManager for REMITENTE
Relate:REMITENTE     &RelationManager,THREAD               ! RelationManager for REMITENTE
Access:DESTINATARIO  &FileManager,THREAD                   ! FileManager for DESTINATARIO
Relate:DESTINATARIO  &RelationManager,THREAD               ! RelationManager for DESTINATARIO
Access:LOCALIDAD2    &FileManager,THREAD                   ! FileManager for LOCALIDAD2
Relate:LOCALIDAD2    &RelationManager,THREAD               ! RelationManager for LOCALIDAD2

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END

lCurrentFDSetting    LONG                                  ! Used by window frame dragging
lAdjFDSetting        LONG                                  ! ditto

  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('comision.INI', NVD_INI)                     ! Configure INIManager to use INI file
  DctInit
  SystemParametersInfo (38, 0, lCurrentFDSetting, 0)       ! Configure frame dragging
  IF lCurrentFDSetting = 1
    SystemParametersInfo (37, 0, lAdjFDSetting, 3)
  END
  Main
  INIMgr.Update
  IF lCurrentFDSetting = 1
    SystemParametersInfo (37, 1, lAdjFDSetting, 3)
  END
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

