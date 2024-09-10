

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS060.INC'),ONCE        !Local module procedure declarations
                     END


AplicaFactura PROCEDURE                                    ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:Comprobante      STRING(20)                            !
loc:SaldoComprobante DECIMAL(9,2)                          !
loc:ImporteaAplicar  DECIMAL(9,2)                          !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Aplicación'),AT(,,203,97),FONT('MS Sans Serif',8,,FONT:regular),CENTER,DOUBLE
                       PANEL,AT(7,5,188,14),USE(?Panel1),FILL(0D5FFFFH)
                       STRING('Saldo Pendiente de Aplicar:'),AT(41,8),USE(?String4),TRN
                       STRING(@n-13.2),AT(138,8),USE(glo:SaldoaAplicar),TRN,RIGHT(1)
                       STRING(@s20),AT(70,39,79,10),USE(loc:Comprobante),TRN
                       STRING('Importe a Aplicar:'),AT(61,60),USE(?String3),TRN,FONT(,,,FONT:bold)
                       PANEL,AT(7,23,188,54),USE(?Panel2),FILL(0E0EFEFH)
                       STRING('Importe Pendiente de Aplicar'),AT(14,29),USE(?String5),TRN
                       STRING(@n12.2),AT(141,39),USE(loc:SaldoComprobante),TRN,RIGHT(1)
                       STRING('del Comprobante:'),AT(14,39),USE(?String5:2),TRN
                       ENTRY(@n12.2),AT(136,60,51,10),USE(loc:ImporteaAplicar),RIGHT(1)
                       BUTTON,AT(149,80,19,14),USE(?OkButton),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\ok.gif')
                       BUTTON,AT(174,80,19,14),USE(?CancelButton),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\cancel.gif'),STD(STD:Close)
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
? DEBUGHOOK(RECIBOS:Record)
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
  GlobalErrors.SetProcedureName('AplicaFactura')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIFAC.SetOpenRelated()
  Relate:APLIFAC.Open                                      ! File RECIBOS used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:RECIBOS.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
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
      IF loc:ImporteaAplicar = 0 THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('El importe a aplicar no puede ser 0.00',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?loc:ImporteaAplicar)
        CYCLE
      .
      
      IF loc:ImporteaAplicar > glo:SaldoaAplicar THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('El importe a aplicar no puede ser mayor que|el saldo pendiente de aplicar del Recibo ($ ' & CLIP(FORMAT(glo:SaldoaAplicar,@n12.2)) & ')',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?loc:ImporteaAplicar)
        CYCLE
      .
      
      IF loc:ImporteaAplicar > loc:SaldoComprobante THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('El importe a aplicar no puede ser mayor que|el importe pendiente de aplicar del Comprobante ($ ' & CLIP(FORMAT(loc:SaldoComprobante,@n12.2)) & ')',|
                'Atención !!!',ICON:Exclamation)
        SELECT(?loc:ImporteaAplicar)
        CYCLE
      .
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OkButton
      ThisWindow.Update
      APFAC:Recibo = FAC:RegFactura
      APFAC:Factura = REC:RegFactura
      APFAC:Fecha = REC:Fecha
      APFAC:Comprobante = REC:Comprobante & ' ' & CLIP(REC:Letra) & FORMAT(REC:Lugar,@N04) & '-' & FORMAT(REC:Numero,@N08)
      APFAC:ImporteAplicado = loc:ImporteaAplicar * -1
      ADD(APLIFAC)                 !Access:Aplicaciones.Insert()
      IF NOT(ERRORCODE()) THEN
        loc:ImporteaAplicar *= -1
        REC:Aplicado += loc:ImporteaAplicar
        Access:Recibos.Update()
      ELSE
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE('El comprobante seleccionado ya fue aplicado.|Si desea volver a aplicar el comprobante con otro importe selecciónelo|en Comprobantes Aplicados y presione el boton "Sacar de Aplicación".',|
                'Comprobante ya aplicado',ICON:Exclamation)
        CYCLE
      .
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
      loc:Comprobante = REC:Comprobante & ' ' & CLIP(REC:Letra) & FORMAT(REC:Lugar,@N04) & '-' & FORMAT(REC:Numero,@N08)
      loc:SaldoComprobante = REC:Importe + REC:Aplicado
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

