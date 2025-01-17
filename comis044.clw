

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS044.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS073.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS074.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS080.INC'),ONCE        !Req'd for module callout resolution
                     END


WinReimpresionGuia PROCEDURE                               ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:Lugar            LONG                                  !
loc:Numero           LONG                                  !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Reimpresi�n de Gu�a'),AT(,,148,82),FONT('MS Sans Serif',8,,FONT:regular),CENTER,GRAY,DOUBLE
                       PANEL,AT(7,8,133,51),USE(?Panel1),FILL(0EDECE2H),BEVEL(-1)
                       PROMPT('Empresa:'),AT(47,18),USE(?glo:Empresa:Prompt),TRN
                       ENTRY(@n1b),AT(83,18,17,10),USE(glo:Empresa),RIGHT(1),REQ
                       ENTRY(@P<<<<P),AT(56,40,25,10),USE(loc:Lugar),RIGHT(1),REQ
                       PROMPT('N�mero:'),AT(21,40),USE(?loc:Numero:Prompt),TRN
                       ENTRY(@P<<<<<<<<P),AT(86,40,41,10),USE(loc:Numero),RIGHT(1),REQ
                       BUTTON,AT(96,64,19,14),USE(?OK),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\ok.gif')
                       BUTTON,AT(121,64,19,14),USE(?Cancel),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\cancel.gif'),STD(STD:Close)
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
  GlobalErrors.SetProcedureName('WinReimpresionGuia')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
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
    Relate:GUIAS.Close
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
      
      GUIA:Empresa = glo:Empresa
      GUIA:Lugar = loc:Lugar
      GUIA:Numero = loc:Numero
      GET(GUIAS,GUIA:Por_Comprobante)
      IF ERRORCODE() THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' No se encontr� ning�n registro con los datos ingresados.',|
                'Atenci�n !!!',ICON:Exclamation)
        SELECT(glo:Empresa)
        CYCLE
      END
      
      CASE glo:Empresa
      OF 1
        ImprimeTotal1
      OF 2
        ImprimeTotal2
      OF 3
        ImprimeTotal3
      END
    END
  ReturnValue = PARENT.TakeAccepted()
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

