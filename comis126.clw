

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS126.INC'),ONCE        !Local module procedure declarations
                     END


CITIVentas PROCEDURE                                       ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:CodigoSeguridad  STRING(6)                             !
loc:Archivo          STRING(40)                            !
loc:archivoA         STRING(40)                            !archivo de alicuotas de venta
loc:SumaCUIT         DECIMAL(7,2)                          !
loc:DigitoVerificador BYTE                                 !
loc:Error            BYTE                                  !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Generaci�n Archivo CITI Ventas'),AT(,,139,91),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,GRAY,DOUBLE
                       PANEL,AT(8,9,123,20),USE(?Panel1),FILL(0EDECE2H),BEVEL(-1)
                       STRING('Empresa:'),AT(36,15),USE(?String2),TRN
                       SPIN(@n1b),AT(72,15,26,10),USE(glo:Empresa),CENTER,REQ,RANGE(1,3),STEP(2)
                       PANEL,AT(8,33,123,36),USE(?Panel2),FILL(0EDECE2H),BEVEL(-1)
                       PROMPT('Fecha Desde:'),AT(20,39),USE(?glo:FechaDesde:Prompt),TRN
                       ENTRY(@d6b),AT(72,39,49,10),USE(glo:FechaDesde),RIGHT(1),REQ
                       PROMPT('Fecha Hasta:'),AT(22,54),USE(?glo:FechaHasta:Prompt),TRN
                       ENTRY(@d6b),AT(72,54,49,10),USE(glo:FechaHasta),RIGHT(1),REQ
                       BUTTON,AT(92,75,17,14),USE(?OkButton),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\ok.gif')
                       BUTTON,AT(113,75,17,14),USE(?CancelButton),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\cancel.gif'),STD(STD:Close)
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
? DEBUGHOOK(CITI:Record)
? DEBUGHOOK(CITIA:Record)
? DEBUGHOOK(CLIENTES:Record)
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
  GlobalErrors.SetProcedureName('CITIVentas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  REMOVE(CITI)
  REMOVE(CITIA)
  Relate:CITI.Open                                         ! File CITIA used by this procedure, so make sure it's RelationManager is open
  Relate:CITIA.Open                                        ! File CITIA used by this procedure, so make sure it's RelationManager is open
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CITIA used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File CITIA used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'�',8)
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
    Relate:CITI.Close
    Relate:CITIA.Close
    Relate:CLIENTES.Close
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
      IF INCOMPLETE() THEN CYCLE.
      PAR:Registro = glo:Empresa
      GET(PARAMETRO,PAR:Por_Registro)
      loc:Archivo = 'CITI_' & FORMAT(YEAR(glo:FechaDesde),@N04) & FORMAT(MONTH(glo:FechaDesde),@N02) & '-' & PAR:LugarFactura & '.TXT'
      REMOVE('CITIVentas\' & loc:Archivo)
      loc:ArchivoA = 'CITIA_' & FORMAT(YEAR(glo:FechaDesde),@N04) & FORMAT(MONTH(glo:FechaDesde),@N02) & '-' & PAR:LugarFactura & '.TXT'
      REMOVE('CITIVentas\' & loc:ArchivoA)
      ! GENERACION DE ARCHIVO 'CITI VENTAS'
      SETCURSOR(CURSOR:Wait)
      loc:Error = 0
      
      FAC:Fecha = glo:FechaDesde
      FAC:Empresa = glo:Empresa
      CLEAR(FAC:Comprobante)
      CLEAR(FAC:Lugar)
      CLEAR(FAC:Numero)
      SET(FAC:Por_Comprobante,FAC:Por_Comprobante)
      LOOP UNTIL EOF(FACTURAS)
        NEXT(FACTURAS)
        IF FAC:Empresa <> glo:Empresa THEN BREAK.
        IF FAC:Fecha > glo:FechaHasta THEN BREAK.
        IF FAC:Fecha < glo:FechaDesde THEN CYCLE.
        IF FAC:Comprobante = 'REC' THEN CYCLE.
        IF (FAC:FacturarA='R' AND FAC:NombreRemitente='ANULADA') OR (FAC:FacturarA='D' AND FAC:NombreDestino='ANULADA') THEN CYCLE.
      
        CITI:Registro = '1' & FORMAT(YEAR(FAC:Fecha),@n04) & FORMAT(MONTH(FAC:Fecha),@n02) & FORMAT(DAY(FAC:Fecha),@n02)
      
        IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '01'.
        IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '06'.
      
      !  CASE FAC:Comprobante
      !  OF 'FAC'
      !    IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '01'.
      !    IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '06'.
      !  OF 'ND'
      !    IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '02'.
      !    IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '07'.
      !  OF 'NC'
      !    IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '03'.
      !    IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '08'.
      !  END
      
        CITI:Registro = CLIP(CITI:Registro) & ' ' & FORMAT(FAC:Lugar,@n04) & FORMAT(FAC:Numero,@n020) & FORMAT(FAC:Numero,@n020)
      
        IF FAC:FacturarA = 'R' THEN
          IF FAC:CategIVARemitente <> 5 THEN
            !-----VALIDA CUIT-------
            IF NOT(FAC:CUITRemitente) OR FAC:CUITRemitente = 0 THEN
              BEEP(BEEP:SystemHand)  ;  YIELD()
              MESSAGE('Comprobante: ' & FORMAT(FAC:Letra,@s1) & FORMAT(FAC:Lugar,@n04) & ' ' & FORMAT(FAC:Numero,@n08),'CUIT Faltante !!!',ICON:Hand)
              loc:Error = 1
              BREAK
            END
            I# = 1
            CLEAR(loc:SumaCUIT)
            LOOP C# = 10 TO 1 BY -1
              IF I# = 7 THEN I# = 1.
              I# += 1
              loc:SumaCUIT += SUB(FAC:CUITRemitente,C#,1) * I#
            END
            loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
            IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
            IF loc:DigitoVerificador <> SUB(FAC:CUITRemitente,11,1) THEN
              BEEP(BEEP:SystemHand)  ;  YIELD()
              MESSAGE('Comprobante: ' & FORMAT(FAC:Letra,@s1) & FORMAT(FAC:Lugar,@n04) & ' ' & FORMAT(FAC:Numero,@n08),'CUIT Erroneo !!!',ICON:Hand)
              loc:Error = 1
              BREAK
            END
            !-----------------------
            CITI:Registro = CLIP(CITI:Registro) & '80' & FORMAT(FAC:CUITRemitente,@n011)
          ELSE
            CITI:Registro = CLIP(CITI:Registro) & '99' & '00000000000'
          END
        ELSE
          IF FAC:CategIVADestino <> 5 THEN
            !-----VALIDA CUIT-------
            IF NOT(FAC:CUITDestino) OR FAC:CUITDestino = 0 THEN
              BEEP(BEEP:SystemHand)  ;  YIELD()
              MESSAGE('Comprobante: ' & FORMAT(FAC:Letra,@s1) & FORMAT(FAC:Lugar,@n04) & ' ' & FORMAT(FAC:Numero,@n08),'CUIT Faltante !!!',ICON:Hand)
              loc:Error = 1
              BREAK
            END
            I# = 1
            CLEAR(loc:SumaCUIT)
            LOOP C# = 10 TO 1 BY -1
              IF I# = 7 THEN I# = 1.
              I# += 1
              loc:SumaCUIT += SUB(FAC:CUITDestino,C#,1) * I#
            END
            loc:DigitoVerificador = 11 - (loc:SumaCUIT % 11)
            IF loc:DigitoVerificador = 11 THEN loc:DigitoVerificador = 0.
      
            IF loc:DigitoVerificador <> SUB(FAC:CUITDestino,11,1) THEN
              BEEP(BEEP:SystemHand)  ;  YIELD()
              MESSAGE('Comprobante: ' & FORMAT(FAC:Letra,@s1) & FORMAT(FAC:Lugar,@n04) & ' ' & FORMAT(FAC:Numero,@n08),'CUIT Erroneo !!!',ICON:Hand)
              loc:Error = 1
              BREAK
            END
            !-----------------------
            CITI:Registro = CLIP(CITI:Registro) & '80' & FORMAT(FAC:CUITDestino,@n011)
          ELSE
            CITI:Registro = CLIP(CITI:Registro) & '99' & '00000000000'
          END
        END
      
        IF FAC:FacturarA = 'R' THEN
          CITI:Registro = CLIP(CITI:Registro) & FORMAT(FAC:NombreRemitente,@s30) & FORMAT((FAC:Importe * 100),@n015) & '000000000000000'
        END
        IF FAC:FacturarA = 'D' THEN
          CITI:Registro = CLIP(CITI:Registro) & FORMAT(FAC:NombreDestino,@s30) & FORMAT((FAC:Importe * 100),@n015) & '000000000000000'
        END
      
        IF FAC:IVA <> 0 THEN
          IF FAC:FacturarA = 'R' THEN
            IF FAC:CategIVARemitente <> 5 THEN
              CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro) * 100),@n015) & '2100' & FORMAT((FAC:IVA * 100),@n015)
            ELSE
              CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro+FAC:IVA) * 100),@n015) & '0000' & '000000000000000'
            END
          END
          IF FAC:FacturarA = 'D' THEN
            IF FAC:CategIVADestino <> 5 THEN
              CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro) * 100),@n015) & '2100' & FORMAT((FAC:IVA * 100),@n015)
            ELSE
              CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro+FAC:IVA) * 100),@n015) & '0000' & '000000000000000'
            END
          END
        ELSE
          CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro) * 100),@n015) & '0000' & '000000000000000'
        END
      
        CITI:Registro = CLIP(CITI:Registro) & '000000000000000' & '000000000000000' & '000000000000000' & '000000000000000' & '000000000000000' & '000000000000000'
        CITI:Registro = CLIP(CITI:Registro) & '00' & '   ' & '0000000000' & '1' & ' ' & '00000000000000' & '00000000' & '00000000'
        CITI:Registro = CLIP(CITI:Registro) & '                                                                           ' & '00000000' & '000000000000000'
      
        Access:CITI.Insert()
      
        !**************** Agrego la linea en el archivo de alicuotas ************************************+
      
      
        IF FAC:Letra = 'A' THEN CITIA:Registro = CLIP(CITI:Registro) & '001'.
        IF FAC:Letra = 'B' THEN CITIA:Registro = CLIP(CITI:Registro) & '006'.
        CITIA:Registro = CLIP(CITI:Registro) & FORMAT(FAC:Lugar,@N05)
        CITIA:Registro = CLIP(CITI:Registro) & FORMAT(FAC:Numero,@N020)
        CITIA:Registro = CLIP(CITI:Registro) & FORMAT((FAC:Neto+FAC:Seguro) * 100,@N015)
        CITIA:Registro = CLIP(CITI:Registro) & FORMAT(FAC:IVA * 100,@N015)
        Access:CITIA.Insert()
      
      
      END
      Access:CITI.Close
      SETCURSOR
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OkButton
      ThisWindow.Update
      IF loc:Error <> 1 THEN
        loc:Archivo = 'CITI_' & FORMAT(YEAR(glo:FechaDesde),@N04) & FORMAT(MONTH(glo:FechaDesde),@N02) & '-' & PAR:LugarFactura & '.TXT'
        RENAME('CITI','CITIVentas\' & loc:Archivo)
        loc:ArchivoA = 'CITIA_' & FORMAT(YEAR(glo:FechaDesde),@N04) & FORMAT(MONTH(glo:FechaDesde),@N02) & '-' & PAR:LugarFactura & '.TXT'
        RENAME('CITIA','CITIVentas\' & loc:Archivo)
        MESSAGE('Se han generado los archivo:s ' & CLIP(loc:Archivo) & ' y ' & CLIP(loc:ArchivoA),'Proceso Finalizado!!!')
      END
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
