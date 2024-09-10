

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS067.INC'),ONCE        !Local module procedure declarations
                     END


FacturasImpagasCliente PROCEDURE                           ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:R_D              STRING(40)                            !
loc:Saldo            DECIMAL(9,2)                          !
loc:Total            DECIMAL(9,2)                          !
Process:View         VIEW(PARAMETRO)
                     END
ReportPageNumber     LONG,AUTO
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
ProgressWindow       WINDOW('Procesando...'),AT(,,142,59),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,9),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,27,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancelar'),AT(46,41,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(521,1198,7396,9906),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',9,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(521,385,7396,771)
                         STRING('FACTURAS IMPAGAS AL:'),AT(73,94),USE(?String19),TRN
                         STRING(@d6b),AT(1552,94),USE(glo:FechaHasta),TRN,RIGHT(1)
                         STRING('CLIENTE:'),AT(73,292),USE(?String17),TRN
                         STRING('PAGINA:'),AT(6292,292),USE(?String16),TRN
                         STRING(@N3),AT(6844,292),USE(ReportPageNumber),TRN
                         STRING(@s40),AT(698,292,3031,146),USE(CLI:Nombre),FONT(,,,FONT:bold)
                         BOX,AT(52,521,7292,208),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Imp. Pagado'),AT(5531,552),USE(?String7:6),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Saldo'),AT(6938,552),USE(?String7:7),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('R/D'),AT(792,552),USE(?String7:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Nombre'),AT(1042,552),USE(?String7:5),TRN,FONT(,,,FONT:bold)
                         STRING('Fecha'),AT(323,552),USE(?String7),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Imp. Original'),AT(4583,552),USE(?String7:4),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Comprobante'),AT(3531,552),USE(?String7:3),TRN,FONT(,,COLOR:Black,FONT:bold)
                       END
detalle                DETAIL,AT(21,,7365,156),USE(?detalle),FONT('Arial',8,COLOR:Black,FONT:regular)
                         STRING(@d6),AT(52,0,604,146),USE(FAC:Fecha),TRN,RIGHT(1)
                         STRING(@s1),AT(3490,0,156,146),USE(FAC:Letra),TRN,CENTER
                         STRING(@n04),AT(3583,0,344,146),USE(FAC:Lugar),TRN,RIGHT(1)
                         STRING(@n08),AT(3948,0,542,146),USE(FAC:Numero),TRN,RIGHT(1)
                         STRING(@n-11.2),AT(4563,0,740,146),USE(FAC:Importe),TRN,RIGHT(2)
                         STRING(@n-13.2),AT(5490,0,750,146),USE(FAC:Aplicado),TRN,RIGHT(2)
                         STRING(@n-13.2),AT(6500,0,750,146),USE(loc:Saldo),TRN,RIGHT(2)
                         STRING(@s1),AT(813,0),USE(FAC:FacturarA),TRN,CENTER
                         STRING(@s40),AT(1021,0,2448,177),USE(loc:R_D)
                       END
total                  DETAIL,AT(,,,260),USE(?total)
                         STRING('TOTAL ......'),AT(5906,73),USE(?String18),TRN
                         STRING(@n-13.2),AT(6417,83),USE(loc:Total),TRN,RIGHT(2),FONT(,,COLOR:Black,FONT:bold)
                       END
                     END
ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(FACTURAS:Record)
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
  GlobalErrors.SetProcedureName('FacturasImpagasCliente')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ThisReport.Init(Process:View, Relate:PARAMETRO, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  ThisReport.SetFilter('PAR:Registro = 1')
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:PARAMETRO.SetQuickScan(1,Propagate:OneMany)
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
    Relate:PARAMETRO.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    report$?ReportPageNumber{PROP:PageNo}=True
  END
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
  CLEAR(loc:Total)
  
  CLI:CodCliente = glo:Cliente
  GET(CLIENTES,CLI:Por_Codigo)
  
  FAC:ClienteFacturar = glo:Cliente
  CLEAR(FAC:Fecha)
  SET(FAC:Por_Cliente,FAC:Por_Cliente)
  LOOP UNTIL EOF(FACTURAS)
    NEXT(FACTURAS)
    IF FAC:ClienteFacturar <> glo:Cliente THEN BREAK.
    IF FAC:Fecha > glo:FechaHasta THEN BREAK.
    IF FAC:Comprobante <> 'FAC' THEN CYCLE.
    IF (FAC:Importe + FAC:Aplicado) = 0 THEN CYCLE.
  
    CASE FAC:FacturarA
    OF 'R'
      loc:R_D = FAC:NombreDestino
    OF 'D'
      loc:R_D = FAC:NombreRemitente
    ELSE
      loc:R_D = ''
    END
    loc:Saldo = FAC:Importe + FAC:Aplicado
  
    PRINT(RPT:detalle)
    loc:Total += loc:Saldo
  END
  IF loc:Total <> 0 THEN PRINT(RPT:total).
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

