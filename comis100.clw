

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS100.INC'),ONCE        !Local module procedure declarations
                     END


AnulaImpresion PROCEDURE                                   ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:Comprobante      STRING(3)                             !
loc:Letra            STRING(1)                             !
loc:Lugar            LONG                                  !
loc:Numero           LONG                                  !
loc:CodigoSeguridad  STRING(6)                             !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Anula Impresión'),AT(,,148,116),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,GRAY,DOUBLE
                       PANEL,AT(7,8,133,62),USE(?Panel1),FILL(0EDECE2H),BEVEL(-1)
                       OPTION,AT(19,9,112,18),USE(loc:Comprobante),TRN
                         RADIO('FACTURA'),AT(23,15),USE(?loc:Comprobante:Radio1),TRN,VALUE('FAC')
                         RADIO('RECIBO'),AT(81,15),USE(?loc:Comprobante:Radio2),TRN,VALUE('REC')
                       END
                       PROMPT('Empresa:'),AT(46,36),USE(?glo:Empresa:Prompt),TRN,FONT(,,,FONT:bold)
                       ENTRY(@n1b),AT(86,36,17,10),USE(glo:Empresa),RIGHT(1),REQ
                       PROMPT('Número:'),AT(16,54),USE(?loc:Numero:Prompt),TRN
                       ENTRY(@s1),AT(46,54,12,10),USE(loc:Letra),CENTER,REQ,UPR
                       ENTRY(@P<<<<P),AT(61,54,22,10),USE(loc:Lugar),RIGHT(1),REQ
                       ENTRY(@P<<<<<<<<P),AT(86,54,41,10),USE(loc:Numero),RIGHT(1),REQ
                       BOX,AT(7,75,133,20),USE(?Box1),COLOR(COLOR:Black),FILL(02F2F2FH)
                       PROMPT('Código de Seguridad:'),AT(21,80),USE(?loc:CodigoSeguridad:Prompt),TRN,FONT(,,COLOR:White,,CHARSET:ANSI)
                       ENTRY(@s6),AT(99,80,28,10),USE(loc:CodigoSeguridad),REQ,UPR,PASSWORD
                       BUTTON,AT(96,99,19,14),USE(?OK),FLAT,ICON('C:\1L\Comisiones\botones\ok.gif')
                       BUTTON,AT(121,99,19,14),USE(?Cancel),FLAT,ICON('C:\1L\Comisiones\botones\cancel.gif'),STD(STD:Close)
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
  GlobalErrors.SetProcedureName('AnulaImpresion')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:FACTURAS.SetOpenRelated()
  Relate:FACTURAS.Open                                     ! File FACTURAS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
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
    Relate:FACTURAS.Close
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
      
      IF loc:CodigoSeguridad <> 'PB2217' THEN
        BEEP(BEEP:SystemHand)  ;  YIELD()
        MESSAGE(' Código de Seguridad incorrecto.',,ICON:Hand)
        SELECT(?loc:CodigoSeguridad)
        CYCLE
      END
      
      FAC:Empresa = glo:Empresa
      FAC:Comprobante = loc:Comprobante
      FAC:Letra = loc:Letra
      FAC:Lugar = loc:Lugar
      FAC:Numero = loc:Numero
      GET(FACTURAS,FAC:Por_Comprobante)
      IF ERRORCODE() THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' No se encontró ningún registro con los datos ingresados.',|
                'Atención !!!',ICON:Exclamation)
        CYCLE
      ELSE
        FAC:Impresa = 'N'
        PUT(FACTURAS)
        IF NOT(ERRORCODE()) THEN MESSAGE(' La anulación se realizó con éxito!!!',,ICON:Tick).
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

