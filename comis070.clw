

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS070.INC'),ONCE        !Local module procedure declarations
                     END


ContraReembolsosImpagos PROCEDURE                          ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
Process:View         VIEW(GUIAS)
                       PROJECT(GUIA:ContraReembolso)
                       PROJECT(GUIA:Fecha)
                       PROJECT(GUIA:Flete)
                       PROJECT(GUIA:Letra)
                       PROJECT(GUIA:LocalidadDestino)
                       PROJECT(GUIA:LocalidadRemitente)
                       PROJECT(GUIA:Lugar)
                       PROJECT(GUIA:NombreDestino)
                       PROJECT(GUIA:NombreRemitente)
                       PROJECT(GUIA:Numero)
                       PROJECT(GUIA:Redespacho)
                       JOIN(TRA:Por_Codigo,GUIA:Redespacho)
                         PROJECT(TRA:Denominacion)
                       END
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

report               REPORT,AT(656,948,7135,10146),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',8,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(656,323,7146,594),FONT('Arial',9,COLOR:Black,FONT:regular)
                         STRING(@d6b),AT(3000,156),USE(glo:FechaHasta),TRN,RIGHT(1)
                         STRING(@N3),AT(6677,156),USE(ReportPageNumber),TRN
                         BOX,AT(31,344,7083,208),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Remitente'),AT(1938,365),USE(?String5),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Destinatario'),AT(3875,365),USE(?String5:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Importe'),AT(6510,365),USE(?String5:5),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Flete'),AT(6000,365),USE(?String5:6),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Fecha'),AT(323,365),USE(?String5:3),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Remito-Guía'),AT(813,365),USE(?String5:4),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('PAGINA:'),AT(6125,156),USE(?String4),TRN
                         STRING('LISTADO DE CONTRA REEMBOLSOS IMPAGOS AL'),AT(52,156),USE(?String1),TRN
                       END
detalle                DETAIL,AT(10,,7135,385),USE(?detalle)
                         STRING(@s40),AT(3865,21,1875,177),USE(GUIA:NombreDestino),TRN
                         STRING(@n10.2),AT(6365,21),USE(GUIA:ContraReembolso),TRN,RIGHT(1)
                         STRING(@s1),AT(6042,21,188,177),USE(GUIA:Flete),TRN,CENTER
                         STRING(@d6),AT(52,21),USE(GUIA:Fecha),TRN,RIGHT(1)
                         STRING(@s1),AT(802,21),USE(GUIA:Letra),TRN
                         STRING(@n04),AT(844,21),USE(GUIA:Lugar),TRN,RIGHT(1),FONT('Courier New',8,COLOR:Black,)
                         STRING(@n08),AT(1188,21),USE(GUIA:Numero),TRN,RIGHT(1),FONT('Courier New',8,COLOR:Black,)
                         STRING(@s30),AT(3865,146),USE(GUIA:LocalidadDestino),TRN
                         STRING(@s30),AT(5750,167,1354,156),USE(TRA:Denominacion),TRN,FONT('Arial',7,,)
                         STRING(@s40),AT(1927,21,1875,177),USE(GUIA:NombreRemitente),TRN
                         STRING(@s30),AT(1927,146),USE(GUIA:LocalidadRemitente),TRN
                         LINE,AT(31,313,7070,0),USE(?Line1),COLOR(COLOR:Black)
                       END
                     END
ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Reset                  PROCEDURE(BYTE Force=0),DERIVED     ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Update                 PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

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
  GlobalErrors.SetProcedureName('ContraReembolsosImpagos')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:FechaHasta',glo:FechaHasta)                    ! Added by: Report
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:GUIAS.SetOpenRelated()
  Relate:GUIAS.Open                                        ! File GUIAS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ThisReport.Init(Process:View, Relate:GUIAS, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  ThisReport.AppendOrder('GUIA:Fecha,GUIA:Numero')
  ThisReport.SetFilter('GUIA:Fecha <<= glo:FechaHasta AND GUIA:ContraReembolso AND NOT(GUIA:Cumplida)')
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


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF ProgressWindow{Prop:AcceptAll} THEN RETURN.
  TRA:CodTransporte = GUIA:Redespacho                      ! Assign linking field value
  Access:TRANSPOR.Fetch(TRA:Por_Codigo)
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
  TRA:CodTransporte = GUIA:Redespacho                      ! Assign linking field value
  Access:TRANSPOR.Fetch(TRA:Por_Codigo)


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detalle)
  RETURN ReturnValue

