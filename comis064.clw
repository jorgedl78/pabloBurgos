

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS064.INC'),ONCE        !Local module procedure declarations
                     END


Remitente PROCEDURE                                        ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Remitente'),AT(,,164,56),FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,DOUBLE
                       STRING(@s40),AT(10,7,146,10),USE(GUIA:NombreRemitente),TRN,FONT(,,0A00000H,FONT:bold)
                       STRING(@s30),AT(10,18),USE(GUIA:DireccionRemitente),TRN
                       STRING(@s30),AT(10,29),USE(GUIA:LocalidadRemitente),TRN
                       STRING(@s35),AT(10,40,146,10),USE(GUIA:TelefonoRemitente),TRN
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass

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
  GlobalErrors.SetProcedureName('Remitente')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?GUIA:NombreRemitente
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:GUIAS.SetOpenRelated()
  Relate:GUIAS.Open                                        ! File GUIAS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'�',8)
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

