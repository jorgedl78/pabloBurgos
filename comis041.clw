

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('COMIS041.INC'),ONCE        !Local module procedure declarations
                     END


VisitasProgramadas PROCEDURE                               ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
FilesOpened          BYTE                                  !
loc:Dia              STRING(40)                            !
loc:Fecha            LONG                                  !
Process:View         VIEW(PARAMETRO)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
DisplayMesString  STRING('Enero    Febrero  Marzo    Abril    Mayo     Junio    Julio    Agosto   SetiembreOctubre  NoviembreDiciembre')
DisplayMesText    STRING(9),DIM(12),OVER(DisplayMesString)
ProgressWindow       WINDOW('Procesando...'),AT(,,142,59),FONT('MS Sans Serif',8,,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,9),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,27,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancelar'),AT(46,41,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(1052,240,6771,13500),PAPER(PAPER:LEGAL),PRE(RPT),FONT('Arial',10,,),THOUS
encabezado             DETAIL,PAGEBEFORE(-1),AT(,,,302),USE(?encabezado)
                         BOX,AT(21,31,4800,208),USE(?Box1),ROUND,COLOR(COLOR:Black),FILL(0DEDEDEH)
                         STRING(@s40),AT(63,52,3031,208),USE(loc:Dia),TRN,FONT(,,,FONT:bold)
                       END
detalle                DETAIL,AT(,,,198),USE(?detalle)
                         STRING(@T1),AT(115,21,406,177),USE(VIS:Hora),TRN,RIGHT(1)
                         STRING(@s40),AT(646,21,2958,177),USE(CLI:Nombre),TRN
                         LINE,AT(21,188,4800,0),USE(?Line1),COLOR(COLOR:Gray)
                       END
espacio                DETAIL,AT(,,,198),USE(?espacio)
                         LINE,AT(21,188,4800,0),USE(?Line1:2),COLOR(COLOR:Gray)
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

Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(DIAS:Record)
? DEBUGHOOK(PARAMETRO:Record)
? DEBUGHOOK(VISITAS:Record)
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
  GlobalErrors.SetProcedureName('VisitasProgramadas')
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
  Access:VISITAS.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:DIAS.UseFile                                      ! File referenced in 'Other Files' so need to inform it's FileManager
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
  loc:Fecha = glo:FechaDesde
  
  LOOP WHILE loc:Fecha <= glo:FechaHasta
  
    DIA:Codigo = (loc:Fecha%7)+1
    GET(DIAS,DIA:Por_Codigo)
  
    loc:Dia = CLIP(DIA:Descripcion) & ', ' & DAY(loc:Fecha) & ' de ' & CLIP(DisplayMesText[MONTH(loc:Fecha)]) & ' de ' & YEAR(loc:Fecha)
  
    PRINT(RPT:encabezado)
  
    VIS:Dia = DIA:Codigo
    CLEAR(VIS:Hora)
    SET(VIS:Por_Dia,VIS:Por_Dia)
    LOOP UNTIL EOF(VISITAS)
      NEXT(VISITAS)
      IF VIS:Dia <> DIA:Codigo THEN BREAK.
  
      CLI:CodCliente = VIS:Cliente
      GET(CLIENTES,CLI:Por_Codigo)
  
      PRINT(RPT:detalle)
      PRINT(RPT:espacio)
    END
    loc:Fecha += 1
  END
  ReturnValue = PARENT.TakeRecord()
  RETURN ReturnValue

