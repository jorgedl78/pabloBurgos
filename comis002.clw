

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS013.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS022.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS099.INC'),ONCE        !Req'd for module callout resolution
                     END


CLIENTES PROCEDURE                                         ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
loc:Nombre           STRING(40)                            !
local:Localidad      STRING(40)                            !
BRW1::View:Browse    VIEW(CLIENTES)
                       PROJECT(CLI:CodCliente)
                       PROJECT(CLI:Nombre)
                       PROJECT(CLI:Localidad)
                       PROJECT(CLI:Distribuidor)
                       PROJECT(CLI:Provincia)
                       JOIN(PCIA:Por_Codigo,CLI:Provincia)
                         PROJECT(PCIA:CodProvincia)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
CLI:CodCliente         LIKE(CLI:CodCliente)           !List box control field - type derived from field
CLI:CodCliente_NormalFG LONG                          !Normal forground color
CLI:CodCliente_NormalBG LONG                          !Normal background color
CLI:CodCliente_SelectedFG LONG                        !Selected forground color
CLI:CodCliente_SelectedBG LONG                        !Selected background color
CLI:Nombre             LIKE(CLI:Nombre)               !List box control field - type derived from field
CLI:Nombre_NormalFG    LONG                           !Normal forground color
CLI:Nombre_NormalBG    LONG                           !Normal background color
CLI:Nombre_SelectedFG  LONG                           !Selected forground color
CLI:Nombre_SelectedBG  LONG                           !Selected background color
CLI:Localidad          LIKE(CLI:Localidad)            !List box control field - type derived from field
CLI:Localidad_NormalFG LONG                           !Normal forground color
CLI:Localidad_NormalBG LONG                           !Normal background color
CLI:Localidad_SelectedFG LONG                         !Selected forground color
CLI:Localidad_SelectedBG LONG                         !Selected background color
CLI:Distribuidor       LIKE(CLI:Distribuidor)         !List box control field - type derived from field
CLI:Distribuidor_NormalFG LONG                        !Normal forground color
CLI:Distribuidor_NormalBG LONG                        !Normal background color
CLI:Distribuidor_SelectedFG LONG                      !Selected forground color
CLI:Distribuidor_SelectedBG LONG                      !Selected background color
PCIA:CodProvincia      LIKE(PCIA:CodProvincia)        !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('CLIENTES'),AT(,,444,211),FONT('MS Sans Serif',8,,),COLOR(0E4EBEFH),CENTER,IMM,ICON('C:\Comisiones\ComisionesSRL\botones\clientes.ico'),SYSTEM,GRAY,DOUBLE,MDI
                       LIST,AT(14,24,225,123),USE(?Browse:1),IMM,VSCROLL,COLOR(0EFEEE7H,COLOR:White,COLOR:Maroon),FORMAT('29R(3)|FM*~Código~L(2)@n6.@130L(2)|FM*~Nombre~@s40@120L(2)|M*~Localidad~@s30@12C' &|
   '|M*~Distribuidor~L(2)@n3b@?'),FROM(Queue:Browse:1)
                       STRING('CONTACTO:'),AT(258,26),USE(?String2),TRN,FONT('Courier New',8,,FONT:regular)
                       STRING(@s25),AT(302,26,106,10),USE(CLI:Contacto),TRN
                       STRING('DIRECCION:'),AT(258,42),USE(?String2:2),TRN,FONT('Courier New',8,,FONT:regular)
                       STRING(@s30),AT(305,42,126,10),USE(CLI:Direccion),TRN
                       STRING(@s40),AT(305,50,127,10),USE(local:Localidad),TRN
                       STRING(@s20),AT(305,58),USE(PCIA:Denominacion),TRN
                       STRING('TELEFONO:'),AT(258,74),USE(?String2:3),TRN,FONT('Courier New',8,,FONT:regular)
                       STRING(@s35),AT(300,74,133,10),USE(CLI:Telefono),TRN
                       STRING('E-MAIL:'),AT(258,89),USE(?String2:4),TRN,FONT('Courier New',8,,FONT:regular)
                       STRING(@s50),AT(291,89,141,10),USE(CLI:Email),TRN,FONT(,,COLOR:Blue,,CHARSET:ANSI)
                       STRING('OBSERVACIONES:'),AT(258,110),USE(?String2:5),TRN,FONT('Courier New',8,,FONT:regular)
                       TEXT,AT(259,120,170,38),USE(CLI:Notas),SKIP,BOXED,FONT(,,COLOR:Red,),READONLY
                       BOX,AT(254,6,182,181),USE(?Box1),FILL(0E2E2E2H)
                       STRING(@s40),AT(256,10,178,10),USE(loc:Nombre),TRN,FONT(,,COLOR:White,FONT:bold)
                       BOX,AT(254,7,182,15),USE(?Box2),FILL(COLOR:Maroon)
                       BUTTON('Alta'),AT(127,151,54,32),USE(?Insert:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\agregar.ico')
                       BUTTON('Modificar'),AT(185,151,54,15),USE(?Change:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\modificar.ico')
                       BUTTON('Borrar'),AT(185,168,54,15),USE(?Delete:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\borrar.ico')
                       BUTTON('     Guías     Sin Facturar'),AT(266,163,67,19),USE(?Button5),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\movi.ico')
                       BUTTON(' Cuenta       Corriente'),AT(354,163,67,19),USE(?Button5:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\ctacte.ico')
                       SHEET,AT(6,4,239,183),USE(?CurrentTab),SPREAD
                         TAB('Por &Nombre'),USE(?Tab:2)
                           STRING(@s40),AT(14,155,93,10),USE(CLI:Nombre),TRN,FONT(,,0A00000H,)
                         END
                         TAB('Por &Código'),USE(?Tab:3)
                           STRING(@n6.b),AT(20,155),USE(CLI:CodCliente),TRN,FONT(,,0A00000H,)
                         END
                         TAB('Por &Localidad'),USE(?Tab:4)
                         END
                         TAB('Por &Distribuidor'),USE(?Tab:6)
                           STRING(@n3b),AT(23,155),USE(CLI:Distribuidor),TRN,FONT(,,0A00000H,)
                         END
                       END
                       BUTTON('    Cerrar'),AT(381,192,54,15),USE(?Close),SKIP,RIGHT,ICON('C:\Comisiones\ComisionesSRL\botones\sale.ico')
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

BRW1::Sort0:Locator  FilterLocatorClass                    ! Default Locator
BRW1::Sort1:Locator  IncrementalLocatorClass               ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort2:Locator  IncrementalLocatorClass               ! Conditional Locator - CHOICE(?CurrentTab) = 3
BRW1::Sort4:Locator  IncrementalLocatorClass               ! Conditional Locator - CHOICE(?CurrentTab) = 4
BRW1::Sort0:StepClass StepStringClass                      ! Default Step Manager
BRW1::Sort1:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort2:StepClass StepStringClass                      ! Conditional Step Manager - CHOICE(?CurrentTab) = 3
BRW1::Sort4:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 4

  CODE
? DEBUGHOOK(CLIENTES:Record)
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
  GlobalErrors.SetProcedureName('CLIENTES')
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
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:CLIENTES,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon CLI:CodCliente for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,CLI:Por_Codigo)  ! Add the sort order for CLI:Por_Codigo for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?CLI:CodCliente,CLI:CodCliente,1,BRW1) ! Initialize the browse locator using ?CLI:CodCliente using key: CLI:Por_Codigo , CLI:CodCliente
  BRW1::Sort2:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon CLI:Localidad for sort order 2
  BRW1.AddSortOrder(BRW1::Sort2:StepClass,CLI:Por_Localidad) ! Add the sort order for CLI:Por_Localidad for sort order 2
  BRW1.AddLocator(BRW1::Sort2:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort2:Locator.Init(,CLI:Localidad,1,BRW1)          ! Initialize the browse locator using  using key: CLI:Por_Localidad , CLI:Localidad
  BRW1::Sort4:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon CLI:Distribuidor for sort order 3
  BRW1.AddSortOrder(BRW1::Sort4:StepClass,CLI:Por_Distribuidor) ! Add the sort order for CLI:Por_Distribuidor for sort order 3
  BRW1.AddLocator(BRW1::Sort4:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort4:Locator.Init(?CLI:Distribuidor,CLI:Distribuidor,1,BRW1) ! Initialize the browse locator using ?CLI:Distribuidor using key: CLI:Por_Distribuidor , CLI:Distribuidor
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon CLI:Nombre for sort order 4
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,CLI:Por_Nombre)  ! Add the sort order for CLI:Por_Nombre for sort order 4
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 4
  BRW1::Sort0:Locator.Init(?CLI:Nombre,CLI:Nombre,1,BRW1)  ! Initialize the browse locator using ?CLI:Nombre using key: CLI:Por_Nombre , CLI:Nombre
  BRW1::Sort0:Locator.FloatRight = 1
  BRW1.AddField(CLI:CodCliente,BRW1.Q.CLI:CodCliente)      ! Field CLI:CodCliente is a hot field or requires assignment from browse
  BRW1.AddField(CLI:Nombre,BRW1.Q.CLI:Nombre)              ! Field CLI:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(CLI:Localidad,BRW1.Q.CLI:Localidad)        ! Field CLI:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(CLI:Distribuidor,BRW1.Q.CLI:Distribuidor)  ! Field CLI:Distribuidor is a hot field or requires assignment from browse
  BRW1.AddField(PCIA:CodProvincia,BRW1.Q.PCIA:CodProvincia) ! Field PCIA:CodProvincia is a hot field or requires assignment from browse
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
    Relate:CLIENTES.Close
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
    UpdateCLIENTES
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
      Movimientos
      ThisWindow.Reset
    OF ?Button5:2
      ThisWindow.Update
      CuentaCorriente
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
      
      loc:Nombre = CLI:Nombre
      
      IF CLI:CodPostal THEN
        local:Localidad = '(' & CLIP(CLI:CodPostal) & ') ' & CLIP(CLI:Localidad)
      ELSE
        local:Localidad = CLIP(CLI:Localidad)
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
  !----------------------------------------------------------------------
   LOOP GreenBarIndex=1 TO RECORDS(SELF.Q)
        GET(SELF.Q,GreenBarIndex)
        SELF.Q.CLI:CodCliente_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for CLI:CodCliente
        SELF.Q.CLI:CodCliente_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.CLI:CodCliente_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:CodCliente_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:Nombre_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for CLI:Nombre
        SELF.Q.CLI:Nombre_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.CLI:Nombre_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:Nombre_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:Localidad_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for CLI:Localidad
        SELF.Q.CLI:Localidad_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.CLI:Localidad_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:Localidad_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:Distribuidor_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for CLI:Distribuidor
        SELF.Q.CLI:Distribuidor_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.CLI:Distribuidor_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:Distribuidor_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        PUT(SELF.Q)
   END
  !----------------------------------------------------------------------


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
  ELSIF CHOICE(?CurrentTab) = 4
    RETURN SELF.SetSort(3,Force)
  ELSE
    RETURN SELF.SetSort(4,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW1.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  
  !----------------------------------------------------------------------
        SELF.Q.CLI:CodCliente_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for CLI:CodCliente
        SELF.Q.CLI:CodCliente_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.CLI:CodCliente_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:CodCliente_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:Nombre_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for CLI:Nombre
        SELF.Q.CLI:Nombre_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.CLI:Nombre_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:Nombre_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:Localidad_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for CLI:Localidad
        SELF.Q.CLI:Localidad_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.CLI:Localidad_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:Localidad_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:Distribuidor_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for CLI:Distribuidor
        SELF.Q.CLI:Distribuidor_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.CLI:Distribuidor_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:Distribuidor_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
  !----------------------------------------------------------------------

