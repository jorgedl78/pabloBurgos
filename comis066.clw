

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS066.INC'),ONCE        !Local module procedure declarations
                     END


FacturasImpagas PROCEDURE                                  ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:Nombre           STRING(40)                            !
loc:Saldo            DECIMAL(9,2)                          !
loc:Total            DECIMAL(9,2)                          !
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

report               REPORT,AT(542,1198,7375,9906),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',9,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(542,385,7375,771)
                         STRING('FACTURAS IMPAGAS AL:'),AT(52,94),USE(?String19),TRN
                         STRING(@s35),AT(52,292,2563,188),USE(PAR:RazonSocial),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@d6b),AT(1531,94),USE(glo:FechaHasta),TRN,RIGHT(1)
                         STRING('PAGINA:'),AT(6125,292),USE(?String16),TRN
                         STRING(@N3),AT(6677,292),USE(ReportPageNumber),TRN
                         BOX,AT(42,521,7302,208),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Imp. Pagado'),AT(5313,552),USE(?String7:5),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Nombre'),AT(771,552),USE(?String7:2),TRN,FONT(,,,FONT:bold)
                         STRING('Fecha'),AT(313,552),USE(?String7),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Imp. Original'),AT(4354,552),USE(?String7:4),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Saldo'),AT(6875,552),USE(?String7:6),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Comprobante'),AT(3219,552),USE(?String7:3),TRN,FONT(,,COLOR:Black,FONT:bold)
                       END
detalle                DETAIL,AT(21,,7354,156),USE(?detalle),FONT('Arial',8,COLOR:Black,FONT:regular)
                         STRING(@d6),AT(31,0,615,146),USE(FAC:Fecha),TRN,RIGHT(1)
                         STRING(@s40),AT(750,0,2396,177),USE(loc:Nombre)
                         STRING(@s1),AT(3177,0,156,146),USE(FAC:Letra),TRN,CENTER
                         STRING(@n04),AT(3292,0,344,146),USE(FAC:Lugar),TRN,RIGHT(1)
                         STRING(@n08),AT(3677,0,542,146),USE(FAC:Numero),TRN,RIGHT(1)
                         STRING(@n-11.2),AT(4333,0,740,146),USE(FAC:Importe),TRN,RIGHT(2)
                         STRING(@n-13.2),AT(5271,0,750,146),USE(FAC:Aplicado),TRN,RIGHT(2)
                         STRING(@n-13.2),AT(6438,0,750,146),USE(loc:Saldo),TRN,RIGHT(1),FONT(,,COLOR:Black,)
                       END
total                  DETAIL,AT(,,,250),USE(?total)
                         LINE,AT(6302,31,1042,0),USE(?Line1),COLOR(COLOR:Black)
                         STRING(@n-13.2),AT(6354,73),USE(loc:Total),TRN,RIGHT(2),FONT(,,,FONT:bold)
                         STRING('TOTAL'),AT(5885,73),USE(?String18),TRN,FONT(,,,FONT:bold)
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
  GlobalErrors.SetProcedureName('FacturasImpagas')
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
  PAR:Registro = glo:Empresa
  GET(PARAMETRO,PAR:Por_Registro)
  
  CLEAR(loc:Total)
  CLEAR(FACTURAS)
  SET(FAC:Por_FechaA,FAC:Por_FechaA)
  LOOP UNTIL EOF(FACTURAS)
    NEXT(FACTURAS)
    IF FAC:Fecha > glo:FechaHasta THEN BREAK.
    IF FAC:Empresa <> glo:Empresa THEN CYCLE.
    IF FAC:Comprobante <> 'FAC' THEN CYCLE.
    IF (FAC:Importe + FAC:Aplicado) = 0 THEN CYCLE.
  
    CASE FAC:FacturarA
    OF 'R'
      loc:Nombre = '[R]  ' & FAC:NombreRemitente
    OF 'D'
      loc:Nombre = '[D]  ' & FAC:NombreDestino
    ELSE
      loc:Nombre = ''
    END
    loc:Saldo = FAC:Importe + FAC:Aplicado
  
    PRINT(RPT:detalle)
  
    loc:Total += loc:Saldo
  END
  IF loc:Total <> 0 THEN PRINT(RPT:total).
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

