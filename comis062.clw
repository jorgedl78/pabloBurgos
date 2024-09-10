

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS062.INC'),ONCE        !Local module procedure declarations
                     END


ListadoRedespachos PROCEDURE                               ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:total            DECIMAL(9,2)                          !
Process:View         VIEW(TRANSPOR)
                       PROJECT(TRA:CodTransporte)
                       PROJECT(TRA:Denominacion)
                     END
ReportPageNumber     LONG,AUTO
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
ProgressWindow       WINDOW('Procesando...'),AT(,,142,59),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,9),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,26,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancelar'),AT(46,41,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(656,948,7135,10271),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',8,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(656,323,7146,594),FONT('Arial',9,COLOR:Black,FONT:regular)
                         STRING(@d6b),AT(3021,10),USE(glo:FechaDesde),TRN,RIGHT(1)
                         STRING(@d6b),AT(4219,10),USE(glo:FechaHasta),TRN,RIGHT(1)
                         STRING(@s30),AT(969,177,2292,188),USE(TRA:Denominacion),TRN,FONT(,,,FONT:bold)
                         STRING(@N3),AT(6677,177),USE(ReportPageNumber),TRN
                         STRING('TRANSPORTE:'),AT(73,177),USE(?String26),TRN
                         BOX,AT(73,344,7000,208),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Remitente'),AT(2115,365),USE(?String5),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Destinatario'),AT(4052,365),USE(?String5:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Importe'),AT(6510,365),USE(?String5:5),TRN,FONT(,,,FONT:bold)
                         STRING('Cobrar A'),AT(5708,365),USE(?String28),TRN,FONT(,,,FONT:bold)
                         STRING('Fecha'),AT(438,365),USE(?String5:3),TRN,FONT(,,,FONT:bold)
                         STRING('Remito-Guía'),AT(969,365),USE(?String5:4),TRN,FONT(,,,FONT:bold)
                         STRING('PAGINA:'),AT(6125,177),USE(?String4),TRN
                         STRING('LISTADO DE REDESPACHOS'),AT(73,10),USE(?String1),TRN
                         STRING('DESDE:'),AT(2594,10),USE(?String18),TRN
                         STRING('HASTA:'),AT(3823,10),USE(?String18:2),TRN
                       END
detalle                DETAIL,AT(,,7135,344),USE(?detalle)
                         STRING(@s40),AT(4042,21,1875,177),USE(GUIA:NombreDestino),TRN
                         STRING(@n-13.2),AT(6229,21),USE(RD:Importe),TRN,RIGHT(1)
                         STRING(@s1),AT(6042,21),USE(GUIA:FacturarA),TRN
                         STRING(@d6),AT(167,21),USE(GUIA:Fecha),TRN,RIGHT(1)
                         STRING(@s1),AT(958,21),USE(GUIA:Letra),TRN,FONT(,,COLOR:Black,)
                         STRING(@n04),AT(1010,21),USE(GUIA:Lugar),TRN,RIGHT(1),FONT('Courier New',8,COLOR:Black,)
                         STRING(@n08),AT(1365,21),USE(GUIA:Numero),TRN,RIGHT(1),FONT('Courier New',8,COLOR:Black,)
                         STRING(@s30),AT(4042,146),USE(GUIA:LocalidadDestino),TRN
                         STRING(@s40),AT(2104,21,1875,177),USE(GUIA:NombreRemitente),TRN
                         STRING(@s30),AT(2104,146),USE(GUIA:LocalidadRemitente),TRN
                       END
items                  DETAIL,AT(,,,167),USE(?items)
                         STRING(@n7),AT(2177,21),USE(ITGUIA:Cantidad),TRN,FONT('Arial',7,,)
                         STRING(@s40),AT(2635,21,2198,156),USE(ITGUIA:Descripcion),TRN,FONT('Arial',7,,)
                       END
linea                  DETAIL,AT(,,,83),USE(?linea)
                         LINE,AT(63,31,7000,0),USE(?Line1),COLOR(COLOR:Black)
                       END
total                  DETAIL,AT(,,,271),USE(?total)
                         BOX,AT(6198,52,875,198),USE(?Box2),ROUND,COLOR(COLOR:Black)
                         STRING('TOTAL'),AT(5667,83),USE(?String27),TRN,FONT(,,,FONT:bold)
                         STRING(@n-13.2),AT(6229,83),USE(loc:total),TRN,RIGHT(1),FONT(,,,FONT:bold)
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

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
? DEBUGHOOK(GUIAS:Record)
? DEBUGHOOK(ITEMGUIA:Record)
? DEBUGHOOK(REDESPACHO:Record)
? DEBUGHOOK(TRANSPOR:Record)
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
  GlobalErrors.SetProcedureName('ListadoRedespachos')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:Transporte',glo:Transporte)                    ! Added by: Report
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:GUIAS.SetOpenRelated()
  Relate:GUIAS.Open                                        ! File ITEMGUIA used by this procedure, so make sure it's RelationManager is open
  Access:REDESPACHO.UseFile                                ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:ITEMGUIA.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:TRANSPOR, ?Progress:PctText, Progress:Thermometer, ProgressMgr, TRA:CodTransporte)
  ThisReport.AddSortOrder(TRA:Por_Codigo)
  ThisReport.AddRange(TRA:CodTransporte,glo:Transporte)
  ThisReport.AppendOrder('+GUIA:Fecha,+GUIA:Lugar,+GUIA:Numero')
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:TRANSPOR.SetQuickScan(1,Propagate:OneMany)
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
  CLEAR(loc:total)
  GUIA:Redespacho = TRA:CodTransporte
  SET(GUIA:Por_Redespacho,GUIA:Por_Redespacho)
  LOOP UNTIL EOF(GUIAS)
    NEXT(GUIAS)
    IF GUIA:Redespacho <> TRA:CodTransporte THEN BREAK.
    IF GUIA:Fecha >= glo:FechaDesde AND GUIA:Fecha <= glo:FechaHasta THEN
      RD:Guia = GUIA:RegGuia
      SET(RD:Por_Guia,RD:Por_Guia)
      LOOP UNTIL EOF(REDESPACHO)
        NEXT(REDESPACHO)
        IF RD:Guia <> GUIA:RegGuia THEN BREAK.
        IF NOT RD:Estado THEN
          PRINT(RPT:detalle)
          loc:total += RD:Importe
  
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
      END
    END
  END
  IF loc:total <> 0 THEN PRINT(RPT:total).
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

