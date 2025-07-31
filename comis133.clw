

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS133.INC'),ONCE        !Local module procedure declarations
                     END


ImprimeFacturaElectronica PROCEDURE                        ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
loc:DetalleGuias     STRING(255)                           !
loc:iva              DECIMAL(7,2)                          !
loc:ImporteItem      DECIMAL(7,2)                          !
loc:Neto             DECIMAL(8,2)                          !
loc:Seguro           DECIMAL(7,2)                          !
loc:Subtotal         DECIMAL(8,2)                          !
loc:porcentajeiva    DECIMAL(7,2)                          !
loc:TipoComrpobante  STRING(20)                            !
loc:TipoComprobante  STRING(20)                            !
Process:View         VIEW(FACTURAS)
                       PROJECT(FAC:CAE)
                       PROJECT(FAC:CUITRemitente)
                       PROJECT(FAC:ClienteFacturar)
                       PROJECT(FAC:DireccionRemitente)
                       PROJECT(FAC:Fecha)
                       PROJECT(FAC:FechaCAE)
                       PROJECT(FAC:Importe)
                       PROJECT(FAC:Letra)
                       PROJECT(FAC:LocalidadRemitente)
                       PROJECT(FAC:Lugar)
                       PROJECT(FAC:NombreRemitente)
                       PROJECT(FAC:Numero)
                       PROJECT(FAC:RegFactura)
                       PROJECT(FAC:TelefonoRemitente)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
ProgressWindow       WINDOW('Report ITEMFAC'),AT(,,142,59),FONT('MS Sans Serif',8,,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(46,42,49,15),USE(?Progress:Cancel),FLAT,LEFT,MSG('Cancel Report'),TIP('Cancel Report'),ICON('WACancel.ico')
                     END

Report               REPORT('ITEMFAC Report'),AT(250,3469,8000,5740),PAPER(PAPER:LETTER),PRE(RPT),FONT('MS Sans Serif',8,,FONT:regular),THOUS
                       HEADER,AT(250,250,8000,3063),USE(?Header),FONT('MS Sans Serif',8,,FONT:regular)
                         STRING(@s1),AT(3646,219,604,552),USE(FAC:Letra),CENTER,FONT(,36,,,CHARSET:ANSI)
                         STRING(@d6),AT(6875,250),USE(FAC:Fecha),RIGHT(1)
                         STRING('Fecha:'),AT(6510,240),USE(?String32),TRN
                         STRING('PABLO A. BURGOS'),AT(313,115),USE(?String26),TRN,FONT('Arial',22,,FONT:bold,CHARSET:ANSI)
                         STRING('Comisiones SRL'),AT(781,427),USE(?String26:2),TRN,FONT('Arial',18,,FONT:bold,CHARSET:ANSI)
                         STRING(@n04),AT(5875,510),USE(FAC:Lugar),RIGHT(1),FONT(,16,,FONT:bold,CHARSET:ANSI)
                         STRING('M. Moreno 861'),AT(969,917),USE(?String27),TRN
                         STRING('-'),AT(6510,510,156,281),USE(?String34),TRN,FONT(,16,,FONT:bold,CHARSET:ANSI)
                         BOX,AT(3448,83,1042,1042),USE(?Box3),COLOR(COLOR:Black)
                         STRING('6000 - JUNIN- BUENOS AIRES'),AT(656,1052),USE(?String28),TRN
                         STRING('CUIT:'),AT(5760,948),USE(?String32:2),TRN
                         STRING('IVA Responsable Inscripto'),AT(740,1208),USE(?String29),TRN
                         STRING('Inicio actividades:'),AT(5760,1156),USE(?String32:3),TRN
                         LINE,AT(198,1521,7635,0),USE(?Line4),COLOR(COLOR:Black)
                         STRING(@s20),AT(2448,1125,3135,281),USE(loc:TipoComprobante),TRN,CENTER,FONT(,16,,FONT:bold,CHARSET:ANSI)
                         STRING('30-71811672-0'),AT(6104,948),USE(?String30),TRN
                         STRING('26/05/1993'),AT(6677,1156),USE(?String31),TRN
                         STRING(@s40),AT(885,1688,3583,167),USE(FAC:NombreRemitente)
                         STRING('Categoría:'),AT(4906,1688),USE(?String32:8),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@n6),AT(3625,1688),USE(FAC:ClienteFacturar),RIGHT(1)
                         STRING('Cliente:'),AT(385,1688),USE(?String32:4),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@P##-########-#Pb),AT(5552,1938),USE(FAC:CUITRemitente)
                         STRING(@s25),AT(5552,1698),USE(IVA:Descripcion),LEFT(1)
                         STRING(@s30),AT(885,1938,2990,167),USE(FAC:DireccionRemitente)
                         STRING('Domicilio:'),AT(260,1938),USE(?String32:5),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s30),AT(885,2167,2948,167),USE(FAC:LocalidadRemitente)
                         STRING('Localidad:'),AT(219,2167),USE(?String32:6),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s35),AT(885,2385,3021,167),USE(FAC:TelefonoRemitente)
                         STRING('CUIT:'),AT(5188,1938),USE(?String32:9),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Teléfono:'),AT(271,2385),USE(?String32:7),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@n08),AT(6583,510),USE(FAC:Numero),RIGHT(1),FONT(,16,,FONT:bold,CHARSET:ANSI)
                         BOX,AT(94,2646,7760,375),USE(?HeaderBox),COLOR(COLOR:Black)
                         STRING('Cantidad'),AT(844,2750,708,167),USE(?HeaderTitle:3),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Descripción'),AT(2500,2760,1229,167),USE(?HeaderTitle:4),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Importe'),AT(6438,2771,750,167),USE(?HeaderTitle:5),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                       END
Detail                 DETAIL,AT(10,10,7875,198),USE(?Detail)
                         STRING(@n10.2),AT(542,10,656,167),USE(ITFAC:Cantidad),RIGHT
                         STRING(@s40),AT(2146,10,2566,170),USE(ITFAC:Descripcion),LEFT
                         STRING(@n10.2),AT(5708,10,1167,167),USE(loc:ImporteItem),RIGHT
                       END
guias                  DETAIL,USE(?guias)
                         STRING(@s255),AT(865,208),USE(loc:DetalleGuias)
                       END
                       FOOTER,AT(219,10719,8000,177),USE(?Footer)
                       END
                       FORM,AT(229,9292,8000,1958),USE(?Form),FONT('MS Sans Serif',8,,FONT:regular)
                         STRING('TOTAL'),AT(6656,625),USE(?String25),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('Otros Impuestos Nacionales Indirectos: $'),AT(208,1292),USE(?String23:8),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         BOX,AT(63,813,7854,771),USE(?HeaderBox:3),COLOR(COLOR:Black)
                         STRING('IVA Contenido $:'),AT(208,1135,2438,167),USE(?String23:7),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('%'),AT(6958,385,125,167),USE(?String23:4),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@n_5.2),AT(6490,385),USE(loc:porcentajeiva),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         LINE,AT(94,42,7813,0),USE(?Line4:2),COLOR(COLOR:Black)
                         STRING('NETO'),AT(6719,156),USE(?String23),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING('IVA'),AT(6240,385),USE(?String24),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         BOX,AT(63,83,7854,740),USE(?HeaderBox:2),COLOR(COLOR:Black)
                         STRING(@n-11.2),AT(7135,156),USE(loc:Subtotal),RIGHT(2)
                         STRING(@n-11.2),AT(7104,625),USE(FAC:Importe),RIGHT(1)
                         STRING('Régimen de Transparencia Fiscal al Consumidor (Ley 27.743)'),AT(219,865),USE(?String23:6),TRN,FONT(,,,FONT:bold+FONT:underline,CHARSET:ANSI)
                         STRING('Alias: pabloysantiagoburgos'),AT(5073,1729),USE(?String23:5),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@n-10.2),AT(7188,385),USE(loc:iva),RIGHT(2)
                         STRING(@d6),AT(3188,1729),USE(FAC:FechaCAE)
                         STRING('Vencimiento:'),AT(2375,1729),USE(?String23:3),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                         STRING(@s20),AT(771,1729),USE(FAC:CAE)
                         STRING('CAE:'),AT(448,1729),USE(?String23:2),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
                       END
                     END
ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Init                   PROCEDURE(ProcessClass PC,<REPORT R>,<PrintPreviewClass PV>) ! Method added to host embed code
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
  GlobalErrors.SetProcedureName('ImprimeFacturaElectronica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIGUIA.SetOpenRelated()
  Relate:APLIGUIA.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  Access:CATIVA.UseFile                                    ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:ITEMFAC.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:CLIENTES.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:FACTURAS, ?Progress:PctText, Progress:Thermometer, ProgressMgr, FAC:RegFactura)
  ThisReport.AddSortOrder(FAC:Por_Registro)
  ThisReport.AddRange(FAC:RegFactura)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:FACTURAS.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
  EnterByTabManager.Init(False)
  RETURN ReturnValue


ThisWindow.Init PROCEDURE(ProcessClass PC,<REPORT R>,<PrintPreviewClass PV>)

  CODE
  IVA:CodCatIVA=FAC:CategIVARemitente
  GET(CATIVA,IVA:Por_CodIVA)
  
  
  IF (FAC:Neto * 1.21) = FAC:Importe THEN
    iva$=1.21
    loc:porcentajeiva=21
  ELSE
    iva$=1.105
    loc:porcentajeiva=10.5
  END
  
  
  IF FAC:Letra = 'A' THEN
    loc:Neto = FAC:Neto
    IF FAC:Seguro THEN loc:Seguro = FAC:Seguro.
    loc:iva=FAC:IVA
  ELSE
    loc:Neto = FAC:Neto + FAC:IVA
    IF FAC:Seguro THEN loc:Seguro = FAC:Seguro * iva$.
    loc:iva=0
  END
  loc:Subtotal = loc:Neto + loc:Seguro
  
  MESSAGE(FAC:Comprobante)
  IF FAC:Comprobante='FAC' THEN
      loc:TipoComprobante='FACTURA'
  END
  IF FAC:Comprobante='NC' THEN
      loc:TipoComprobante='CREDITO'
  END
  PARENT.Init(PC,R,PV)


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:APLIGUIA.Close
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
  CLEAR(loc:ImporteItem)
  
  IF FAC:Letra = 'A' THEN
    loc:ImporteItem = ITFAC:Importe
  ELSE
    loc:ImporteItem = ITFAC:Importe + (ITFAC:Importe * loc:porcentajeiva / 100)
  END
  
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  PRINT(RPT:guias)
  RETURN ReturnValue

