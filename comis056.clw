

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS056.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS124.INC'),ONCE        !Req'd for module callout resolution
                     END


WinSubdiarioIVACompras PROCEDURE                           ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:CodigoSeguridad  STRING(6)                             !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Subdiario IVA Compras'),AT(,,139,139),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,GRAY,DOUBLE
                       PANEL,AT(8,8,123,19),USE(?Panel3),FILL(0EDECE2H),BEVEL(-1)
                       STRING('Empresa:'),AT(36,13),USE(?String1),TRN
                       SPIN(@n1b),AT(72,13,23,10),USE(glo:Empresa),CENTER,REQ,RANGE(1,3),STEP(2)
                       PANEL,AT(8,32,123,36),USE(?Panel2),FILL(0EDECE2H),BEVEL(-1)
                       PROMPT('Fecha Desde:'),AT(20,38),USE(?glo:FechaDesde:Prompt),TRN
                       ENTRY(@d6b),AT(72,38,49,10),USE(glo:FechaDesde),RIGHT(1),REQ
                       PROMPT('Fecha Hasta:'),AT(22,53),USE(?glo:FechaHasta:Prompt),TRN
                       ENTRY(@d6b),AT(72,53,49,10),USE(glo:FechaHasta),RIGHT(1),REQ
                       PANEL,AT(8,74,123,19),USE(?Panel3:2),FILL(0E0EFEFH),BEVEL(-1)
                       PROMPT('Nro. Hoja Inicial:'),AT(13,79),USE(?glo:HojaInicial:Prompt),TRN
                       ENTRY(@n6.b),AT(72,79,32,10),USE(glo:HojaInicial),RIGHT(1),REQ
                       BOX,AT(8,99,123,19),USE(?Box1),COLOR(COLOR:Black),FILL(0494949H)
                       PROMPT('Código de Seguridad:'),AT(20,103),USE(?loc:CodigoSeguridad:Prompt),TRN,FONT(,,COLOR:White,,CHARSET:ANSI)
                       ENTRY(@s6),AT(96,103,23,10),USE(loc:CodigoSeguridad),REQ,UPR,PASSWORD
                       BUTTON,AT(92,122,17,14),USE(?OkButton),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\ok.gif')
                       BUTTON,AT(113,122,17,14),USE(?CancelButton),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\cancel.gif'),STD(STD:Close)
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
  GlobalErrors.SetProcedureName('WinSubdiarioIVACompras')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel3
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
  EnterByTabManager.ExcludeControl(?CancelButton)
  EnterByTabManager.ExcludeControl(?OkButton)
  EnterByTabManager.Init(False)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
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
    OF ?OkButton
      IF INCOMPLETE() THEN CYCLE.
      
      IF loc:CodigoSeguridad <> 'PB2217' THEN
        BEEP(BEEP:SystemHand)  ;  YIELD()
        MESSAGE(' Código de Seguridad incorrecto.',,ICON:Hand)
        SELECT(?loc:CodigoSeguridad)
        CYCLE
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OkButton
      ThisWindow.Update
      SubdiarioIVACompras
      ThisWindow.Reset
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
    CASE EVENT()
    OF EVENT:OpenWindow
      CLEAR(glo:HojaInicial)
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

