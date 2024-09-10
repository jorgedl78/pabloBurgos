

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS022.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS025.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS026.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COMIS064.INC'),ONCE        !Req'd for module callout resolution
                     END


Movimientos PROCEDURE                                      ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:Total            DECIMAL(9,2)                          !
BRW1::View:Browse    VIEW(GUIAS)
                       PROJECT(GUIA:Fecha)
                       PROJECT(GUIA:Lugar)
                       PROJECT(GUIA:Numero)
                       PROJECT(GUIA:Flete)
                       PROJECT(GUIA:Importe)
                       PROJECT(GUIA:RegGuia)
                       PROJECT(GUIA:ClienteFacturar)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
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
GUIA:Flete             LIKE(GUIA:Flete)               !List box control field - type derived from field
GUIA:Flete_NormalFG    LONG                           !Normal forground color
GUIA:Flete_NormalBG    LONG                           !Normal background color
GUIA:Flete_SelectedFG  LONG                           !Selected forground color
GUIA:Flete_SelectedBG  LONG                           !Selected background color
GUIA:Importe           LIKE(GUIA:Importe)             !List box control field - type derived from field
GUIA:Importe_NormalFG  LONG                           !Normal forground color
GUIA:Importe_NormalBG  LONG                           !Normal background color
GUIA:Importe_SelectedFG LONG                          !Selected forground color
GUIA:Importe_SelectedBG LONG                          !Selected background color
GUIA:RegGuia           LIKE(GUIA:RegGuia)             !Primary key field - type derived from field
GUIA:ClienteFacturar   LIKE(GUIA:ClienteFacturar)     !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Guías Sin Facturar'),AT(,,247,169),FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,GRAY,DOUBLE
                       PANEL,AT(-5,8,253,17),USE(?Panel1),FILL(COLOR:Maroon),BEVEL(-1)
                       STRING(@s40),AT(11,11,225,12),USE(CLI:Nombre),TRN,CENTER,FONT(,10,COLOR:White,FONT:bold)
                       LIST,AT(13,33,221,91),USE(?List),IMM,VSCROLL,COLOR(,COLOR:White,COLOR:Green),FORMAT('60R(4)|F*J~Fecha~C(0)@d6@[23R(3)F*@n04@30R(4)|F*@n08@](65)|F~Remito-Guía Nro.~L(' &|
   '2)29C|F*~Flete~@s1@48R(3)|F*~Importe~C(0)@n12.2@'),FROM(Queue:Browse)
                       BUTTON,AT(13,128,21,15),USE(?Destinatario),SKIP,TIP('Remitente / Destinatario'),ICON('C:\Comisiones\ComisionesSRL\botones\distribuidor.ico')
                       BUTTON,AT(39,128,21,15),USE(?Redespacho),SKIP,TIP('Redespacho'),ICON('C:\Comisiones\ComisionesSRL\botones\camion2.ico')
                       STRING('Total:'),AT(143,131),USE(?String3),TRN,FONT(,,,FONT:bold)
                       BOX,AT(171,129,63,11),USE(?Box1),ROUND,COLOR(COLOR:Black),FILL(08EEEECH)
                       STRING(@n-13.2),AT(174,131),USE(loc:Total),TRN,RIGHT(1),FONT(,,,FONT:bold)
                       LINE,AT(13,146,221,0),USE(?Line1),COLOR(COLOR:Gray),LINEWIDTH(2)
                       BUTTON('Cerrar'),AT(190,151,45,14),USE(?Button3),SKIP,RIGHT,ICON('C:\Comisiones\ComisionesSRL\botones\sale.ico'),STD(STD:Close)
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


  CODE
? DEBUGHOOK(CLIENTES:Record)
? DEBUGHOOK(GUIAS:Record)
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
  GlobalErrors.SetProcedureName('Movimientos')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:GUIAS,SELF) ! Initialize the browse manager
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,GUIA:Por_Cliente_FechaD)              ! Add the sort order for GUIA:Por_Cliente_FechaD for sort order 1
  BRW1.AddRange(GUIA:ClienteFacturar,Relate:GUIAS,Relate:CLIENTES) ! Add file relationship range limit for sort order 1
  BRW1.SetFilter('(GUIA:FormaPago = 1 AND NOT GUIA:Facturada)') ! Apply filter expression to browse
  ?List{PROP:IconList,1} = '~botones\notilde.ico'
  ?List{PROP:IconList,2} = '~botones\tilde.ico'
  BRW1.AddField(GUIA:Fecha,BRW1.Q.GUIA:Fecha)              ! Field GUIA:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Lugar,BRW1.Q.GUIA:Lugar)              ! Field GUIA:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Numero,BRW1.Q.GUIA:Numero)            ! Field GUIA:Numero is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Flete,BRW1.Q.GUIA:Flete)              ! Field GUIA:Flete is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Importe,BRW1.Q.GUIA:Importe)          ! Field GUIA:Importe is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:RegGuia,BRW1.Q.GUIA:RegGuia)          ! Field GUIA:RegGuia is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:ClienteFacturar,BRW1.Q.GUIA:ClienteFacturar) ! Field GUIA:ClienteFacturar is a hot field or requires assignment from browse
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
    OF ?Destinatario
      ThisWindow.Update
      BRW1.UpdateViewRecord
      IF GUIA:ClienteFacturar = GUIA:Remitente THEN
        Destinatario
      ELSE
        Remitente
      END
    OF ?Redespacho
      ThisWindow.Update
      Redespacho
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
    OF ?List
      BRW1.UpdateViewRecord
      
      IF NOT RECORDS(BRW1) THEN
        DISABLE(?Destinatario)
      ELSE
        ENABLE(?Destinatario)
      END
      
      IF GUIA:Redespacho THEN
        ENABLE(?Redespacho)
      ELSE
        DISABLE(?Redespacho)
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


BRW1.ResetFromView PROCEDURE

loc:Total:Sum        REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:GUIAS.SetQuickScan(1)
  SELF.Reset
  LOOP
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    loc:Total:Sum += GUIA:Importe
  END
  loc:Total = loc:Total:Sum
  PARENT.ResetFromView
  Relate:GUIAS.SetQuickScan(0)
  SETCURSOR()


BRW1.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  
  SELF.Q.GUIA:Fecha_NormalFG = -1                          ! Set color values for GUIA:Fecha
  SELF.Q.GUIA:Fecha_NormalBG = -1
  SELF.Q.GUIA:Fecha_SelectedFG = -1
  SELF.Q.GUIA:Fecha_SelectedBG = -1
  IF (GUIA:Cumplida)
    SELF.Q.GUIA:Fecha_Icon = 2                             ! Set icon from icon list
  ELSE
    SELF.Q.GUIA:Fecha_Icon = 1                             ! Set icon from icon list
  END
  SELF.Q.GUIA:Lugar_NormalFG = -1                          ! Set color values for GUIA:Lugar
  SELF.Q.GUIA:Lugar_NormalBG = -1
  SELF.Q.GUIA:Lugar_SelectedFG = -1
  SELF.Q.GUIA:Lugar_SelectedBG = -1
  SELF.Q.GUIA:Numero_NormalFG = -1                         ! Set color values for GUIA:Numero
  SELF.Q.GUIA:Numero_NormalBG = -1
  SELF.Q.GUIA:Numero_SelectedFG = -1
  SELF.Q.GUIA:Numero_SelectedBG = -1
  SELF.Q.GUIA:Flete_NormalFG = -1                          ! Set color values for GUIA:Flete
  SELF.Q.GUIA:Flete_NormalBG = -1
  SELF.Q.GUIA:Flete_SelectedFG = -1
  SELF.Q.GUIA:Flete_SelectedBG = -1
  SELF.Q.GUIA:Importe_NormalFG = -1                        ! Set color values for GUIA:Importe
  SELF.Q.GUIA:Importe_NormalBG = -1
  SELF.Q.GUIA:Importe_SelectedFG = -1
  SELF.Q.GUIA:Importe_SelectedBG = -1

