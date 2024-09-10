

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS120.INC'),ONCE        !Local module procedure declarations
                     END


SelectCOMPROBANTE PROCEDURE                                ! Generated from procedure template - Window

EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Seleccionar Comprobante'),AT(,,123,75),FONT('MS Sans Serif',8,,FONT:regular),COLOR(0ACFFFFH),CENTER,GRAY,DOUBLE
                       BUTTON('F A C T U R A {10}A'),AT(10,12,103,18),USE(?FacturaA),SKIP,FONT(,,COLOR:Blue,FONT:bold),KEY(AKey)
                       BUTTON('F A C T U R A {10}B'),AT(10,41,103,18),USE(?FacturaB),SKIP,FONT(,,COLOR:Green,FONT:bold),KEY(BKey)
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
? DEBUGHOOK(PARAMETRO:Record)
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
  GlobalErrors.SetProcedureName('SelectCOMPROBANTE')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?FacturaA
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:FACTURAS.SetOpenRelated()
  Relate:FACTURAS.Open                                     ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
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
    Relate:FACTURAS.Close
    Relate:PARAMETRO.Close
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
    OF ?FacturaA
      CLEAR(glo:NumeraFactura)
      PAR:Registro = 1
      GET(PARAMETRO,PAR:Por_Registro)
      
      FAC:Empresa = 1
      FAC:Letra = 'A'
      FAC:Lugar = PAR:LugarFactura
      CLEAR(FAC:Numero)
      SET(FAC:Por_Comprobante,FAC:Por_Comprobante)
      LOOP UNTIL EOF(FACTURAS)
        NEXT(FACTURAS)
        IF ERRORCODE() THEN BREAK.
        IF FAC:Empresa <> 1 THEN BREAK.
        IF FAC:Letra <> 'A' THEN BREAK.
        IF FAC:Lugar <> PAR:LugarFactura THEN BREAK.
        IF glo:NumeraFactura < FAC:Numero THEN glo:NumeraFactura = FAC:Numero.
      END
      glo:NumeraFactura += 1
      glo:LetraFactura = 'A'
      glo:LugarFactura = PAR:LugarFactura
    OF ?FacturaB
      CLEAR(glo:NumeraFactura)
      PAR:Registro = 1
      GET(PARAMETRO,PAR:Por_Registro)
      
      FAC:Empresa = 1
      FAC:Letra = 'B'
      FAC:Lugar = PAR:LugarFactura
      CLEAR(FAC:Numero)
      SET(FAC:Por_Comprobante,FAC:Por_Comprobante)
      LOOP UNTIL EOF(FACTURAS)
        NEXT(FACTURAS)
        IF ERRORCODE() THEN BREAK.
        IF FAC:Empresa <> 1 THEN BREAK.
        IF FAC:Letra <> 'B' THEN BREAK.
        IF FAC:Lugar <> PAR:LugarFactura THEN BREAK.
        IF glo:NumeraFactura < FAC:Numero THEN glo:NumeraFactura = FAC:Numero.
      END
      glo:NumeraFactura += 1
      glo:LetraFactura = 'B'
      glo:LugarFactura = PAR:LugarFactura
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?FacturaA
      ThisWindow.Update
       POST(Event:CloseWindow)
    OF ?FacturaB
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
    CASE EVENT()
    OF EVENT:OpenWindow
      CLEAR(glo:LetraFactura)
      CLEAR(glo:LugarFactura)
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

