

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS092.INC'),ONCE        !Local module procedure declarations
                     END


ImpresionRecibo1 PROCEDURE                                 ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:Concepto         STRING(8),DIM(10)                     !
loc:Banco            STRING(25),DIM(10)                    !
loc:Numero           LONG,DIM(10)                          !
loc:FechaValor       LONG,DIM(10)                          !
loc:Importe          DECIMAL(9,2),DIM(10)                  !
loc:Comprobante      STRING(20),DIM(10)                    !
loc:FechaComp        LONG,DIM(10)                          !
loc:ImpOriginal      DECIMAL(8,2),DIM(10)                  !
loc:ImpAplicado      DECIMAL(9,2),DIM(10)                  !
loc:TotalRecibido    DECIMAL(9,2)                          !
loc:TotalAplicaciones DECIMAL(9,2)                         !
loc:Saldo            DECIMAL(9,2)                          !
Process:View         VIEW(FACTURAS)
                       PROJECT(FAC:ClienteFacturar)
                       PROJECT(FAC:Fecha)
                       PROJECT(FAC:Letra)
                       PROJECT(FAC:Lugar)
                       PROJECT(FAC:Numero)
                       PROJECT(FAC:RegFactura)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
! Variables para Monto en Letras

Numero                  REAL
Centavos                REAL
Unidades                REAL
Decenas                 REAL
Centenas                REAL
Valor                   REAL
SinCientos              REAL
Respuesta               STRING(240)
Modulo                  STRING(34)
Parcial                 STRING(34)
D_Unidades_G            STRING(210)
D_Unidades              STRING(10),DIM(21),OVER(D_Unidades_G)
D_Decenas_G             STRING(72)
D_Decenas               STRING(9),DIM(8),OVER(D_Decenas_G)
D_Centenas_G            STRING(117)
D_Centenas              STRING(13),DIM(9),OVER(D_Centenas_G)
ProgressWindow       WINDOW('Procesando...'),AT(,,142,59),FONT('MS Sans Serif',8,,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,9),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,27,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancelar'),AT(46,41,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(458,427,7448,11146),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',8,,FONT:regular),THOUS
cabecera               DETAIL,AT(,,,2396),USE(?cabecera)
                         LINE,AT(7400,41,0,2380),USE(?Line11:2),COLOR(COLOR:Black)
                         LINE,AT(73,41,0,2380),USE(?Line11),COLOR(COLOR:Black)
                         BOX,AT(3469,42,500,500),USE(?Box1),COLOR(COLOR:Black)
                         LINE,AT(73,42,7332,0),USE(?Line1),COLOR(COLOR:Black)
                         STRING('Pablo A. Burgos'),AT(969,94),USE(?String1),TRN,FONT(,14,,FONT:bold)
                         STRING(@s1),AT(3552,135),USE(FAC:Letra),TRN,CENTER,FONT(,18,,FONT:bold)
                         STRING('RECIBO'),AT(4740,115,708,188),USE(?String6),TRN,FONT(,11,,FONT:bold)
                         STRING(@n08),AT(6333,115),USE(FAC:Numero),TRN,RIGHT(1),FONT('Courier New',11,,FONT:bold)
                         STRING(@n04),AT(5823,115),USE(FAC:Lugar),TRN,RIGHT(1),FONT('Courier New',11,,FONT:bold)
                         STRING('Comisiones SRL'),AT(1094,323),USE(?String2),TRN,FONT(,12,,FONT:bold)
                         STRING('Fecha:'),AT(5479,438),USE(?String8),TRN
                         STRING(@d6),AT(5927,438),USE(FAC:Fecha),TRN,RIGHT(1)
                         STRING('Documento'),AT(3469,552),USE(?String39),TRN,FONT(,7,,)
                         STRING('M. Moreno 861'),AT(260,688),USE(?String3),TRN
                         STRING('Tel. 0236 - 154643365'),AT(2198,688),USE(?String38),TRN
                         STRING('Alias: pabloysantiagoburgos'),AT(4542,792),USE(?String11:2),TRN,FONT(,,,FONT:bold)
                         STRING('No Válido'),AT(3510,677),USE(?String39:2),TRN,FONT(,7,,)
                         STRING('6000 - JUNIN - Bs. As.'),AT(260,844),USE(?String4),TRN
                         STRING('ORIGINAL'),AT(6417,865,813,177),USE(?Comprobante),TRN,RIGHT(1)
                         STRING('como'),AT(3604,802),USE(?String39:3),TRN,FONT(,7,,)
                         STRING('Factura'),AT(3552,917),USE(?String39:4),TRN,FONT(,7,,)
                         LINE,AT(73,1063,7332,0),USE(?Line1:2),COLOR(COLOR:Black)
                         STRING(@n6.),AT(5427,1146),USE(FAC:ClienteFacturar),TRN,LEFT
                         STRING('Sr./Sres.'),AT(208,1146),USE(?String11),TRN,FONT(,,,FONT:bold)
                         STRING(@s40),AT(958,1146,2573,167),USE(CLI:Nombre),TRN,FONT(,,,FONT:bold)
                         STRING('Cuenta Nro.:'),AT(4656,1146),USE(?String31),TRN,RIGHT(1)
                         STRING(@s30),AT(958,1292),USE(CLI:Direccion),TRN
                         STRING('C.U.I.T.:'),AT(4896,1292),USE(?String31:2),TRN,RIGHT(1)
                         STRING(@p##-########-#pb),AT(5427,1292),USE(CLI:CUIT),TRN
                         STRING(@s30),AT(958,1438),USE(CLI:Localidad),TRN
                         LINE,AT(73,1625,7332,0),USE(?Line1:3),COLOR(COLOR:Black)
                         STRING('Recibimos la cantidad de Pesos:'),AT(208,1688),USE(?String37),TRN,FONT(,,,FONT:italic)
                         TEXT,AT(2021,1688,5115,333),USE(glo:MontoLetra),BOXED
                         STRING('Este cobro se aplica a los siguientes comprobantes:'),AT(3833,2031),USE(?String40:2),TRN,FONT(,,,FONT:bold)
                         STRING('Detalle de los valores recibidos:'),AT(208,2031),USE(?String40),TRN,FONT(,,,FONT:bold)
                         BOX,AT(73,2188,7331,188),USE(?Box2),COLOR(COLOR:Black),FILL(0F4F4F4H)
                         LINE,AT(3688,2188,0,238),USE(?Line9:2),COLOR(COLOR:Black)
                         STRING('Imp. Original'),AT(5521,2208),USE(?String26:8),TRN,FONT(,,,FONT:bold)
                         STRING('Importe'),AT(3177,2208),USE(?String26:4),TRN,FONT(,,,FONT:bold)
                         STRING('Tipo'),AT(125,2208),USE(?String26),TRN,FONT(,,,FONT:bold)
                         STRING('Banco'),AT(563,2208),USE(?String26:2),TRN,FONT(,,,FONT:bold)
                         STRING('Número'),AT(1948,2208),USE(?String26:3),TRN,FONT(,,,FONT:bold)
                         STRING('Fecha'),AT(2667,2208),USE(?String26:5),TRN,FONT(,,,FONT:bold)
                         STRING('Fecha'),AT(5010,2208),USE(?String26:7),TRN,FONT(,,,FONT:bold)
                         STRING('Comprobante'),AT(3781,2208),USE(?String26:6),TRN,FONT(,,,FONT:bold)
                         STRING('Importe Aplicado'),AT(6396,2208),USE(?String26:9),TRN,FONT(,,,FONT:bold)
                       END
detalle                DETAIL,AT(-31,10,7469,125),USE(?detalle),FONT('Arial',7,,FONT:regular,CHARSET:ANSI)
                         STRING(@s8),AT(156,10,458,125),USE(loc:Concepto[1]),TRN
                         STRING(@s25),AT(594,10,1350,125),USE(loc:Banco[1]),TRN
                         STRING(@n10.b),AT(1927,10,510,125),USE(loc:Numero[1]),TRN,RIGHT(1)
                         STRING(@d6b),AT(2510,10,521,125),USE(loc:FechaValor[1]),TRN,RIGHT(1)
                         STRING(@n-13.2b),AT(2979,10,646,125),USE(loc:Importe[1]),TRN,RIGHT(2)
                         STRING(@s20),AT(3813,10,1115,125),USE(loc:Comprobante[1]),TRN
                         STRING(@d6b),AT(4875,10,500,125),USE(loc:FechaComp[1]),TRN,RIGHT(1)
                         STRING(@n-11.2b),AT(5583,10,656,125),USE(loc:ImpOriginal[1]),TRN,RIGHT(2)
                         STRING(@n-13.2b),AT(6583,10,750,125),USE(loc:ImpAplicado[1]),TRN,RIGHT(2)
                         LINE,AT(3719,-16,0,186),USE(?Line9),COLOR(COLOR:Black)
                       END
pie                    DETAIL,AT(,,,1302),USE(?pie)
                         LINE,AT(7396,-1900,0,2765),USE(?Line13:3),COLOR(COLOR:Black)
                         BOX,AT(73,10,7331,188),USE(?Box2:2),COLOR(COLOR:Black),FILL(0F4F4F4H)
                         STRING('TOTAL VALORES .....'),AT(1750,42),USE(?String45),TRN,RIGHT(1)
                         STRING(@n-13.2),AT(2844,42),USE(loc:TotalRecibido),TRN,RIGHT(2)
                         STRING('TOTAL APLICADO .....'),AT(5396,42),USE(?String45:2),TRN,RIGHT(1)
                         STRING(@n-13.2),AT(6552,42),USE(loc:TotalAplicaciones),TRN,RIGHT(2)
                         LINE,AT(73,-1900,0,2765),USE(?Line13),COLOR(COLOR:Black)
                         STRING('SALDO A FAVOR .....'),AT(5427,438),USE(?StringSaldo),TRN,RIGHT(1)
                         STRING(@n-13.2b),AT(6552,438),USE(loc:Saldo),TRN,RIGHT(2)
                         STRING('. . . . . . . . . . . . . . . . . . . . . . . . . . .'),AT(760,646),USE(?String54),TRN
                         STRING('Firma:'),AT(292,646),USE(?String53),TRN
                         LINE,AT(3688,-52,0,238),USE(?Line9:3),COLOR(COLOR:Black)
                         LINE,AT(73,865,7333,0),USE(?Line1:5),COLOR(COLOR:Black)
                       END
                     END
ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
Open                   PROCEDURE(),DERIVED                 ! Method added to host embed code
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
? DEBUGHOOK(APLIFAC:Record)
? DEBUGHOOK(BANCOS:Record)
? DEBUGHOOK(CLIENTES:Record)
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
Calc_Modulo         ROUTINE

  IF Valor = 100 THEN
    Modulo = 'CIEN'
  ELSE
    DO Calc_Parcial
    IF Valor > 100 THEN
      Valor = INT(Valor / 100)
      IF SinCientos = 0 THEN
        Modulo = CLIP(D_Centenas[Valor])
      ELSE
        Modulo = CLIP(D_Centenas[Valor]) & ' ' & CLIP(Parcial)
      .
    ELSE
      Modulo = CLIP(Parcial)
    .
  .
Calc_Parcial        ROUTINE

  Centenas = INT(Valor / 100)
  Decenas = INT(Valor / 10) - Centenas * 10
  Unidades = Valor - (Decenas * 10) - (Centenas * 100) + 1
  SinCientos = (Decenas * 10) + Unidades - 1

  CASE SinCientos
    OF 0 TO 20
      Parcial = CLIP(D_Unidades[SinCientos + 1])
    OF 21 TO 99
      IF Unidades = 1 THEN
        Parcial = CLIP(D_Decenas[Decenas - 1])
      ELSIF Decenas > 2 THEN
        Parcial = CLIP(D_Decenas[Decenas - 1]) & ' Y ' & CLIP(D_Unidades[Unidades])
      ELSE
        Parcial = CLIP(D_Decenas[Decenas - 1]) & CLIP(D_Unidades[Unidades])
      .
  END

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('ImpresionRecibo1')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIFAC.SetOpenRelated()
  Relate:APLIFAC.Open                                      ! File BANCOS used by this procedure, so make sure it's RelationManager is open
  Access:CLIENTES.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:RECIBOS.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:VALORES.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:BANCOS.UseFile                                    ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:FACTURAS, ?Progress:PctText, Progress:Thermometer, ProgressMgr, FAC:RegFactura)
  ThisReport.AddSortOrder(FAC:Por_Registro)
  ThisReport.AddRange(FAC:RegFactura)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:FACTURAS.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  SELF.Zoom = PageWidth
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
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
    Relate:APLIFAC.Close
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
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


ThisReport.Open PROCEDURE

  CODE
  PARENT.Open
  ! MONTO ESCRITO
  
    D_Unidades_G = 'CERO      ' |             !Carga de Unidades
                 & 'UN        ' |
                 & 'DOS       ' |
                 & 'TRES      ' |
                 & 'CUATRO    ' |
                 & 'CINCO     ' |
                 & 'SEIS      ' |
                 & 'SIETE     ' |
                 & 'OCHO      ' |
                 & 'NUEVE     ' |
                 & 'DIEZ      ' |
                 & 'ONCE      ' |             ! Y de primera decena
                 & 'DOCE      ' |
                 & 'TRECE     ' |
                 & 'CATORCE   ' |
                 & 'QUINCE    ' |
                 & 'DIECISEIS ' |
                 & 'DIECISIETE' |
                 & 'DIECIOCHO ' |
                 & 'DIECINUEVE' |
                 & 'VEINTE    '
    D_Decenas_G =  'VEINTI   ' |              !Carga de Decenas
                 & 'TREINTA  ' |
                 & 'CUARENTA ' |
                 & 'CINCUENTA' |
                 & 'SESENTA  ' |
                 & 'SETENTA  ' |
                 & 'OCHENTA  ' |
                 & 'NOVENTA  '
    D_Centenas_G = 'CIENTO       ' |          !Carga de Centenas
                 & 'DOSCIENTOS   ' |
                 & 'TRESCIENTOS  ' |
                 & 'CUATROCIENTOS' |
                 & 'QUINIENTOS   ' |
                 & 'SEISCIENTOS  ' |
                 & 'SETECIENTOS  ' |
                 & 'OCHOCIENTOS  ' |
                 & 'NOVECIENTOS  '
  
  !--------------------------------------------------------------------------------
    CLEAR(Respuesta)
  
    Numero = ABS(FAC:Importe)
    Valor = INT(Numero)
    Centavos = (Numero - Valor) * 100                                           !Centavos
    IF Valor = 1 THEN
      Respuesta = 'PESO.'
    ELSE
      Respuesta = 'PESOS.'
    .
  
    Valor = INT(Centavos + 0.01)
    IF Centavos <> 0 THEN Respuesta = 'PESOS CON ' & FORMAT(Valor,@n02) & '/100 CTVOS.'.
  
  
    Valor = INT(Numero - (INT(Numero / 1000) * 1000))                           !Unidades
    IF Valor <> 0 THEN
      DO Calc_Modulo
      Respuesta = CLIP(Modulo) & ' ' & CLIP(Respuesta)
    .
  
    Valor = INT(Numero / 1000) - (INT(Numero / 1000000) * 1000)                  !Miles
    IF Valor = 1 THEN
      Respuesta = 'UN MIL ' & CLIP(Respuesta)
    ELSIF Valor <> 0 THEN
      DO Calc_Modulo
      Respuesta = CLIP(Modulo) & ' MIL ' & CLIP(Respuesta)
    .
  
    Valor = INT(Numero / 1000000)                                                !Millones
    IF Valor = 1 THEN
      Respuesta = 'UN MILLON ' & CLIP(Respuesta)
    ELSIF Valor <> 0 THEN
      DO Calc_Modulo
      Respuesta = CLIP(Modulo) & ' MILLONES ' & CLIP(Respuesta)
    .
  
  glo:MontoLetra = Respuesta


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  LOOP 2 TIMES
    V# = 0
    A# = 0
    b# += 1
  
    SETTARGET(REPORT,?cabecera)
      IF b# = 2 THEN ?Comprobante{PROP:Text} = 'DUPLICADO'.
    SETTARGET
  
    CLI:CodCliente = FAC:ClienteFacturar
    GET(CLIENTES,CLI:Por_Codigo)
  
    PRINT(RPT:cabecera)
  
    CLEAR(loc:TotalRecibido)
    VAL:Recibo = FAC:RegFactura
    SET(VAL:Por_Recibo,VAL:Por_Recibo)
    LOOP UNTIL EOF(VALORES)
      NEXT(VALORES)
      IF VAL:Recibo <> FAC:RegFactura THEN BREAK.
      CLEAR(BCO:Denominacion)
      BCO:Codigo = VAL:Banco
      GET(BANCOS,BCO:Por_Codigo)
  
      V# += 1
      loc:Concepto[V#] = VAL:Tipo
      loc:Banco[V#] = BCO:Denominacion
      loc:Numero[V#] = VAL:Numero
      loc:FechaValor[V#] = VAL:Fecha
      loc:Importe[V#] = VAL:Importe
  
      loc:TotalRecibido += VAL:Importe
    END
  
    CLEAR(loc:TotalAplicaciones)
    APFAC:Recibo = FAC:RegFactura
    CLEAR(APFAC:Factura)
    SET(APFAC:Por_Recibo,APFAC:Por_Recibo)
    LOOP UNTIL EOF(APLIFAC)
      NEXT(APLIFAC)
      IF APFAC:Recibo <> FAC:RegFactura THEN BREAK.
      REC:RegFactura = APFAC:Factura
      GET(RECIBOS,REC:Por_Registro)
  
      A# += 1
      loc:Comprobante[A#] = APFAC:Comprobante
      loc:FechaComp[A#] = APFAC:Fecha
      loc:ImpOriginal[A#] = REC:Importe
      loc:ImpAplicado[A#] = APFAC:ImporteAplicado
  
      loc:TotalAplicaciones += APFAC:ImporteAplicado
    END
  
    LOOP I# = 1 TO 10 BY 1
  
      loc:Concepto[1] = loc:Concepto[I#]
      loc:Banco[1] = loc:Banco[I#]
      loc:Numero[1] = loc:Numero[I#]
      loc:FechaValor[1] = loc:FechaValor[I#]
      loc:Importe[1] = loc:Importe[I#]
  
      loc:Comprobante[1] = loc:Comprobante[I#]
      loc:FechaComp[1] = loc:FechaComp[I#]
      loc:ImpOriginal[1] = loc:ImpOriginal[I#]
      loc:ImpAplicado[1] = loc:ImpAplicado[I#]
  
      PRINT(RPT:detalle)
    END
  
    loc:Saldo = loc:TotalRecibido + loc:TotalAplicaciones
    IF loc:Saldo = 0 THEN
      SETTARGET(REPORT,?pie)
        HIDE(?StringSaldo)
      SETTARGET
    END
  
    PRINT(RPT:pie)
  END
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

