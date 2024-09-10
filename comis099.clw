

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS099.INC'),ONCE        !Local module procedure declarations
                     END


CuentaCorriente PROCEDURE                                  ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
loc:Debito           DECIMAL(9,2)                          !
loc:Credito          DECIMAL(9,2)                          !
loc:Saldo            DECIMAL(9,2)                          !
loc:TotalDebito      DECIMAL(9,2)                          !
loc:TotalCredito     DECIMAL(9,2)                          !
loc:TotalSaldo       DECIMAL(9,2)                          !
BRW1::View:Browse    VIEW(FACTURAS)
                       PROJECT(FAC:Fecha)
                       PROJECT(FAC:Comprobante)
                       PROJECT(FAC:Letra)
                       PROJECT(FAC:Lugar)
                       PROJECT(FAC:Numero)
                       PROJECT(FAC:RegFactura)
                       PROJECT(FAC:ClienteFacturar)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
FAC:Fecha              LIKE(FAC:Fecha)                !List box control field - type derived from field
FAC:Comprobante        LIKE(FAC:Comprobante)          !List box control field - type derived from field
FAC:Letra              LIKE(FAC:Letra)                !List box control field - type derived from field
FAC:Lugar              LIKE(FAC:Lugar)                !List box control field - type derived from field
FAC:Numero             LIKE(FAC:Numero)               !List box control field - type derived from field
loc:Debito             LIKE(loc:Debito)               !List box control field - type derived from local data
loc:Credito            LIKE(loc:Credito)              !List box control field - type derived from local data
loc:Saldo              LIKE(loc:Saldo)                !List box control field - type derived from local data
FAC:RegFactura         LIKE(FAC:RegFactura)           !Primary key field - type derived from field
FAC:ClienteFacturar    LIKE(FAC:ClienteFacturar)      !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('Cuenta Corriente'),AT(,,303,169),FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,GRAY,DOUBLE
                       PANEL,AT(-3,8,308,17),USE(?Panel1),FILL(COLOR:Maroon),BEVEL(-1)
                       STRING(@s40),AT(39,11,225,12),USE(CLI:Nombre),TRN,CENTER,FONT(,10,COLOR:White,FONT:bold)
                       LIST,AT(11,33,281,91),USE(?List),IMM,VSCROLL,COLOR(,COLOR:White,COLOR:Green),FORMAT('48R(3)|F~Fecha~L(2)@d6@[18CF@s3@10CF@s1@20R(2)F@n04@34R(3)|F@n08@]|F~Comprobante' &|
   '~L(2)46R(3)|F~Débito~L(2)@n-13.2b@46R(3)|F~Crédito~L(2)@n-13.2b@48R(3)|F~Saldo C' &|
   'pte.~L(2)@n-13.2@E(,0E0EFEFH,,)'),FROM(Queue:Browse)
                       STRING('Saldo:'),AT(204,129),USE(?String3),TRN,FONT(,,,FONT:bold)
                       BOX,AT(235,128,57,11),USE(?Box1),ROUND,COLOR(COLOR:Black),FILL(08EEEECH)
                       STRING(@n-13.2),AT(231,129),USE(loc:TotalSaldo),TRN,RIGHT(1),FONT(,,,FONT:bold)
                       LINE,AT(11,146,281,0),USE(?Line1),COLOR(COLOR:Gray),LINEWIDTH(2)
                       BUTTON('Cerrar'),AT(129,151,45,14),USE(?Button3),SKIP,RIGHT,ICON('C:\1L\Comisiones\botones\sale.ico'),STD(STD:Close)
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
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


  CODE
? DEBUGHOOK(CLIENTES:Record)
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
  GlobalErrors.SetProcedureName('CuentaCorriente')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('loc:Debito',loc:Debito)                            ! Added by: BrowseBox(ABC)
  BIND('loc:Credito',loc:Credito)                          ! Added by: BrowseBox(ABC)
  BIND('loc:Saldo',loc:Saldo)                              ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:CLIENTES.SetOpenRelated()
  Relate:CLIENTES.Open                                     ! File CLIENTES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:FACTURAS,SELF) ! Initialize the browse manager
  SELF.Open(Window)                                        ! Open window
  ?List{Prop:LineHeight} = 0
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,FAC:Por_Cliente)                      ! Add the sort order for FAC:Por_Cliente for sort order 1
  BRW1.AddRange(FAC:ClienteFacturar,Relate:FACTURAS,Relate:CLIENTES) ! Add file relationship range limit for sort order 1
  BRW1.AppendOrder('+FAC:Fecha')                           ! Append an additional sort order
  BRW1.SetFilter('(NOT(FAC:Cobrada))')                     ! Apply filter expression to browse
  BRW1.AddField(FAC:Fecha,BRW1.Q.FAC:Fecha)                ! Field FAC:Fecha is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Comprobante,BRW1.Q.FAC:Comprobante)    ! Field FAC:Comprobante is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Letra,BRW1.Q.FAC:Letra)                ! Field FAC:Letra is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Lugar,BRW1.Q.FAC:Lugar)                ! Field FAC:Lugar is a hot field or requires assignment from browse
  BRW1.AddField(FAC:Numero,BRW1.Q.FAC:Numero)              ! Field FAC:Numero is a hot field or requires assignment from browse
  BRW1.AddField(loc:Debito,BRW1.Q.loc:Debito)              ! Field loc:Debito is a hot field or requires assignment from browse
  BRW1.AddField(loc:Credito,BRW1.Q.loc:Credito)            ! Field loc:Credito is a hot field or requires assignment from browse
  BRW1.AddField(loc:Saldo,BRW1.Q.loc:Saldo)                ! Field loc:Saldo is a hot field or requires assignment from browse
  BRW1.AddField(FAC:RegFactura,BRW1.Q.FAC:RegFactura)      ! Field FAC:RegFactura is a hot field or requires assignment from browse
  BRW1.AddField(FAC:ClienteFacturar,BRW1.Q.FAC:ClienteFacturar) ! Field FAC:ClienteFacturar is a hot field or requires assignment from browse
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


BRW1.ResetFromView PROCEDURE

loc:TotalDebito:Sum  REAL                                  ! Sum variable for browse totals
loc:TotalCredito:Sum REAL                                  ! Sum variable for browse totals
loc:TotalSaldo:Sum   REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:FACTURAS.SetQuickScan(1)
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
    loc:TotalDebito:Sum += loc:Debito
    loc:TotalCredito:Sum += loc:Credito
    loc:TotalSaldo:Sum += loc:Saldo
  END
  loc:TotalDebito = loc:TotalDebito:Sum
  loc:TotalCredito = loc:TotalCredito:Sum
  loc:TotalSaldo = loc:TotalSaldo:Sum
  PARENT.ResetFromView
  Relate:FACTURAS.SetQuickScan(0)
  SETCURSOR()


BRW1.SetQueueRecord PROCEDURE

  CODE
  loc:Saldo = FAC:Importe + FAC:Aplicado
  IF (FAC:Comprobante = 'FAC')
    loc:Debito = FAC:Importe
  ELSE
    loc:Debito = 0
  END
  IF (FAC:Comprobante = 'REC')
    loc:Credito = FAC:Importe * -1
  ELSE
    loc:Credito = 0
  END
  PARENT.SetQueueRecord
  
  SELF.Q.loc:Debito = loc:Debito                           !Assign formula result to display queue
  SELF.Q.loc:Credito = loc:Credito                         !Assign formula result to display queue
  SELF.Q.loc:Saldo = loc:Saldo                             !Assign formula result to display queue

