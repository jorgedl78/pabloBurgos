

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS089.INC'),ONCE        !Local module procedure declarations
                     END


VistaValores PROCEDURE                                     ! Generated from procedure template - Window

BRW5::View:Browse    VIEW(VALORES)
                       PROJECT(VAL:Tipo)
                       PROJECT(VAL:Numero)
                       PROJECT(VAL:Fecha)
                       PROJECT(VAL:Importe)
                       PROJECT(VAL:CodigoInterno)
                       PROJECT(VAL:Recibo)
                       PROJECT(VAL:Banco)
                       JOIN(BCO:Por_Codigo,VAL:Banco)
                         PROJECT(BCO:Denominacion)
                         PROJECT(BCO:Codigo)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
VAL:Tipo               LIKE(VAL:Tipo)                 !List box control field - type derived from field
VAL:Tipo_NormalFG      LONG                           !Normal forground color
VAL:Tipo_NormalBG      LONG                           !Normal background color
VAL:Tipo_SelectedFG    LONG                           !Selected forground color
VAL:Tipo_SelectedBG    LONG                           !Selected background color
BCO:Denominacion       LIKE(BCO:Denominacion)         !List box control field - type derived from field
BCO:Denominacion_NormalFG LONG                        !Normal forground color
BCO:Denominacion_NormalBG LONG                        !Normal background color
BCO:Denominacion_SelectedFG LONG                      !Selected forground color
BCO:Denominacion_SelectedBG LONG                      !Selected background color
VAL:Numero             LIKE(VAL:Numero)               !List box control field - type derived from field
VAL:Numero_NormalFG    LONG                           !Normal forground color
VAL:Numero_NormalBG    LONG                           !Normal background color
VAL:Numero_SelectedFG  LONG                           !Selected forground color
VAL:Numero_SelectedBG  LONG                           !Selected background color
VAL:Fecha              LIKE(VAL:Fecha)                !List box control field - type derived from field
VAL:Fecha_NormalFG     LONG                           !Normal forground color
VAL:Fecha_NormalBG     LONG                           !Normal background color
VAL:Fecha_SelectedFG   LONG                           !Selected forground color
VAL:Fecha_SelectedBG   LONG                           !Selected background color
VAL:Importe            LIKE(VAL:Importe)              !List box control field - type derived from field
VAL:Importe_NormalFG   LONG                           !Normal forground color
VAL:Importe_NormalBG   LONG                           !Normal background color
VAL:Importe_SelectedFG LONG                           !Selected forground color
VAL:Importe_SelectedBG LONG                           !Selected background color
VAL:CodigoInterno      LIKE(VAL:CodigoInterno)        !Primary key field - type derived from field
VAL:Recibo             LIKE(VAL:Recibo)               !Browse key field - type derived from field
BCO:Codigo             LIKE(BCO:Codigo)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('Valores'),AT(,,315,61),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,SYSTEM,DOUBLE
                       LIST,AT(11,11,293,42),USE(?List),IMM,VSCROLL,COLOR(0E0EFEFH),FORMAT('35L(2)|FM*~Tipo~@s8@104L(2)|FM*~Banco~@s25@42R(3)|FM*~Número~L(2)@n10.b@47R(3)|F' &|
   'M*~Fecha~L(2)@d6b@45R(3)|FM*~Importe~L(2)@n-13.2@'),FROM(Queue:Browse)
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


  CODE
? DEBUGHOOK(FACTURAS:Record)
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
  GlobalErrors.SetProcedureName('VistaValores')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:FACTURAS.SetOpenRelated()
  Relate:FACTURAS.Open                                     ! File FACTURAS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW5.Init(?List,Queue:Browse.ViewPosition,BRW5::View:Browse,Queue:Browse,Relate:VALORES,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW5.Q &= Queue:Browse
  BRW5.AddSortOrder(,VAL:Por_Recibo)                       ! Add the sort order for VAL:Por_Recibo for sort order 1
  BRW5.AddRange(VAL:Recibo,Relate:VALORES,Relate:FACTURAS) ! Add file relationship range limit for sort order 1
  BRW5.AddField(VAL:Tipo,BRW5.Q.VAL:Tipo)                  ! Field VAL:Tipo is a hot field or requires assignment from browse
  BRW5.AddField(BCO:Denominacion,BRW5.Q.BCO:Denominacion)  ! Field BCO:Denominacion is a hot field or requires assignment from browse
  BRW5.AddField(VAL:Numero,BRW5.Q.VAL:Numero)              ! Field VAL:Numero is a hot field or requires assignment from browse
  BRW5.AddField(VAL:Fecha,BRW5.Q.VAL:Fecha)                ! Field VAL:Fecha is a hot field or requires assignment from browse
  BRW5.AddField(VAL:Importe,BRW5.Q.VAL:Importe)            ! Field VAL:Importe is a hot field or requires assignment from browse
  BRW5.AddField(VAL:CodigoInterno,BRW5.Q.VAL:CodigoInterno) ! Field VAL:CodigoInterno is a hot field or requires assignment from browse
  BRW5.AddField(VAL:Recibo,BRW5.Q.VAL:Recibo)              ! Field VAL:Recibo is a hot field or requires assignment from browse
  BRW5.AddField(BCO:Codigo,BRW5.Q.BCO:Codigo)              ! Field BCO:Codigo is a hot field or requires assignment from browse
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
    Relate:FACTURAS.Close
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
        SELF.Q.VAL:Tipo_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for VAL:Tipo
        SELF.Q.VAL:Tipo_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.VAL:Tipo_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Tipo_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.BCO:Denominacion_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for BCO:Denominacion
        SELF.Q.BCO:Denominacion_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.BCO:Denominacion_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.BCO:Denominacion_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Numero_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for VAL:Numero
        SELF.Q.VAL:Numero_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.VAL:Numero_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Numero_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Fecha_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for VAL:Fecha
        SELF.Q.VAL:Fecha_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.VAL:Fecha_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Fecha_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Importe_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for VAL:Importe
        SELF.Q.VAL:Importe_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.VAL:Importe_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Importe_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        PUT(SELF.Q)
   END
  !----------------------------------------------------------------------


BRW5.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  
  !----------------------------------------------------------------------
        SELF.Q.VAL:Tipo_NormalFG   = CHOOSE(CHOICE(?List) % 2,-1,-1) ! Set color values for VAL:Tipo
        SELF.Q.VAL:Tipo_NormalBG   = CHOOSE(CHOICE(?List) % 2,-1,16777215)
        SELF.Q.VAL:Tipo_SelectedFG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.VAL:Tipo_SelectedBG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.BCO:Denominacion_NormalFG   = CHOOSE(CHOICE(?List) % 2,-1,-1) ! Set color values for BCO:Denominacion
        SELF.Q.BCO:Denominacion_NormalBG   = CHOOSE(CHOICE(?List) % 2,-1,16777215)
        SELF.Q.BCO:Denominacion_SelectedFG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.BCO:Denominacion_SelectedBG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.VAL:Numero_NormalFG   = CHOOSE(CHOICE(?List) % 2,-1,-1) ! Set color values for VAL:Numero
        SELF.Q.VAL:Numero_NormalBG   = CHOOSE(CHOICE(?List) % 2,-1,16777215)
        SELF.Q.VAL:Numero_SelectedFG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.VAL:Numero_SelectedBG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.VAL:Fecha_NormalFG   = CHOOSE(CHOICE(?List) % 2,-1,-1) ! Set color values for VAL:Fecha
        SELF.Q.VAL:Fecha_NormalBG   = CHOOSE(CHOICE(?List) % 2,-1,16777215)
        SELF.Q.VAL:Fecha_SelectedFG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.VAL:Fecha_SelectedBG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.VAL:Importe_NormalFG   = CHOOSE(CHOICE(?List) % 2,-1,-1) ! Set color values for VAL:Importe
        SELF.Q.VAL:Importe_NormalBG   = CHOOSE(CHOICE(?List) % 2,-1,16777215)
        SELF.Q.VAL:Importe_SelectedFG = CHOOSE(CHOICE(?List) % 2,-1,-1)
        SELF.Q.VAL:Importe_SelectedBG = CHOOSE(CHOICE(?List) % 2,-1,-1)
  !----------------------------------------------------------------------

