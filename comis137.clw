

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS137.INC'),ONCE        !Local module procedure declarations
                     END


Regimen_de_Compras_y_Ventas PROCEDURE                      ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
Loc:ArchivoVentas    STRING(40)                            !
loc:ArchivoVentasAlicuotas STRING(40)                      !
loc:ArchivoCompras   STRING(40)                            !
loc:ArchivoComprasAlicuotas STRING(40)                     !
loc:CodigoSeguridad  STRING(6)                             !
loc:Archivo          STRING(40)                            !
loc:SumaCUIT         DECIMAL(7,2)                          !
loc:DigitoVerificador BYTE                                 !
loc:Error            BYTE                                  !
loc:RegistroAlicuotasCompras STRING(100)                   !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Regimen de Compras y Ventas'),AT(,,141,91),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),CENTER,GRAY,DOUBLE
                       PANEL,AT(8,9,123,20),USE(?Panel1),FILL(0EDECE2H),BEVEL(-1)
                       STRING('Empresa:'),AT(36,15),USE(?String2),TRN
                       SPIN(@n1b),AT(72,15,26,10),USE(glo:Empresa),CENTER,REQ,RANGE(1,3),STEP(2)
                       PANEL,AT(8,33,123,36),USE(?Panel2),FILL(0EDECE2H),BEVEL(-1)
                       PROMPT('Fecha Desde:'),AT(20,39),USE(?glo:FechaDesde:Prompt),TRN
                       ENTRY(@d6b),AT(72,39,49,10),USE(glo:FechaDesde),RIGHT(1),REQ
                       PROMPT('Fecha Hasta:'),AT(22,54),USE(?glo:FechaHasta:Prompt),TRN
                       ENTRY(@d6b),AT(72,54,49,10),USE(glo:FechaHasta),RIGHT(1),REQ
                       BUTTON,AT(92,75,17,14),USE(?OkButton),FLAT,ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico')
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
? DEBUGHOOK(CITIC:Record)
? DEBUGHOOK(CITICA:Record)
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(FACPROV:Record)
? DEBUGHOOK(FACTURAS:Record)
? DEBUGHOOK(PARAMETRO:Record)
? DEBUGHOOK(PROVEEDORES:Record)
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
  GlobalErrors.SetProcedureName('Regimen_de_Compras_y_Ventas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:CITI.Open                                         ! File PROVEEDORES used by this procedure, so make sure it's RelationManager is open
  Relate:CITIA.Open                                        ! File PROVEEDORES used by this procedure, so make sure it's RelationManager is open
  Relate:CITIC.Open                                        ! File PROVEEDORES used by this procedure, so make sure it's RelationManager is open
  Relate:CITICA.Open                                       ! File PROVEEDORES used by this procedure, so make sure it's RelationManager is open
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File PROVEEDORES used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PROVEEDORES used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:FACPROV.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:PROVEEDORES.UseFile                               ! File referenced in 'Other Files' so need to inform it's FileManager
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
    Relate:CITI.Close
    Relate:CITIA.Close
    Relate:CITIC.Close
    Relate:CITICA.Close
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
      loc:ArchivoVentas = 'RV_' & PAR:CUIT & FORMAT(MONTH(glo:FechaDesde),@N02) & FORMAT(YEAR(glo:FechaDesde),@N04) & '.TXT'
      loc:ArchivoVentasAlicuotas = 'RVA_' & PAR:CUIT & FORMAT(MONTH(glo:FechaDesde),@N02) & FORMAT(YEAR(glo:FechaDesde),@N04) & '.TXT'
      loc:ArchivoCompras = 'RC_' & PAR:CUIT & FORMAT(MONTH(glo:FechaDesde),@N02) & FORMAT(YEAR(glo:FechaDesde),@N04) & '.TXT'
      loc:ArchivoComprasAlicuotas = 'RCA_' & PAR:CUIT & FORMAT(MONTH(glo:FechaDesde),@N02) & FORMAT(YEAR(glo:FechaDesde),@N04) & '.TXT'
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OkButton
      ThisWindow.Update
      ! GENERACION DE ARCHIVO 'COMPROBANTES DE VENTAS'
      SETCURSOR(CURSOR:Wait)
      loc:Error = 0
      
      FAC:Fecha = glo:FechaDesde
      FAC:Empresa = glo:Empresa
      CLEAR(FAC:Comprobante)
      CLEAR(FAC:Lugar)
      CLEAR(FAC:Numero)
      SET(FAC:Por_FechaA,FAC:Por_FechaA)
      LOOP UNTIL EOF(FACTURAS)
        NEXT(FACTURAS)
        IF FAC:Empresa = glo:Empresa THEN !BREAK.
            IF FAC:Fecha > glo:FechaHasta THEN BREAK.
            IF FAC:Fecha < glo:FechaDesde THEN CYCLE.
            IF FAC:Comprobante = 'REC' THEN CYCLE.
            IF FAC:FE=0 THEN CYCLE.
            !IF (FAC:FacturarA='R' AND FAC:NombreRemitente='ANULADA') OR (FAC:FacturarA='D' AND FAC:NombreDestino='ANULADA') THEN CYCLE.
      
            CITI:Registro = FORMAT(YEAR(FAC:Fecha),@n04) & FORMAT(MONTH(FAC:Fecha),@n02) & FORMAT(DAY(FAC:Fecha),@n02)
      
      !      IF FAC:Comprobante='FAC' THEN
      !          IF FAC:Letra = 'A' THEN CITIA:Registro = '001'.
      !          IF FAC:Letra = 'B' THEN CITIA:Registro = '006'.
      !      END
      !      IF FAC:Comprobante='NC' THEN
      !          IF FAC:Letra = 'A' THEN CITIA:Registro = '003'.
      !          IF FAC:Letra = 'B' THEN CITIA:Registro = '008'.
      !      END
      
            CASE FAC:Comprobante
            OF 'FAC'
              IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '001'.
              IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '006'.
            OF 'ND'
              IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '002'.
              IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '007'.
            OF 'NC'
              IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '003'.
              IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '008'.
            END
      
            CITI:Registro = CLIP(CITI:Registro) & FORMAT(FAC:Lugar,@n05) & FORMAT(FAC:Numero,@n020) & FORMAT(FAC:Numero,@n020)
      
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
                CITI:Registro = CLIP(CITI:Registro) & '80' & FORMAT(FAC:CUITRemitente,@n020)
              ELSE
                CITI:Registro = CLIP(CITI:Registro) & '99' & '0000000000000000000'
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
                CITI:Registro = CLIP(CITI:Registro) & '80' & FORMAT(FAC:CUITDestino,@n020)
              ELSE
                CITI:Registro = CLIP(CITI:Registro) & '99' & '00000000000000000000'
              END
            END
      
            IF FAC:FacturarA = 'R' THEN
              CITI:Registro = CLIP(CITI:Registro) & FORMAT(FAC:NombreRemitente,@s30) & FORMAT((FAC:Importe * 100),@n015) & '000000000000000'
            END
            IF FAC:FacturarA = 'D' THEN
              CITI:Registro = CLIP(CITI:Registro) & FORMAT(FAC:NombreDestino,@s30) & FORMAT((FAC:Importe * 100),@n015) & '000000000000000'
            END
      
            CITI:Registro = CLIP(CITI:Registro) & '000000000000000'
            CITI:Registro = CLIP(CITI:Registro) & '000000000000000'
            CITI:Registro = CLIP(CITI:Registro) & '000000000000000'
            CITI:Registro = CLIP(CITI:Registro) & '000000000000000'
            CITI:Registro = CLIP(CITI:Registro) & '000000000000000'
            CITI:Registro = CLIP(CITI:Registro) & '000000000000000'
            CITI:Registro = CLIP(CITI:Registro) & 'PES'
            CITI:Registro = CLIP(CITI:Registro) & '0001000000'
            CITI:Registro = CLIP(CITI:Registro) & '1'
            CITI:Registro = CLIP(CITI:Registro) & 'A'
            CITI:Registro = CLIP(CITI:Registro) & '000000000000000'
            CITI:Registro = CLIP(CITI:Registro) & '00000000'
      
          !  IF FAC:IVA <> 0 THEN
          !    IF FAC:FacturarA = 'R' THEN
          !      IF FAC:CategIVARemitente <> 5 THEN
          !        CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro) * 100),@n015) & '2100' & FORMAT((FAC:IVA * 100),@n015)
          !      ELSE
          !        CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro+FAC:IVA) * 100),@n015) & '0000' & '000000000000000'
          !      END
          !    END
          !    IF FAC:FacturarA = 'D' THEN
          !      IF FAC:CategIVADestino <> 5 THEN
          !        CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro) * 100),@n015) & '2100' & FORMAT((FAC:IVA * 100),@n015)
          !      ELSE
          !        CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro+FAC:IVA) * 100),@n015) & '0000' & '000000000000000'
          !      END
          !    END
          !  ELSE
          !    CITI:Registro = CLIP(CITI:Registro) & FORMAT(((FAC:Neto+FAC:Seguro) * 100),@n015) & '0000' & '000000000000000'
          !  END
      
            Access:CITI.Insert()
        END !IF FAC:Empresa = glo:Empresa
      END
      Access:CITI.Close
      
      COPY('C:\Afip\CITI.TXT','C:\Afip\' & loc:ArchivoVentas)
      
      setcursor(0)
      ! GENERACION DE ARCHIVO 'ALICUOTAS DE VENTAS'
      SETCURSOR(CURSOR:Wait)
      loc:Error = 0
      
      FAC:Fecha = glo:FechaDesde
      FAC:Empresa = glo:Empresa
      CLEAR(FAC:Comprobante)
      CLEAR(FAC:Lugar)
      CLEAR(FAC:Numero)
      SET(FAC:Por_FechaA,FAC:Por_FechaA)
      clear(CITIA:Record)
      LOOP UNTIL EOF(FACTURAS)
        NEXT(FACTURAS)
        IF FAC:Empresa = glo:Empresa THEN !BREAK.
            IF FAC:Fecha > glo:FechaHasta THEN BREAK.
            IF FAC:Fecha < glo:FechaDesde THEN CYCLE.
            IF FAC:Comprobante = 'REC' THEN CYCLE.
            IF FAC:FE=0 THEN CYCLE.
            !IF (FAC:FacturarA='R' AND FAC:NombreRemitente='ANULADA') OR (FAC:FacturarA='D' AND FAC:NombreDestino='ANULADA') THEN CYCLE.
      
            IF FAC:Comprobante='FAC' THEN
                IF FAC:Letra = 'A' THEN CITIA:Registro = '001'.
                IF FAC:Letra = 'B' THEN CITIA:Registro = '006'.
            END
            IF FAC:Comprobante='NC' THEN
                IF FAC:Letra = 'A' THEN CITIA:Registro = '003'.
                IF FAC:Letra = 'B' THEN CITIA:Registro = '008'.
            END
      
      
      !      CASE FAC:Comprobante
      !      OF 'FAC'
      !        IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '001'.
      !        IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '006'.
      !      OF 'ND'
      !        IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '002'.
      !        IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '007'.
      !      OF 'NC'
      !        IF FAC:Letra = 'A' THEN CITI:Registro = CLIP(CITI:Registro) & '003'.
      !        IF FAC:Letra = 'B' THEN CITI:Registro = CLIP(CITI:Registro) & '008'.
      !      END
      
            CITIA:Registro = CLIP(CITIA:Registro) & FORMAT(FAC:Lugar,@n05) & FORMAT(FAC:Numero,@n020)
            CITIA:Registro = CLIP(CITIA:Registro) & FORMAT((FAC:Neto * 100),@n015)
      
            IF (FAC:Neto * 1.21) = FAC:Importe THEN
              iva"='0005'
            ELSE
              iva"='0004'
            END
            CITIA:Registro = CLIP(CITIA:Registro) & CLIP(IVA")
            CITIA:Registro = CLIP(CITIA:Registro) & FORMAT((FAC:IVA * 100),@n015)
      
            Access:CITIA.Insert()
        END !IF FAC:Empresa = glo:Empresa
      END
      Access:CITI.Close
      
      COPY('C:\Afip\CITIA.TXT','C:\Afip\' & loc:ArchivoVentasAlicuotas)
      
      setcursor(0)
      ! GENERACION DE ARCHIVO 'COMPROBANTES DE COMPRAS'
      SETCURSOR(CURSOR:Wait)
      loc:Error = 0
      
      FCP:FechaPresentacion = glo:FechaDesde
      FCP:Empresa = glo:Empresa
      CLEAR(FCP:Comprobante)
      CLEAR(FCP:Lugar)
      CLEAR(FCP:Numero)
      
      SET(FCP:Por_Fecha_Presentacion,FCP:Por_Fecha_Presentacion)
      LOOP UNTIL EOF(FACPROV)
        NEXT(FACPROV)
      
        IF FCP:Empresa = glo:Empresa THEN !CYCLE.
            IF FCP:FechaPresentacion > glo:FechaHasta THEN CYCLE.
            IF FCP:FechaPresentacion < glo:FechaDesde THEN CYCLE.
      
            CITIC:Registro = FORMAT(YEAR(FCP:FechaPresentacion),@n04) & FORMAT(MONTH(FCP:FechaPresentacion),@n02) & FORMAT(DAY(FCP:FechaPresentacion),@n02)  !Fecha de presentacion
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:Comprobante,@n03) !Codigo de comprobante
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:Lugar,@n05) !Punto de venta
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:Numero,@n020) !Numero de comprobante
            
      
            !busco los datos del proveedor
            documento$=''
            CLEAR(PROV:Record)
            PROV:CodProveedor=FCP:CodProveedor
            set(PROVEEDORES,PROV:Por_CodProveedor)
            NEXT(PROVEEDORES)
      
            IF PROV:CUIT<>'' then documento$=80.
            CITIC:Registro = CLIP(CITIC:Registro) & ALL(' ',16) & FORMAT(documento$,@n02) !Tipo documento del poveedor
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(PROV:CUIT,@n020) !Numero de documento del proveedor
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(PROV:Nombre,@S30) &  FORMAT(FCP:Importe * 100,@n015) !Nombre o denominacion del proveedor + Importe total
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:NoGravado * 100,@n015) ! Importe neto no gravado
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:Exento * 100,@n015) ! Importe exento
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:PercepIVA * 100,@n015) ! Percepciones iva
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:PercepOtros * 100,@n015) ! Percepciones impuestos nacionales
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:PercepIB * 100,@n015) ! percepciones iibb
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:PercepMunicipal * 100,@n015) ! percepciones impuestos municipales
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT(FCP:ImpuestosInternos * 100,@n015) ! impuestos internos
            CITIC:Registro = CLIP(CITIC:Registro) & 'PES' !Codigo moneda
            CITIC:Registro = CLIP(CITIC:Registro) & '0001000000' !Tipo cambio
      
            cantidadAlicuotas$=0
            if FCP:Iva10>0 then cantidadAlicuotas$+=1.
            if FCP:Iva21>0 then cantidadAlicuotas$+=1.
            if FCP:Iva27>0 then cantidadAlicuotas$+=1.
            CITIC:Registro = CLIP(CITIC:Registro) & cantidadAlicuotas$
            CITIC:Registro = CLIP(CITIC:Registro) & 'A' !codigo de operacion
            CITIC:Registro = CLIP(CITIC:Registro) & FORMAT((FCP:Iva10+FCP:Iva21+FCP:Iva27) * 100,@n015) !Credito fiscal computable
            CITIC:Registro = CLIP(CITIC:Registro) & '000000000000000' !Otros tributos
            CITIC:Registro = CLIP(CITIC:Registro) & '00000000000' !CUIT emisor/corredor
            CITIC:Registro = CLIP(CITIC:Registro) & ALL(' ',30) & '000000000000000' !Denominacion del emisor + Iva comision
            
      
      
            Access:CITIC.Insert()
        END !FCP:Empresa = glo:Empresa THEN
      END
      Access:CITIC.Close
      
      COPY('C:\Afip\CITIC.TXT','C:\Afip\' & loc:ArchivoCompras)
      
      setcursor(0)
      ! GENERACION DE ARCHIVO 'ALICUOTAS DE COMPRAS'
      SETCURSOR(CURSOR:Wait)
      loc:Error = 0
      
      FCP:FechaPresentacion = glo:FechaDesde
      FCP:Empresa = glo:Empresa
      CLEAR(FCP:Comprobante)
      CLEAR(FCP:Lugar)
      CLEAR(FCP:Numero)
      SET(FCP:Por_Fecha_Presentacion,FCP:Por_Fecha_Presentacion)
      LOOP UNTIL EOF(FACPROV)
        NEXT(FACPROV)
        CLEAR(CITICA:Registro)
        IF FCP:Empresa = glo:Empresa THEN !CYCLE.
            loc:RegistroAlicuotasCompras=''
            IF FCP:FechaPresentacion > glo:FechaHasta THEN CYCLE.
            IF FCP:FechaPresentacion < glo:FechaDesde THEN CYCLE.
      
            loc:RegistroAlicuotasCompras = CLIP(loc:RegistroAlicuotasCompras) & FORMAT(FCP:Comprobante,@n03) !Codigo de comprobante
            loc:RegistroAlicuotasCompras = CLIP(loc:RegistroAlicuotasCompras) & FORMAT(FCP:Lugar,@n05) !Punto de venta
            loc:RegistroAlicuotasCompras = CLIP(loc:RegistroAlicuotasCompras) & FORMAT(FCP:Numero,@n020) !Numero de comprobante
            
      
            !busco los datos del proveedor
            documento$=''
            CLEAR(PROV:Record)
            PROV:CodProveedor=FCP:CodProveedor
            set(PROVEEDORES,PROV:Por_CodProveedor)
            NEXT(PROVEEDORES)
      
            IF PROV:CUIT<>'' then documento$=80.
            loc:RegistroAlicuotasCompras = CLIP(loc:RegistroAlicuotasCompras) & FORMAT(documento$,@n02) !Tipo documento del poveedor
            loc:RegistroAlicuotasCompras = CLIP(loc:RegistroAlicuotasCompras) & FORMAT(PROV:CUIT,@n020) !Numero de documento del proveedor
            loc:RegistroAlicuotasCompras = CLIP(loc:RegistroAlicuotasCompras) & FORMAT(FCP:NetoGravado * 100,@n015) ! Importe neto no gravado
            codigoAlicuota"='0000'
            IF FCP:Iva10>0 THEN !codigoAlicuota" = '0004'.
              CITICA:Registro = CLIP(loc:RegistroAlicuotasCompras) & '0004' & FORMAT(FCP:Iva10 * 100,@n015)
              !CITICA:Registro = CLIP(CITICA:Registro) & FORMAT((FCP:Iva10 + FCP:Iva21 + FCP:Iva27) * 100,@n015) ! Importe liquidado de iva
              Access:CITICA.Insert()
            END
            IF FCP:Iva21>0 THEN !codigoAlicuota" = '0005'.
              CITICA:Registro = CLIP(loc:RegistroAlicuotasCompras) & '0005' & FORMAT(FCP:Iva21 * 100,@n015)
              Access:CITICA.Insert()
            END
            IF FCP:Iva27>0 THEN !codigoAlicuota" = '0006'.
              CITICA:Registro = CLIP(loc:RegistroAlicuotasCompras) & '0006' & FORMAT(FCP:Iva27 * 100,@n015)
              Access:CITICA.Insert()
            END
      
            
        END !IF FCP:Empresa <> glo:Empresa THEN
      END
      Access:CITIC.Close
      
      COPY('C:\Afip\CITICA.TXT','C:\Afip\' & loc:ArchivoComprasAlicuotas)
      
      setcursor(0)
      IF loc:Error <> 1 THEN
        !loc:Archivo = 'CITI_' & FORMAT(YEAR(glo:FechaDesde),@N04) & FORMAT(MONTH(glo:FechaDesde),@N02) & '-' & PAR:LugarFactura & '.TXT'
        !RENAME('CITI','CITIVentas\' & loc:Archivo)
        MESSAGE('Se generaron los 4 archivos del período seleccionado en la carpeta C:\Afip: ','Proceso Finalizado!!!')
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

