

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS122.INC'),ONCE        !Local module procedure declarations
                     END


DepurarBase PROCEDURE                                      ! Generated from procedure template - Window

EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Depurar Base Empresa 2'),AT(,,109,100),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),CENTER,GRAY,DOUBLE
                       BUTTON('GUIAS'),AT(15,12,79,17),USE(?Guias),SKIP,FONT(,,,FONT:bold)
                       BUTTON('FACTURAS'),AT(15,40,79,17),USE(?Facturas),SKIP,FONT(,,,FONT:bold)
                       BUTTON('Redespachos s/Transporte'),AT(7,69,96,17),USE(?Redespacho)
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
? DEBUGHOOK(APLIGUIA:Record)
? DEBUGHOOK(FACTURAS:Record)
? DEBUGHOOK(GUIAS:Record)
? DEBUGHOOK(ITEMFAC:Record)
? DEBUGHOOK(ITEMGUIA:Record)
? DEBUGHOOK(REDESPACHO:Record)
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
  GlobalErrors.SetProcedureName('DepurarBase')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Guias
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIFAC.SetOpenRelated()
  Relate:APLIFAC.Open                                      ! File VALORES used by this procedure, so make sure it's RelationManager is open
  Access:APLIGUIA.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:ITEMFAC.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:ITEMGUIA.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:REDESPACHO.UseFile                                ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:VALORES.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
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
    OF ?Guias
      SETCURSOR(CURSOR:Wait)
      
      STREAM(GUIAS)
      STREAM(ITEMGUIA)
      STREAM(REDESPACHO)
      
      CLEAR(GUIAS)
      SET(GUIA:Por_Registro,GUIA:Por_Registro)
      LOOP UNTIL EOF(GUIAS)
        NEXT(GUIAS)
        IF GUIA:Empresa <> 2 THEN CYCLE.
      
        ITGUIA:RegGuia = GUIA:RegGuia
        CLEAR(ITGUIA:Item)
        SET(ITGUIA:Por_Guia,ITGUIA:Por_Guia)
        LOOP UNTIL EOF(ITEMGUIA)
          NEXT(ITEMGUIA)
          IF ITGUIA:RegGuia <> GUIA:RegGuia THEN BREAK.
          DELETE(ITEMGUIA)
        END
      
        RD:Guia = GUIA:RegGuia
        SET(RD:Por_Guia,RD:Por_Guia)
        LOOP UNTIL EOF(REDESPACHO)
          NEXT(REDESPACHO)
          IF RD:Guia <> GUIA:RegGuia THEN BREAK.
          DELETE(REDESPACHO)
        END
        DELETE(GUIAS)
      END
      
      FLUSH(GUIAS)
      FLUSH(ITEMGUIA)
      FLUSH(REDESPACHO)
      
      SETCURSOR
    OF ?Facturas
      SETCURSOR(CURSOR:Wait)
      
      STREAM(FACTURAS)
      STREAM(ITEMFAC)
      STREAM(APLIFAC)
      STREAM(APLIGUIA)
      STREAM(VALORES)
      
      CLEAR(FACTURAS)
      SET(FAC:Por_Registro,FAC:Por_Registro)
      LOOP UNTIL EOF(FACTURAS)
        NEXT(FACTURAS)
        IF FAC:Empresa <> 2 THEN CYCLE.
      
        ITFAC:RegFactura = FAC:RegFactura
        CLEAR(ITFAC:Item)
        SET(ITFAC:Por_Factura,ITFAC:Por_Factura)
        LOOP UNTIL EOF(ITEMFAC)
          NEXT(ITEMFAC)
          IF ITFAC:RegFactura <> FAC:RegFactura THEN BREAK.
          DELETE(ITEMFAC)
        END
        APGUIA:Factura = FAC:RegFactura
        CLEAR(APGUIA:Guia)
        SET(APGUIA:Por_Factura,APGUIA:Por_Factura)
        LOOP UNTIL EOF(APLIGUIA)
          NEXT(APLIGUIA)
          IF APGUIA:Factura <> FAC:RegFactura THEN BREAK.
          DELETE(APLIGUIA)
        END
        IF FAC:Comprobante = 'REC' THEN
          APFAC:Recibo = FAC:RegFactura
          CLEAR(APFAC:Factura)
          SET(APFAC:Por_Recibo,APFAC:Por_Recibo)
          LOOP UNTIL EOF(APLIFAC)
            NEXT(APLIFAC)
            IF APFAC:Recibo <> FAC:RegFactura THEN BREAK.
            DELETE(APLIFAC)
          END
          VAL:Recibo = FAC:RegFactura
          SET(VAL:Por_Recibo,VAL:Por_Recibo)
          LOOP UNTIL EOF(VALORES)
            NEXT(VALORES)
            IF VAL:Recibo <> FAC:RegFactura THEN BREAK.
            DELETE(VALORES)
          END
        END
        DELETE(FACTURAS)
      END
      FLUSH(FACTURAS)
      FLUSH(ITEMFAC)
      FLUSH(APLIFAC)
      FLUSH(APLIGUIA)
      FLUSH(VALORES)
      
      SETCURSOR
    OF ?Redespacho
      SETCURSOR(CURSOR:Wait)
      STREAM(REDESPACHO)
      
      CLEAR(REDESPACHO)
      SET(RD:Por_Guia,RD:Por_Guia)
      LOOP UNTIL EOF(REDESPACHO)
        NEXT(REDESPACHO)
      
        GUIA:RegGuia = RD:Guia
        GET(GUIAS,GUIA:Por_Registro)
        IF GUIA:Redespacho THEN CYCLE.
      
        DELETE(REDESPACHO)
      END
      FLUSH(REDESPACHO)
      SETCURSOR
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

