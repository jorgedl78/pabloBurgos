

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS090.INC'),ONCE        !Local module procedure declarations
                     END


VistaAplicaciones PROCEDURE                                ! Generated from procedure template - Window

BRW5::View:Browse    VIEW(APLIFAC)
                       PROJECT(APFAC:Fecha)
                       PROJECT(APFAC:Comprobante)
                       PROJECT(APFAC:ImporteAplicado)
                       PROJECT(APFAC:Recibo)
                       PROJECT(APFAC:Factura)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
APFAC:Fecha            LIKE(APFAC:Fecha)              !List box control field - type derived from field
APFAC:Fecha_NormalFG   LONG                           !Normal forground color
APFAC:Fecha_NormalBG   LONG                           !Normal background color
APFAC:Fecha_SelectedFG LONG                           !Selected forground color
APFAC:Fecha_SelectedBG LONG                           !Selected background color
APFAC:Comprobante      LIKE(APFAC:Comprobante)        !List box control field - type derived from field
APFAC:Comprobante_NormalFG LONG                       !Normal forground color
APFAC:Comprobante_NormalBG LONG                       !Normal background color
APFAC:Comprobante_SelectedFG LONG                     !Selected forground color
APFAC:Comprobante_SelectedBG LONG                     !Selected background color
APFAC:ImporteAplicado  LIKE(APFAC:ImporteAplicado)    !List box control field - type derived from field
APFAC:ImporteAplicado_NormalFG LONG                   !Normal forground color
APFAC:ImporteAplicado_NormalBG LONG                   !Normal background color
APFAC:ImporteAplicado_SelectedFG LONG                 !Selected forground color
APFAC:ImporteAplicado_SelectedBG LONG                 !Selected background color
APFAC:Recibo           LIKE(APFAC:Recibo)             !Browse key field - type derived from field
APFAC:Factura          LIKE(APFAC:Factura)            !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('Aplicaciones'),AT(,,225,62),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,SYSTEM,DOUBLE
                       LIST,AT(11,10,203,42),USE(?List),IMM,VSCROLL,COLOR(0E0EFEFH),FORMAT('47R(3)|FM*~Fecha~L(2)@d6@84L(2)|FM*~Comprobante~@s20@52R(3)|FM*~Importe Aplicado' &|
   '~L(2)@n-13.2@'),FROM(Queue:Browse)
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

BRW5                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW5::Sort0:Locator  StepLocatorClass                      ! Default Locator

  CODE
? DEBUGHOOK(APLIFAC:Record)
? DEBUGHOOK(FACTURAS:Record)
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
  GlobalErrors.SetProcedureName('VistaAplicaciones')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIFAC.SetOpenRelated()
  Relate:APLIFAC.Open                                      ! File FACTURAS used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW5.Init(?List,Queue:Browse.ViewPosition,BRW5::View:Browse,Queue:Browse,Relate:APLIFAC,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW5.Q &= Queue:Browse
  BRW5.AddSortOrder(,APFAC:Por_Recibo)                     ! Add the sort order for APFAC:Por_Recibo for sort order 1
  BRW5.AddRange(APFAC:Recibo,Relate:APLIFAC,Relate:FACTURAS) ! Add file relationship range limit for sort order 1
  BRW5.AddLocator(BRW5::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW5::Sort0:Locator.Init(,APFAC:Factura,1,BRW5)          ! Initialize the browse locator using  using key: APFAC:Por_Recibo , APFAC:Factura
  BRW5.AddField(APFAC:Fecha,BRW5.Q.APFAC:Fecha)            ! Field APFAC:Fecha is a hot field or requires assignment from browse
  BRW5.AddField(APFAC:Comprobante,BRW5.Q.APFAC:Comprobante) ! Field APFAC:Comprobante is a hot field or requires assignment from browse
  BRW5.AddField(APFAC:ImporteAplicado,BRW5.Q.APFAC:ImporteAplicado) ! Field APFAC:ImporteAplicado is a hot field or requires assignment from browse
  BRW5.AddField(APFAC:Recibo,BRW5.Q.APFAC:Recibo)          ! Field APFAC:Recibo is a hot field or requires assignment from browse
  BRW5.AddField(APFAC:Factura,BRW5.Q.APFAC:Factura)        ! Field APFAC:Factura is a hot field or requires assignment from browse
  BRW5.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window


BRW5.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)
  !----------------------------------------------------------------------
   LOOP GreenBarIndex=1 TO RECORDS(SELF.Q)
        GET(SELF.Q,GreenBarIndex)
        SELF.Q.APFAC:Fecha_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for APFAC:Fecha
        SELF.Q.APFAC:Fecha_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.APFAC:Fecha_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.APFAC:Fecha_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.APFAC:Comprobante_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for APFAC:Comprobante
        SELF.Q.APFAC:Comprobante_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.APFAC:Comprobante_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.APFAC:Comprobante_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.APFAC:ImporteAplicado_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for APFAC:ImporteAplicado
        SELF.Q.APFAC:ImporteAplicado_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.APFAC:ImporteAplicado_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.APFAC:ImporteAplicado_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        PUT(SELF.Q)
   END
  !----------------------------------------------------------------------


BRW5.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  
  !----------------------------------------------------------------------
        SELF.Q.APFAC:Fecha_NormalFG   = CHOOSE(CHOICE(?List) % 2,-1,-1) ! Set color values for APFAC:Fecha
        SELF.Q.APFAC:Fecha_NormalBG   = CHOOSE(CHOICE(?List) % 2,-1,16777215)
        SELF.Q.APFAC:Fecha_SelectedFG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.APFAC:Fecha_SelectedBG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.APFAC:Comprobante_NormalFG   = CHOOSE(CHOICE(?List) % 2,-1,-1) ! Set color values for APFAC:Comprobante
        SELF.Q.APFAC:Comprobante_NormalBG   = CHOOSE(CHOICE(?List) % 2,-1,16777215)
        SELF.Q.APFAC:Comprobante_SelectedFG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.APFAC:Comprobante_SelectedBG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.APFAC:ImporteAplicado_NormalFG   = CHOOSE(CHOICE(?List) % 2,-1,-1) ! Set color values for APFAC:ImporteAplicado
        SELF.Q.APFAC:ImporteAplicado_NormalBG   = CHOOSE(CHOICE(?List) % 2,-1,16777215)
        SELF.Q.APFAC:ImporteAplicado_SelectedFG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.APFAC:ImporteAplicado_SelectedBG = CHOOSE(CHOICE(?List) % 2,-1,-1)
  !----------------------------------------------------------------------

