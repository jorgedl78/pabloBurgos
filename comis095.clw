

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS095.INC'),ONCE        !Local module procedure declarations
                     END


VALORES PROCEDURE                                          ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
loc:Banco            STRING(5)                             !
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?BCO:Denominacion
BCO:Denominacion       LIKE(BCO:Denominacion)         !List box control field - type derived from field
BCO:Codigo             LIKE(BCO:Codigo)               !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW1::View:Browse    VIEW(VALORES)
                       PROJECT(VAL:Fecha)
                       PROJECT(VAL:Numero)
                       PROJECT(VAL:Importe)
                       PROJECT(VAL:CodigoInterno)
                       PROJECT(VAL:Banco)
                       PROJECT(VAL:Recibo)
                       JOIN(FAC:Por_Registro,VAL:Recibo)
                         PROJECT(FAC:Lugar)
                         PROJECT(FAC:Numero)
                         PROJECT(FAC:RegFactura)
                         PROJECT(FAC:ClienteFacturar)
                         JOIN(CLI:Por_Codigo,FAC:ClienteFacturar)
                           PROJECT(CLI:Nombre)
                           PROJECT(CLI:CodCliente)
                         END
                       END
                       JOIN(BCO:Por_Codigo,VAL:Banco)
                         PROJECT(BCO:Denominacion)
                         PROJECT(BCO:Codigo)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
VAL:Fecha              LIKE(VAL:Fecha)                !List box control field - type derived from field
VAL:Fecha_NormalFG     LONG                           !Normal forground color
VAL:Fecha_NormalBG     LONG                           !Normal background color
VAL:Fecha_SelectedFG   LONG                           !Selected forground color
VAL:Fecha_SelectedBG   LONG                           !Selected background color
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
VAL:Importe            LIKE(VAL:Importe)              !List box control field - type derived from field
VAL:Importe_NormalFG   LONG                           !Normal forground color
VAL:Importe_NormalBG   LONG                           !Normal background color
VAL:Importe_SelectedFG LONG                           !Selected forground color
VAL:Importe_SelectedBG LONG                           !Selected background color
FAC:Lugar              LIKE(FAC:Lugar)                !List box control field - type derived from field
FAC:Lugar_NormalFG     LONG                           !Normal forground color
FAC:Lugar_NormalBG     LONG                           !Normal background color
FAC:Lugar_SelectedFG   LONG                           !Selected forground color
FAC:Lugar_SelectedBG   LONG                           !Selected background color
FAC:Numero             LIKE(FAC:Numero)               !List box control field - type derived from field
FAC:Numero_NormalFG    LONG                           !Normal forground color
FAC:Numero_NormalBG    LONG                           !Normal background color
FAC:Numero_SelectedFG  LONG                           !Selected forground color
FAC:Numero_SelectedBG  LONG                           !Selected background color
CLI:Nombre             LIKE(CLI:Nombre)               !List box control field - type derived from field
CLI:Nombre_NormalFG    LONG                           !Normal forground color
CLI:Nombre_NormalBG    LONG                           !Normal background color
CLI:Nombre_SelectedFG  LONG                           !Selected forground color
CLI:Nombre_SelectedBG  LONG                           !Selected background color
VAL:CodigoInterno      LIKE(VAL:CodigoInterno)        !Primary key field - type derived from field
VAL:Banco              LIKE(VAL:Banco)                !Browse key field - type derived from field
FAC:RegFactura         LIKE(FAC:RegFactura)           !Related join file key field - type derived from field
CLI:CodCliente         LIKE(CLI:CodCliente)           !Related join file key field - type derived from field
BCO:Codigo             LIKE(BCO:Codigo)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
FDCB3::View:FileDropCombo VIEW(BANCOS)
                       PROJECT(BCO:Denominacion)
                       PROJECT(BCO:Codigo)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
QuickWindow          WINDOW('VALORES'),AT(,,433,198),FONT('MS Sans Serif',8,,FONT:regular),COLOR(0E4EBEFH),CENTER,IMM,ICON('C:\Comisiones\ComisionesSRL\botones\valores.ico'),SYSTEM,GRAY,DOUBLE,MDI
                       LIST,AT(13,23,407,131),USE(?Browse:1),IMM,VSCROLL,COLOR(0EDECE2H),FORMAT('49R(2)|FM*~Fecha~L@d6@102L(2)|FM*~Banco~@s25@42R(2)|FM*~Número~L@n10.@49R(2)|FM*' &|
   '~Importe~L@n-13.2@[23R(2)F*@n04@38R(2)|FM*@n08@]|FM~Recibo~L(2)160L(2)|FM*~Clien' &|
   'te~@s40@'),FROM(Queue:Browse:1)
                       SHEET,AT(7,4,419,171),USE(?CurrentTab)
                         TAB('Por &Fecha'),USE(?Tab:2)
                           PROMPT('Fecha:'),AT(26,159),USE(?VAL:Fecha:Prompt),TRN
                           ENTRY(@d6b),AT(58,159,49,10),USE(VAL:Fecha),RIGHT(1),FONT(,,0A00000H,,CHARSET:ANSI)
                         END
                         TAB('Por &Banco/Número'),USE(?Tab:3)
                           STRING('Banco:'),AT(26,159),USE(?String1),TRN
                           COMBO(@s20),AT(58,159,121,10),USE(BCO:Denominacion),IMM,UPR,FORMAT('100L(2)|M@s25@'),DROP(5),FROM(Queue:FileDropCombo)
                         END
                         TAB('Por &Número'),USE(?Tab:4)
                           PROMPT('Número:'),AT(26,159),USE(?VAL:Numero:Prompt),TRN
                           ENTRY(@n10.b),AT(58,159,49,10),USE(VAL:Numero),RIGHT(1),FONT(,,0A00000H,,CHARSET:ANSI)
                         END
                       END
                       BUTTON('Cerrar'),AT(190,179,54,16),USE(?Close),SKIP,RIGHT,ICON('C:\Comisiones\ComisionesSRL\botones\sale.ico')
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
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW1::Sort3:Locator  EntryLocatorClass                     ! Conditional Locator - CHOICE(?CurrentTab) = 3
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
BRW1::Sort2:StepClass StepStringClass                      ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort3:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 3
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

FDCB3                CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo           !Reference to browse queue type
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END


  CODE
? DEBUGHOOK(BANCOS:Record)
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
  GlobalErrors.SetProcedureName('VALORES')
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
  Relate:BANCOS.SetOpenRelated()
  Relate:BANCOS.Open                                       ! File BANCOS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:VALORES,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort2:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon VAL:Banco for sort order 1
  BRW1.AddSortOrder(BRW1::Sort2:StepClass,VAL:Por_Banco)   ! Add the sort order for VAL:Por_Banco for sort order 1
  BRW1.AddRange(VAL:Banco,loc:Banco)                       ! Add single value range limit for sort order 1
  BRW1::Sort3:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon VAL:Numero for sort order 2
  BRW1.AddSortOrder(BRW1::Sort3:StepClass,VAL:Por_Numero)  ! Add the sort order for VAL:Por_Numero for sort order 2
  BRW1.AddLocator(BRW1::Sort3:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort3:Locator.Init(?VAL:Numero,VAL:Numero,1,BRW1)  ! Initialize the browse locator using ?VAL:Numero using key: VAL:Por_Numero , VAL:Numero
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon VAL:Fecha for sort order 3
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,VAL:Por_Fecha)   ! Add the sort order for VAL:Por_Fecha for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(?VAL:Fecha,VAL:Fecha,1,BRW1)    ! Initialize the browse locator using ?VAL:Fecha using key: VAL:Por_Fecha , VAL:Fecha
  BRW1.SetFilter('(VAL:Tipo = ''Cheque'')')                ! Apply filter expression to browse
  BRW1.AddField(VAL:Fecha,BRW1.Q.VAL:Fecha)                ! Field VAL:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(BCO:Denominacion,BRW1.Q.BCO:Denominacion)  ! Field BCO:Denominacion is a hot field or requires assignment from browse
  BRW1.AddField(VAL:Numero,BRW1.Q.VAL:Numero)              ! Field VAL:Numero is a hot field or requires assignment from browse
  BRW1.AddField(VAL:Importe,BRW1.Q.VAL:Importe)            ! Field VAL:Importe is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Lugar,BRW1.Q.FAC:Lugar)                ! Field FAC:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Numero,BRW1.Q.FAC:Numero)              ! Field FAC:Numero is a hot field or requires assignment from browse
  BRW1.AddField(CLI:Nombre,BRW1.Q.CLI:Nombre)              ! Field CLI:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(VAL:CodigoInterno,BRW1.Q.VAL:CodigoInterno) ! Field VAL:CodigoInterno is a hot field or requires assignment from browse
  BRW1.AddField(VAL:Banco,BRW1.Q.VAL:Banco)                ! Field VAL:Banco is a hot field or requires assignment from browse
  BRW1.AddField(FAC:RegFactura,BRW1.Q.FAC:RegFactura)      ! Field FAC:RegFactura is a hot field or requires assignment from browse
  BRW1.AddField(CLI:CodCliente,BRW1.Q.CLI:CodCliente)      ! Field CLI:CodCliente is a hot field or requires assignment from browse
  BRW1.AddField(BCO:Codigo,BRW1.Q.BCO:Codigo)              ! Field BCO:Codigo is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  FDCB3.Init(BCO:Denominacion,?BCO:Denominacion,Queue:FileDropCombo.ViewPosition,FDCB3::View:FileDropCombo,Queue:FileDropCombo,Relate:BANCOS,ThisWindow,GlobalErrors,0,1,0)
  FDCB3.Q &= Queue:FileDropCombo
  FDCB3.AddSortOrder()
  FDCB3.AddField(BCO:Denominacion,FDCB3.Q.BCO:Denominacion)
  FDCB3.AddField(BCO:Codigo,FDCB3.Q.BCO:Codigo)
  FDCB3.AddUpdateField(BCO:Codigo,loc:Banco)
  ThisWindow.AddItem(FDCB3.WindowComponent)
  FDCB3.DefaultFill = 0
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
    Relate:BANCOS.Close
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


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)
  !----------------------------------------------------------------------
   LOOP GreenBarIndex=1 TO RECORDS(SELF.Q)
        GET(SELF.Q,GreenBarIndex)
        SELF.Q.VAL:Fecha_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for VAL:Fecha
        SELF.Q.VAL:Fecha_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.VAL:Fecha_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Fecha_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.BCO:Denominacion_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for BCO:Denominacion
        SELF.Q.BCO:Denominacion_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.BCO:Denominacion_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.BCO:Denominacion_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Numero_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for VAL:Numero
        SELF.Q.VAL:Numero_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.VAL:Numero_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Numero_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Importe_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for VAL:Importe
        SELF.Q.VAL:Importe_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.VAL:Importe_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.VAL:Importe_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.FAC:Lugar_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for FAC:Lugar
        SELF.Q.FAC:Lugar_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.FAC:Lugar_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.FAC:Lugar_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.FAC:Numero_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for FAC:Numero
        SELF.Q.FAC:Numero_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.FAC:Numero_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.FAC:Numero_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:Nombre_NormalFG   = CHOOSE(GreenBarIndex % 2,-1,-1) ! Set color values for CLI:Nombre
        SELF.Q.CLI:Nombre_NormalBG   = CHOOSE(GreenBarIndex % 2,-1,16777215)
        SELF.Q.CLI:Nombre_SelectedFG = CHOOSE(GreenBarIndex % 2,-1,-1)
        SELF.Q.CLI:Nombre_SelectedBG = CHOOSE(GreenBarIndex % 2,-1,-1)
        PUT(SELF.Q)
   END
  !----------------------------------------------------------------------


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
  
  !----------------------------------------------------------------------
        SELF.Q.VAL:Fecha_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for VAL:Fecha
        SELF.Q.VAL:Fecha_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.VAL:Fecha_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.VAL:Fecha_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.BCO:Denominacion_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for BCO:Denominacion
        SELF.Q.BCO:Denominacion_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.BCO:Denominacion_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.BCO:Denominacion_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.VAL:Numero_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for VAL:Numero
        SELF.Q.VAL:Numero_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.VAL:Numero_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.VAL:Numero_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.VAL:Importe_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for VAL:Importe
        SELF.Q.VAL:Importe_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.VAL:Importe_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.VAL:Importe_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.FAC:Lugar_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for FAC:Lugar
        SELF.Q.FAC:Lugar_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.FAC:Lugar_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.FAC:Lugar_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.FAC:Numero_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for FAC:Numero
        SELF.Q.FAC:Numero_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.FAC:Numero_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.FAC:Numero_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:Nombre_NormalFG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1) ! Set color values for CLI:Nombre
        SELF.Q.CLI:Nombre_NormalBG   = CHOOSE(CHOICE(?Browse:1) % 2,-1,16777215)
        SELF.Q.CLI:Nombre_SelectedFG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
        SELF.Q.CLI:Nombre_SelectedBG = CHOOSE(CHOICE(?Browse:1) % 2,-1,-1)
  !----------------------------------------------------------------------


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window


FDCB3.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue

