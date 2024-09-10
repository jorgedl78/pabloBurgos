

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS134.INC'),ONCE        !Local module procedure declarations
                     END


ImprimeFacturaElectronica1 PROCEDURE                       ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:espacios         BYTE                                  !
loc:DetalleGuias     STRING(255)                           !
loc:ImporteItem      DECIMAL(7,2)                          !
loc:Neto             DECIMAL(8,2)                          !
loc:Seguro           DECIMAL(7,2)                          !
loc:Subtotal         DECIMAL(8,2)                          !
Process:View         VIEW(FACTURAS)
                       PROJECT(FAC:CUITDestino)
                       PROJECT(FAC:CUITRemitente)
                       PROJECT(FAC:DireccionDestino)
                       PROJECT(FAC:DireccionRemitente)
                       PROJECT(FAC:Fecha)
                       PROJECT(FAC:IVA)
                       PROJECT(FAC:Importe)
                       PROJECT(FAC:LocalidadDestino)
                       PROJECT(FAC:LocalidadRemitente)
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

report               REPORT,AT(354,198,7781,13135),PAPER(PAPER:LEGAL),PRE(RPT),FONT('Arial',8,,FONT:regular),THOUS
encabezado             DETAIL,AT(,,,3625),USE(?encabezado)
                         STRING('PABLO A.BURGOS'),AT(615,229),USE(?String34),TRN
                         STRING('Comisiones'),AT(563,469),USE(?String35),TRN
                         STRING(@n08),AT(6250,479),USE(FAC:Numero),TRN,RIGHT(1),FONT('Courier New',10,COLOR:Black,FONT:bold)
                         STRING('M. Moreno 861'),AT(656,708),USE(?String36),TRN
                         STRING('6000 - JUNIN - BUENOS AIRES'),AT(635,990),USE(?String36:2),TRN
                         STRING('IVA Responable Inscripto'),AT(594,1198),USE(?String36:3),TRN
                         STRING(@d6),AT(6813,1896),USE(FAC:Fecha),TRN,RIGHT(1)
                         STRING(@s30),AT(302,1990,1563,177),USE(FAC:LocalidadRemitente,,?FAC:LocalidadRemitente:2),TRN
                         STRING(@s30),AT(1969,1990,1542,177),USE(FAC:LocalidadDestino,,?FAC:LocalidadDestino:2),TRN
                         STRING(@s40),AT(917,2438,2542,177),USE(FAC:NombreRemitente),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@s40),AT(4833,2438,2573,167),USE(FAC:NombreDestino),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@P##-########-#Pb),AT(917,2688),USE(FAC:CUITRemitente),TRN
                         STRING(@P##-########-#Pb),AT(4833,2688,865,167),USE(FAC:CUITDestino),TRN
                         STRING(@s30),AT(917,2927),USE(FAC:DireccionRemitente),TRN
                         STRING(@s30),AT(4833,2927),USE(FAC:DireccionDestino),TRN
                         STRING(@s30),AT(917,3156,1698,177),USE(FAC:LocalidadRemitente),TRN
                         STRING(@s30),AT(4833,3156,1625,177),USE(FAC:LocalidadDestino),TRN
                         STRING(@s35),AT(2938,3156,1302,167),USE(FAC:TelefonoRemitente),TRN
                         STRING(@s35),AT(6729,3156,990,167),USE(FAC:TelefonoDestino),TRN
                       END
detalle                DETAIL,AT(,,7750,208),USE(?detalle)
                         STRING(@n7),AT(156,42),USE(ITFAC:Cantidad),TRN,RIGHT(1)
                         STRING(@s40),AT(896,42,2573,167),USE(ITFAC:Descripcion),TRN
                         STRING(@n10.2),AT(4156,42),USE(loc:ImporteItem),TRN,RIGHT(2)
                       END
espacio                DETAIL,AT(,,,208),USE(?espacio)
                       END
pie                    DETAIL,AT(,,,1990),USE(?pie)
                         STRING('X'),AT(5781,-604,292,198),USE(?FleteOrigen),TRN,HIDE,CENTER,FONT('Arial',12,COLOR:Black,FONT:regular)
                         TEXT,AT(156,344,2385,854),USE(FAC:Observacion),BOXED,TRN
                         STRING(@n-11.2),AT(6771,240),USE(loc:Subtotal),TRN,RIGHT(1)
                         TEXT,AT(156,-563,4500,719),USE(loc:DetalleGuias),BOXED,TRN,HIDE
                         STRING(@n-11.2),AT(6771,-542),USE(loc:Neto),TRN,RIGHT(2)
                         STRING(@n10.2),AT(5208,479),USE(FAC:ValorDeclarado),TRN,RIGHT(1)
                         STRING(@n-10.2b),AT(6833,771),USE(FAC:IVA),TRN,RIGHT(2)
                         STRING(@n10.2b),AT(6813,-52),USE(loc:Seguro),TRN,RIGHT(1)
                         STRING('X'),AT(5781,-188,292,198),USE(?FleteDestino),TRN,HIDE,CENTER,FONT('Arial',12,COLOR:Black,FONT:regular)
                         STRING(@n-11.2),AT(6771,1052),USE(FAC:Importe),RIGHT(1)
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

  CODE
? DEBUGHOOK(APLIGUIA:Record)
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
  GlobalErrors.SetProcedureName('ImprimeFacturaElectronica1')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIGUIA.SetOpenRelated()
  Relate:APLIGUIA.Open                                     ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Access:CLIENTES.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:ITEMFAC.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:FACTURAS, ?Progress:PctText, Progress:Thermometer, ProgressMgr, FAC:RegFactura)
  ThisReport.AddSortOrder(FAC:Por_Registro)
  ThisReport.AddRange(FAC:RegFactura)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report)
  ?Progress:UserString{Prop:Text}=''
  Relate:FACTURAS.SetQuickScan(1,Propagate:OneMany)
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
  
  LOOP 2 TIMES
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
        loc:ImporteItem = ITFAC:Importe * iva$
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
  
  
    CLEAR(loc:Seguro)
    IF FAC:Letra = 'A' THEN
      loc:Neto = FAC:Neto
      IF FAC:Seguro THEN loc:Seguro = FAC:Seguro.
    ELSE
      loc:Neto = FAC:Neto * iva$
      IF FAC:Seguro THEN loc:Seguro = FAC:Seguro * iva$.
    END
    loc:Subtotal = loc:Neto + loc:Seguro
    PRINT(RPT:pie)
  END
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

