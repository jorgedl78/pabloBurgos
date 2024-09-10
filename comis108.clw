

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS108.INC'),ONCE        !Local module procedure declarations
                     END


WinLiquidacionRedespacho PROCEDURE                         ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:FechaPago        LONG                                  !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Liquidaci�n de Pago'),AT(,,139,92),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,GRAY,DOUBLE
                       PANEL,AT(8,9,123,64),USE(?Panel1),FILL(0EDECE2H)
                       PROMPT('Fecha Desde:'),AT(19,17),USE(?glo:FechaDesde:Prompt),TRN
                       ENTRY(@d6b),AT(69,17,49,10),USE(glo:FechaDesde),RIGHT(1),REQ
                       PROMPT('Fecha Hasta:'),AT(21,32),USE(?glo:FechaHasta:Prompt),TRN
                       ENTRY(@d6b),AT(69,32,49,10),USE(glo:FechaHasta),RIGHT(1),REQ
                       LINE,AT(9,49,120,0),USE(?Line1),COLOR(04B4B4BH),LINEWIDTH(2)
                       PROMPT('Fecha de Pago:'),AT(14,56),USE(?loc:FechaPago:Prompt),TRN
                       ENTRY(@d6b),AT(69,56,49,10),USE(loc:FechaPago),RIGHT(1),REQ
                       BUTTON,AT(92,76,17,14),USE(?OK),FLAT,ICON('C:\1L\Comisiones\botones\ok.gif')
                       BUTTON,AT(113,76,17,14),USE(?Cancel),FLAT,ICON('C:\1L\Comisiones\botones\cancel.gif'),STD(STD:Close)
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass

  CODE
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
  GlobalErrors.SetProcedureName('WinLiquidacionRedespacho')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:TRANSPOR.SetOpenRelated()
  Relate:TRANSPOR.Open                                     ! File TRANSPOR used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'�',8)
  EnterByTabManager.ExcludeControl(?Cancel)
  EnterByTabManager.ExcludeControl(?OK)
  EnterByTabManager.Init(False)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:TRANSPOR.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?OK
      IF INCOMPLETE() THEN CYCLE.
      SETCURSOR(CURSOR:Wait)
      GUIA:Redespacho = TRA:CodTransporte
      SET(GUIA:Por_Redespacho,GUIA:Por_Redespacho)
      LOOP UNTIL EOF(GUIAS)
        NEXT(GUIAS)
        IF GUIA:Redespacho <> TRA:CodTransporte THEN BREAK.
        IF GUIA:Fecha >= glo:FechaDesde AND GUIA:Fecha <= glo:FechaHasta THEN
          RD:Guia = GUIA:RegGuia
          GET(REDESPACHO,RD:Por_Guia)
          IF NOT RD:Estado THEN
            RD:Estado = loc:FechaPago
            PUT(REDESPACHO)
          END
        END
      END
      SETCURSOR
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
       POST(Event:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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
  IF Running          !Se voc� est� terminando a inst�ncia que est� executando
     ThreadNo = 0     !reinicializa a vari�vel ThreadNo
  END
  END
  If EVENT() = EVENT:OPENWINDOW
  IF NOT ThreadNo                      !Se esta � a primeira inst�ncia
     ThreadNo = THREAD()               ! salva o n�mero da Thread
     Running = TRUE                    ! e marca que est� executando
  ELSE                                 !Sen�o
     POST(EVENT:GainFocus, , ThreadNo) !d� o foco para a inst�ncia que est� executando
     RETURN(Level:Fatal)
  END
  END
  If EVENT() = EVENT:GainFocus 
   TARGET{PROP:Active} = TRUE     !Ativa a Thread
   IF TARGET{PROP:Iconize} = TRUE !Se o usu�rio iconizou a janela
      TARGET{PROP:Iconize} = ''   ! ..restaura
   END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

