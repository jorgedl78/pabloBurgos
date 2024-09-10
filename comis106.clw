

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS106.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS014.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS107.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS108.INC'),ONCE        !Req'd for module callout resolution
                     END


REDESPACHOS PROCEDURE                                      ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(REDESPACHO)
                       PROJECT(RD:Importe)
                       PROJECT(RD:Estado)
                       PROJECT(RD:Guia)
                       JOIN(GUIA:Por_Registro,RD:Guia)
                         PROJECT(GUIA:Fecha)
                         PROJECT(GUIA:Letra)
                         PROJECT(GUIA:Lugar)
                         PROJECT(GUIA:Numero)
                         PROJECT(GUIA:NombreRemitente)
                         PROJECT(GUIA:NombreDestino)
                         PROJECT(GUIA:RegGuia)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
GUIA:Fecha             LIKE(GUIA:Fecha)               !List box control field - type derived from field
GUIA:Fecha_NormalFG    LONG                           !Normal forground color
GUIA:Fecha_NormalBG    LONG                           !Normal background color
GUIA:Fecha_SelectedFG  LONG                           !Selected forground color
GUIA:Fecha_SelectedBG  LONG                           !Selected background color
GUIA:Letra             LIKE(GUIA:Letra)               !List box control field - type derived from field
GUIA:Letra_NormalFG    LONG                           !Normal forground color
GUIA:Letra_NormalBG    LONG                           !Normal background color
GUIA:Letra_SelectedFG  LONG                           !Selected forground color
GUIA:Letra_SelectedBG  LONG                           !Selected background color
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
GUIA:NombreDestino     LIKE(GUIA:NombreDestino)       !List box control field - type derived from field
GUIA:NombreDestino_NormalFG LONG                      !Normal forground color
GUIA:NombreDestino_NormalBG LONG                      !Normal background color
GUIA:NombreDestino_SelectedFG LONG                    !Selected forground color
GUIA:NombreDestino_SelectedBG LONG                    !Selected background color
RD:Importe             LIKE(RD:Importe)               !List box control field - type derived from field
RD:Importe_NormalFG    LONG                           !Normal forground color
RD:Importe_NormalBG    LONG                           !Normal background color
RD:Importe_SelectedFG  LONG                           !Selected forground color
RD:Importe_SelectedBG  LONG                           !Selected background color
RD:Importe_Icon        LONG                           !Entry's icon ID
RD:Estado              LIKE(RD:Estado)                !List box control field - type derived from field
RD:Estado_NormalFG     LONG                           !Normal forground color
RD:Estado_NormalBG     LONG                           !Normal background color
RD:Estado_SelectedFG   LONG                           !Selected forground color
RD:Estado_SelectedBG   LONG                           !Selected background color
RD:Guia                LIKE(RD:Guia)                  !Primary key field - type derived from field
GUIA:RegGuia           LIKE(GUIA:RegGuia)             !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('REDESPACHOS'),AT(,,446,203),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,SYSTEM,GRAY,DOUBLE,MDI
                       PANEL,AT(-1,4,448,20),USE(?Panel1),FILL(0EDECE2H),BEVEL(-1)
                       PROMPT('Transporte:'),AT(89,10),USE(?glo:Transporte:Prompt),TRN,FONT(,10,,FONT:bold)
                       ENTRY(@n3b),AT(149,10,29,11),USE(glo:Transporte),RIGHT(1),FONT(,11,,FONT:bold),COLOR(080FF00H)
                       BUTTON('...'),AT(183,9,12,11),USE(?CallLookup),SKIP,TIP('Seleccionar Transporte')
                       STRING(@s30),AT(203,9,165,11),USE(TRA:Denominacion),TRN,FONT(,10,COLOR:Blue,FONT:bold,CHARSET:ANSI)
                       LIST,AT(13,36,419,123),USE(?Browse:1),IMM,VSCROLL,FORMAT('48R(2)|FM*~Fecha~L@d6@[8R(2)F*@s1@20R(2)F*@n04@34R(2)|F*@n08@]|FM~Guía Nro.~L(2)' &|
   '123L(2)|FM*~Remitente~@s40@123L(2)|FM*~Destinatario~@s40@48R(3)|M*J~Importe~L(2)' &|
   '@n-13.2@40R(3)|M*~Fecha Pago~L(2)@d6b@'),FROM(Queue:Browse:1)
                       BUTTON('Liquidar Pago'),AT(377,163,55,14),USE(?Liquidacion),SKIP
                       BUTTON('Pagado ?'),AT(318,163,55,14),USE(?Pagado),SKIP,LEFT,TIP('Pagado / No Pagado'),ICON('C:\Comisiones\ComisionesSRL\botones\pago.ico')
                       SHEET,AT(7,29,431,154),USE(?CurrentTab),WIZARD
                         TAB('&1) Por Guía'),USE(?Tab:2)
                           BUTTON('Listado...'),AT(13,163,52,14),USE(?Imprimir),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\imprimir.ICO')
                           BUTTON('Modificar'),AT(161,163,42,14),USE(?Change),SKIP
                           BUTTON('Borrar'),AT(207,163,42,14),USE(?Delete),SKIP
                         END
                       END
                       BUTTON('Salir'),AT(389,186,49,14),USE(?Close),SKIP,RIGHT,ICON('C:\Comisiones\ComisionesSRL\botones\sale.ico')
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
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW1::Sort0:StepClass StepClass                            ! Default Step Manager
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?Browse:1
EditInPlace::RD:Guia EditEntryClass                        ! Edit-in-place class for field RD:Importe
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END


  CODE
? DEBUGHOOK(REDESPACHO:Record)
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
  GlobalErrors.SetProcedureName('REDESPACHOS')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:Transporte',glo:Transporte)                    ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCompleted)                    ! Add the close control to the window amanger
  Relate:REDESPACHO.SetOpenRelated()
  Relate:REDESPACHO.Open                                   ! File TRANSPOR used by this procedure, so make sure it's RelationManager is open
  Access:TRANSPOR.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  CLEAR(glo:Transporte)
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:REDESPACHO,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AppendOrder('-GUIA:Numero')                         ! Append an additional sort order
  BRW1.SetFilter('(GUIA:Redespacho = glo:Transporte)')     ! Apply filter expression to browse
  ?Browse:1{PROP:IconList,1} = '~botones\notilde.ico'
  ?Browse:1{PROP:IconList,2} = '~botones\tilde.ico'
  BRW1.AddField(GUIA:Fecha,BRW1.Q.GUIA:Fecha)              ! Field GUIA:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Letra,BRW1.Q.GUIA:Letra)              ! Field GUIA:Letra is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Lugar,BRW1.Q.GUIA:Lugar)              ! Field GUIA:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Numero,BRW1.Q.GUIA:Numero)            ! Field GUIA:Numero is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:NombreRemitente,BRW1.Q.GUIA:NombreRemitente) ! Field GUIA:NombreRemitente is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:NombreDestino,BRW1.Q.GUIA:NombreDestino) ! Field GUIA:NombreDestino is a hot field or requires assignment from browse
  BRW1.AddField(RD:Importe,BRW1.Q.RD:Importe)              ! Field RD:Importe is a hot field or requires assignment from browse
  BRW1.AddField(RD:Estado,BRW1.Q.RD:Estado)                ! Field RD:Estado is a hot field or requires assignment from browse
  BRW1.AddField(RD:Guia,BRW1.Q.RD:Guia)                    ! Field RD:Guia is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:RegGuia,BRW1.Q.GUIA:RegGuia)          ! Field GUIA:RegGuia is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
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
    Relate:REDESPACHO.Close
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
    SelectTRANSPORTE
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?glo:Transporte
      IF glo:Transporte OR ?glo:Transporte{Prop:Req}
        TRA:CodTransporte = glo:Transporte
        IF Access:TRANSPOR.TryFetch(TRA:Por_Codigo)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            glo:Transporte = TRA:CodTransporte
          ELSE
            SELECT(?glo:Transporte)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup
      ThisWindow.Update
      TRA:CodTransporte = glo:Transporte
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        glo:Transporte = TRA:CodTransporte
      END
      ThisWindow.Reset(1)
      SELECT(?Browse:1)
    OF ?Liquidacion
      ThisWindow.Update
      WinLiquidacionRedespacho
      ThisWindow.Reset
    OF ?Pagado
      ThisWindow.Update
      BRW1.UpdateViewRecord
      IF NOT(RD:Estado) THEN
        RD:Estado = TODAY()
      ELSE
        RD:Estado = ''
      END
      Access:REDESPACHO.Update()
      ThisWindow.Reset(TRUE)
    OF ?Imprimir
      ThisWindow.Update
      WinListadoRedespacho
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
    CASE FIELD()
    OF ?Browse:1
      IF NOT RECORDS(BRW1) THEN
        ?Pagado{PROP:Disable} = TRUE
      ELSE
        ?Pagado{PROP:Disable} = FALSE
      END
    END
  ReturnValue = PARENT.TakeNewSelection()
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
  !----------------------------------------------------------------------
   LOOP GreenBarIndex=1 TO RECORDS(SELF.Q)
        GET(SELF.Q,GreenBarIndex)
        SELF.Q.GUIA:Fecha_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for GUIA:Fecha
        SELF.Q.GUIA:Fecha_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,15790320)
        SELF.Q.GUIA:Fecha_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:Fecha_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:Letra_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for GUIA:Letra
        SELF.Q.GUIA:Letra_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,15790320)
        SELF.Q.GUIA:Letra_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:Letra_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:Lugar_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for GUIA:Lugar
        SELF.Q.GUIA:Lugar_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,15790320)
        SELF.Q.GUIA:Lugar_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:Lugar_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:Numero_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for GUIA:Numero
        SELF.Q.GUIA:Numero_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,15790320)
        SELF.Q.GUIA:Numero_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:Numero_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:NombreRemitente_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for GUIA:NombreRemitente
        SELF.Q.GUIA:NombreRemitente_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,15790320)
        SELF.Q.GUIA:NombreRemitente_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:NombreRemitente_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:NombreDestino_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for GUIA:NombreDestino
        SELF.Q.GUIA:NombreDestino_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,15790320)
        SELF.Q.GUIA:NombreDestino_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.GUIA:NombreDestino_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.RD:Importe_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for RD:Importe
        SELF.Q.RD:Importe_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,15790320)
        SELF.Q.RD:Importe_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.RD:Importe_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.RD:Estado_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for RD:Estado
        SELF.Q.RD:Estado_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,15790320)
        SELF.Q.RD:Estado_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.RD:Estado_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        PUT(SELF.Q)
   END
  !----------------------------------------------------------------------


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::RD:Guia,31)
  SELF.AddEditControl(,1)
  SELF.AddEditControl(,6)
  SELF.AddEditControl(,11)
  SELF.AddEditControl(,16)
  SELF.AddEditControl(,21)
  SELF.AddEditControl(,26)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  
  IF (RD:Estado)
    SELF.Q.RD:Importe_Icon = 2                             ! Set icon from icon list
  ELSE
    SELF.Q.RD:Importe_Icon = 1                             ! Set icon from icon list
  END
  !----------------------------------------------------------------------
        SELF.Q.GUIA:Fecha_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for GUIA:Fecha
        SELF.Q.GUIA:Fecha_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,15790320)
        SELF.Q.GUIA:Fecha_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:Fecha_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:Letra_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for GUIA:Letra
        SELF.Q.GUIA:Letra_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,15790320)
        SELF.Q.GUIA:Letra_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:Letra_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:Lugar_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for GUIA:Lugar
        SELF.Q.GUIA:Lugar_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,15790320)
        SELF.Q.GUIA:Lugar_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:Lugar_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:Numero_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for GUIA:Numero
        SELF.Q.GUIA:Numero_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,15790320)
        SELF.Q.GUIA:Numero_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:Numero_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:NombreRemitente_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for GUIA:NombreRemitente
        SELF.Q.GUIA:NombreRemitente_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,15790320)
        SELF.Q.GUIA:NombreRemitente_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:NombreRemitente_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:NombreDestino_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for GUIA:NombreDestino
        SELF.Q.GUIA:NombreDestino_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,15790320)
        SELF.Q.GUIA:NombreDestino_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.GUIA:NombreDestino_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.RD:Importe_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for RD:Importe
        SELF.Q.RD:Importe_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,15790320)
        SELF.Q.RD:Importe_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.RD:Importe_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.RD:Estado_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for RD:Estado
        SELF.Q.RD:Estado_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,15790320)
        SELF.Q.RD:Estado_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.RD:Estado_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
  !----------------------------------------------------------------------


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

