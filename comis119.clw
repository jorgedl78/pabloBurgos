

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS119.INC'),ONCE        !Local module procedure declarations
                     END


EmisionRecibo PROCEDURE                                    ! Generated from procedure template - Window

EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Emisión de Recibo'),AT(,,205,53),FONT('MS Sans Serif',8,,FONT:regular),COLOR(080FFFFH),CENTER,DOUBLE
                       STRING('<191>Desea emitir el comprobante de cobro (RECIBO)?'),AT(6,15),USE(?String1),TRN,FONT(,,,FONT:bold)
                       BUTTON('&Si'),AT(64,35,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&No'),AT(106,35,36,14),USE(?CancelButton),STD(STD:Close)
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
? DEBUGHOOK(APLIFAC:Record)
? DEBUGHOOK(FACTURAS:Record)
? DEBUGHOOK(PARAMETRO:Record)
? DEBUGHOOK(RECIBOS:Record)
? DEBUGHOOK(VALORES:Record)
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
  GlobalErrors.SetProcedureName('EmisionRecibo')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIFAC.SetOpenRelated()
  Relate:APLIFAC.Open                                      ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:RECIBOS.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:VALORES.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
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
  IF SELF.FilesOpened
    Relate:APLIFAC.Close
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
    OF ?OkButton
      CLEAR(glo:NumeraFactura)
      PAR:Registro = FAC:Empresa
      GET(PARAMETRO,PAR:Por_Registro)
      
      REC:Empresa = FAC:Empresa
      REC:Comprobante = 'REC'
      SET(REC:Por_Comprobante,REC:Por_Comprobante)
      LOOP UNTIL EOF(RECIBOS)
        NEXT(RECIBOS)
        IF ERRORCODE() THEN BREAK.
        IF REC:Empresa <> FAC:Empresa THEN BREAK.
        IF REC:Comprobante <> 'REC' THEN BREAK.
        IF REC:Letra = 'X' AND REC:Lugar = PAR:LugarFactura AND glo:NumeraFactura < REC:Numero THEN
          glo:NumeraFactura = REC:Numero
        END
      END
      glo:NumeraFactura += 1
      
      ! GENERACION DE RECIBO
      STREAM(RECIBOS)
      CLEAR(RECIBOS)
      REC:Fecha = FAC:Fecha
      REC:Empresa = FAC:Empresa
      REC:Comprobante = 'REC'
      REC:Letra = 'X'
      REC:Lugar = FAC:Lugar
      REC:Numero = glo:NumeraFactura
      REC:FacturarA = ''
      REC:ClienteFacturar = FAC:ClienteFacturar
      REC:Remitente = 0
      REC:NombreRemitente = ''
      REC:CUITRemitente = ''
      REC:DireccionRemitente = ''
      REC:LocalidadRemitente = ''
      REC:TelefonoRemitente = ''
      REC:Destinatario = 0
      REC:NombreDestino = ''
      REC:CUITDestino = ''
      REC:DireccionDestino = ''
      REC:LocalidadDestino = ''
      REC:TelefonoDestino = ''
      REC:Distribuidor = FAC:Distribuidor
      REC:TipoServicio = ''
      REC:Flete = ''
      REC:ValorDeclarado = 0
      REC:Neto = 0
      REC:Seguro = 0
      REC:IVA = 0
      REC:Importe = FAC:Importe * -1
      REC:Aplicado = FAC:Importe
      REC:Impresa = 'N'
      REC:Cobrada = ''
      REC:Observacion = ''
      Access:RECIBOS.TryInsert()
      
      APFAC:Recibo = REC:RegFactura
      APFAC:Factura = FAC:RegFactura
      APFAC:Fecha = FAC:Fecha
      APFAC:Comprobante = CLIP(FAC:Comprobante) & ' ' & CLIP(FAC:Letra) & FORMAT(FAC:Lugar,@n04) & '-' & FORMAT(FAC:Numero,@n08)
      APFAC:ImporteAplicado = FAC:Importe * -1
      Access:APLIFAC.TryInsert()
      
      VAL:Recibo = REC:RegFactura
      VAL:Tipo = 'Efectivo'
      VAL:Banco = ''
      VAL:Numero = 0
      VAL:Fecha = 0
      VAL:Importe = FAC:Importe
      Access:VALORES.TryInsert()
      
      FLUSH(RECIBOS)
      
      glo:Dia = 1
      POST(EVENT:CloseWindow)
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

