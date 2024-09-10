

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS072.INC'),ONCE        !Local module procedure declarations
                     END


MovimientosCliente PROCEDURE                               ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:RemitenteDestinatario STRING(40)                       !
loc:Total            DECIMAL(9,2)                          !
Process:View         VIEW(CLIENTES)
                       PROJECT(CLI:CodCliente)
                       PROJECT(CLI:Direccion)
                       PROJECT(CLI:Localidad)
                       PROJECT(CLI:Nombre)
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

report               REPORT,AT(521,1458,7417,9531),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',9,,FONT:regular),THOUS
                       HEADER,AT(521,427,7417,1000)
                         STRING('MOVIMIENTO GENERAL'),AT(3031,10),USE(?String18),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@P[<<<<<<]P),AT(146,281,531,146),USE(CLI:CodCliente),TRN,LEFT(1),FONT(,,COLOR:Black,FONT:bold)
                         STRING(@s40),AT(719,281,3000,146),USE(CLI:Nombre),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@s30),AT(146,427,2260,146),USE(CLI:Direccion),TRN
                         STRING(@d6),AT(5177,583),USE(glo:FechaDesde),TRN,RIGHT(1)
                         STRING(@d6),AT(6385,583),USE(glo:FechaHasta),TRN,RIGHT(1)
                         STRING('DESDE:'),AT(4698,583),USE(?String14),TRN
                         STRING('HASTA:'),AT(5958,583),USE(?String14:2),TRN
                         STRING(@s30),AT(146,583,2208,146),USE(CLI:Localidad),TRN
                         BOX,AT(63,771,7271,208),USE(?Box1),COLOR(COLOR:Black)
                         STRING('Remito-Guía'),AT(844,802),USE(?String6:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Fecha'),AT(375,802),USE(?String6),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Remitente/Destinatario'),AT(1979,802),USE(?String6:3),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('R.C.'),AT(4510,802),USE(?String6:7),TRN,FONT(,,,FONT:bold)
                         STRING('Flete'),AT(4844,802),USE(?String6:5),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Importe'),AT(5260,802),USE(?String6:6),TRN,FONT(,,,FONT:bold)
                         STRING('Observación'),AT(5833,802),USE(?String6:4),TRN,FONT(,,COLOR:Black,FONT:bold)
                       END
detalle                DETAIL,AT(,,,188),USE(?detalle)
                         STRING(@d6),AT(31,21,698,146),USE(GUIA:Fecha),TRN,RIGHT(1)
                         STRING(@s1),AT(823,21,156,146),USE(GUIA:Letra),TRN,CENTER
                         STRING(@s10),AT(4188,21,646,188),USE(GUIA:RemitoCliente),TRN,RIGHT(1)
                         STRING(@n08),AT(1250,21,635,146),USE(GUIA:Numero),TRN,RIGHT(1)
                         STRING(@s40),AT(1979,21,2170,188),USE(loc:RemitenteDestinatario),TRN
                         STRING(@s1),AT(4885,21,188,188),USE(GUIA:Flete),TRN,CENTER
                         STRING(@n12.2),AT(5042,21,675,188),USE(GUIA:Importe),TRN,RIGHT(1)
                         TEXT,AT(5833,21,1510,615),USE(GUIA:Observacion),BOXED,TRN,FONT('Arial',7,,FONT:regular+FONT:italic)
                         STRING(@n04),AT(927,21,344,146),USE(GUIA:Lugar),TRN,RIGHT(1)
                       END
items                  DETAIL,AT(,,,146),USE(?items),FONT('Arial',8,,FONT:regular)
                         STRING(@n7),AT(2073,21,458,125),USE(ITGUIA:Cantidad),TRN,RIGHT(1),FONT('Arial',7,,FONT:regular+FONT:italic)
                         STRING(@s40),AT(2646,21,2146,125),USE(ITGUIA:Descripcion),TRN,FONT('Arial',7,,FONT:regular+FONT:italic)
                       END
linea                  DETAIL,AT(,,,83),USE(?linea)
                         LINE,AT(63,21,7269,0),USE(?Line1),COLOR(COLOR:Black)
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
  GlobalErrors.SetProcedureName('MovimientosCliente')
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
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:ITEMGUIA.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:CLIENTES, ?Progress:PctText, Progress:Thermometer, ProgressMgr, CLI:CodCliente)
  ThisReport.AddSortOrder(CLI:Por_Codigo)
  ThisReport.AddRange(CLI:CodCliente,glo:Cliente)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:CLIENTES.SetQuickScan(1,Propagate:OneMany)
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
  
  
  
  CLEAR(GUIA:ClienteFacturar)
  CLEAR(GUIA:Fecha)
  SET(GUIA:Por_Cliente_FechaA,GUIA:Por_Cliente_FechaA)
  LOOP UNTIL EOF(GUIAS)
    NEXT(GUIAS)
    IF GUIA:Impresa = 'A' THEN CYCLE.
    IF GUIA:Remitente <> glo:Cliente AND GUIA:Destinatario <> glo:Cliente THEN CYCLE.
    IF GUIA:Fecha > glo:FechaHasta THEN CYCLE.
    IF GUIA:Fecha < glo:FechaDesde THEN CYCLE.
  
    IF GUIA:Remitente = CLI:CodCliente THEN
      loc:RemitenteDestinatario = '[D]  ' & CLIP(GUIA:NombreDestino)
    ELSE
      loc:RemitenteDestinatario = '[R]  ' & CLIP(GUIA:NombreRemitente)
    END
  
    IF CLI:PosicionIVA<>1 THEN
      GUIA:Importe=GUIA:Importe * 1.21
    END!IF
  
    PRINT(RPT:detalle)
  
    ITGUIA:RegGuia = GUIA:RegGuia
    CLEAR(ITGUIA:Item)
    SET(ITGUIA:Por_Guia,ITGUIA:Por_Guia)
    LOOP UNTIL EOF(ITEMGUIA)
      NEXT(ITEMGUIA)
      IF ITGUIA:RegGuia <> GUIA:RegGuia THEN BREAK.
      PRINT(RPT:items)
    END
  
    PRINT(RPT:linea)
  END
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

