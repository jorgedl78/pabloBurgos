

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS058.INC'),ONCE        !Local module procedure declarations
                     END


GuiasPendientesFacturar PROCEDURE                          ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:RemitenteDestinatario STRING(40)                       !
loc:Total            DECIMAL(9,2)                          !
Process:View         VIEW(GUIAS)
                       PROJECT(GUIA:ClienteFacturar)
                       PROJECT(GUIA:Fecha)
                       PROJECT(GUIA:Flete)
                       PROJECT(GUIA:Importe)
                       PROJECT(GUIA:Letra)
                       PROJECT(GUIA:Lugar)
                       PROJECT(GUIA:Numero)
                       JOIN(CLI:Por_Codigo,GUIA:ClienteFacturar)
                         PROJECT(CLI:CodCliente)
                         PROJECT(CLI:Direccion)
                         PROJECT(CLI:Localidad)
                         PROJECT(CLI:Nombre)
                       END
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

report               REPORT,AT(792,1458,6927,9531),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',9,,FONT:regular),THOUS
                       HEADER,AT(792,417,6927,1000)
                         STRING('GUIAS SIN FACTURAR'),AT(2833,10),USE(?String18),TRN,FONT(,,,FONT:bold)
                         STRING(@P[<<<<<<]P),AT(146,281,531,146),USE(CLI:CodCliente),TRN,LEFT(1),FONT(,,,FONT:bold)
                         STRING(@s40),AT(719,281,3000,146),USE(CLI:Nombre),TRN,FONT(,,,FONT:bold)
                         STRING(@s30),AT(146,427,2260,146),USE(CLI:Direccion),TRN
                         STRING(@d6),AT(4740,583),USE(glo:FechaDesde),TRN,RIGHT(1)
                         STRING(@d6),AT(5948,583),USE(glo:FechaHasta),TRN,RIGHT(1)
                         STRING('DESDE:'),AT(4260,583),USE(?String14),TRN
                         STRING('HASTA:'),AT(5521,583),USE(?String14:2),TRN
                         STRING(@s30),AT(146,583,2208,146),USE(CLI:Localidad),TRN
                         BOX,AT(63,771,6719,208),USE(?Box1),COLOR(COLOR:Black)
                         STRING('Remito-Guía'),AT(1010,802),USE(?String6:2),TRN,FONT(,,,FONT:bold)
                         STRING('Fecha'),AT(438,802),USE(?String6),TRN,FONT(,,,FONT:bold)
                         STRING('Remitente/Destinatario'),AT(2417,802),USE(?String6:3),TRN,FONT(,,,FONT:bold)
                         STRING('Flete'),AT(5438,802),USE(?String6:5),TRN,FONT(,,,FONT:bold)
                         STRING('Importe'),AT(6188,802),USE(?String6:4),TRN,FONT(,,,FONT:bold)
                       END
break1                 BREAK(GUIA:ClienteFacturar)
detalle                  DETAIL,AT(,,,198),USE(?detalle)
                           STRING(@d6),AT(94,21,698,146),USE(GUIA:Fecha),TRN,RIGHT(1)
                           STRING(@s1),AT(1010,21,156,146),USE(GUIA:Letra),TRN,CENTER
                           STRING(@n08),AT(1563,21,635,146),USE(GUIA:Numero),TRN,RIGHT(1)
                           STRING(@s40),AT(2417,21,2990,188),USE(loc:RemitenteDestinatario),TRN
                           STRING(@s1),AT(5479,21,188,188),USE(GUIA:Flete),TRN,CENTER
                           STRING(@n04),AT(1188,21,344,146),USE(GUIA:Lugar),TRN,RIGHT(1)
                           STRING(@n12.2),AT(5844,21,802,146),USE(GUIA:Importe),TRN,RIGHT(1)
                         END
                         FOOTER,AT(,,,229)
                           LINE,AT(5729,21,1042,0),USE(?Line1),COLOR(COLOR:Black)
                           STRING(@n12.2),AT(5833,52),USE(loc:Total),TRN,RIGHT(1),FONT(,,,FONT:bold)
                           STRING('TOTAL'),AT(5302,52),USE(?String20),TRN,FONT(,,,FONT:bold)
                         END
                       END
                     END
ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Reset                  PROCEDURE(BYTE Force=0),DERIVED     ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Update                 PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
? DEBUGHOOK(GUIAS:Record)
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
  GlobalErrors.SetProcedureName('GuiasPendientesFacturar')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:FechaDesde',glo:FechaDesde)                    ! Added by: Report
  BIND('glo:FechaHasta',glo:FechaHasta)                    ! Added by: Report
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:GUIAS.SetOpenRelated()
  Relate:GUIAS.Open                                        ! File GUIAS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:GUIAS, ?Progress:PctText, Progress:Thermometer, ProgressMgr, GUIA:Fecha)
  ThisReport.AddSortOrder(GUIA:Por_Cliente_FechaA)
  ThisReport.AddRange(GUIA:ClienteFacturar,glo:Cliente)
  ThisReport.SetFilter('GUIA:Fecha >= glo:FechaDesde AND GUIA:Fecha <<= glo:FechaHasta AND NOT GUIA:Facturada AND GUIA:Impresa <<> ''A''')
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
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF ProgressWindow{Prop:AcceptAll} THEN RETURN.
  CLI:CodCliente = GUIA:ClienteFacturar                    ! Assign linking field value
  Access:CLIENTES.Fetch(CLI:Por_Codigo)
  PARENT.Reset(Force)


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


ThisWindow.Update PROCEDURE

  CODE
  PARENT.Update
  CLI:CodCliente = GUIA:ClienteFacturar                    ! Assign linking field value
  Access:CLIENTES.Fetch(CLI:Por_Codigo)


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  IF GUIA:FacturarA = 'R' THEN
    loc:RemitenteDestinatario = '[D]   ' & CLIP(GUIA:NombreDestino)
  ELSE
    loc:RemitenteDestinatario = '[R]   ' & CLIP(GUIA:NombreRemitente)
  END
  
  loc:Total += GUIA:Importe
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detalle)
  RETURN ReturnValue

