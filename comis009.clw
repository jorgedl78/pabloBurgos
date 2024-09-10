

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS009.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS021.INC'),ONCE        !Req'd for module callout resolution
                     END


DISTRIBUIDORES PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
BRW1::View:Browse    VIEW(DISTRIBUIDORES)
                       PROJECT(DIS:CodDistribuidor)
                       PROJECT(DIS:Nombre)
                       PROJECT(DIS:Localidad)
                       PROJECT(DIS:Telefono)
                       PROJECT(DIS:Zona)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
DIS:CodDistribuidor    LIKE(DIS:CodDistribuidor)      !List box control field - type derived from field
DIS:Nombre             LIKE(DIS:Nombre)               !List box control field - type derived from field
DIS:Localidad          LIKE(DIS:Localidad)            !List box control field - type derived from field
DIS:Telefono           LIKE(DIS:Telefono)             !List box control field - type derived from field
DIS:Zona               LIKE(DIS:Zona)                 !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('DISTRIBUIDORES'),AT(,,411,182),FONT('MS Sans Serif',8,,),COLOR(0E4EBEFH),CENTER,IMM,ICON('C:\Comisiones\ComisionesSRL\botones\distribuidor.ico'),SYSTEM,GRAY,DOUBLE,MDI
                       LIST,AT(13,22,383,114),USE(?Browse:1),IMM,VSCROLL,COLOR(COLOR:White),FORMAT('28R(3)|FM~Código~C(0)@n3@119L(2)|FM~Nombre~@s35@76L(2)|FM~Localidad~@s30@120L(2)' &|
   '|FM~Teléfono~@s30@20C|FM~Zona~@n3@'),FROM(Queue:Browse:1)
                       BUTTON('Agregar'),AT(121,140,54,16),USE(?Insert:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\agregar.ico')
                       BUTTON('Modificar'),AT(179,140,54,16),USE(?Change:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\modificar.ico')
                       BUTTON('Borrar'),AT(237,140,54,16),USE(?Delete:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\borrar.ico')
                       SHEET,AT(8,4,395,156),USE(?CurrentTab),ABOVE(54)
                         TAB('Por &Codigo'),USE(?Tab:2)
                           STRING(@n3b),AT(23,144),USE(DIS:CodDistribuidor),TRN,FONT(,,0A00000H,)
                         END
                         TAB('Por &Nombre'),USE(?Tab:3)
                           STRING(@s35),AT(24,144,87,10),USE(DIS:Nombre),TRN,FONT(,,0A00000H,)
                         END
                         TAB('Por &Zona'),USE(?Tab:4)
                           STRING(@n3b),AT(24,144),USE(DIS:Zona),TRN,FONT(,,0A00000H,)
                         END
                       END
                       BUTTON('    Cerrar'),AT(349,164,54,16),USE(?Close),SKIP,RIGHT,ICON('C:\Comisiones\ComisionesSRL\botones\sale.ico')
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
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
                     END

BRW1::Sort0:Locator  IncrementalLocatorClass               ! Default Locator
BRW1::Sort1:Locator  IncrementalLocatorClass               ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort3:Locator  IncrementalLocatorClass               ! Conditional Locator - CHOICE(?CurrentTab) = 3
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
BRW1::Sort1:StepClass StepStringClass                      ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort3:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 3

  CODE
? DEBUGHOOK(DISTRIBUIDORES:Record)
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
  GlobalErrors.SetProcedureName('DISTRIBUIDORES')
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
  Relate:DISTRIBUIDORES.Open                               ! File DISTRIBUIDORES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:DISTRIBUIDORES,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon DIS:Nombre for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,DIS:Por_Nombre)  ! Add the sort order for DIS:Por_Nombre for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?DIS:Nombre,DIS:Nombre,1,BRW1)  ! Initialize the browse locator using ?DIS:Nombre using key: DIS:Por_Nombre , DIS:Nombre
  BRW1::Sort3:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon DIS:Zona for sort order 2
  BRW1.AddSortOrder(BRW1::Sort3:StepClass,DIS:Por_Zona)    ! Add the sort order for DIS:Por_Zona for sort order 2
  BRW1.AddLocator(BRW1::Sort3:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort3:Locator.Init(?DIS:Zona,DIS:Zona,1,BRW1)      ! Initialize the browse locator using ?DIS:Zona using key: DIS:Por_Zona , DIS:Zona
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon DIS:CodDistribuidor for sort order 3
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,DIS:Por_Codigo)  ! Add the sort order for DIS:Por_Codigo for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(?DIS:CodDistribuidor,DIS:CodDistribuidor,1,BRW1) ! Initialize the browse locator using ?DIS:CodDistribuidor using key: DIS:Por_Codigo , DIS:CodDistribuidor
  BRW1.AddField(DIS:CodDistribuidor,BRW1.Q.DIS:CodDistribuidor) ! Field DIS:CodDistribuidor is a hot field or requires assignment from browse
  BRW1.AddField(DIS:Nombre,BRW1.Q.DIS:Nombre)              ! Field DIS:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(DIS:Localidad,BRW1.Q.DIS:Localidad)        ! Field DIS:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(DIS:Telefono,BRW1.Q.DIS:Telefono)          ! Field DIS:Telefono is a hot field or requires assignment from browse
  BRW1.AddField(DIS:Zona,BRW1.Q.DIS:Zona)                  ! Field DIS:Zona is a hot field or requires assignment from browse
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
    Relate:DISTRIBUIDORES.Close
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
    UpdateDISTRIBUIDORES
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

