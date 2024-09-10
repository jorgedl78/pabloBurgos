

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS125.INC'),ONCE        !Local module procedure declarations
                     END


FacturasImpagasGeneral PROCEDURE                           ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
loc:SaldoComprobante DECIMAL(9,2)                          !
loc:Acumulado        DECIMAL(9,2)                          !
Process:View         VIEW(CLIENTES)
                       PROJECT(CLI:Direccion)
                       PROJECT(CLI:Nombre)
                       PROJECT(CLI:Telefono)
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

Report               REPORT('CLIENTES Report'),AT(510,1000,7417,10188),PAPER(PAPER:A4),PRE(RPT),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(510,250,7417,740),USE(?Header),FONT('MS Sans Serif',8,,FONT:regular)
                         BOX,AT(83,531,7250,208),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Fecha'),AT(354,563),USE(?String7),TRN,FONT(,,,FONT:bold)
                         STRING('Comprobante'),AT(1000,563),USE(?String7:2),TRN,FONT(,,,FONT:bold)
                         STRING('Imp. Pagado'),AT(4521,563),USE(?String7:4),TRN,FONT(,,,FONT:bold)
                         STRING('Saldo Cpte.'),AT(5510,563),USE(?String7:5),TRN,FONT(,,,FONT:bold)
                         STRING('Acumulado'),AT(6531,563),USE(?String7:6),TRN,FONT(,,,FONT:bold)
                         STRING('Imp. Original'),AT(3604,563),USE(?String7:3),TRN,FONT(,,,FONT:bold)
                         STRING('FACTURAS IMPAGAS AL:'),AT(2177,354),USE(?ReportDatePrompt,,?ReportDatePrompt:2),TRN,FONT('Arial',8,,FONT:regular)
                         STRING('<<-- Date Stamp -->'),AT(3542,354,760,177),USE(?ReportDateStamp,,?ReportDateStamp:2),TRN,FONT('Arial',8,,FONT:bold)
                         STRING(@pPAGINA:  <<#p),AT(6552,354),PAGENO,USE(?PageCount,,?PageCount:2),TRN,FONT('Arial',8,,FONT:regular)
                       END
cliente                DETAIL,AT(,,7750,250),USE(?cliente)
                         STRING(@s30),AT(3167,31),USE(CLI:Direccion),TRN
                         STRING(@s40),AT(104,31,3000,167),USE(CLI:Nombre),TRN,FONT(,,,FONT:bold)
                         STRING(@s35),AT(5219,31,2115,167),USE(CLI:Telefono),TRN
                         LINE,AT(83,188,7250,0),USE(?Line1),COLOR(COLOR:Black)
                       END
facturas               DETAIL,AT(,,,188),USE(?facturas)
                         STRING(@s1),AT(1271,10),USE(FAC:Letra),TRN
                         STRING(@n08),AT(1667,10),USE(FAC:Numero),TRN,RIGHT(1)
                         STRING(@n-13.2),AT(4458,10),USE(FAC:Aplicado),TRN,RIGHT(2)
                         STRING(@n-13.2),AT(5396,10),USE(loc:SaldoComprobante),TRN,RIGHT(1)
                         STRING(@n-13.2),AT(6375,10),USE(loc:Acumulado),TRN,RIGHT(1)
                         STRING(@n-11.2),AT(3635,10),USE(FAC:Importe),TRN,RIGHT(1)
                         STRING(@s3),AT(1000,10),USE(FAC:Comprobante),TRN
                         STRING(@n04),AT(1323,10),USE(FAC:Lugar),TRN,RIGHT(1)
                         STRING(@d6),AT(104,10),USE(FAC:Fecha),TRN,RIGHT(1)
                       END
linea                  DETAIL,AT(,,,198),USE(?linea)
                         LINE,AT(83,21,7250,0),USE(?Line1:2),COLOR(COLOR:Black)
                         LINE,AT(83,52,7250,0),USE(?Line1:3),COLOR(COLOR:Black)
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

ProgressMgr          StepStringClass                       ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(FACTURAS:Record)
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
  GlobalErrors.SetProcedureName('FacturasImpagasGeneral')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File FACTURAS used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:CLIENTES, ?Progress:PctText, Progress:Thermometer, ProgressMgr, CLI:Nombre)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(CLI:Por_Nombre)
  ThisReport.SetFilter('CLI:Nombre <<> ''ANULADA''')
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
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


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp:2{PROP:Text}=FORMAT(TODAY(),@D17)
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
  f#=0
  CLEAR(loc:Acumulado)
  FAC:ClienteFacturar = CLI:CodCliente
  CLEAR(FAC:Fecha)
  SET(FAC:Por_Cliente,FAC:Por_Cliente)
  LOOP UNTIL EOF(FACTURAS)
    NEXT(FACTURAS)
    IF FAC:ClienteFacturar <> CLI:CodCliente THEN BREAK.
    IF (FAC:Importe+FAC:Aplicado) = 0 THEN CYCLE.
    CLEAR(loc:SaldoComprobante)
    IF f#=0 THEN
      PRINT(RPT:cliente)
      f#=1
    END
    loc:SaldoComprobante = FAC:Importe + FAC:Aplicado
    loc:Acumulado += FAC:Importe + FAC:Aplicado
    PRINT(RPT:facturas)
  END
  IF f#=1 THEN PRINT(RPT:linea).
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

