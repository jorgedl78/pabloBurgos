

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS052.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS053.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS121.INC'),ONCE        !Req'd for module callout resolution
                     END


COMPRAS PROCEDURE                                          ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
FilesOpened          BYTE                                  !
BRW1::View:Browse    VIEW(FACPROV)
                       PROJECT(FCP:FechaEmision)
                       PROJECT(FCP:CodProveedor)
                       PROJECT(FCP:Letra)
                       PROJECT(FCP:Lugar)
                       PROJECT(FCP:Numero)
                       PROJECT(FCP:Importe)
                       PROJECT(FCP:RegFacturaProv)
                       PROJECT(FCP:FechaPresentacion)
                       PROJECT(FCP:Comprobante)
                       JOIN(PROV:Por_CodProveedor,FCP:CodProveedor)
                         PROJECT(PROV:Nombre)
                         PROJECT(PROV:CodProveedor)
                       END
                       JOIN(CPTE:Por_Codigo,FCP:Comprobante)
                         PROJECT(CPTE:Abreviatura)
                         PROJECT(CPTE:Codigo)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
CPTE:Abreviatura       LIKE(CPTE:Abreviatura)         !List box control field - type derived from field
FCP:FechaEmision       LIKE(FCP:FechaEmision)         !List box control field - type derived from field
FCP:CodProveedor       LIKE(FCP:CodProveedor)         !List box control field - type derived from field
PROV:Nombre            LIKE(PROV:Nombre)              !List box control field - type derived from field
FCP:Letra              LIKE(FCP:Letra)                !List box control field - type derived from field
FCP:Lugar              LIKE(FCP:Lugar)                !List box control field - type derived from field
FCP:Numero             LIKE(FCP:Numero)               !List box control field - type derived from field
FCP:Importe            LIKE(FCP:Importe)              !List box control field - type derived from field
FCP:RegFacturaProv     LIKE(FCP:RegFacturaProv)       !Primary key field - type derived from field
FCP:FechaPresentacion  LIKE(FCP:FechaPresentacion)    !Browse key field - type derived from field
PROV:CodProveedor      LIKE(PROV:CodProveedor)        !Related join file key field - type derived from field
CPTE:Codigo            LIKE(CPTE:Codigo)              !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('COMPRAS'),AT(,,393,207),FONT('MS Sans Serif',8,,),COLOR(0E4EBEFH),CENTER,IMM,ICON('C:\Comisiones\ComisionesSRL\botones\anotador.ico'),SYSTEM,GRAY,DOUBLE,MDI
                       PANEL,AT(-1,6,395,20),USE(?Panel1),FILL(0EDF0E6H),BEVEL(-1)
                       STRING('Empresa:'),AT(78,10),USE(?String2),TRN,FONT(,10,,FONT:bold)
                       SPIN(@n1b),AT(131,10,25,13),USE(PAR:Registro),CENTER,FONT('Arial Black',12,,),COLOR(080FF00H),RANGE(1,3),STEP(2)
                       STRING(@s35),AT(163,10,191,12),USE(PAR:RazonSocial),TRN,FONT(,10,COLOR:Blue,FONT:bold)
                       LIST,AT(12,53,369,107),USE(?Browse:1),IMM,VSCROLL,COLOR(COLOR:White),FORMAT('23C|FM~Cpte~@s3@47R(2)|FM~Fecha~C(0)@d6@21R(2)F@n4@147L(2)|FM~Proveedor~R(65)@s4' &|
   '0@[10CF@s1@23R(2)F@n04@33R(2)|FM@n08@](73)|FM~Número~52R(3)|FM~Importe~L(2)@n-13' &|
   '.2@'),FROM(Queue:Browse:1)
                       BUTTON('Agregar'),AT(213,163,54,16),USE(?Insert:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\agregar.ico')
                       BUTTON('Modificar'),AT(270,163,54,16),USE(?Change:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\modificar.ico')
                       BUTTON(' Borrar'),AT(327,163,54,16),USE(?Delete:2),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\borrar.ico')
                       SHEET,AT(7,34,380,149),USE(?CurrentTab),ABOVE(68)
                         TAB('Por &Fecha'),USE(?Tab:2)
                           PROMPT('Fecha:'),AT(12,166),USE(?FCP:FechaPresentacion:Prompt),TRN
                           ENTRY(@d6b),AT(45,166,49,10),USE(FCP:FechaPresentacion),RIGHT(1)
                         END
                         TAB('Por &Número'),USE(?Tab:3)
                           PROMPT('Número:'),AT(12,166),USE(?FCP:Numero:Prompt),TRN
                           ENTRY(@n8b),AT(45,166,49,10),USE(FCP:Numero),RIGHT(1)
                         END
                         TAB('Por &Proveedor'),USE(?Tab:4)
                           BUTTON('Proveedor?'),AT(12,163,62,16),USE(?SelectPROVEEDOR),SKIP,LEFT,ICON('WAParent.ICO')
                         END
                       END
                       BUTTON('   Cerrar'),AT(170,187,54,16),USE(?Close),SKIP,RIGHT,ICON('C:\Comisiones\ComisionesSRL\botones\sale.ico')
                       BUTTON('Ver Ficha'),AT(135,163,56,16),USE(?View),SKIP,LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\ventana.ico')
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
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW1::Sort1:Locator  EntryLocatorClass                     ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
BRW1::Sort1:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort2:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 3

  CODE
? DEBUGHOOK(FACPROV:Record)
? DEBUGHOOK(PARAMETRO:Record)
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
  GlobalErrors.SetProcedureName('COMPRAS')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCompleted)                    ! Add the close control to the window amanger
  Relate:FACPROV.SetOpenRelated()
  Relate:FACPROV.Open                                      ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:FACPROV,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon FCP:Numero for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,FCP:Por_NroComprobante) ! Add the sort order for FCP:Por_NroComprobante for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?FCP:Numero,FCP:Numero,1,BRW1)  ! Initialize the browse locator using ?FCP:Numero using key: FCP:Por_NroComprobante , FCP:Numero
  BRW1.SetFilter('(FCP:Empresa = PAR:Registro)')           ! Apply filter expression to browse
  BRW1::Sort2:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon FCP:CodProveedor for sort order 2
  BRW1.AddSortOrder(BRW1::Sort2:StepClass,FCP:Por_Proveedor_Fecha) ! Add the sort order for FCP:Por_Proveedor_Fecha for sort order 2
  BRW1.AddRange(FCP:CodProveedor,glo:Proveedor)            ! Add single value range limit for sort order 2
  BRW1.SetFilter('(FCP:Empresa = PAR:Registro)')           ! Apply filter expression to browse
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha+ScrollSort:Descending) ! Moveable thumb based upon FCP:FechaPresentacion for sort order 3
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,FCP:Por_FechaPresentacionD) ! Add the sort order for FCP:Por_FechaPresentacionD for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(?FCP:FechaPresentacion,FCP:FechaPresentacion,1,BRW1) ! Initialize the browse locator using ?FCP:FechaPresentacion using key: FCP:Por_FechaPresentacionD , FCP:FechaPresentacion
  BRW1.SetFilter('(FCP:Empresa = PAR:Registro)')           ! Apply filter expression to browse
  BRW1.AddField(CPTE:Abreviatura,BRW1.Q.CPTE:Abreviatura)  ! Field CPTE:Abreviatura is a hot field or requires assignment from browse
  BRW1.AddField(FCP:FechaEmision,BRW1.Q.FCP:FechaEmision)  ! Field FCP:FechaEmision is a hot field or requires assignment from browse
  BRW1.AddField(FCP:CodProveedor,BRW1.Q.FCP:CodProveedor)  ! Field FCP:CodProveedor is a hot field or requires assignment from browse
  BRW1.AddField(PROV:Nombre,BRW1.Q.PROV:Nombre)            ! Field PROV:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(FCP:Letra,BRW1.Q.FCP:Letra)                ! Field FCP:Letra is a hot field or requires assignment from browse
  BRW1.AddField(FCP:Lugar,BRW1.Q.FCP:Lugar)                ! Field FCP:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(FCP:Numero,BRW1.Q.FCP:Numero)              ! Field FCP:Numero is a hot field or requires assignment from browse
  BRW1.AddField(FCP:Importe,BRW1.Q.FCP:Importe)            ! Field FCP:Importe is a hot field or requires assignment from browse
  BRW1.AddField(FCP:RegFacturaProv,BRW1.Q.FCP:RegFacturaProv) ! Field FCP:RegFacturaProv is a hot field or requires assignment from browse
  BRW1.AddField(FCP:FechaPresentacion,BRW1.Q.FCP:FechaPresentacion) ! Field FCP:FechaPresentacion is a hot field or requires assignment from browse
  BRW1.AddField(PROV:CodProveedor,BRW1.Q.PROV:CodProveedor) ! Field PROV:CodProveedor is a hot field or requires assignment from browse
  BRW1.AddField(CPTE:Codigo,BRW1.Q.CPTE:Codigo)            ! Field CPTE:Codigo is a hot field or requires assignment from browse
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
    Relate:FACPROV.Close
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
    UpdateFACPROV
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
    OF ?Change:2
      BRW1.UpdateViewRecord
      IF FCP:FechaPresentacion < (TODAY()-60) THEN
        MESSAGE('Comprobante ya presentado.','Periodo Cerrado!!!',ICON:Exclamation)
        CYCLE
      END
    OF ?Delete:2
      BRW1.UpdateViewRecord
      IF FCP:FechaPresentacion < (TODAY()-60) THEN
        MESSAGE('Comprobante ya presentado.','Periodo Cerrado!!!',ICON:Exclamation)
        CYCLE
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?SelectPROVEEDOR
      ThisWindow.Update
      GlobalRequest = SelectRecord
      SelectPROVEEDORES
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
    OF ?PAR:Registro
      GET(PARAMETRO,PAR:Por_Registro)
      
      ThisWindow.Reset(TRUE)
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
    CASE EVENT()
    OF EVENT:OpenWindow
      PAR:Registro = 1
      GET(PARAMETRO,PAR:Por_Registro)
      ThisWindow.Reset(TRUE)
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
  SELF.ViewControl = ?View                                 ! Setup the control used to initiate view only mode


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

