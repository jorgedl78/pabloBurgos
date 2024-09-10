

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS104.INC'),ONCE        !Local module procedure declarations
                     END


ResumenCtaCte PROCEDURE                                    ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:SaldoAnterior    DECIMAL(9,2)                          !
loc:Debito           DECIMAL(9,2)                          !
loc:Credito          DECIMAL(9,2)                          !
loc:SaldoComprobante DECIMAL(9,2)                          !
loc:Acumulado        DECIMAL(9,2)                          !
Process:View         VIEW(CLIENTES)
                       PROJECT(CLI:CodCliente)
                       PROJECT(CLI:Direccion)
                       PROJECT(CLI:Localidad)
                       PROJECT(CLI:Nombre)
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

report               REPORT,AT(792,1438,6927,9625),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',9,,FONT:regular),THOUS
                       HEADER,AT(792,417,6927,1000)
                         STRING('RESUMEN DE CUENTA CORRIENTE'),AT(2469,10),USE(?String18),TRN,FONT(,,,FONT:bold)
                         STRING(@P[<<<<<<]P),AT(146,281,531,146),USE(CLI:CodCliente),TRN,LEFT(1),FONT(,,,FONT:bold)
                         STRING(@s40),AT(719,281,3000,146),USE(CLI:Nombre),TRN,FONT(,,,FONT:bold)
                         STRING(@s30),AT(146,427,2260,146),USE(CLI:Direccion),TRN
                         STRING(@d6),AT(4740,583),USE(glo:FechaDesde),TRN,RIGHT(1)
                         STRING(@d6),AT(5948,583),USE(glo:FechaHasta),TRN,RIGHT(1)
                         STRING('DESDE:'),AT(4260,583),USE(?String14),TRN
                         STRING('HASTA:'),AT(5521,583),USE(?String14:2),TRN
                         STRING(@s30),AT(146,583,2208,146),USE(CLI:Localidad),TRN
                         BOX,AT(63,771,6719,208),USE(?Box1),COLOR(COLOR:Black)
                         STRING('Comprobante'),AT(1010,802),USE(?String6:2),TRN,FONT(,,,FONT:bold)
                         STRING('Fecha'),AT(438,802),USE(?String6),TRN,FONT(,,,FONT:bold)
                         STRING('Débito'),AT(3260,802),USE(?String6:3),TRN,FONT(,,,FONT:bold)
                         STRING('Crédito'),AT(4042,802),USE(?String6:6),TRN,FONT(,,,FONT:bold)
                         STRING('Saldo Cpte.'),AT(4854,802),USE(?String6:5),TRN,FONT(,,,FONT:bold)
                         STRING('Acumulado'),AT(6052,802),USE(?String6:4),TRN,FONT(,,,FONT:bold)
                       END
break1                 BREAK(CLI:CodCliente)
                         HEADER,AT(,,,219)
                           STRING('Saldo Anterior:'),AT(5042,21,833,146),USE(?String28),TRN
                           STRING(@n-13.2),AT(5875,21,844,146),USE(loc:SaldoAnterior),TRN,RIGHT(2)
                         END
detalle                  DETAIL,AT(,,,198),USE(?detalle)
                           STRING(@n-13.2b),AT(3625,21,844,146),USE(loc:Credito),TRN,RIGHT(2)
                           STRING(@n-13.2),AT(4677,21,844,146),USE(loc:SaldoComprobante),TRN,RIGHT(2)
                           STRING(@n-13.2),AT(5875,21,844,146),USE(loc:Acumulado),TRN,RIGHT(2)
                           STRING(@n-13.2b),AT(2792,21,844,146),USE(loc:Debito),TRN,RIGHT(2)
                           STRING(@s3),AT(1010,21,271,146),USE(FAC:Comprobante),TRN
                           STRING(@d6),AT(94,21,698,146),USE(FAC:Fecha),TRN,RIGHT(1)
                           STRING(@s1),AT(1281,21,156,146),USE(FAC:Letra),TRN,CENTER
                           STRING(@n08),AT(1750,21,635,146),USE(FAC:Numero),TRN,RIGHT(1)
                           STRING(@n04),AT(1417,21,344,146),USE(FAC:Lugar),TRN,RIGHT(1)
                         END
                         FOOTER,AT(0,0,,229)
                           LINE,AT(5729,21,1042,0),USE(?Line1),COLOR(COLOR:Black)
                           STRING(@n-13.2),AT(5865,52),USE(loc:Acumulado,,?loc:Acumulado:2),TRN,RIGHT(2),FONT(,,,FONT:bold)
                           STRING('SALDO'),AT(5302,52),USE(?String20),TRN,FONT(,,,FONT:bold)
                         END
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
  GlobalErrors.SetProcedureName('ResumenCtaCte')
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
  ! RESUMEN DE CUENTA CORRIENTE
  FAC:ClienteFacturar = glo:Cliente
  CLEAR(FAC:Fecha)
  SET(FAC:Por_Cliente,FAC:Por_Cliente)
  LOOP UNTIL EOF(FACTURAS)
    NEXT(FACTURAS)
    IF FAC:ClienteFacturar <> glo:Cliente THEN BREAK.
    IF FAC:Fecha > glo:FechaHasta THEN BREAK.
    IF FAC:Fecha < glo:FechaDesde THEN
      IF FAC:Cobrada THEN
        loc:SaldoAnterior += FAC:Importe + FAC:Aplicado
      ELSE
        loc:SaldoAnterior += FAC:Importe
      END
      loc:Acumulado = loc:SaldoAnterior
      CYCLE
    ELSE
      IF FAC:Cobrada THEN
        loc:Acumulado += FAC:Importe + FAC:Aplicado
      ELSE
        loc:Acumulado += FAC:Importe
      END
    END
  
  !  loc:Numero = CLIP(FAC:Letra) & ' ' & FORMAT(FAC:Lugar,@n04) & '-' & FORMAT(FAC:Numero,@n08)
   
  !  CASE (FAC:Comprobante)
  !  OF 'FC'
  !    loc:Comprobante = 'Factura'
  !  OF 'ND'
  !    loc:Comprobante = 'Nota de Débito'
  !  OF 'NC'
  !    loc:Comprobante = 'Nota de Crédito'
  !  OF 'RC'
  !    loc:Comprobante = 'Recibo'
  !  END
  
    IF FAC:Comprobante = 'FAC' THEN
      loc:Debito = FAC:Importe
    ELSE
      loc:Debito = 0
    END
    IF FAC:Comprobante = 'REC' THEN
      loc:Credito = FAC:Importe
    ELSE
      loc:Credito = 0
    END
  
    loc:SaldoComprobante = FAC:Importe + FAC:Aplicado
  
    PRINT(RPT:detalle)
  END
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

