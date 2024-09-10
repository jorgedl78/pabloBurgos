

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS031.INC'),ONCE        !Local module procedure declarations
                     END


VistaGuias PROCEDURE                                       ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:Nombre           STRING(40)                            !
loc:Importe          DECIMAL(9,2)                          !
BRW1::View:Browse    VIEW(APLIGUIA)
                       PROJECT(APGUIA:Factura)
                       PROJECT(APGUIA:Guia)
                       JOIN(GUIA:Por_Registro,APGUIA:Guia)
                         PROJECT(GUIA:Letra)
                         PROJECT(GUIA:Lugar)
                         PROJECT(GUIA:Numero)
                         PROJECT(GUIA:Fecha)
                         PROJECT(GUIA:Flete)
                         PROJECT(GUIA:RegGuia)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
GUIA:Letra             LIKE(GUIA:Letra)               !List box control field - type derived from field
GUIA:Lugar             LIKE(GUIA:Lugar)               !List box control field - type derived from field
GUIA:Numero            LIKE(GUIA:Numero)              !List box control field - type derived from field
GUIA:Fecha             LIKE(GUIA:Fecha)               !List box control field - type derived from field
loc:Nombre             LIKE(loc:Nombre)               !List box control field - type derived from local data
GUIA:Flete             LIKE(GUIA:Flete)               !List box control field - type derived from field
loc:Importe            LIKE(loc:Importe)              !List box control field - type derived from local data
APGUIA:Factura         LIKE(APGUIA:Factura)           !Primary key field - type derived from field
APGUIA:Guia            LIKE(APGUIA:Guia)              !Primary key field - type derived from field
GUIA:RegGuia           LIKE(GUIA:RegGuia)             !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Guías Aplicadas...'),AT(,,369,76),FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,DOUBLE
                       LIST,AT(11,15,347,50),USE(?List),IMM,VSCROLL,COLOR(0FFFFB7H,COLOR:Black,080FF80H),FORMAT('[9CF@s1@21R(3)F@n04@39R(4)F@n08@]|F~Remito-Guía~L(2)49R(3)|F~Fecha~L(2)@d6@147L(' &|
   '2)|F~Remitente/Destinatario~@s40@22C|F~Flete~@s1@48R(3)|F~Importe~L(2)@n12.2@'),FROM(Queue:Browse)
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
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


  CODE
? DEBUGHOOK(APLIGUIA:Record)
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
  GlobalErrors.SetProcedureName('VistaGuias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('loc:Nombre',loc:Nombre)                            ! Added by: BrowseBox(ABC)
  BIND('loc:Importe',loc:Importe)                          ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:APLIGUIA.SetOpenRelated()
  Relate:APLIGUIA.Open                                     ! File FACTURAS used by this procedure, so make sure it's RelationManager is open
  Access:FACTURAS.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:APLIGUIA,SELF) ! Initialize the browse manager
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,APGUIA:Por_Factura)                   ! Add the sort order for APGUIA:Por_Factura for sort order 1
  BRW1.AddRange(APGUIA:Factura,Relate:APLIGUIA,Relate:FACTURAS) ! Add file relationship range limit for sort order 1
  BRW1.AddField(GUIA:Letra,BRW1.Q.GUIA:Letra)              ! Field GUIA:Letra is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Lugar,BRW1.Q.GUIA:Lugar)              ! Field GUIA:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Numero,BRW1.Q.GUIA:Numero)            ! Field GUIA:Numero is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Fecha,BRW1.Q.GUIA:Fecha)              ! Field GUIA:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(loc:Nombre,BRW1.Q.loc:Nombre)              ! Field loc:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:Flete,BRW1.Q.GUIA:Flete)              ! Field GUIA:Flete is a hot field or requires assignment from browse
  BRW1.AddField(loc:Importe,BRW1.Q.loc:Importe)            ! Field loc:Importe is a hot field or requires assignment from browse
  BRW1.AddField(APGUIA:Factura,BRW1.Q.APGUIA:Factura)      ! Field APGUIA:Factura is a hot field or requires assignment from browse
  BRW1.AddField(APGUIA:Guia,BRW1.Q.APGUIA:Guia)            ! Field APGUIA:Guia is a hot field or requires assignment from browse
  BRW1.AddField(GUIA:RegGuia,BRW1.Q.GUIA:RegGuia)          ! Field GUIA:RegGuia is a hot field or requires assignment from browse
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
    Relate:APLIGUIA.Close
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


BRW1.SetQueueRecord PROCEDURE

  CODE
  IF (FAC:Letra = 'B')
    loc:Importe = GUIA:Importe * 1.21
  ELSE
    loc:Importe = GUIA:Importe
  END
  IF GUIA:FacturarA = 'R' THEN loc:Nombre = 'D   ' & GUIA:NombreDestino.
  IF GUIA:FacturarA = 'D' THEN loc:Nombre = 'R   ' & GUIA:NombreRemitente.
  PARENT.SetQueueRecord
  
  SELF.Q.loc:Importe = loc:Importe                         !Assign formula result to display queue

