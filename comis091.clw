

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS091.INC'),ONCE        !Local module procedure declarations
                     END


AplicaGuias PROCEDURE                                      ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:Comprobante      STRING(20)                            !
loc:ImporteaAplicar  DECIMAL(11,2)                         !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Facturar'),AT(,,175,74),FONT('MS Sans Serif',8,,FONT:regular),CENTER,DOUBLE
                       PANEL,AT(7,5,162,14),USE(?Panel1),FILL(0D5FFFFH)
                       STRING('Remito-Guía Nro.:'),AT(17,8),USE(?String4),TRN
                       STRING(@s20),AT(79,8,86,10),USE(loc:Comprobante),TRN,FONT(,,,FONT:bold)
                       STRING('Importe:'),AT(43,33),USE(?String3),TRN,FONT(,,,FONT:bold)
                       PANEL,AT(7,23,162,31),USE(?Panel2),FILL(0E0EFEFH)
                       ENTRY(@n12.2),AT(81,33,51,10),USE(loc:ImporteaAplicar),RIGHT(1)
                       BUTTON,AT(126,57,19,14),USE(?OkButton),FLAT,ICON('C:\1L\Comisiones\botones\ok.gif')
                       BUTTON,AT(150,57,19,14),USE(?CancelButton),FLAT,ICON('C:\1L\Comisiones\botones\cancel.gif'),STD(STD:Close)
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
? DEBUGHOOK(APLIGUIA:Record)
? DEBUGHOOK(FACTURAS:Record)
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
  GlobalErrors.SetProcedureName('AplicaGuias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIGUIA.SetOpenRelated()
  Relate:APLIGUIA.Open                                     ! File GUIAS used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
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
    Relate:APLIGUIA.Close
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
        BEEP(BEEP:SystemQuestion)  ;  YIELD()
        CASE MESSAGE('Esta seguro que desea aplicar la Guía con importe 0.00 ?','Atención !!!',ICON:Question,'Si|No',2,2)
        OF 2
          SELECT(?loc:ImporteaAplicar)
          CYCLE
        END
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OkButton
      ThisWindow.Update
      APGUIA:Factura = FAC:RegFactura
      APGUIA:Guia = GUIA:RegGuia
      ADD(APLIGUIA)                 !Access:Aplicaciones.Insert()
      IF NOT(ERRORCODE()) THEN
        GUIA:Importe = loc:ImporteaAplicar
        GUIA:Facturada = FAC:Fecha
        Access:Guias.Update()
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
      GUIA:RegGuia = glo:Guia
      GET(GUIAS,GUIA:Por_Registro)
      loc:Comprobante = CLIP(GUIA:Letra) & '  ' & FORMAT(GUIA:Lugar,@N04) & '-' & FORMAT(GUIA:Numero,@N08)
      loc:ImporteaAplicar = glo:ImporteFacturar
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

