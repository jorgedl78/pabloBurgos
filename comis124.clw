

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS124.INC'),ONCE        !Local module procedure declarations
                     END


SubdiarioIVACompras PROCEDURE                              ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
loc:Contador         SHORT                                 !
loc:Hoja             SHORT                                 !
loc:Cliente          STRING(35)                            !
loc:CategIVA         BYTE                                  !
loc:CUIT             STRING(13)                            !
loc:NoGravado        DECIMAL(9,2)                          !
loc:Gravado          DECIMAL(9,2)                          !
Process:View         VIEW(FACPROV)
                       PROJECT(FCP:Exento)
                       PROJECT(FCP:FechaPresentacion)
                       PROJECT(FCP:Importe)
                       PROJECT(FCP:ImpuestosInternos)
                       PROJECT(FCP:Iva10)
                       PROJECT(FCP:Iva21)
                       PROJECT(FCP:Iva27)
                       PROJECT(FCP:Letra)
                       PROJECT(FCP:Lugar)
                       PROJECT(FCP:NetoGravado)
                       PROJECT(FCP:NoGravado)
                       PROJECT(FCP:Numero)
                       PROJECT(FCP:PercepIB)
                       PROJECT(FCP:PercepIVA)
                       PROJECT(FCP:PercepOtros)
                       PROJECT(FCP:Comprobante)
                       PROJECT(FCP:CodProveedor)
                       JOIN(CPTE:Por_Codigo,FCP:Comprobante)
                         PROJECT(CPTE:Abreviatura)
                       END
                       JOIN(PROV:Por_CodProveedor,FCP:CodProveedor)
                         PROJECT(PROV:CUIT)
                         PROJECT(PROV:Nombre)
                         PROJECT(PROV:PosicionIVA)
                       END
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
                         STRING(@n6.),AT(10385,333,438,156),USE(loc:Hoja),TRN
                         STRING('HOJA NRO.:'),AT(9719,333),USE(?String47),TRN
                         STRING(@d6),AT(4542,333),USE(glo:FechaDesde),TRN,RIGHT(1),FONT(,,,FONT:bold)
                         STRING(@d6),AT(6240,333),USE(glo:FechaHasta),TRN,RIGHT(1),FONT(,,,FONT:bold)
                         STRING('DESDE:'),AT(4135,333),USE(?String4),TRN
                         STRING('HASTA:'),AT(5823,333),USE(?String4:2),TRN
                         STRING('SUBDIARIO IVA COMPRAS'),AT(94,333),USE(?String3),TRN
                         BOX,AT(31,490,10844,208),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Iva 27%'),AT(8365,531),USE(?String8:12),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Imp.Int.'),AT(9052,531),USE(?String8:13),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Percep.Iva'),AT(9594,531),USE(?String8:14),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Fecha'),AT(198,531),USE(?String8),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Iva 21%'),AT(6938,531),USE(?String8:9),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Total'),AT(10521,531),USE(?String8:11),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('No Gravado'),AT(5333,531),USE(?String8:7),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Gravado'),AT(6229,531),USE(?String8:8),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Nro Comprob.'),AT(948,531),USE(?String8:3),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Cat.Iva'),AT(3990,531),USE(?String8:5),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('C.U.I.T.'),AT(4469,531),USE(?String8:6),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Iva 10.5%'),AT(7573,531),USE(?String8:10),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('T.C.'),AT(656,531),USE(?String8:2),TRN,FONT('Arial',8,,FONT:bold)
                         STRING('Proveedor'),AT(1969,531),USE(?String8:4),TRN,FONT('Arial',8,,FONT:bold)
                       END
detalle                DETAIL,AT(,,,188),USE(?detalle),FONT('Arial',8,,)
                         STRING(@P##-########-#Pb),AT(4469,21,823,146),USE(PROV:CUIT),TRN
                         STRING(@n-10.2b),AT(6750,21,594,146),USE(FCP:Iva21),TRN,RIGHT(2)
                         STRING(@n-10.2b),AT(9594,21,594,146),USE(FCP:PercepIVA),TRN,RIGHT(2)
                         STRING(@n-11.2),AT(10146,21,656,146),USE(FCP:Importe),TRN,RIGHT(2)
                         STRING(@n-10.2b),AT(8885,21,594,146),USE(FCP:ImpuestosInternos),TRN,RIGHT(2)
                         STRING(@n-10.2b),AT(8177,21,594,146),USE(FCP:Iva27),TRN,RIGHT(2)
                         STRING(@n-10.2b),AT(7479,21,594,146),USE(FCP:Iva10),TRN,RIGHT(2)
                         STRING(@n02),AT(4094,21,177,146),USE(PROV:PosicionIVA),TRN
                         STRING(@d5),AT(42,21,,145),USE(FCP:FechaPresentacion),TRN,RIGHT(1)
                         STRING(@s1),AT(948,21,156,146),USE(FCP:Letra),TRN
                         STRING(@n08),AT(1333,21,552,146),USE(FCP:Numero),TRN,RIGHT(1)
                         STRING(@s40),AT(1969,21,2042,146),USE(PROV:Nombre),TRN
                         STRING(@n-13.2b),AT(5229,21,750,146),USE(loc:NoGravado),TRN,RIGHT(1)
                         STRING(@n-13.2b),AT(5948,21,750,146),USE(FCP:NetoGravado),TRN,RIGHT(1)
                         STRING(@s3),AT(656,21,240,146),USE(CPTE:Abreviatura),TRN
                         STRING(@n04),AT(1021,21,302,146),USE(FCP:Lugar),TRN,RIGHT(1)
                       END
totales                DETAIL,AT(,,,240),USE(?totales),FONT('Arial',8,,FONT:regular,CHARSET:ANSI)
                         LINE,AT(31,31,10844,0),USE(?Line1),COLOR(COLOR:Black)
                         STRING('TOTALES'),AT(4760,52),USE(?String35),TRN,FONT(,,,FONT:bold)
                         STRING(@n-13.2),AT(5292,83),SUM,USE(loc:NoGravado,,?loc:NoGravado:2),TRN,RIGHT(1),FONT(,7,,FONT:bold),TALLY(detalle)
                         STRING(@n-13.2),AT(6021,83),SUM,USE(FCP:NetoGravado,,?FCP:NetoGravado:2),TRN,RIGHT(1),FONT(,7,,FONT:bold),TALLY(detalle)
                         STRING(@n-13.2),AT(6656,83),SUM,USE(FCP:Iva21,,?FCP:Iva21:2),TRN,RIGHT(2),FONT(,7,,FONT:bold),TALLY(detalle)
                         STRING(@n-13.2),AT(7375,83),SUM,USE(FCP:Iva10,,?FCP:Iva10:2),TRN,RIGHT(2),FONT(,7,,FONT:bold),TALLY(detalle)
                         STRING(@n-13.2),AT(8104,83),SUM,USE(FCP:Iva27,,?FCP:Iva27:2),TRN,RIGHT(2),FONT(,7,,FONT:bold),TALLY(detalle)
                         STRING(@n-13.2),AT(8771,83),SUM,USE(FCP:ImpuestosInternos,,?FCP:ImpuestosInternos:2),TRN,RIGHT(2),FONT(,7,,FONT:bold),TALLY(detalle)
                         STRING(@n-13.2),AT(9490,83),SUM,USE(FCP:PercepIVA,,?FCP:PercepIVA:2),TRN,RIGHT(2),FONT(,7,,FONT:bold),TALLY(detalle)
                         STRING(@n-13.2),AT(10156,83,667,146),SUM,USE(FCP:Importe,,?FCP:Importe:2),TRN,RIGHT(2),FONT(,7,,FONT:bold),TALLY(detalle)
                       END
                     END
ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(ReportManager)
AskPreview             PROCEDURE(),DERIVED                 ! Method added to host embed code
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
? DEBUGHOOK(FACPROV:Record)
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
  GlobalErrors.SetProcedureName('SubdiarioIVACompras')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:Empresa',glo:Empresa)                          ! Added by: Report
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:FACPROV.SetOpenRelated()
  Relate:FACPROV.Open                                      ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  PAR:Registro = glo:Empresa
  GET(PARAMETRO,PAR:Por_Registro)
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:FACPROV, ?Progress:PctText, Progress:Thermometer, ProgressMgr, FCP:FechaPresentacion)
  ThisReport.AddSortOrder(FCP:Por_Fecha_Presentacion)
  ThisReport.AddRange(FCP:FechaPresentacion,glo:FechaDesde,glo:FechaHasta)
  ThisReport.SetFilter('FCP:Empresa = glo:Empresa')
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:FACPROV.SetQuickScan(1,Propagate:OneMany)
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
    Relate:FACPROV.Close
    Relate:PARAMETRO.Close
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF ProgressWindow{Prop:AcceptAll} THEN RETURN.
  CPTE:Codigo = FCP:Comprobante                            ! Assign linking field value
  Access:COMPROBANTES.Fetch(CPTE:Por_Codigo)
  PROV:CodProveedor = FCP:CodProveedor                     ! Assign linking field value
  Access:PROVEEDORES.Fetch(PROV:Por_CodProveedor)
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


ThisWindow.Update PROCEDURE

  CODE
  PARENT.Update
  CPTE:Codigo = FCP:Comprobante                            ! Assign linking field value
  Access:COMPROBANTES.Fetch(CPTE:Por_Codigo)
  PROV:CodProveedor = FCP:CodProveedor                     ! Assign linking field value
  Access:PROVEEDORES.Fetch(PROV:Por_CodProveedor)


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  loc:NoGravado = FCP:NoGravado + FCP:Exento + FCP:PercepOtros + FCP:PercepIB
  loc:Contador += 1
  IF loc:Contador = 36 THEN
    loc:Hoja += 1
    loc:Contador = 0
  END
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detalle)
  RETURN ReturnValue

