

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS054.INC'),ONCE        !Local module procedure declarations
                     END


ImpresionGuia2 PROCEDURE                                   ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:espacios         BYTE                                  !
Process:View         VIEW(GUIAS)
                       PROJECT(GUIA:ContraReembolso)
                       PROJECT(GUIA:DireccionDestino)
                       PROJECT(GUIA:DireccionRemitente)
                       PROJECT(GUIA:Fecha)
                       PROJECT(GUIA:Importe)
                       PROJECT(GUIA:Letra)
                       PROJECT(GUIA:LocalidadDestino)
                       PROJECT(GUIA:LocalidadRemitente)
                       PROJECT(GUIA:Lugar)
                       PROJECT(GUIA:NombreDestino)
                       PROJECT(GUIA:NombreRemitente)
                       PROJECT(GUIA:Numero)
                       PROJECT(GUIA:Observacion)
                       PROJECT(GUIA:RegGuia)
                       PROJECT(GUIA:TelefonoDestino)
                       PROJECT(GUIA:TelefonoRemitente)
                       PROJECT(GUIA:ValorDeclarado)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
ProgressWindow       WINDOW('Procesando...'),AT(,,142,59),FONT('MS Sans Serif',8,,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,9),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,27,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancelar'),AT(46,41,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(458,427,7448,11146),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',8,COLOR:Black,FONT:regular),THOUS
encabezado             DETAIL,AT(,,,3135),USE(?encabezado)
                         LINE,AT(7400,41,0,2893),USE(?Line11:2),COLOR(COLOR:Black)
                         LINE,AT(73,41,0,2893),USE(?Line11),COLOR(COLOR:Black)
                         BOX,AT(3469,42,500,500),USE(?Box1),COLOR(COLOR:Black)
                         LINE,AT(73,42,7332,0),USE(?Line1),COLOR(COLOR:Black)
                         STRING('BURGOS COMISIONES'),AT(656,94),USE(?String1),TRN,FONT(,14,COLOR:Black,FONT:bold)
                         STRING(@s1),AT(3552,135),USE(GUIA:Letra),TRN,CENTER,FONT(,18,COLOR:Black,FONT:bold)
                         STRING('ACUSE DE RECIBO N<186>'),AT(4583,115,1333,188),USE(?String6),TRN,FONT(,9,COLOR:Black,FONT:bold)
                         STRING(@n08),AT(6458,115),USE(GUIA:Numero),TRN,RIGHT(1),FONT('Courier New',10,COLOR:Black,FONT:bold)
                         STRING(@n04),AT(5969,115),USE(GUIA:Lugar),TRN,RIGHT(1),FONT('Courier New',10,COLOR:Black,FONT:bold)
                         STRING('de Atilio Burgos'),AT(1115,323),USE(?String2),TRN,FONT(,12,COLOR:Black,FONT:bold)
                         STRING('Fecha:'),AT(5479,396),USE(?String8),TRN
                         STRING(@d6),AT(5927,396),USE(GUIA:Fecha),RIGHT(1),FONT(,,COLOR:Black,FONT:bold)
                         STRING('Documento'),AT(3469,552),USE(?String39),TRN,FONT(,7,COLOR:Black,)
                         LINE,AT(3688,1094,0,1800),USE(?Line5),COLOR(COLOR:Black)
                         STRING(@s40),AT(4740,1188,2573,167),USE(GUIA:NombreDestino),TRN
                         STRING('H. Irigoyen 479'),AT(260,688),USE(?String3),TRN
                         STRING('Tel. (02364)  431084'),AT(2198,688),USE(?String38),TRN
                         STRING('No Válido'),AT(3510,677),USE(?String39:2),TRN,FONT(,7,COLOR:Black,)
                         STRING('6000 - JUNIN - Bs. As.'),AT(260,844),USE(?String4),TRN
                         STRING('Celular 0236  -  154 - 643365'),AT(1781,844),USE(?String38:2),TRN
                         STRING('ORIGINAL'),AT(6417,865,813,177),USE(?Original),TRN,RIGHT(1)
                         STRING('como'),AT(3604,802),USE(?String39:3),TRN,FONT(,7,COLOR:Black,)
                         STRING('Factura'),AT(3552,917),USE(?String39:4),TRN,FONT(,7,COLOR:Black,)
                         LINE,AT(73,1083,7332,0),USE(?Line1:2),COLOR(COLOR:Black)
                         STRING('Remitente:'),AT(208,1188),USE(?String11),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@s40),AT(958,1188,2573,167),USE(GUIA:NombreRemitente),TRN
                         STRING('Destinatario:'),AT(3854,1188),USE(?String11:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@s30),AT(958,1354),USE(GUIA:DireccionRemitente),TRN
                         STRING(@s30),AT(4740,1354),USE(GUIA:DireccionDestino),TRN
                         STRING(@s30),AT(958,1521),USE(GUIA:LocalidadRemitente),TRN
                         STRING(@s30),AT(4740,1521),USE(GUIA:LocalidadDestino),TRN
                         STRING(@s35),AT(958,1698,2260,167),USE(GUIA:TelefonoRemitente),TRN
                         STRING(@s35),AT(4740,1698,2260,167),USE(GUIA:TelefonoDestino),TRN
                         LINE,AT(73,1938,7332,0),USE(?Line1:3),COLOR(COLOR:Black)
                         STRING('Contra Reembolso:'),AT(1958,2031),USE(?ContraReembolso),TRN
                         STRING(@n10.2b),AT(2906,2031),USE(GUIA:ContraReembolso),TRN,RIGHT(1)
                         STRING('Observaciones:'),AT(208,2031),USE(?String11:3),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Redespacho:'),AT(3854,2031),USE(?String11:4),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@s30),AT(4740,2042,1927,167),USE(TRA:Denominacion),TRN
                         TEXT,AT(219,2219,3417,656),USE(GUIA:Observacion),BOXED,TRN
                         STRING(@s30),AT(4740,2208),USE(TRA:Direccion),TRN
                         STRING(@s30),AT(4740,2375),USE(TRA:Localidad),TRN
                         STRING(@s35),AT(4740,2542,2240,167),USE(TRA:Telefono),TRN
                         STRING('** FLETE A COBRAR EN DESTINO **'),AT(3854,2719,2094,146),USE(?Flete),TRN,FONT(,,COLOR:Black,FONT:bold)
                         BOX,AT(73,2896,7332,208),USE(?Box2),COLOR(COLOR:Black),FILL(0F4F4F4H)
                         STRING('Cantidad'),AT(115,2938),USE(?String26),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Descripción'),AT(688,2938),USE(?String26:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Aforo'),AT(3365,2938),USE(?String26:3),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Valor declarado $'),AT(5500,2938),USE(?String26:5),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@n9.2),AT(6500,2938),USE(GUIA:ValorDeclarado),TRN,RIGHT(1),FONT(,,COLOR:Black,FONT:bold)
                       END
detalle                DETAIL,AT(,,,188),USE(?detalle)
                         STRING(@n7),AT(156,10,458,167),USE(ITGUIA:Cantidad),TRN,RIGHT(1)
                         STRING(@s40),AT(719,10,2510,167),USE(ITGUIA:Descripcion),TRN
                         STRING(@n10.2),AT(3042,10,615,167),USE(ITGUIA:Aforo),TRN,RIGHT(2)
                       END
espacio                DETAIL,AT(,,,188),USE(?espacio)
                       END
pie                    DETAIL,AT(,,,1490),USE(?pie)
                         LINE,AT(7400,-1122,0,2120),USE(?Line13:3),COLOR(COLOR:Black)
                         LINE,AT(73,-1125,0,2120),USE(?Line13),COLOR(COLOR:Black)
                         LINE,AT(73,0,7332,0),USE(?Line1:4),COLOR(COLOR:Black)
                         LINE,AT(2552,6,0,980),USE(?Line5:4),COLOR(COLOR:Black)
                         LINE,AT(3688,6,0,980),USE(?Line5:3),COLOR(COLOR:Black)
                         STRING('CONDICIONES ESPECIALES DEL TRANSPORTE'),AT(3750,21),USE(?String45),TRN,FONT(,7,,)
                         STRING('TOTAL'),AT(2594,73),USE(?String33),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@n12.2),AT(2917,73),USE(GUIA:Importe),TRN,RIGHT(2)
                         STRING('1)  El comisionista NO se hará RESPONSABLE del DINERO EN EFECTIVO'),AT(3823,188),USE(?String45:2),TRN,FONT(,7,,)
                         LINE,AT(2563,260,1140,0),USE(?Line9),COLOR(COLOR:Black)
                         STRING('proveniente de contrarreembolso o pagos a efectuar.'),AT(3823,302),USE(?String45:3),TRN,FONT(,7,,)
                         STRING('2)  El comisionista NO se hará RESPONSABLE de documentos y efectos'),AT(3823,458),USE(?String45:4),TRN,FONT(,7,,)
                         STRING('. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'),AT(146,156),USE(?String36),TRN
                         STRING('y contenido. En caso de pérdida o avería no estará obligado a indemnizar'),AT(3823,708),USE(?String45:6),TRN,FONT(,7,,)
                         STRING('de valor, si al tiempo de entrega, el remitente no hubiera declarado su valor'),AT(3823,583),USE(?String45:5),TRN,FONT(,7,,)
                         STRING('. . . . . . . . . . . . . . . . . .'),AT(135,729),USE(?String36:2),TRN
                         STRING('. . . . . . . . . . . . . . . . . .'),AT(1385,729),USE(?String36:3),TRN
                         STRING('Apellido y Nombre'),AT(896,260),USE(?String35),TRN
                         LINE,AT(73,990,7332,0),USE(?Line1:5),COLOR(COLOR:Black)
                         STRING('más que el valor declarado.'),AT(3823,833),USE(?String45:7),TRN,FONT(,7,,)
                         STRING('Firma'),AT(563,833),USE(?String35:2),TRN
                         STRING('Documento'),AT(1688,833),USE(?String35:3),TRN
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
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(GUIAS:Record)
? DEBUGHOOK(ITEMGUIA:Record)
? DEBUGHOOK(TRANSPOR:Record)
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
  GlobalErrors.SetProcedureName('ImpresionGuia2')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File ITEMGUIA used by this procedure, so make sure it's RelationManager is open
  Access:TRANSPOR.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:ITEMGUIA.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
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
    Relate:CLIENTES.Close
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
  LOOP 2 TIMES
    c# = 0
  
    IF GUIA:Redespacho THEN
      TRA:CodTransporte = GUIA:Redespacho
      GET(TRANSPOR,TRA:Por_Codigo)
    ELSE
      CLEAR(TRANSPOR)
    END
  
    SETTARGET(REPORT,?encabezado)
      IF b# = 1 THEN ?Original{PROP:Text} = 'DUPLICADO'.
      IF NOT GUIA:ContraReembolso THEN ?ContraReembolso{PROP:Text} = ''.
  
      IF GUIA:Flete = 'R' THEN ?Flete{PROP:Text} = '** FLETE PAGO **'.
      IF GUIA:Flete = 'I' THEN ?Flete{PROP:Text} = '** FLETE PAGO HASTA JUNIN **'.
      IF GUIA:Flete = 'D' THEN ?Flete{PROP:Text} = '** FLETE A COBRAR EN DESTINO **'.
    SETTARGET
  
    PRINT(RPT:encabezado)
  
    ITGUIA:RegGuia = GUIA:RegGuia
    CLEAR(ITGUIA:Item)
    SET(ITGUIA:Por_Guia,ITGUIA:Por_Guia)
    LOOP UNTIL EOF(ITEMGUIA)
      NEXT(ITEMGUIA)
      IF ITGUIA:RegGuia <> GUIA:RegGuia THEN BREAK.
      IF glo:ImprimeTotal = 'N' THEN
        SETTARGET(REPORT,?detalle)
          HIDE(?ITGUIA:Aforo)
        SETTARGET
      END
      PRINT(RPT:detalle)
      c# += 1
    END
    loc:espacios = 5 - c#
    LOOP loc:espacios TIMES
      PRINT(RPT:espacio)
    END
    IF glo:ImprimeTotal = 'N' THEN
      SETTARGET(REPORT,?pie)
        HIDE(?GUIA:Importe)
      SETTARGET
    END
    PRINT(RPT:pie)
    b# += 1
  END
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

