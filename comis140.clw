

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS140.INC'),ONCE        !Local module procedure declarations
                     END


ImpresionFacturaElectronica3 PROCEDURE                     ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:espacios         BYTE                                  !
loc:DetalleGuias     STRING(255)                           !
loc:ImporteItem      DECIMAL(7,2)                          !
loc:Neto             DECIMAL(8,2)                          !
loc:Seguro           DECIMAL(7,2)                          !
loc:Subtotal         DECIMAL(8,2)                          !
loc:nombre           STRING(40)                            !
loc:cuit             STRING(13)                            !
loc:domicilio        STRING(30)                            !
loc:localidad        STRING(30)                            !
loc:telefono         STRING(30)                            !
loc:ivaresponsable   STRING(20)                            !
loc:tipo_comprobante STRING(20)                            !
Process:View         VIEW(FACTURAS)
                       PROJECT(FAC:CAE)
                       PROJECT(FAC:CUITDestino)
                       PROJECT(FAC:CUITRemitente)
                       PROJECT(FAC:DireccionDestino)
                       PROJECT(FAC:DireccionRemitente)
                       PROJECT(FAC:Fecha)
                       PROJECT(FAC:FechaCAE)
                       PROJECT(FAC:IVA)
                       PROJECT(FAC:Importe)
                       PROJECT(FAC:Letra)
                       PROJECT(FAC:LocalidadDestino)
                       PROJECT(FAC:LocalidadRemitente)
                       PROJECT(FAC:Lugar)
                       PROJECT(FAC:NombreDestino)
                       PROJECT(FAC:NombreRemitente)
                       PROJECT(FAC:Numero)
                       PROJECT(FAC:Observacion)
                       PROJECT(FAC:RegFactura)
                       PROJECT(FAC:TelefonoDestino)
                       PROJECT(FAC:TelefonoRemitente)
                       PROJECT(FAC:ValorDeclarado)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
ProgressWindow       WINDOW('Procesando...'),AT(,,142,59),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,9),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,27,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancelar'),AT(46,41,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(240,563,7781,10625),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',8,,FONT:regular),THOUS
encabezado             DETAIL,AT(,,,3010),USE(?encabezado)
                         LINE,AT(188,2906,7333,0),USE(?Line1:4),COLOR(COLOR:Black)
                         STRING('PABLO'),AT(1594,94),USE(?String36),TRN,FONT(,22,,FONT:bold,CHARSET:ANSI)
                         STRING(@s1),AT(3677,73,729,656),USE(FAC:Letra),CENTER,FONT(,48,,,CHARSET:ANSI)
                         STRING('Servicio Puerta a Puerta'),AT(750,427),USE(?String36:2),TRN,FONT(,12,,FONT:bold,CHARSET:ANSI)
                         STRING('de Romina Elisa Sánchez'),AT(938,625),USE(?String36:38),TRN,FONT(,9,,,CHARSET:ANSI)
                         STRING('Nombre:'),AT(500,1615),USE(?String36:32),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s40),AT(1073,1615,2542,177),USE(loc:nombre,,?loc:nombre:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Número:'),AT(5615,417),USE(?String36:28),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@n08),AT(6781,406),USE(FAC:Numero),TRN,RIGHT(1),FONT('Courier New',10,COLOR:Black,FONT:bold)
                         BOX,AT(3521,52,1042,781),USE(?Box1),COLOR(COLOR:Black)
                         STRING('M. Moreno 861'),AT(1219,771),USE(?String36:3),TRN
                         STRING('C.U.I.T.: 27-27184555-9'),AT(5667,771),USE(?String36:30),TRN
                         STRING(@n04),AT(6115,406),USE(FAC:Lugar),TRN,RIGHT(1),FONT('Courier New',10,COLOR:Black,FONT:bold)
                         STRING('6000 - JUNIN - BUENOS AIRES'),AT(823,906),USE(?String36:4),TRN
                         STRING('Ing. Brutos: 27-27184555-9'),AT(5479,917),USE(?String36:39),TRN
                         STRING('CUIT:'),AT(4375,1833),USE(?String36:33),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@P##-########-#Pb),AT(4771,1833),USE(loc:cuit,,?loc:cuit:2),TRN
                         STRING('-'),AT(6646,354,177,260),USE(?String36:29),TRN,FONT(,14,,FONT:bold,CHARSET:ANSI)
                         STRING('Responsable Monotributo'),AT(823,1063),USE(?String36:5),TRN,FONT(,9,,FONT:bold,CHARSET:ANSI)
                         STRING('Domicilio:'),AT(458,1833),USE(?String36:34),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s30),AT(1073,1833),USE(loc:domicilio,,?loc:domicilio:2),TRN
                         STRING('Localidad:'),AT(406,2063),USE(?String36:35),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s30),AT(1073,2063,1698,177),USE(loc:localidad,,?loc:localidad:2),TRN
                         STRING('Inicio Actividades: 01-07-2006'),AT(5333,1052),USE(?String36:31),TRN
                         STRING(@s20),AT(3177,865),USE(loc:tipo_comprobante),TRN,CENTER(1),FONT('Courier New',10,COLOR:Black,FONT:bold)
                         LINE,AT(260,1354,7333,0),USE(?Line1),COLOR(COLOR:Black)
                         STRING('IVA:'),AT(4438,1615),USE(?String36:37),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s20),AT(4771,1615),USE(loc:ivaresponsable),TRN
                         STRING('Telefono:'),AT(448,2323),USE(?String36:36),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s30),AT(1094,2333,1302,167),USE(loc:telefono,,?loc:telefono:2),TRN
                         STRING(@d6),AT(6844,167),USE(FAC:Fecha),TRN,RIGHT(1)
                         STRING('Trans'),AT(688,63),USE(?String36:40),TRN,FONT('Century',22,,FONT:bold,CHARSET:ANSI)
                         LINE,AT(229,2594,7333,0),USE(?Line1:2),COLOR(COLOR:Black)
                         STRING('Cantidad'),AT(250,2688),USE(?String36:18),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Importe'),AT(4292,2688),USE(?String36:20),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Descripción'),AT(1344,2688),USE(?String36:19),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                       END
detalle                DETAIL,AT(,,7823,208),USE(?detalle)
                         STRING(@n7),AT(156,42),USE(ITFAC:Cantidad),TRN,RIGHT(1)
                         STRING(@s40),AT(896,52,2573,167),USE(ITFAC:Descripcion),TRN
                         STRING(@n10.2),AT(4156,42),USE(loc:ImporteItem),TRN,RIGHT(2)
                       END
espacio                DETAIL,AT(,,,208),USE(?espacio)
                       END
pie                    DETAIL,AT(,,,6708),USE(?pie)
                         STRING('X'),AT(5781,-604,292,198),USE(?FleteOrigen),TRN,HIDE,CENTER,FONT('Arial',12,COLOR:Black,FONT:regular)
                         TEXT,AT(240,5198,2385,854),USE(FAC:Observacion),BOXED,TRN
                         STRING('CAE:'),AT(1927,6354),USE(?String36:26),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Vencimiento:'),AT(3844,6354),USE(?String36:27),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         LINE,AT(5719,4958,1667,0),USE(?Line6:2),COLOR(COLOR:Black)
                         STRING('Subtotal:'),AT(5917,5073),USE(?String36:23),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('IVA'),AT(6219,5427),USE(?String36:24),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@n-11.2),AT(6677,5073),USE(loc:Subtotal),TRN,RIGHT(1)
                         TEXT,AT(240,31,4500,719),USE(loc:DetalleGuias),BOXED,TRN,HIDE
                         LINE,AT(4177,2760,0,1646),USE(?Line3),COLOR(COLOR:Black)
                         LINE,AT(323,2750,7333,0),USE(?Line1:3),COLOR(COLOR:Black)
                         LINE,AT(313,2990,7333,0),USE(?Line1:6),COLOR(COLOR:Black)
                         STRING('Destino'),AT(6063,2781),USE(?String36:7),TRN
                         STRING('Remitente'),AT(1958,2792),USE(?String36:6),TRN
                         STRING('Nombre:'),AT(4646,3104),USE(?String36:14),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Nombre:'),AT(927,3115),USE(?String36:8),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s40),AT(1500,3115,2542,177),USE(FAC:NombreRemitente),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@s40),AT(5260,3115,2573,167),USE(FAC:NombreDestino),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('CUIT:'),AT(4802,3333),USE(?String36:15),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('CUIT:'),AT(1083,3344),USE(?String36:9),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@P##-########-#Pb),AT(1500,3344),USE(FAC:CUITRemitente),TRN
                         STRING(@P##-########-#Pb),AT(5260,3344,865,167),USE(FAC:CUITDestino),TRN
                         STRING('Domicilio:'),AT(4604,3563),USE(?String36:16),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s30),AT(5260,3563),USE(FAC:DireccionDestino),TRN
                         STRING('Domicilio:'),AT(885,3573),USE(?String36:10),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s30),AT(1500,3573),USE(FAC:DireccionRemitente),TRN
                         STRING('Localidad:'),AT(4552,3792),USE(?String36:17),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s30),AT(5260,3792,1625,177),USE(FAC:LocalidadDestino),TRN
                         STRING('Localidad:'),AT(833,3802),USE(?String36:11),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s30),AT(1500,3802,1698,177),USE(FAC:LocalidadRemitente),TRN
                         STRING('Telefono:'),AT(4594,4052),USE(?String36:13),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Telefono:'),AT(875,4063),USE(?String36:12),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s35),AT(5250,4063,990,167),USE(FAC:TelefonoDestino),TRN
                         STRING(@s35),AT(1521,4073,1302,167),USE(FAC:TelefonoRemitente),TRN
                         LINE,AT(281,4396,7333,0),USE(?Line1:7),COLOR(COLOR:Black)
                         LINE,AT(146,6260,7333,0),USE(?Line1:5),COLOR(COLOR:Black)
                         LINE,AT(6500,6135,0,-1479),USE(?Line9),COLOR(COLOR:Black)
                         STRING('Valor declarado:'),AT(3177,5927),USE(?String36:21),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         LINE,AT(5729,5646,1677,0),USE(?Line6:3),COLOR(COLOR:Black)
                         BOX,AT(5719,4667,1677,1490),USE(?Box2),COLOR(COLOR:Black)
                         STRING(@n-11.2),AT(6771,-542),USE(loc:Neto),TRN,RIGHT(2)
                         STRING(@n10.2),AT(4115,5917),USE(FAC:ValorDeclarado),TRN,RIGHT(1)
                         STRING(@n-10.2b),AT(6740,5427),USE(FAC:IVA),TRN,RIGHT(2)
                         STRING('Total'),AT(6063,5823),USE(?String36:25),TRN,FONT(,10,,FONT:bold,CHARSET:ANSI)
                         STRING(@n10.2b),AT(6719,4771),USE(loc:Seguro),TRN,RIGHT(1)
                         LINE,AT(5719,5323,1677,0),USE(?Line6),COLOR(COLOR:Black)
                         STRING('Seguro'),AT(6000,4771),USE(?String36:22),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('X'),AT(5781,-188,292,198),USE(?FleteDestino),TRN,HIDE,CENTER,FONT('Arial',12,COLOR:Black,FONT:regular)
                         STRING(@n-11.2),AT(6510,5823),USE(FAC:Importe),RIGHT(1),FONT(,10,,,CHARSET:ANSI)
                         STRING(@s20),AT(2250,6354),USE(FAC:CAE)
                         STRING(@d6),AT(4635,6354),USE(FAC:FechaCAE)
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
? DEBUGHOOK(APLIGUIA:Record)
? DEBUGHOOK(CATIVA:Record)
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(FACTURAS:Record)
? DEBUGHOOK(GUIAS:Record)
? DEBUGHOOK(ITEMFAC:Record)
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
  GlobalErrors.SetProcedureName('ImpresionFacturaElectronica3')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIGUIA.SetOpenRelated()
  Relate:APLIGUIA.Open                                     ! File CATIVA used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File CATIVA used by this procedure, so make sure it's RelationManager is open
  Access:CLIENTES.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:ITEMFAC.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:CATIVA.UseFile                                    ! File referenced in 'Other Files' so need to inform it's FileManager
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
    Relate:APLIGUIA.Close
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
  PAR:Registro = 1
  GET(PARAMETRO,PAR:Por_Registro)
  
  SETTARGET(Report)
  x# = Report{PROP:Xpos}
  y# = Report{PROP:Ypos}
  x# += PAR:XPosFactura
  y# += PAR:YPosFactura
  TARGET{PROP:Xpos} = x#
  TARGET{PROP:Ypos} = y#
  SETTARGET
  
  LOOP 1 TIMES
    c# = 0
    b# = 0
    CLEAR(loc:DetalleGuias)
  
    CLI:CodCliente = FAC:ClienteFacturar
    GET(CLIENTES,CLI:Por_Codigo)
    
    IF (FAC:Neto * 1.21) = FAC:Importe THEN
      iva$=1.21
    ELSE
      iva$=1.105
    END
  
    SETTARGET(REPORT,?encabezado)
  !    IF NOT(ERRORCODE()) THEN
  !      CASE CLI:PosicionIVA
  !      OF 1
  !        UNHIDE(?IVA1)
  !      OF 2
  !        UNHIDE(?IVA2)
  !      OF 3
  !        UNHIDE(?IVA3)
  !      OF 4
  !        UNHIDE(?IVA4)
  !      OF 5
  !        UNHIDE(?IVA5)
  !      OF 6
  !        UNHIDE(?IVA6)
  !      END
  !    ELSE
  !      UNHIDE(?IVA5)
  !    END
  !
  !    CASE FAC:TipoServicio
  !    OF 'T'
  !      UNHIDE(?Transporte)
  !    OF 'C'
  !      UNHIDE(?Comision)
  !    END
  !
      IF FAC:Comprobante='FAC' THEN
          loc:tipo_comprobante='FACTURA'
      END
      CASE FAC:Flete
      OF 'R'
        IVA:CodCatIVA=FAC:CategIVARemitente
        get(CATIVA,IVA:Por_CodIVA)
        loc:ivaresponsable=IVA:Descripcion
        loc:nombre=FAC:NombreRemitente
        loc:cuit=FAC:CUITRemitente
        loc:domicilio= FAC:DireccionRemitente
        loc:localidad= FAC:LocalidadRemitente
        loc:telefono=FAC:TelefonoRemitente
      OF 'D'
        IVA:CodCatIVA=FAC:CategIVADestino
        get(CATIVA,IVA:Por_CodIVA)
        loc:ivaresponsable=IVA:Descripcion
        loc:nombre=FAC:NombreDestino
        loc:cuit= FAC:CUITDestino
        loc:domicilio= FAC:DireccionDestino
        loc:localidad=FAC:LocalidadDestino
        loc:telefono= FAC:TelefonoDestino
      END
  
  
    SETTARGET
    PRINT(RPT:encabezado)
  
    CLEAR(loc:ImporteItem)
    CLEAR(loc:Neto)
    ITFAC:RegFactura = FAC:RegFactura
    CLEAR(ITFAC:Item)
    SET(ITFAC:Por_Factura,ITFAC:Por_Factura)
    LOOP UNTIL EOF(ITEMFAC)
      NEXT(ITEMFAC)
      IF ITFAC:RegFactura <> FAC:RegFactura THEN BREAK.
      IF FAC:Letra = 'A' THEN
        loc:ImporteItem = ITFAC:Importe
      ELSE
        loc:ImporteItem = ITFAC:Importe
      END
      PRINT(RPT:detalle)
      c# += 1
    END
    loc:espacios = 3 - c#
    LOOP loc:espacios TIMES
      PRINT(RPT:espacio)
    END
  
    loc:DetalleGuias = 'GUIA NRO.: '
    APGUIA:Factura = FAC:RegFactura
    CLEAR(APGUIA:Guia)
    SET(APGUIA:Por_Factura,APGUIA:Por_Factura)
    LOOP UNTIL EOF(APLIGUIA)
      NEXT(APLIGUIA)
      IF APGUIA:Factura <> FAC:RegFactura THEN BREAK.
      GUIA:RegGuia = APGUIA:Guia
      GET(GUIAS,GUIA:Por_Registro)
      loc:DetalleGuias = CLIP(loc:DetalleGuias) & ' - ' & GUIA:Numero
      b# = 1
    END
  
    SETTARGET(REPORT,?pie)
      IF b# = 1 THEN UNHIDE(?loc:DetalleGuias).
      IF FAC:Letra = 'B' THEN HIDE(?FAC:IVA).
    SETTARGET
  
    CLEAR(loc:Seguro)
    IF FAC:Letra = 'A' THEN
      loc:Neto = FAC:Neto
      IF FAC:Seguro THEN loc:Seguro = FAC:Seguro.
    ELSE
      loc:Neto = FAC:Neto
      IF FAC:Seguro THEN loc:Seguro = FAC:Seguro.
    END
    loc:Subtotal = loc:Neto + loc:Seguro
    PRINT(RPT:pie)
  END
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

