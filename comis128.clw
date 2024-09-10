

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS128.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS130.INC'),ONCE        !Req'd for module callout resolution
                     END


PARAMETRO_1 PROCEDURE                                      ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
Loc:Tipo_Comprobante STRING(2)                             !
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
WS_Window WINDOW,AT(,,358,132),FONT('MS Sans Serif',8,,FONT:regular),CENTER,WALLPAPER('fondo.jpg'),CENTERED, |
         GRAY
       STRING(@s50),AT(53,12,251,14),USE(glo_nombre_usuario),TRN,CENTER,FONT(,12,COLOR:White,FONT:bold,CHARSET:ANSI)
       TEXT,AT(15,36,323,60),USE(glo:mensage),SKIP,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI),COLOR(0C7DEDBH), |
           READONLY
     END
Window               WINDOW('Parametros   ** EMPRESA N<186> 1 **'),AT(,,305,164),FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,GRAY,DOUBLE
                       SHEET,AT(11,8,279,129),USE(?Sheet1),ABOVE(64)
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
                             ENTRY(@n-5b),AT(73,105,29,10),USE(PAR:XPosFactura),RIGHT(1)
                             PROMPT('Superior:'),AT(131,105),USE(?PAR:YPosFactura:Prompt),TRN
                             ENTRY(@n-5b),AT(169,105,29,10),USE(PAR:YPosFactura),RIGHT(1)
                           END
                         END
                         TAB('Fact. Electrónica'),USE(?Tab4)
                           PROMPT('Cetificado:'),AT(19,28),USE(?PAR1:RazonSocial:Prompt:2),TRN
                           ENTRY(@s100),AT(54,27,219,10),USE(PARFE:Certificado)
                           ENTRY(@s100),AT(54,40,219,10),USE(PARFE:Clave)
                           PROMPT('Clave:'),AT(32,40),USE(?PAR1:RazonSocial:Prompt:3),TRN
                           ENTRY(@s11),AT(54,52,61,10),USE(PARFE:CUIP)
                           PROMPT('CUIP:'),AT(33,52),USE(?PAR1:RazonSocial:Prompt:4),TRN
                           ENTRY(@n-14),AT(54,65,32,10),USE(PARFE:Puesto),RIGHT
                           PROMPT('Puesto:'),AT(28,65),USE(?PAR1:RazonSocial:Prompt:5),TRN
                           CHECK('Modo Test'),AT(135,65),USE(Glo:Test),TRN
                           GROUP('Consultar Ultimo Comprobante'),AT(28,78,245,55),USE(?Group4),BOXED
                             PROMPT('Factura'),AT(65,91),USE(?PAR1:RazonSocial:Prompt:6),TRN
                             PROMPT('N/C'),AT(133,91),USE(?PAR1:RazonSocial:Prompt:7),TRN
                             PROMPT('N/D'),AT(189,90),USE(?PAR1:RazonSocial:Prompt:8),TRN
                             PROMPT('A'),AT(55,103),USE(?PAR1:RazonSocial:Prompt:9),TRN
                             ENTRY(@n-14),AT(63,103,32,10),USE(PARFE:FA),RIGHT
                             BUTTON,AT(99,103,15,10),USE(?Button3),ICON(ICON:VCRlocate)
                             ENTRY(@n-14),AT(123,103,32,10),USE(PARFE:NCA),RIGHT
                             BUTTON,AT(159,103,15,10),USE(?Button3:3),ICON(ICON:VCRlocate)
                             ENTRY(@n-14),AT(183,103,32,10),USE(PARFE:NDA),RIGHT
                             BUTTON,AT(219,103,15,10),USE(?Button3:5),ICON(ICON:VCRlocate)
                             PROMPT('B'),AT(53,116),USE(?PAR1:RazonSocial:Prompt:10),TRN
                             ENTRY(@n-14),AT(63,116,32,10),USE(PARFE:FB),RIGHT
                             BUTTON,AT(99,116,15,10),USE(?Button3:2),ICON(ICON:VCRlocate)
                             ENTRY(@n-14),AT(123,116,32,10),USE(PARFE:NCB),RIGHT
                             BUTTON,AT(159,116,15,10),USE(?Button3:4),ICON(ICON:VCRlocate)
                             ENTRY(@n-14),AT(183,116,32,10),USE(PARFE:NDB),RIGHT
                             BUTTON,AT(219,116,15,10),USE(?Button3:6),ICON(ICON:VCRlocate)
                           END
                         END
                       END
                       BUTTON('Grabar'),AT(78,143,57,17),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico')
                       BUTTON('Cancelar'),AT(142,143,57,17),USE(?Cancel),LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\Cancel1.ico'),STD(STD:Close)
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
? DEBUGHOOK(PARAMFE:Record)
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
    Glo:Parametros = 'FECompUltimoAutorizado ' &format(Loc:Tipo_Comprobante,@n02)&' '&format(PARFE:Puesto,@n04) &' -c ' & PARFE:CUIP     &| ! Asigna el CUIT
                                        ' -r ' & CLIP(PARFE:Certificado) &| ! Asigna el certificado
                                        ' -k ' & CLIP(PARFE:Clave)       &| ! Asigna la clave
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

    if Loc:Tipo_Comprobante=1 then
        PARFE:FA=Lee_FECompUltimoAutorizado() ! Factura A
    end
    if Loc:Tipo_Comprobante=2 then
        PARFE:NDA=Lee_FECompUltimoAutorizado()! Notas de Debito A
    end
    if Loc:Tipo_Comprobante=3 then
        PARFE:NCA=Lee_FECompUltimoAutorizado() ! Notas de Credito A
    end
    if Loc:Tipo_Comprobante=6 then
        PARFE:FB=Lee_FECompUltimoAutorizado() ! Factura B
    end
    if Loc:Tipo_Comprobante=7 then
        PARFE:NDB=Lee_FECompUltimoAutorizado() ! Notas de Debito B
    end
    if Loc:Tipo_Comprobante=8 then
        PARFE:NCB=Lee_FECompUltimoAutorizado() ! Notas de Credito B
    end

    display()

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PARAMETRO_1')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PAR1:RazonSocial:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:PARAMETRO.Open                                    ! File PARAMFE used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMFE.Open                                      ! File PARAMFE used by this procedure, so make sure it's RelationManager is open
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
    Relate:PARAMFE.Close
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
    OF ?Button3
      Loc:Tipo_Comprobante=1 ! Factura A
      do ConsultarUltimoComprobante
    OF ?Button3:3
      Loc:Tipo_Comprobante=3 ! NC A
      do ConsultarUltimoComprobante
    OF ?Button3:5
      Loc:Tipo_Comprobante=2 ! ND A
      do ConsultarUltimoComprobante
    OF ?Button3:2
      Loc:Tipo_Comprobante=6 ! Factura B
      do ConsultarUltimoComprobante
    OF ?Button3:4
      Loc:Tipo_Comprobante=8 ! NC B
      do ConsultarUltimoComprobante
    OF ?Button3:6
      Loc:Tipo_Comprobante=7 ! ND B
      do ConsultarUltimoComprobante
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
      PUT(PARAMETRO)
      
      PUT(PARAMFE)
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
      PAR:Registro = 1
      GET(PARAMETRO,PAR:Por_Registro)
      
      PARFE:IDParametrosFE=1
      GET(PARAMFE,PARFE:ParametrosFE_x_ID)
      
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

