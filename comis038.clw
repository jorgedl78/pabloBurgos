

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS038.INC'),ONCE        !Local module procedure declarations
                     END


HojaRutaDistribuidor PROCEDURE                             ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
Process:View         VIEW(GUIAS)
                       PROJECT(GUIA:ContraReembolso)
                       PROJECT(GUIA:DireccionDestino)
                       PROJECT(GUIA:DireccionRemitente)
                       PROJECT(GUIA:Fecha)
                       PROJECT(GUIA:Letra)
                       PROJECT(GUIA:LocalidadDestino)
                       PROJECT(GUIA:LocalidadRemitente)
                       PROJECT(GUIA:Lugar)
                       PROJECT(GUIA:NombreDestino)
                       PROJECT(GUIA:NombreRemitente)
                       PROJECT(GUIA:Numero)
                       PROJECT(GUIA:RemitoCliente)
                       PROJECT(GUIA:TelefonoDestino)
                       PROJECT(GUIA:TelefonoRemitente)
                       PROJECT(GUIA:Distribuidor)
                       PROJECT(GUIA:Redespacho)
                       JOIN(DIS:Por_Codigo,GUIA:Distribuidor)
                         PROJECT(DIS:Nombre)
                       END
                       JOIN(TRA:Por_Codigo,GUIA:Redespacho)
                         PROJECT(TRA:Denominacion)
                         PROJECT(TRA:Direccion)
                         PROJECT(TRA:Localidad)
                         PROJECT(TRA:Telefono)
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

report               REPORT,AT(656,948,7135,10146),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',8,,FONT:regular),THOUS
                       HEADER,AT(656,323,7146,594),FONT('Arial',9,COLOR:Black,FONT:regular)
                         STRING(@d6),AT(1615,10),USE(GUIA:Fecha),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING(@N3),AT(6677,177),USE(ReportPageNumber),TRN
                         STRING('DISTRIBUIDOR:'),AT(73,177),USE(?String26),TRN
                         STRING(@s35),AT(1115,177,2625,188),USE(DIS:Nombre),TRN,FONT(,,,FONT:bold)
                         BOX,AT(73,344,7000,208),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Redespacho'),AT(5083,365),USE(?String5:3),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Remitente'),AT(260,365),USE(?String5),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('Destinatario'),AT(2750,365),USE(?String5:2),TRN,FONT(,,COLOR:Black,FONT:bold)
                         STRING('PAGINA:'),AT(6125,177),USE(?String4),TRN
                         STRING('HOJA DE RUTA DEL DIA'),AT(73,10),USE(?String1),TRN,FONT(,,COLOR:Black,)
                       END
break1                 BREAK(GUIA:Numero)
                         HEADER,AT(0,0,,167)
                           STRING(@s1),AT(1302,21),USE(GUIA:Letra),TRN,FONT(,,COLOR:Black,FONT:bold)
                           STRING('Contra Reembolso:'),AT(5406,21),USE(?Reembolso),TRN,FONT(,,COLOR:Black,FONT:italic)
                           STRING(@n10.2b),AT(6438,21),USE(GUIA:ContraReembolso),TRN
                           STRING(@n04),AT(1396,21),USE(GUIA:Lugar),TRN,RIGHT(1),FONT('Courier New',8,COLOR:Black,FONT:bold)
                           STRING(@n08),AT(1781,21),USE(GUIA:Numero),TRN,RIGHT(1),FONT('Courier New',8,COLOR:Black,FONT:bold)
                           STRING('Remito Cliente:'),AT(2906,21),USE(?RemitoCliente),TRN,FONT(,,,FONT:italic)
                           STRING(@s10b),AT(3750,21),USE(GUIA:RemitoCliente),TRN
                           STRING('REMITO-GUIA NRO.:'),AT(94,21),USE(?String8),TRN,FONT(,,COLOR:Black,FONT:bold)
                         END
detalle                  DETAIL,AT(10,,7135,667),USE(?detalle)
                           STRING(@s40),AT(2740,21,1969,177),USE(GUIA:NombreDestino),TRN
                           STRING(@s30),AT(2740,156),USE(GUIA:DireccionDestino),TRN
                           STRING(@s30),AT(2740,292),USE(GUIA:LocalidadDestino),TRN
                           STRING(@s40),AT(250,21,1969,177),USE(GUIA:NombreRemitente),TRN
                           STRING(@s35),AT(2740,427,1969,177),USE(GUIA:TelefonoDestino),TRN
                           STRING(@s30),AT(5073,21),USE(TRA:Denominacion),TRN
                           STRING(@s30),AT(250,156),USE(GUIA:DireccionRemitente),TRN
                           STRING(@s30),AT(5073,156),USE(TRA:Direccion),TRN
                           STRING(@s30),AT(250,292),USE(GUIA:LocalidadRemitente),TRN
                           STRING(@s30),AT(5073,292),USE(TRA:Localidad),TRN
                           STRING(@s35),AT(250,427,1969,177),USE(GUIA:TelefonoRemitente),TRN
                           STRING(@s35),AT(5073,427,1927,177),USE(TRA:Telefono),TRN
                           LINE,AT(63,604,7000,0),USE(?Line1),COLOR(COLOR:Black)
                         END
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
  GlobalErrors.SetProcedureName('HojaRutaDistribuidor')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:Distribuidor',glo:Distribuidor)                ! Added by: Report
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:GUIAS.SetOpenRelated()
  Relate:GUIAS.Open                                        ! File GUIAS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric+ScrollSort:Descending,)
  ThisReport.Init(Process:View, Relate:GUIAS, ?Progress:PctText, Progress:Thermometer, ProgressMgr, GUIA:Fecha)
  ThisReport.AddSortOrder(GUIA:Por_Fecha)
  ThisReport.AddRange(GUIA:Fecha,glo:FechaDesde)
  ThisReport.SetFilter('GUIA:Distribuidor = glo:Distribuidor AND GUIA:Impresa <<> ''A''')
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
  DIS:CodDistribuidor = GUIA:Distribuidor                  ! Assign linking field value
  Access:DISTRIBUIDORES.Fetch(DIS:Por_Codigo)
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
  DIS:CodDistribuidor = GUIA:Distribuidor                  ! Assign linking field value
  Access:DISTRIBUIDORES.Fetch(DIS:Por_Codigo)
  TRA:CodTransporte = GUIA:Redespacho                      ! Assign linking field value
  Access:TRANSPOR.Fetch(TRA:Por_Codigo)


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  SETTARGET(REPORT,?detalle)
    IF NOT GUIA:ContraReembolso THEN
      ?Reembolso{PROP:Text} = ''
    ELSE
      ?Reembolso{PROP:Text} = 'Contra Reembolso:'
    END
    IF NOT GUIA:RemitoCliente THEN
      ?RemitoCliente{PROP:Text} = ''
    ELSE
      ?RemitoCliente{PROP:Text} = 'Remito Cliente:'
    END
  SETTARGET
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detalle)
  RETURN ReturnValue

