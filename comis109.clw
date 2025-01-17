

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS109.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS110.INC'),ONCE        !Req'd for module callout resolution
                     END


DESTINOS PROCEDURE                                         ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?LOC:Localidad
LOC:Localidad          LIKE(LOC:Localidad)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW1::View:Browse    VIEW(TRANSLOC)
                       PROJECT(TRL:Lunes)
                       PROJECT(TRL:Martes)
                       PROJECT(TRL:Miercoles)
                       PROJECT(TRL:Jueves)
                       PROJECT(TRL:Viernes)
                       PROJECT(TRL:Sabado)
                       PROJECT(TRL:Domingo)
                       PROJECT(TRL:Transporte)
                       PROJECT(TRL:Localidad)
                       JOIN(TRA:Por_Codigo,TRL:Transporte)
                         PROJECT(TRA:Denominacion)
                         PROJECT(TRA:CodTransporte)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
TRA:Denominacion       LIKE(TRA:Denominacion)         !List box control field - type derived from field
TRL:Lunes              LIKE(TRL:Lunes)                !List box control field - type derived from field
TRL:Lunes_NormalFG     LONG                           !Normal forground color
TRL:Lunes_NormalBG     LONG                           !Normal background color
TRL:Lunes_SelectedFG   LONG                           !Selected forground color
TRL:Lunes_SelectedBG   LONG                           !Selected background color
TRL:Martes             LIKE(TRL:Martes)               !List box control field - type derived from field
TRL:Martes_NormalFG    LONG                           !Normal forground color
TRL:Martes_NormalBG    LONG                           !Normal background color
TRL:Martes_SelectedFG  LONG                           !Selected forground color
TRL:Martes_SelectedBG  LONG                           !Selected background color
TRL:Miercoles          LIKE(TRL:Miercoles)            !List box control field - type derived from field
TRL:Miercoles_NormalFG LONG                           !Normal forground color
TRL:Miercoles_NormalBG LONG                           !Normal background color
TRL:Miercoles_SelectedFG LONG                         !Selected forground color
TRL:Miercoles_SelectedBG LONG                         !Selected background color
TRL:Jueves             LIKE(TRL:Jueves)               !List box control field - type derived from field
TRL:Jueves_NormalFG    LONG                           !Normal forground color
TRL:Jueves_NormalBG    LONG                           !Normal background color
TRL:Jueves_SelectedFG  LONG                           !Selected forground color
TRL:Jueves_SelectedBG  LONG                           !Selected background color
TRL:Viernes            LIKE(TRL:Viernes)              !List box control field - type derived from field
TRL:Viernes_NormalFG   LONG                           !Normal forground color
TRL:Viernes_NormalBG   LONG                           !Normal background color
TRL:Viernes_SelectedFG LONG                           !Selected forground color
TRL:Viernes_SelectedBG LONG                           !Selected background color
TRL:Sabado             LIKE(TRL:Sabado)               !List box control field - type derived from field
TRL:Sabado_NormalFG    LONG                           !Normal forground color
TRL:Sabado_NormalBG    LONG                           !Normal background color
TRL:Sabado_SelectedFG  LONG                           !Selected forground color
TRL:Sabado_SelectedBG  LONG                           !Selected background color
TRL:Domingo            LIKE(TRL:Domingo)              !List box control field - type derived from field
TRL:Domingo_NormalFG   LONG                           !Normal forground color
TRL:Domingo_NormalBG   LONG                           !Normal background color
TRL:Domingo_SelectedFG LONG                           !Selected forground color
TRL:Domingo_SelectedBG LONG                           !Selected background color
TRL:Transporte         LIKE(TRL:Transporte)           !Primary key field - type derived from field
TRL:Localidad          LIKE(TRL:Localidad)            !Primary key field - type derived from field
TRA:CodTransporte      LIKE(TRA:CodTransporte)        !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
FDCB5::View:FileDropCombo VIEW(LOCALIDA)
                       PROJECT(LOC:Localidad)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('DESTINOS'),AT(,,249,169),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,SYSTEM,GRAY,DOUBLE,MDI
                       STRING('Localidad:'),AT(43,13),USE(?String1),FONT(,,,FONT:bold)
                       COMBO(@s20),AT(88,13,118,10),USE(LOC:Localidad),IMM,FORMAT('120L(2)|@s30@'),DROP(5),FROM(Queue:FileDropCombo)
                       LIST,AT(19,30,211,91),USE(?Browse:1),IMM,NOBAR,COLUMN,FORMAT('125L(2)|F~Transporte~@s30@11C|_F*~L~@s1@E(0FF00H,,,)11C|_F*~M~@s1@E(0FF00H,,,)11' &|
   'C|_F*~M~@s1@E(0FF00H,,,)11C|_F*~J~@s1@E(0FF00H,,,)11C|_F*~V~@s1@E(0FF00H,,,)11C|' &|
   '_F*~S~@s1@E(0FF00H,,,)11C|_F*~D~@s1@E(0FF00H,,,)'),FROM(Queue:Browse:1)
                       BUTTON('Agregar'),AT(41,125,54,16),USE(?Insert:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\agregar.ico')
                       BUTTON('Modificar'),AT(98,125,54,16),USE(?Change:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\modificar.ico'),DEFAULT
                       BUTTON('Borrar'),AT(155,125,54,16),USE(?Delete:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\borrar.ico')
                       SHEET,AT(10,4,229,141),USE(?CurrentTab),WIZARD
                         TAB('Por Localidad'),USE(?Tab:3)
                         END
                       END
                       BUTTON('Cerrar'),AT(185,150,54,16),USE(?Close),SKIP,RIGHT,ICON('C:\Comisiones\ComisionesSRL\botones\sale.ico')
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
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
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

FDCB5                CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo           !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END


  CODE
? DEBUGHOOK(LOCALIDA:Record)
? DEBUGHOOK(TRANSLOC:Record)
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
  GlobalErrors.SetProcedureName('DESTINOS')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCompleted)                    ! Add the close control to the window amanger
  Relate:LOCALIDA.Open                                     ! File LOCALIDA used by this procedure, so make sure it's RelationManager is open
  Relate:TRANSLOC.SetOpenRelated()
  Relate:TRANSLOC.Open                                     ! File LOCALIDA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:TRANSLOC,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.AddSortOrder(,TRL:Por_Localidad)                    ! Add the sort order for TRL:Por_Localidad for sort order 1
  BRW1.AddRange(TRL:Localidad,LOC:Localidad)               ! Add single value range limit for sort order 1
  BRW1.AddField(TRA:Denominacion,BRW1.Q.TRA:Denominacion)  ! Field TRA:Denominacion is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Lunes,BRW1.Q.TRL:Lunes)                ! Field TRL:Lunes is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Martes,BRW1.Q.TRL:Martes)              ! Field TRL:Martes is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Miercoles,BRW1.Q.TRL:Miercoles)        ! Field TRL:Miercoles is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Jueves,BRW1.Q.TRL:Jueves)              ! Field TRL:Jueves is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Viernes,BRW1.Q.TRL:Viernes)            ! Field TRL:Viernes is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Sabado,BRW1.Q.TRL:Sabado)              ! Field TRL:Sabado is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Domingo,BRW1.Q.TRL:Domingo)            ! Field TRL:Domingo is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Transporte,BRW1.Q.TRL:Transporte)      ! Field TRL:Transporte is a hot field or requires assignment from browse
  BRW1.AddField(TRL:Localidad,BRW1.Q.TRL:Localidad)        ! Field TRL:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(TRA:CodTransporte,BRW1.Q.TRA:CodTransporte) ! Field TRA:CodTransporte is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW1.AskProcedure = 1
  FDCB5.Init(LOC:Localidad,?LOC:Localidad,Queue:FileDropCombo.ViewPosition,FDCB5::View:FileDropCombo,Queue:FileDropCombo,Relate:LOCALIDA,ThisWindow,GlobalErrors,0,1,0)
  FDCB5.Q &= Queue:FileDropCombo
  FDCB5.AddSortOrder()
  FDCB5.AddField(LOC:Localidad,FDCB5.Q.LOC:Localidad)
  ThisWindow.AddItem(FDCB5.WindowComponent)
  FDCB5.DefaultFill = 0
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'�',8)
  EnterByTabManager.Init(False)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:LOCALIDA.Close
    Relate:TRANSLOC.Close
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
    UpdateTRANSLOC
    ReturnValue = GlobalResponse
  END
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


BRW1.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  
  IF (TRL:Lunes)
    SELF.Q.TRL:Lunes_NormalFG = -1                         ! Set conditional color values for TRL:Lunes
    SELF.Q.TRL:Lunes_NormalBG = 65280
    SELF.Q.TRL:Lunes_SelectedFG = -1
    SELF.Q.TRL:Lunes_SelectedBG = -1
  ELSE
    SELF.Q.TRL:Lunes_NormalFG = -1                         ! Set color values for TRL:Lunes
    SELF.Q.TRL:Lunes_NormalBG = -1
    SELF.Q.TRL:Lunes_SelectedFG = -1
    SELF.Q.TRL:Lunes_SelectedBG = -1
  END
  IF (TRL:Martes)
    SELF.Q.TRL:Martes_NormalFG = -1                        ! Set conditional color values for TRL:Martes
    SELF.Q.TRL:Martes_NormalBG = 65280
    SELF.Q.TRL:Martes_SelectedFG = -1
    SELF.Q.TRL:Martes_SelectedBG = -1
  ELSE
    SELF.Q.TRL:Martes_NormalFG = -1                        ! Set color values for TRL:Martes
    SELF.Q.TRL:Martes_NormalBG = -1
    SELF.Q.TRL:Martes_SelectedFG = -1
    SELF.Q.TRL:Martes_SelectedBG = -1
  END
  IF (TRL:Miercoles)
    SELF.Q.TRL:Miercoles_NormalFG = -1                     ! Set conditional color values for TRL:Miercoles
    SELF.Q.TRL:Miercoles_NormalBG = 65280
    SELF.Q.TRL:Miercoles_SelectedFG = -1
    SELF.Q.TRL:Miercoles_SelectedBG = -1
  ELSE
    SELF.Q.TRL:Miercoles_NormalFG = -1                     ! Set color values for TRL:Miercoles
    SELF.Q.TRL:Miercoles_NormalBG = -1
    SELF.Q.TRL:Miercoles_SelectedFG = -1
    SELF.Q.TRL:Miercoles_SelectedBG = -1
  END
  IF (TRL:Jueves)
    SELF.Q.TRL:Jueves_NormalFG = -1                        ! Set conditional color values for TRL:Jueves
    SELF.Q.TRL:Jueves_NormalBG = 65280
    SELF.Q.TRL:Jueves_SelectedFG = -1
    SELF.Q.TRL:Jueves_SelectedBG = -1
  ELSE
    SELF.Q.TRL:Jueves_NormalFG = -1                        ! Set color values for TRL:Jueves
    SELF.Q.TRL:Jueves_NormalBG = -1
    SELF.Q.TRL:Jueves_SelectedFG = -1
    SELF.Q.TRL:Jueves_SelectedBG = -1
  END
  IF (TRL:Viernes)
    SELF.Q.TRL:Viernes_NormalFG = -1                       ! Set conditional color values for TRL:Viernes
    SELF.Q.TRL:Viernes_NormalBG = 65280
    SELF.Q.TRL:Viernes_SelectedFG = -1
    SELF.Q.TRL:Viernes_SelectedBG = -1
  ELSE
    SELF.Q.TRL:Viernes_NormalFG = -1                       ! Set color values for TRL:Viernes
    SELF.Q.TRL:Viernes_NormalBG = -1
    SELF.Q.TRL:Viernes_SelectedFG = -1
    SELF.Q.TRL:Viernes_SelectedBG = -1
  END
  IF (TRL:Sabado)
    SELF.Q.TRL:Sabado_NormalFG = -1                        ! Set conditional color values for TRL:Sabado
    SELF.Q.TRL:Sabado_NormalBG = 65280
    SELF.Q.TRL:Sabado_SelectedFG = -1
    SELF.Q.TRL:Sabado_SelectedBG = -1
  ELSE
    SELF.Q.TRL:Sabado_NormalFG = -1                        ! Set color values for TRL:Sabado
    SELF.Q.TRL:Sabado_NormalBG = -1
    SELF.Q.TRL:Sabado_SelectedFG = -1
    SELF.Q.TRL:Sabado_SelectedBG = -1
  END
  IF (TRL:Domingo)
    SELF.Q.TRL:Domingo_NormalFG = -1                       ! Set conditional color values for TRL:Domingo
    SELF.Q.TRL:Domingo_NormalBG = 65280
    SELF.Q.TRL:Domingo_SelectedFG = -1
    SELF.Q.TRL:Domingo_SelectedBG = -1
  ELSE
    SELF.Q.TRL:Domingo_NormalFG = -1                       ! Set color values for TRL:Domingo
    SELF.Q.TRL:Domingo_NormalBG = -1
    SELF.Q.TRL:Domingo_SelectedFG = -1
    SELF.Q.TRL:Domingo_SelectedBG = -1
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window


FDCB5.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue

