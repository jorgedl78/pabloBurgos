

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS007.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS019.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS111.INC'),ONCE        !Req'd for module callout resolution
                     END


TRANSPORTES PROCEDURE                                      ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
BRW1::View:Browse    VIEW(TRANSPOR)
                       PROJECT(TRA:CodTransporte)
                       PROJECT(TRA:Denominacion)
                       PROJECT(TRA:Direccion)
                       PROJECT(TRA:Localidad)
                       PROJECT(TRA:Telefono)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
TRA:CodTransporte      LIKE(TRA:CodTransporte)        !List box control field - type derived from field
TRA:Denominacion       LIKE(TRA:Denominacion)         !List box control field - type derived from field
TRA:Direccion          LIKE(TRA:Direccion)            !List box control field - type derived from field
TRA:Localidad          LIKE(TRA:Localidad)            !List box control field - type derived from field
TRA:Telefono           LIKE(TRA:Telefono)             !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('TRANSPORTES'),AT(,,423,195),FONT('MS Sans Serif',8,,),COLOR(0E4EBEFH),CENTER,IMM,ICON('C:\Comisiones\ComisionesSRL\botones\camion2.ico'),SYSTEM,GRAY,DOUBLE,MDI
                       LIST,AT(14,22,395,123),USE(?Browse:1),IMM,VSCROLL,COLOR(COLOR:White),FORMAT('30R(3)|FM~Código~L(2)@n3@115L(2)|FM~Nombre~@s30@80L(2)|M~Dirección~@s30@77L(2)|M' &|
   '~Localidad~@s30@80L(2)|M~Teléfono~@s35@'),FROM(Queue:Browse:1)
                       BUTTON('Agregar'),AT(127,150,54,16),USE(?Insert:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\agregar.ico')
                       BUTTON('Modificar'),AT(184,150,54,16),USE(?Change:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\modificar.ico')
                       BUTTON('Borrar'),AT(241,150,54,16),USE(?Delete:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\borrar.ico')
                       SHEET,AT(7,4,408,167),USE(?CurrentTab),ABOVE(54)
                         TAB('Por &Nombre'),USE(?Tab:2)
                           STRING(@s30),AT(58,153,63,10),USE(TRA:Denominacion),TRN,FONT(,,0A00000H,)
                         END
                         TAB('Por &Código'),USE(?Tab:3)
                           STRING(@n3b),AT(58,153),USE(TRA:CodTransporte),TRN,FONT(,,0A00000H,)
                         END
                       END
                       BUTTON('    Cerrar'),AT(360,175,54,16),USE(?Close),SKIP,RIGHT,ICON('C:\Comisiones\ComisionesSRL\botones\sale.ico')
                       BUTTON,AT(13,147,24,22),USE(?Button5),SKIP,FLAT,TIP('Ver Destinos...'),ICON('C:\Comisiones\ComisionesSRL\botones\ruta.ico')
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
                     END

BRW1::Sort0:Locator  FilterLocatorClass                    ! Default Locator
BRW1::Sort1:Locator  IncrementalLocatorClass               ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort0:StepClass StepStringClass                      ! Default Step Manager
BRW1::Sort1:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 2

  CODE
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
  GlobalErrors.SetProcedureName('TRANSPORTES')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCompleted)                    ! Add the close control to the window amanger
  Relate:TRANSPOR.SetOpenRelated()
  Relate:TRANSPOR.Open                                     ! File TRANSPOR used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:TRANSPOR,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon TRA:CodTransporte for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,TRA:Por_Codigo)  ! Add the sort order for TRA:Por_Codigo for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?TRA:CodTransporte,TRA:CodTransporte,1,BRW1) ! Initialize the browse locator using ?TRA:CodTransporte using key: TRA:Por_Codigo , TRA:CodTransporte
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon TRA:Denominacion for sort order 2
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,TRA:Por_Denominacion) ! Add the sort order for TRA:Por_Denominacion for sort order 2
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort0:Locator.Init(?TRA:Denominacion,TRA:Denominacion,1,BRW1) ! Initialize the browse locator using ?TRA:Denominacion using key: TRA:Por_Denominacion , TRA:Denominacion
  BRW1::Sort0:Locator.FloatRight = 1
  BRW1.AddField(TRA:CodTransporte,BRW1.Q.TRA:CodTransporte) ! Field TRA:CodTransporte is a hot field or requires assignment from browse
  BRW1.AddField(TRA:Denominacion,BRW1.Q.TRA:Denominacion)  ! Field TRA:Denominacion is a hot field or requires assignment from browse
  BRW1.AddField(TRA:Direccion,BRW1.Q.TRA:Direccion)        ! Field TRA:Direccion is a hot field or requires assignment from browse
  BRW1.AddField(TRA:Localidad,BRW1.Q.TRA:Localidad)        ! Field TRA:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(TRA:Telefono,BRW1.Q.TRA:Telefono)          ! Field TRA:Telefono is a hot field or requires assignment from browse
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    Relate:TRANSPOR.Close
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
    UpdateTRANSPOR
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
    OF ?Button5
      ThisWindow.Update
      TRANS_DESTINOS
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
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue

