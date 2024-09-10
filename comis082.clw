

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS082.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS130.INC'),ONCE        !Req'd for module callout resolution
                     END


PARAMETRO_3 PROCEDURE                                      ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
Loc:Tipo_Comprobante STRING(2)                             !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Parametros   ** EMPRESA N<186> 3 **'),AT(,,307,176),FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,GRAY,DOUBLE
                       SHEET,AT(11,8,278,129),USE(?Sheet1),ABOVE(64)
                         TAB('&Empresa'),USE(?Tab1)
                           PROMPT('Razon Social:'),AT(25,37),USE(?PAR1:RazonSocial:Prompt),TRN
                           ENTRY(@s35),AT(79,37,143,10),USE(PAR:RazonSocial),UPR
                           PROMPT('Dirección:'),AT(25,52),USE(?PAR1:Direccion:Prompt),TRN
                           ENTRY(@s35),AT(79,52,117,10),USE(PAR:Direccion)
                           PROMPT('Cod Postal:'),AT(25,67),USE(?PAR1:CodPostal:Prompt),TRN
                           ENTRY(@s8),AT(79,67,46,10),USE(PAR:CodPostal),UPR
                           PROMPT('Localidad:'),AT(25,82),USE(?PAR1:Localidad:Prompt),TRN
                           ENTRY(@s30),AT(79,82,117,10),USE(PAR:Localidad),UPR
                           PROMPT('Provincia:'),AT(25,97),USE(?PAR1:Provincia:Prompt),TRN
                           ENTRY(@s30),AT(79,97,117,10),USE(PAR:Provincia),UPR
                         END
                         TAB('&Inf. Impositiva'),USE(?Tab2)
                           PROMPT('Categoría IVA:'),AT(25,37),USE(?PAR1:CategoriaIVA:Prompt),TRN
                           ENTRY(@s25),AT(87,37,95,10),USE(PAR:CategoriaIVA),UPR
                           PROMPT('CUIT:'),AT(25,52),USE(?PAR1:CUIT:Prompt),TRN
                           ENTRY(@P##-########-#Pb),AT(87,52,64,10),USE(PAR:CUIT)
                           PROMPT('Inicio Actividad:'),AT(25,67),USE(?PAR1:InicioActividad:Prompt),TRN
                           ENTRY(@d6b),AT(87,67,50,10),USE(PAR:InicioActividad),RIGHT(1)
                           PROMPT('Ingresos Brutos:'),AT(25,82),USE(?PAR1:IngresosBrutos:Prompt),TRN
                           ENTRY(@s15),AT(87,82,90,10),USE(PAR:IngresosBrutos),UPR
                         END
                         TAB('&Facturación'),USE(?Tab3)
                           GROUP('Remito-Guía'),AT(25,28,195,26),USE(?Group1),BOXED
                             PROMPT('Letra:'),AT(50,41),USE(?PAR1:LetraGuia:Prompt),TRN
                             ENTRY(@s1),AT(73,41,17,10),USE(PAR:LetraGuia),CENTER,REQ,UPR
                             PROMPT('Punto de Venta:'),AT(108,41),USE(?PAR1:LugarGuia:Prompt),TRN
                             ENTRY(@n04),AT(166,41,31,10),USE(PAR:LugarGuia),RIGHT(1),REQ
                           END
                           GROUP('Facturas'),AT(25,61,195,26),USE(?Group1:2),BOXED
                             PROMPT('Letra'),AT(52,73),USE(?PAR1:LetraFactura:Prompt),TRN
                             ENTRY(@s1),AT(73,73,17,10),USE(PAR:LetraFactura),CENTER,UPR
                             PROMPT('Punto de Venta:'),AT(109,73),USE(?PAR1:LugarFactura:Prompt)
                             ENTRY(@n04),AT(167,73,31,10),USE(PAR:LugarFactura),RIGHT(1),REQ
                           END
                           GROUP('Margenes Impresión de Factura'),AT(25,93,195,26),USE(?Group3),BOXED
                             PROMPT('Izquierdo:'),AT(37,105),USE(?PAR:XPosFactura:Prompt),TRN
                             ENTRY(@n5b),AT(73,105,29,10),USE(PAR:XPosFactura),RIGHT(1)
                             PROMPT('Superior:'),AT(131,105),USE(?PAR:YPosFactura:Prompt),TRN
                             ENTRY(@n5b),AT(169,105,29,10),USE(PAR:YPosFactura),RIGHT(1)
                           END
                         END
                         TAB('Fact. Electrónica'),USE(?Tab4)
                           STRING('Certificado:'),AT(21,31),USE(?String1:4)
                           ENTRY(@s100),AT(59,31,221,10),USE(PARFE3:Certificado)
                           ENTRY(@s100),AT(59,44,117,10),USE(PARFE3:Clave)
                           STRING('Clave.'),AT(36,45),USE(?String1:5)
                           ENTRY(@s11),AT(59,57,117,10),USE(PARFE3:CUIP)
                           STRING('CUIP:'),AT(37,58),USE(?String1:6)
                           ENTRY(@n-14),AT(59,70,28,10),USE(PARFE3:Puesto),RIGHT
                           STRING('Puesto:'),AT(32,71),USE(?String1:7)
                           CHECK('Modo Test'),AT(103,71),USE(Glo:Test)
                           GROUP('Consultar ultimo comprobante'),AT(31,87,195,40),USE(?Group4),BOXED
                             STRING('Factura'),AT(46,99),USE(?String1)
                             STRING('N/C'),AT(106,99),USE(?String1:2)
                             STRING('N/D'),AT(162,98),USE(?String1:3)
                             ENTRY(@n-14),AT(49,110,20,10),USE(PARFE3:F)
                             ENTRY(@n-14),AT(105,110,21,10),USE(PARFE3:NC)
                             BUTTON,AT(129,108,15,13),USE(?Button3:2),ICON(ICON:VCRlocate)
                             ENTRY(@n-14),AT(162,110,17,10),USE(PARFE3:ND)
                             BUTTON,AT(185,108,15,13),USE(?Button3:3),ICON(ICON:VCRlocate)
                             BUTTON,AT(72,108,15,13),USE(?Button3),ICON(ICON:VCRlocate)
                           END
                         END
                       END
                       BUTTON('Grabar'),AT(81,143,57,17),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\1L\Comisiones\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(145,143,57,17),USE(?Cancel),LEFT,ICON('C:\1L\Comisiones\botones\Cancel1.ico'),STD(STD:Close)
                     END

WS_Window WINDOW,AT(,,358,132),FONT('MS Sans Serif',8,,FONT:regular),CENTER,WALLPAPER('fondo.jpg'),CENTERED, |
         GRAY
       STRING(@s50),AT(53,12,251,14),USE(glo_nombre_usuario),TRN,CENTER,FONT(,12,COLOR:White,FONT:bold,CHARSET:ANSI)
       TEXT,AT(15,36,323,60),USE(glo:mensage),SKIP,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI),COLOR(0C7DEDBH), |
           READONLY
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
? DEBUGHOOK(PARAMETRO:Record)
? DEBUGHOOK(PARAMFE3:Record)
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------
ConsultarUltimoComprobante ROUTINE
    !PARFE:IDParametrosFE=1
    !get(PARAMFE,PARFE:ParametrosFE_x_ID)
     remove('ticket.XML')

    !Cargo variables
    Glo:Ejecutable = PATH() & '\wsfe.exe'
    Glo:Parametros = 'FECompUltimoAutorizado ' &format(Loc:Tipo_Comprobante,@n02)&' '&format(PARFE3:Puesto,@n04) &' -c ' & PARFE3:CUIP     &| ! Asigna el CUIT
                                        ' -r ' & CLIP(PARFE3:Certificado) &| ! Asigna el certificado
                                        ' -k ' & CLIP(PARFE3:Clave)       &| ! Asigna la clave
                                        ' -o Respuesta.txt '                       &| ! Guarda la respuesta en el archivo
                                        ' -t ticket.XML '                             ! Si el ticket no existe lo genera

    SETCLIPBOARD(CLIP(GLO:Ejecutable) & ' ' & CLIP(GLO:Parametros))    ! Lo guardo en el portapapeles

    !MESSAGE('Comando enviado: |' & CLIP(GLO:Ejecutable) & ' ' & CLIP(GLO:Parametros))

    !También se puede agilizar enviando el parámetro --ticket xxxx.xml en vez de utilizar "-r .... -k ...". Lea el manual para mayor orientación.

    !Llamo al Web Services
    IF EXISTS(CLIP('.\Respuesta.txt')) ! Si existe el archivo donde guardo las respuestas, lo borro
      REMOVE(CLIP('.\Respuesta.txt'))
    END!IF

    glo:mensage='<13,10>Consultando última Factura A registrada.<13,10>Conectando con los Servicios de la AFIP.<13,10>Espere por favor...'

    setcursor(cursor:wait)
    OPEN(WS_Window)
       ACCEPT
          IF EVENT() = Event:OpenWindow
                !!! CONEXION CON EL WS DE AFIP

                Ejecuta_WS

             POST(EVENT:CloseWindow)
          END
       END
    CLOSE(WS_Window)
    setcursor()

    if Loc:Tipo_Comprobante=11 then
        PARFE3:F=Lee_FECompUltimoAutorizado() ! Factura C
    end
    if Loc:Tipo_Comprobante=12 then
        PARFE3:ND=Lee_FECompUltimoAutorizado()! Notas de Debito C
    end
    if Loc:Tipo_Comprobante=13 then
        PARFE3:NC=Lee_FECompUltimoAutorizado() ! Notas de Credito C
    end

    display()

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PARAMETRO_3')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PAR1:RazonSocial:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:PARAMETRO.Open                                    ! File PARAMFE3 used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMFE3.Open                                     ! File PARAMFE3 used by this procedure, so make sure it's RelationManager is open
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
    Relate:PARAMETRO.Close
    Relate:PARAMFE3.Close
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
    OF ?Button3:2
      Loc:Tipo_Comprobante=13 ! NC C
      do ConsultarUltimoComprobante
    OF ?Button3:3
      Loc:Tipo_Comprobante=12 ! ND C
      do ConsultarUltimoComprobante
    OF ?Button3
      Loc:Tipo_Comprobante=11 ! Factura C
      do ConsultarUltimoComprobante
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
      PUT(PARAMETRO)
      
      
      PUT(PARAMFE3)
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
      PAR:Registro = 3
      GET(PARAMETRO,PAR:Por_Registro)
      
      PARFE3:IDParametrosFE=1
      GET(PARAMFE3,PARFE3:ParametrosFE_x_ID)
      
      remove('ticket.XML')
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
    CASE EVENT()
    OF EVENT:OpenWindow
      DISPLAY
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

