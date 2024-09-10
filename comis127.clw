

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS127.INC'),ONCE        !Local module procedure declarations
                     END


GeneraFacturasAnuladas PROCEDURE                           ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:Fecha            LONG                                  !
loc:Letra            STRING(1)                             !
loc:Lugar            LONG                                  !
loc:NumeroDesde      LONG                                  !
loc:NumeroHasta      LONG                                  !
loc:CodigoSeguridad  STRING(6)                             !
loc:Contador         SHORT                                 !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Anula Facturas'),AT(,,148,159),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,GRAY,DOUBLE
                       PANEL,AT(7,8,133,103),USE(?Panel1),FILL(0EDECE2H),BEVEL(-1)
                       PROMPT('Fecha:'),AT(18,19),USE(?loc:Fecha:Prompt),TRN
                       ENTRY(@d6b),AT(78,19,41,10),USE(loc:Fecha),RIGHT(1),REQ
                       PROMPT('Empresa:'),AT(18,33),USE(?glo:Empresa:Prompt),TRN
                       ENTRY(@n1b),AT(78,33,17,10),USE(glo:Empresa),RIGHT(1),REQ
                       PROMPT('Número Desde:'),AT(18,75),USE(?loc:NumeroDesde:Prompt),TRN
                       ENTRY(@s1),AT(78,47,12,10),USE(loc:Letra),CENTER,REQ,UPR
                       STRING('Punta de Venta:'),AT(18,61),USE(?String1:2),TRN
                       STRING('Letra:'),AT(18,47),USE(?String1),TRN
                       ENTRY(@P<<<<P),AT(78,61,22,10),USE(loc:Lugar),RIGHT(1),REQ
                       ENTRY(@P<<<<<<<<P),AT(78,75,41,10),USE(loc:NumeroDesde),RIGHT(1),REQ
                       PROMPT('Número Hasta:'),AT(18,89),USE(?loc:NumeroHasta:2),TRN
                       ENTRY(@P<<<<<<<<P),AT(78,89,41,10),USE(loc:NumeroHasta),RIGHT(1),REQ
                       BOX,AT(7,117,133,20),USE(?Box1),COLOR(COLOR:Black),FILL(02F2F2FH)
                       PROMPT('Código de Seguridad:'),AT(21,122),USE(?loc:CodigoSeguridad:Prompt),TRN,FONT(,,COLOR:White,,CHARSET:ANSI)
                       ENTRY(@s6),AT(99,122,28,10),USE(loc:CodigoSeguridad),REQ,UPR,PASSWORD
                       BUTTON,AT(96,142,19,14),USE(?OK),FLAT,ICON('C:\1L\Comisiones\botones\ok.gif')
                       BUTTON,AT(121,142,19,14),USE(?Cancel),FLAT,ICON('C:\1L\Comisiones\botones\cancel.gif'),STD(STD:Close)
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
  GlobalErrors.SetProcedureName('GeneraFacturasAnuladas')
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
      CASE MESSAGE('Esta seguro que desea anular las siguientes facturas:|Desde: ' & CLIP(loc:Letra) & ' ' & FORMAT(loc:Lugar,@n04) & '-' & FORMAT(loc:NumeroDesde,@n08) & '|Hasta:  ' & CLIP(loc:Letra) & ' ' & FORMAT(loc:Lugar,@n04) & '-' & FORMAT(loc:NumeroHasta,@n08),'Confirma Anulación!!!',ICON:Question,'Si|No',2,2)
      OF 1
        SETCURSOR(CURSOR:Wait)
        CLEAR(loc:Contador)
        FAC:Empresa = glo:Empresa
        FAC:Comprobante = 'FAC'
        FAC:Letra = loc:Letra
        FAC:Lugar = loc:Lugar
        LOOP I# = loc:NumeroDesde TO loc:NumeroHasta BY 1
          FAC:Numero = I#
          GET(FACTURAS,FAC:Por_Comprobante)
          IF ERRORCODE() THEN
            FAC:Fecha = loc:Fecha
            FAC:Empresa = glo:Empresa
            FAC:Comprobante = 'FAC'
            FAC:Letra = loc:Letra
            FAC:Lugar = loc:Lugar
            FAC:Numero = I#
            FAC:FacturarA = 'R'
            FAC:ClienteFacturar = 0
            FAC:Remitente = 0
            FAC:NombreRemitente = 'ANULADA'
            FAC:ValorDeclarado = 0
            FAC:Neto = 0
            FAC:Seguro = 0
            FAC:IVA = 0
            FAC:Importe = 0
            FAC:Aplicado = 0
            FAC:Impresa = 'S'
            Access:FACTURAS.TryInsert()
            loc:Contador += 1
          END
        END
        SETCURSOR
        IF loc:Contador <> 0 THEN
          MESSAGE('Se anularon ' & CLIP(loc:Contador) & ' facturas con éxito.','Proceso Finalizado!!!',ICON:Tick)
        ELSE
          MESSAGE('No se anuló ninguna factura.','Proceso Finalizado!!!',ICON:Hand)
        END
      OF 2
        CYCLE
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

