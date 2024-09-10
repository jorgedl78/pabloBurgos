

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS035.INC'),ONCE        !Local module procedure declarations
                     END


ReciboContraReembolso PROCEDURE                            ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
Process:View         VIEW(GUIAS)
                       PROJECT(GUIA:ContraReembolso)
                       PROJECT(GUIA:Cumplida)
                       PROJECT(GUIA:Lugar)
                       PROJECT(GUIA:NombreDestino)
                       PROJECT(GUIA:NombreRemitente)
                       PROJECT(GUIA:Numero)
                       PROJECT(GUIA:RegGuia)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
! Variables Monto en Letras

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
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,10),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,27,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancelar'),AT(46,41,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(708,406,7156,3698),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',10,,),THOUS
detalle                DETAIL,AT(,,,3063),USE(?detalle)
                         STRING(@s35),AT(1375,875,2698,208),USE(PAR:RazonSocial),TRN,FONT(,,,FONT:bold)
                         STRING(@s255),AT(2021,1146,4969,208),USE(glo:MontoLetra),TRN
                         STRING('Recibí de'),AT(635,875),USE(?String2),TRN,FONT(,,,FONT:italic)
                         STRING('la cantidad de pesos'),AT(635,1146),USE(?String3),TRN,FONT(,,,FONT:italic)
                         STRING('en concepto de'),AT(635,1417),USE(?String10),TRN,FONT(,,,FONT:italic)
                         STRING('CONTRA REEMBOLSO - GUIA NRO.'),AT(1729,1417),USE(?String11),TRN
                         STRING('-'),AT(4375,1417,240,208),USE(?String14),TRN,CENTER
                         STRING(@n04),AT(4073,1417),USE(GUIA:Lugar),TRN,RIGHT(1)
                         STRING(@n08),AT(4521,1417),USE(GUIA:Numero),TRN,RIGHT(1)
                         STRING(@s40),AT(1667,1688,3031,208),USE(GUIA:NombreDestino)
                         STRING('por cuenta de'),AT(635,1688),USE(?String4),TRN,FONT(,,,FONT:italic)
                         LINE,AT(2688,2521,1200,0),USE(?Line1),COLOR(COLOR:Black)
                         STRING('Firma'),AT(3156,2531),USE(?String17),TRN,FONT('Arial',7,,FONT:regular,CHARSET:ANSI)
                         STRING('Aclaración'),AT(4667,2531),USE(?String17:2),TRN,FONT('Arial',7,,FONT:regular,CHARSET:ANSI)
                         LINE,AT(3927,2521,2000,0),USE(?Line1:2),COLOR(COLOR:Black)
                         LINE,AT(5979,2521,1000,0),USE(?Line1:3),COLOR(COLOR:Black)
                         STRING('$'),AT(813,2365,198,250),USE(?String6),TRN,CENTER,FONT('Arial',16,,FONT:italic)
                         STRING(@s40),AT(3323,2698,3115,208),USE(GUIA:NombreRemitente),TRN,CENTER
                         BOX,AT(1083,2302,1000,354),USE(?Box2),ROUND,COLOR(COLOR:Black),FILL(0ECECECH)
                         STRING(@N*10.2),AT(1208,2396,708,208),USE(GUIA:ContraReembolso),TRN,RIGHT(1),FONT(,,,FONT:bold)
                         STRING('Documento'),AT(6250,2531),USE(?String17:3),TRN,FONT('Arial',7,,FONT:regular,CHARSET:ANSI)
                         BOX,AT(42,63,7073,2958),USE(?Box1),COLOR(COLOR:Black)
                         STRING('Recibo'),AT(177,156,1323,427),USE(?String15),TRN,FONT('Batang',26,,FONT:regular+FONT:italic)
                         STRING(@d18),AT(4875,281,2031,),USE(GUIA:Cumplida),TRN,RIGHT(1)
                         BOX,AT(83,115,6979,2854),USE(?Box1:2),COLOR(COLOR:Black)
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
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
? DEBUGHOOK(GUIAS:Record)
? DEBUGHOOK(PARAMETRO:Record)
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
  GlobalErrors.SetProcedureName('ReciboContraReembolso')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:GUIAS.SetOpenRelated()
  Relate:GUIAS.Open                                        ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:GUIAS, ?Progress:PctText, Progress:Thermometer, ProgressMgr, GUIA:RegGuia)
  ThisReport.AddSortOrder(GUIA:Por_Registro)
  ThisReport.AddRange(GUIA:RegGuia)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:GUIAS.SetQuickScan(1,Propagate:OneMany)
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
    Relate:GUIAS.Close
    Relate:PARAMETRO.Close
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


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  PAR:Registro = glo:Empresa
  GET(PARAMETRO,PAR:Por_Registro)
  
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
  
    Valor = INT(GUIA:ContraReembolso)
    Centavos = (GUIA:ContraReembolso - Valor) * 100                                           !Centavos
    IF Valor = 1 THEN
      Respuesta = 'PESO.'
    ELSE
      Respuesta = 'PESOS.'
    .
  
    Valor = INT(Centavos + 0.01)
    IF Centavos <> 0 THEN Respuesta = 'PESOS CON ' & FORMAT(Valor,@n02) & '/100 CTVOS.'.
  
  
    Valor = INT(GUIA:ContraReembolso - (INT(GUIA:ContraReembolso / 1000) * 1000))             !Unidades
    IF Valor <> 0 THEN
      DO Calc_Modulo
      Respuesta = CLIP(Modulo) & ' ' & CLIP(Respuesta)
    .
  
    Valor = INT(GUIA:ContraReembolso / 1000) - (INT(GUIA:ContraReembolso / 1000000) * 1000)   !Miles
    IF Valor = 1 THEN
      Respuesta = 'UN MIL ' & CLIP(Respuesta)
    ELSIF Valor <> 0 THEN
      DO Calc_Modulo
      Respuesta = CLIP(Modulo) & ' MIL ' & CLIP(Respuesta)
    .
  
    Valor = INT(GUIA:ContraReembolso / 1000000)                                               !Millones
    IF Valor = 1 THEN
      Respuesta = 'UN MILLON ' & CLIP(Respuesta)
    ELSIF Valor <> 0 THEN
      DO Calc_Modulo
      Respuesta = CLIP(Modulo) & ' MILLONES ' & CLIP(Respuesta)
    .
  
  glo:MontoLetra = Respuesta
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detalle)
  RETURN ReturnValue

