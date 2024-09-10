

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS123.INC'),ONCE        !Local module procedure declarations
                     END


SubdiarioIVAVentas PROCEDURE                               ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
loc:Contador         SHORT                                 !
loc:Hoja             SHORT                                 !
loc:Cliente          STRING(35)                            !
loc:CategIVA         BYTE                                  !
loc:CUIT             STRING(13)                            !
loc:NoGravado        DECIMAL(9,2)                          !
loc:Gravado          DECIMAL(9,2)                          !
Process:View         VIEW(FACTURAS)
                       PROJECT(FAC:Comprobante)
                       PROJECT(FAC:Empresa)
                       PROJECT(FAC:Fecha)
                       PROJECT(FAC:IVA)
                       PROJECT(FAC:Importe)
                       PROJECT(FAC:Letra)
                       PROJECT(FAC:Lugar)
                       PROJECT(FAC:Numero)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
ProgressWindow       WINDOW('Procesando...'),AT(,,142,59),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,10),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,28,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancelar'),AT(46,42,49,15),USE(?Progress:Cancel)
                     END

Report               REPORT('FACTURAS Report'),AT(313,979,11000,6875),PAPER(PAPER:A4),PRE(RPT),FONT('MS Sans Serif',8,COLOR:Black,,CHARSET:ANSI),LANDSCAPE,THOUS
                       HEADER,AT(313,250,11000,708),USE(?Header),FONT('MS Sans Serif',8,,FONT:regular)
                         STRING(@s35),AT(94,21),USE(PAR:RazonSocial),TRN
                         STRING(@P##-########-#P),AT(94,177),USE(PAR:CUIT),TRN
                         STRING(@n6.),AT(10385,333),USE(loc:Hoja),TRN
                         STRING('HOJA NRO.:'),AT(9719,333),USE(?String37),TRN
                         STRING(@d6),AT(4542,333),USE(glo:FechaDesde),TRN,RIGHT(1),FONT(,,,FONT:bold)
                         STRING(@d6),AT(6240,333),USE(glo:FechaHasta),TRN,RIGHT(1),FONT(,,,FONT:bold)
                         STRING('DESDE:'),AT(4135,333),USE(?String4),TRN
                         STRING('HASTA:'),AT(5823,333),USE(?String4:2),TRN
                         STRING('SUBDIARIO IVA VENTAS'),AT(94,333),USE(?String3),TRN
                         BOX,AT(31,490,10844,208),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Fecha'),AT(198,531),USE(?String8),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Iva 21%'),AT(8688,531),USE(?String8:9),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Total'),AT(10521,531),USE(?String8:11),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('No Gravado'),AT(6552,531),USE(?String8:7),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Gravado'),AT(7719,531),USE(?String8:8),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Número Comprob.'),AT(1135,531),USE(?String8:3),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Cat.Iva'),AT(4813,531),USE(?String8:5),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('C.U.I.T.'),AT(5323,531),USE(?String8:6),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Iva 10.5%'),AT(9521,531),USE(?String8:10),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('T.C.'),AT(729,531),USE(?String8:2),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Cliente'),AT(2375,531),USE(?String8:4),TRN,FONT('Arial',8,,FONT:bold)
                       END
detalle                DETAIL,AT(,,,188),USE(?detalle),FONT('Arial',8,,)
                         STRING(@P##-########-#Pb),AT(5323,21,823,146),USE(loc:CUIT),TRN
                         STRING(@n-15.2b),AT(8271,21,823,146),USE(FAC:IVA),TRN,RIGHT(2)
                         STRING(@n-15.2),AT(9906,21,896,146),USE(FAC:Importe),TRN,RIGHT(1)
                         STRING(@n02),AT(4917,21,177,146),USE(loc:CategIVA),TRN
                         STRING(@d5),AT(42,21,490,145),USE(FAC:Fecha),TRN,RIGHT(1)
                         STRING(@s1),AT(1135,21,156,146),USE(FAC:Letra),TRN
                         STRING(@n08),AT(1573,21,552,146),USE(FAC:Numero),TRN,RIGHT(1)
                         STRING(@s35),AT(2375,21,2313,146),USE(loc:Cliente),TRN
                         STRING(@n-15.2b),AT(6219,21,979,146),USE(loc:NoGravado),TRN,RIGHT(1)
                         STRING(@n-15.2),AT(7271,21,917,146),USE(loc:Gravado),TRN,RIGHT(1)
                         STRING(@s3),AT(729,21,240,146),USE(FAC:Comprobante),TRN
                         STRING(@n04),AT(1219,21,302,146),USE(FAC:Lugar),TRN,RIGHT(1)
                       END
totales                DETAIL,AT(,,,240),USE(?totales),FONT('Arial',8,,FONT:regular,CHARSET:ANSI)
                         LINE,AT(31,31,10844,0),USE(?Line1),COLOR(COLOR:Black)
                         STRING(@n-15.2),AT(8344,63,1010,177),SUM,USE(FAC:IVA,,?FAC:IVA:2),TRN,RIGHT(2),FONT(,,,FONT:bold),TALLY(detalle)
                         STRING(@n-15.2),AT(9927,63),SUM,USE(FAC:Importe,,?FAC:Importe:2),TRN,RIGHT(1),FONT(,,,FONT:bold),TALLY(detalle)
                         STRING('TOTALES'),AT(5594,63),USE(?String35),TRN,FONT(,,,FONT:bold)
                         STRING(@n-15.2),AT(6333,63,969,177),SUM,USE(loc:NoGravado,,?loc:NoGravado:2),TRN,RIGHT(1),FONT(,,,FONT:bold),TALLY(detalle)
                         STRING(@n-15.2),AT(7354,63,938,177),SUM,USE(loc:Gravado,,?loc:Gravado:2),TRN,RIGHT(1),FONT(,,,FONT:bold),TALLY(detalle)
                       END
                     END
ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(ReportManager)
AskPreview             PROCEDURE(),DERIVED                 ! Method added to host embed code
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

ThisWindow.AskPreview PROCEDURE

  CODE
  PRINT(RPT:totales)
  PARENT.AskPreview


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SubdiarioIVAVentas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:Empresa',glo:Empresa)                          ! Added by: Report
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  PAR:Registro = glo:Empresa
  GET(PARAMETRO,PAR:Por_Registro)
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:FACTURAS, ?Progress:PctText, Progress:Thermometer, ProgressMgr, FAC:Fecha)
  ThisReport.AddSortOrder(FAC:Por_FechaA)
  ThisReport.AddRange(FAC:Fecha,glo:FechaDesde,glo:FechaHasta)
  ThisReport.AppendOrder('+FAC:Letra,+FAC:Lugar,+FAC:Numero')
  ThisReport.SetFilter('FAC:Empresa = glo:Empresa AND FAC:Comprobante <<> ''REC''')
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:FACTURAS.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  SELF.Zoom = 100
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
    CASE EVENT()
    OF EVENT:OpenWindow
      loc:Hoja = glo:HojaInicial
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
  IF FAC:FacturarA = 'R' THEN
    loc:Cliente = FAC:NombreRemitente
    loc:CategIVA = FAC:CategIVARemitente
    loc:CUIT = FAC:CUITRemitente
  ELSE
    loc:Cliente = FAC:NombreDestino
    loc:CategIVA = FAC:CategIVADestino
    loc:CUIT = FAC:CUITDestino
  END
  
  IF FAC:Comprobante='NC' THEN
      FAC:Neto=FAC:Neto * -1
      FAC:Seguro=FAC:Seguro * -1
      FAC:IVA=FAC:IVA * -1
      FAC:Importe=FAC:Importe * -1
  END
  
  loc:Gravado = FAC:Neto + FAC:Seguro
  
  loc:Contador += 1
  IF loc:Contador = 36 THEN
    loc:Hoja += 1
    loc:Contador = 0
  END
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detalle)
  RETURN ReturnValue

