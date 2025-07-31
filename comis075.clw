

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS075.INC'),ONCE        !Local module procedure declarations
                     END


GuiasSinFacturar PROCEDURE                                 ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:Nombre           STRING(40)                            !
loc:Total            DECIMAL(14,2)                         !
Process:View         VIEW(PARAMETRO)
                       PROJECT(PAR:RazonSocial)
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

report               REPORT,AT(792,1458,6927,9531),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',9,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(792,417,6927,1000)
                         STRING('GUIAS SIN FACTURAR AL:'),AT(83,375),USE(?String18),TRN,FONT(,,COLOR:Black,)
                         STRING(@d6),AT(1615,375),USE(glo:FechaHasta),TRN,RIGHT(1)
                         STRING('PAGINA:'),AT(5979,563),USE(?String17),TRN
                         STRING(@N3),AT(6510,563),USE(ReportPageNumber),TRN
                         STRING(@s35),AT(83,563,2615,188),USE(PAR:RazonSocial),TRN,FONT(,,,FONT:bold)
                         BOX,AT(63,771,6719,208),USE(?Box1),COLOR(COLOR:Black)
                         STRING('Comprobante'),AT(4229,802),USE(?String6:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Fecha'),AT(438,802),USE(?String6),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Facturar a'),AT(1094,802),USE(?String6:3),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Importe'),AT(6167,802),USE(?String6:4),TRN,FONT(,,COLOR:Black,FONT:bold)
                       END
detalle                DETAIL,AT(,,,156),USE(?detalle),FONT('Arial',8,,FONT:regular)
                         STRING(@d6),AT(94,10,698,135),USE(GUIA:Fecha),TRN,RIGHT(1)
                         STRING(@s1),AT(4229,10,156,135),USE(GUIA:Letra),TRN,CENTER
                         STRING(@n08),AT(4740,10,531,135),USE(GUIA:Numero),TRN,RIGHT(1)
                         STRING(@s40),AT(1083,10,2573,135),USE(loc:Nombre),TRN
                         STRING(@n04),AT(4406,10,281,135),USE(GUIA:Lugar),TRN,RIGHT(1)
                         STRING(@n12.2),AT(5823,10,802,135),USE(GUIA:Importe),TRN,RIGHT(1)
                       END
total                  DETAIL,AT(,,,281),USE(?total)
                         LINE,AT(5708,52,1042,0),USE(?Line1),COLOR(COLOR:Black)
                         STRING('TOTAL'),AT(4844,104),USE(?String20),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@n17.2),AT(5510,104),USE(loc:Total),TRN,RIGHT(1),FONT(,,COLOR:Black,FONT:bold)
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

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('GuiasSinFacturar')
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
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
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
  PAR:Registro = glo:Empresa
  GET(PARAMETRO,PAR:Por_Registro)
  
  CLEAR(loc:Total)
  CLEAR(GUIAS)
  SET(GUIA:Por_Registro,GUIA:Por_Registro)
  LOOP UNTIL EOF(GUIAS)
    NEXT(GUIAS)
    IF GUIA:Impresa = 'A' THEN CYCLE.
    IF GUIA:Empresa <> glo:Empresa THEN CYCLE.
    IF GUIA:Fecha > glo:FechaHasta THEN CYCLE.
    IF GUIA:Facturada THEN CYCLE.
  
    CASE GUIA:FacturarA
    OF 'R'
      loc:Nombre = '[R]  ' & GUIA:NombreRemitente
    OF 'D'
      loc:Nombre = '[D]  ' & GUIA:NombreDestino
    ELSE
      loc:Nombre = ''
    END
  
    PRINT(RPT:detalle)
  
    loc:Total += GUIA:Importe
  END
  IF loc:Total <> 0 THEN PRINT(RPT:total).
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

