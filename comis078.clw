

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS078.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS016.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS025.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS063.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS079.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS080.INC'),ONCE        !Req'd for module callout resolution
                     END


GUIAS_EMPRESA3 PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
BRW1::View:Browse    VIEW(GUIAS)
                       PROJECT(GUIA:Fecha)
                       PROJECT(GUIA:Lugar)
                       PROJECT(GUIA:Numero)
                       PROJECT(GUIA:NombreRemitente)
                       PROJECT(GUIA:Flete)
                       PROJECT(GUIA:RegGuia)
                       PROJECT(GUIA:ClienteFacturar)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
GUIA:Fecha             LIKE(GUIA:Fecha)               !List box control field - type derived from field
GUIA:Fecha_NormalFG    LONG                           !Normal forground color
GUIA:Fecha_NormalBG    LONG                           !Normal background color
GUIA:Fecha_SelectedFG  LONG                           !Selected forground color
GUIA:Fecha_SelectedBG  LONG                           !Selected background color
GUIA:Fecha_Icon        LONG                           !Entry's icon ID
GUIA:Lugar             LIKE(GUIA:Lugar)               !List box control field - type derived from field
GUIA:Lugar_NormalFG    LONG                           !Normal forground color
GUIA:Lugar_NormalBG    LONG                           !Normal background color
GUIA:Lugar_SelectedFG  LONG                           !Selected forground color
GUIA:Lugar_SelectedBG  LONG                           !Selected background color
GUIA:Numero            LIKE(GUIA:Numero)              !List box control field - type derived from field
GUIA:Numero_NormalFG   LONG                           !Normal forground color
GUIA:Numero_NormalBG   LONG                           !Normal background color
GUIA:Numero_SelectedFG LONG                           !Selected forground color
GUIA:Numero_SelectedBG LONG                           !Selected background color
GUIA:NombreRemitente   LIKE(GUIA:NombreRemitente)     !List box control field - type derived from field
GUIA:NombreRemitente_NormalFG LONG                    !Normal forground color
GUIA:NombreRemitente_NormalBG LONG                    !Normal background color
GUIA:NombreRemitente_SelectedFG LONG                  !Selected forground color
GUIA:NombreRemitente_SelectedBG LONG                  !Selected background color
GUIA:Flete             LIKE(GUIA:Flete)               !List box control field - type derived from field
GUIA:Flete_NormalFG    LONG                           !Normal forground color
GUIA:Flete_NormalBG    LONG                           !Normal background color
GUIA:Flete_SelectedFG  LONG                           !Selected forground color
GUIA:Flete_SelectedBG  LONG                           !Selected background color
GUIA:RegGuia           LIKE(GUIA:RegGuia)             !Primary key field - type derived from field
GUIA:ClienteFacturar   LIKE(GUIA:ClienteFacturar)     !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW4::View:Browse    VIEW(ITEMGUIA)
                       PROJECT(ITGUIA:Cantidad)
                       PROJECT(ITGUIA:Descripcion)
                       PROJECT(ITGUIA:Aforo)
                       PROJECT(ITGUIA:RegGuia)
                       PROJECT(ITGUIA:Item)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ITGUIA:Cantidad        LIKE(ITGUIA:Cantidad)          !List box control field - type derived from field
ITGUIA:Descripcion     LIKE(ITGUIA:Descripcion)       !List box control field - type derived from field
ITGUIA:Aforo           LIKE(ITGUIA:Aforo)             !List box control field - type derived from field
ITGUIA:RegGuia         LIKE(ITGUIA:RegGuia)           !Primary key field - type derived from field
ITGUIA:Item            LIKE(ITGUIA:Item)              !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('REMITOS - GUIAS'),AT(,,457,254),FONT('MS Sans Serif',8,COLOR:Black,),COLOR(0E4EBEFH),CENTER,IMM,ICON('C:\Comisiones\ComisionesSRL\botones\movi.ico'),SYSTEM,GRAY,DOUBLE,MDI
                       PANEL,AT(-1,5,459,18),USE(?Panel2),FILL(COLOR:Green),BEVEL(-1)
                       STRING('3'),AT(4,6,19,15),USE(?String5),TRN,CENTER,FONT('Arial Black',12,COLOR:White,FONT:bold)
                       STRING('Trans'),AT(178,4,43,22),USE(?String2),TRN,CENTER,FONT('Brush Script MT',20,COLOR:White,)
                       STRING('PABLO'),AT(216,5,64,22),USE(?String2:2),TRN,CENTER,FONT('Arial Black',16,COLOR:White,FONT:italic)
                       BUTTON,AT(420,83,24,16),USE(?Redespacho),SKIP,FLAT,TIP('Ver Redespacho'),ICON('C:\1L\Comisiones\botones\camion2.ico')
                       LIST,AT(12,45,276,107),USE(?Browse:1),IMM,VSCROLL,COLOR(0F8F8F8H,COLOR:White,COLOR:Green),FORMAT('56R(2)|FM*J~Fecha~L@d6@[22R(3)F*@n04@29R(4)|FM*@n08@](57)|FM~Comprobante~127L(2)' &|
   '|FM*~Remitente~@s40@4C|F*~Flete~@s1@'),FROM(Queue:Browse:1)
                       BUTTON('Alta'),AT(297,45,55,33),USE(?Insert:2),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\agregar.ico')
                       BUTTON('Modificar'),AT(357,45,55,15),USE(?Change:2),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\modificar.ico')
                       BUTTON('Borrar'),AT(357,63,55,15),USE(?Delete:2),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\borrar.ico')
                       STRING('DESTINATARIO:'),AT(294,90),USE(?String1),TRN,FONT(,,COLOR:Black,FONT:bold)
                       PROMPT('Nombre:'),AT(297,105),USE(?GUIA:NombreDestino:Prompt),TRN
                       ENTRY(@s40),AT(332,105,109,10),USE(GUIA:NombreDestino),SKIP,COLOR(0FFFFC1H),UPR,READONLY
                       PANEL,AT(294,100,151,54),USE(?Panel1),BEVEL(-1)
                       PROMPT('Dirección:'),AT(297,117),USE(?GUIA:DireccionDestino:Prompt),TRN
                       ENTRY(@s30),AT(332,117,109,10),USE(GUIA:DireccionDestino),SKIP,COLOR(0FFFFC1H),UPR,READONLY
                       PROMPT('Localidad:'),AT(297,129),USE(?GUIA:LocalidadDestino:Prompt),TRN
                       ENTRY(@s30),AT(332,129,109,10),USE(GUIA:LocalidadDestino),SKIP,COLOR(0FFFFC1H),UPR,READONLY
                       PROMPT('Teléfono:'),AT(297,141),USE(?GUIA:TelefonoDestino:Prompt),TRN
                       ENTRY(@s35),AT(332,141,109,10),USE(GUIA:TelefonoDestino),SKIP,COLOR(0FFFFC1H),UPR,READONLY
                       PROMPT('Remito:'),AT(372,165),USE(?GUIA:RemitoCliente:Prompt)
                       ENTRY(@s10),AT(399,164,47,10),USE(GUIA:RemitoCliente),SKIP,RIGHT(1),TIP('Remito del Cliente'),READONLY
                       PROMPT('OBSERVACION:'),AT(294,165),USE(?GUIA:Observacion:Prompt),TRN,FONT(,,COLOR:Black,FONT:bold)
                       TEXT,AT(294,176,151,51),USE(GUIA:Observacion),SKIP,BOXED,VSCROLL,FONT(,,0400080H,),COLOR(0E1E1E1H),READONLY
                       BUTTON('  Cumplir'),AT(70,155,54,14),USE(?Cumplir),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\marcar.ico')
                       BUTTON(' Imprimir'),AT(12,155,54,14),USE(?Imprimir),SKIP,LEFT,KEY(F2Key),ICON('C:\1L\Comisiones\botones\imprimir.ICO')
                       LIST,AT(12,176,276,51),USE(?List),IMM,SKIP,NOBAR,FORMAT('40R(5)|F~Cantidad~L(2)@n7.@179L(2)|F~Descripción~@s35@40R(3)|F~Aforo~L(2)@n10.2@'),FROM(Queue:Browse)
                       SHEET,AT(7,27,443,206),USE(?CurrentTab),ABOVE(56)
                         TAB('Por &Fecha'),USE(?Tab:1)
                           PROMPT('Fecha:'),AT(135,158),USE(?GUIA:Fecha:Prompt),TRN
                           ENTRY(@d6),AT(166,158,49,10),USE(GUIA:Fecha),RIGHT(1),FONT(,,COLOR:Green,,CHARSET:ANSI)
                         END
                         TAB('Por &Número'),USE(?Tab:2)
                           PROMPT('Número:'),AT(135,158),USE(?GUIA:Numero:Prompt),TRN
                           ENTRY(@n_8b),AT(166,158,49,10),USE(GUIA:Numero),RIGHT(1),FONT(,,COLOR:Green,,CHARSET:ANSI)
                         END
                         TAB('Por &Cliente'),USE(?Tab:3)
                           BUTTON(' Seleccionar Cliente...'),AT(129,155,94,14),USE(?SelectCLIENTE),SKIP,LEFT,ICON('C:\1L\Comisiones\botones\buscar.ico')
                         END
                       END
                       BUTTON('    Cerrar'),AT(201,237,56,15),USE(?Close),SKIP,RIGHT,ICON('C:\1L\Comisiones\botones\sale.ico')
                       BUTTON,AT(394,83,24,16),USE(?ContraReembolso),SKIP,FLAT,TIP('Ver Contra Reembolso'),ICON('C:\1L\Comisiones\botones\cheque.ico')
                       STRING('F2 - Imprime Guía'),AT(10,236),USE(?String3)
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW1::Sort1:Locator  EntryLocatorClass                     ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
BRW1::Sort1:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort2:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 3
BRW4                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
                     END


  CODE
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(DISTRIBUIDORES:Record)
? DEBUGHOOK(GUIAS:Record)
? DEBUGHOOK(ITEMGUIA:Record)
? DEBUGHOOK(PARAMETRO:Record)
? DEBUGHOOK(TRANSPOR:Record)
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
  GlobalErrors.SetProcedureName('GUIAS_EMPRESA3')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel2
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCompleted)                    ! Add the close control to the window amanger
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Access:DISTRIBUIDORES.UseFile                            ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:TRANSPOR.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:GUIAS.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:GUIAS,SELF) ! Initialize the browse manager
  BRW4.Init(?List,Queue:Browse.ViewPosition,BRW4::View:Browse,Queue:Browse,Relate:ITEMGUIA,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowNumeric)     ! Moveable thumb based upon GUIA:Numero for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,GUIA:Por_Numero) ! Add the sort order for GUIA:Por_Numero for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?GUIA:Numero,GUIA:Numero,1,BRW1) ! Initialize the browse locator using ?GUIA:Numero using key: GUIA:Por_Numero , GUIA:Numero
  BRW1.SetFilter('(GUIA:Empresa = 3)')                     ! Apply filter expression to browse
  BRW1::Sort2:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon GUIA:ClienteFacturar for sort order 2
  BRW1.AddSortOrder(BRW1::Sort2:StepClass,GUIA:Por_Cliente_FechaD) ! Add the sort order for GUIA:Por_Cliente_FechaD for sort order 2
  BRW1.AddRange(GUIA:ClienteFacturar,glo:Cliente)          ! Add single value range limit for sort order 2
  BRW1.SetFilter('(GUIA:Empresa = 3)')                     ! Apply filter expression to browse
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlt+ScrollSort:Descending) ! Moveable thumb based upon GUIA:Fecha for sort order 3
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,GUIA:Por_Fecha)  ! Add the sort order for GUIA:Por_Fecha for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(?GUIA:Fecha,GUIA:Fecha,1,BRW1)  ! Initialize the browse locator using ?GUIA:Fecha using key: GUIA:Por_Fecha , GUIA:Fecha
  BRW1.AppendOrder('-GUIA:Numero')                         ! Append an additional sort order
  BRW1.SetFilter('(GUIA:Empresa = 3)')                     ! Apply filter expression to browse
  ?Browse:1{PROP:IconList,1} = '~botones\anulada.ico'
  ?Browse:1{PROP:IconList,2} = '~botones\notilde.ico'
  ?Browse:1{PROP:IconList,3} = '~botones\tilde.ico'
  BRW1.AddField(GUIA:Fecha,BRW1.Q.GUIA:Fecha)              ! Field GUIA:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Lugar,BRW1.Q.GUIA:Lugar)              ! Field GUIA:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Numero,BRW1.Q.GUIA:Numero)            ! Field GUIA:Numero is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:NombreRemitente,BRW1.Q.GUIA:NombreRemitente) ! Field GUIA:NombreRemitente is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Flete,BRW1.Q.GUIA:Flete)              ! Field GUIA:Flete is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:RegGuia,BRW1.Q.GUIA:RegGuia)          ! Field GUIA:RegGuia is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:ClienteFacturar,BRW1.Q.GUIA:ClienteFacturar) ! Field GUIA:ClienteFacturar is a hot field or requires assignment from browse
  BRW4.Q &= Queue:Browse
  BRW4.AddSortOrder(,ITGUIA:Por_Guia)                      ! Add the sort order for ITGUIA:Por_Guia for sort order 1
  BRW4.AddRange(ITGUIA:RegGuia,Relate:ITEMGUIA,Relate:GUIAS) ! Add file relationship range limit for sort order 1
  BRW4.AddField(ITGUIA:Cantidad,BRW4.Q.ITGUIA:Cantidad)    ! Field ITGUIA:Cantidad is a hot field or requires assignment from browse
  BRW4.AddField(ITGUIA:Descripcion,BRW4.Q.ITGUIA:Descripcion) ! Field ITGUIA:Descripcion is a hot field or requires assignment from browse
  BRW4.AddField(ITGUIA:Aforo,BRW4.Q.ITGUIA:Aforo)          ! Field ITGUIA:Aforo is a hot field or requires assignment from browse
  BRW4.AddField(ITGUIA:RegGuia,BRW4.Q.ITGUIA:RegGuia)      ! Field ITGUIA:RegGuia is a hot field or requires assignment from browse
  BRW4.AddField(ITGUIA:Item,BRW4.Q.ITGUIA:Item)            ! Field ITGUIA:Item is a hot field or requires assignment from browse
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW4.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    Relate:CLIENTES.Close
    Relate:PARAMETRO.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    UpdateGUIAS3
    ReturnValue = GlobalResponse
  END
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
    OF ?Insert:2
      CLEAR(glo:NumeraGuia)
      PAR:Registro = 3
      GET(PARAMETRO,PAR:Por_Registro)
      
      GUIA:Empresa = 3
      SET(GUIA:Por_Comprobante,GUIA:Por_Comprobante)
      LOOP UNTIL EOF(GUIAS)
        NEXT(GUIAS)
        IF ERRORCODE() THEN BREAK.
        IF GUIA:Empresa <> 3 THEN BREAK.
        IF GUIA:Letra = PAR:LetraGuia AND GUIA:Lugar = PAR:LugarGuia AND glo:NumeraGuia < GUIA:Numero THEN
          glo:NumeraGuia = GUIA:Numero
        END
      END
      glo:NumeraGuia += 1
    OF ?Change:2
      BRW1.UpdateViewRecord
      IF GUIA:Facturada THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' No es posible modificar la Guía,| la misma se encuentra Facturada.',|
                'Atención !!!',ICON:Exclamation)
        CYCLE
      .
    OF ?Delete:2
      BRW1.UpdateViewRecord
      IF GUIA:Facturada THEN
        BEEP(BEEP:SystemExclamation)  ;  YIELD()
        MESSAGE(' No es posible borrar la Guía,| la misma se encuentra Facturada.',|
                'Atención !!!',ICON:Exclamation)
        CYCLE
      .
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Redespacho
      ThisWindow.Update
      Redespacho
      ThisWindow.Reset
    OF ?Cumplir
      ThisWindow.Update
      BRW1.UpdateViewRecord
      GUIA:Cumplida = TODAY()
      Access:Guias.Update()
      ThisWindow.Reset(TRUE)
    OF ?Imprimir
      ThisWindow.Update
      ImprimeTotal3
      ThisWindow.Reset
      BRW1.UpdateViewRecord
      GUIA:Impresa = 'S'
      Access:Guias.Update()
      ThisWindow.Reset(TRUE)
    OF ?SelectCLIENTE
      ThisWindow.Update
      GlobalRequest = SelectRecord
      SelectCLIENTES
      ThisWindow.Reset
      IF CHOICE(?CurrentTab) = 3 THEN
        IF NOT(RECORDS(BRW1)) THEN
          BEEP(BEEP:SystemQuestion)  ;  YIELD()
          MESSAGE('El Cliente seleccionado no registra movimientos.',|
                  'Sin Movimientos',ICON:Question)
        END
      END
    OF ?ContraReembolso
      ThisWindow.Update
      WinContraReembolso
      ThisWindow.Reset
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


ThisWindow.TakeNewSelection PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all NewSelection events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeNewSelection()
    CASE FIELD()
    OF ?Browse:1
      BRW1.UpdateViewRecord
      glo:Cliente = GUIA:ClienteFacturar
      
      IF GUIA:Impresa = 'S' THEN
        DISABLE(?Imprimir)
      ELSE
        ENABLE(?Imprimir)
      END
      
      IF GUIA:Cumplida THEN
        DISABLE(?Cumplir)
      ELSE
        ENABLE(?Cumplir)
      END
      
      IF GUIA:Redespacho THEN
        UNHIDE(?Redespacho)
      ELSE
        HIDE(?Redespacho)
      END
      
      IF GUIA:ContraReembolso THEN
        UNHIDE(?ContraReembolso)
      ELSE
        HIDE(?ContraReembolso)
      END
      
      IF NOT RECORDS(BRW1) THEN
        DISABLE(?Imprimir)
        DISABLE(?Cumplir)
      END
    END
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


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?CurrentTab) = 3
    RETURN SELF.SetSort(2,Force)
  ELSE
    RETURN SELF.SetSort(3,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW1.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  
  SELF.Q.GUIA:Fecha_NormalFG = -1                          ! Set color values for GUIA:Fecha
  SELF.Q.GUIA:Fecha_NormalBG = -1
  SELF.Q.GUIA:Fecha_SelectedFG = -1
  SELF.Q.GUIA:Fecha_SelectedBG = -1
  IF (GUIA:Cumplida)
    SELF.Q.GUIA:Fecha_Icon = 3                             ! Set icon from icon list
  ELSIF (GUIA:Impresa = 'A')
    SELF.Q.GUIA:Fecha_Icon = 1                             ! Set icon from icon list
  ELSE
    SELF.Q.GUIA:Fecha_Icon = 2                             ! Set icon from icon list
  END
  SELF.Q.GUIA:Lugar_NormalFG = -1                          ! Set color values for GUIA:Lugar
  SELF.Q.GUIA:Lugar_NormalBG = -1
  SELF.Q.GUIA:Lugar_SelectedFG = -1
  SELF.Q.GUIA:Lugar_SelectedBG = -1
  SELF.Q.GUIA:Numero_NormalFG = -1                         ! Set color values for GUIA:Numero
  SELF.Q.GUIA:Numero_NormalBG = -1
  SELF.Q.GUIA:Numero_SelectedFG = -1
  SELF.Q.GUIA:Numero_SelectedBG = -1
  SELF.Q.GUIA:NombreRemitente_NormalFG = -1                ! Set color values for GUIA:NombreRemitente
  SELF.Q.GUIA:NombreRemitente_NormalBG = -1
  SELF.Q.GUIA:NombreRemitente_SelectedFG = -1
  SELF.Q.GUIA:NombreRemitente_SelectedBG = -1
  SELF.Q.GUIA:Flete_NormalFG = -1                          ! Set color values for GUIA:Flete
  SELF.Q.GUIA:Flete_NormalBG = -1
  SELF.Q.GUIA:Flete_SelectedFG = -1
  SELF.Q.GUIA:Flete_SelectedBG = -1


BRW4.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)

