

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS121.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS053.INC'),ONCE        !Req'd for module callout resolution
                     END


UpdateFACPROV PROCEDURE                                    ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
Queue:FileDrop       QUEUE                            !Queue declaration for browse/combo box using ?CPTE:Descripcion
CPTE:Descripcion       LIKE(CPTE:Descripcion)         !List box control field - type derived from field
CPTE:Codigo            LIKE(CPTE:Codigo)              !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
FDB7::View:FileDrop  VIEW(COMPROBANTES)
                       PROJECT(CPTE:Descripcion)
                       PROJECT(CPTE:Codigo)
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
History::FCP:Record  LIKE(FCP:RECORD),THREAD
QuickWindow          WINDOW('Form FACPROV'),AT(,,305,225),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,SYSTEM,GRAY,DOUBLE
                       SHEET,AT(7,6,289,197),USE(?CurrentTab),WIZARD
                         TAB('General'),USE(?Tab:1)
                           BOX,AT(9,9,287,16),USE(?Box2),FILL(COLOR:Green)
                           STRING(@s35),AT(50,12,205,),USE(PAR:RazonSocial),TRN,CENTER,FONT(,10,COLOR:Yellow,FONT:bold,CHARSET:ANSI)
                           PROMPT('Proveedor:'),AT(13,32),USE(?FCP:CodProveedor:Prompt),TRN
                           ENTRY(@n4b),AT(55,32,33,10),USE(FCP:CodProveedor),RIGHT(1),REQ
                           BUTTON('...'),AT(91,31,12,11),USE(?SelectPROVEEDOR),SKIP,TIP('Seleccionar Proveedor')
                           BOX,AT(109,31,180,11),USE(?Box1),ROUND,COLOR(COLOR:Black),FILL(080FFFFH)
                           STRING(@s40),AT(112,32,173,10),USE(PROV:Nombre),TRN,FONT(,,,FONT:bold)
                           STRING(@s25),AT(172,43),USE(IVA:Descripcion),TRN
                           STRING(@P##-########-#Pb),AT(110,43),USE(PROV:CUIT),TRN
                           PROMPT('Fecha Emisión:'),AT(13,58),USE(?FCP:FechaEmision:Prompt),TRN
                           ENTRY(@d6b),AT(65,58,49,10),USE(FCP:FechaEmision),RIGHT(1)
                           PROMPT('Presentación:'),AT(13,72),USE(?FCP:FechaPresentacion:Prompt),TRN
                           ENTRY(@D014B),AT(65,72,33,10),USE(FCP:FechaPresentacion),RIGHT(1)
                           LIST,AT(65,85,88,10),USE(CPTE:Descripcion),FORMAT('100L(2)|M@s25@'),DROP(5),FROM(Queue:FileDrop)
                           PROMPT('Número:'),AT(13,99),USE(?FCP:Numero:Prompt),TRN
                           ENTRY(@s1),AT(65,99,13,10),USE(FCP:Letra),SKIP,CENTER,REQ,UPR
                           ENTRY(@n04b),AT(83,99,24,10),USE(FCP:Lugar),RIGHT(1),REQ
                           ENTRY(@n08b),AT(112,99,40,10),USE(FCP:Numero),RIGHT(1),REQ
                           PANEL,AT(158,57,131,139),USE(?Panel1),FILL(0F6F6F6H),BEVEL(-1)
                           PROMPT('Importe Total:'),AT(169,64),USE(?FCP:Importe:Prompt),TRN,FONT(,,,FONT:bold)
                           ENTRY(@n-13.2),AT(230,64,54,10),USE(FCP:Importe),RIGHT(1),FONT(,,,FONT:bold),COLOR(080FF80H)
                           PROMPT('Neto Gravado:'),AT(176,79),USE(?FCP:NetoGravado:Prompt),TRN
                           ENTRY(@n-13.2b),AT(235,79,49,10),USE(FCP:NetoGravado),SKIP,RIGHT(1),COLOR(0DBDBDBH),READONLY
                           STRING('Comprobante:'),AT(13,85),USE(?String3),TRN
                           PROMPT('No Gravado:'),AT(182,91),USE(?FCP:NoGravado:Prompt),TRN
                           ENTRY(@n-13.2b),AT(235,91,49,10),USE(FCP:NoGravado),RIGHT(1)
                           PROMPT('Exento:'),AT(198,104),USE(?FCP:Exento:Prompt),TRN
                           ENTRY(@n-13.2b),AT(235,104,49,10),USE(FCP:Exento),RIGHT(1)
                           PROMPT('Iva 10,50%:'),AT(186,116),USE(?FCP:Iva10:Prompt),TRN
                           ENTRY(@n-13.2b),AT(235,116,49,10),USE(FCP:Iva10),RIGHT(1)
                           PROMPT('Iva 21,00%:'),AT(186,130),USE(?FCP:Iva21:Prompt),TRN
                           BUTTON,AT(223,130,11,10),USE(?RecalculoIVA),SKIP,FLAT,TIP('Calcular IVA'),ICON('C:\Comisiones\ComisionesSRL\botones\select.ico')
                           ENTRY(@n-13.2b),AT(235,130,49,10),USE(FCP:Iva21),RIGHT(1)
                           PROMPT('Iva 27,00%:'),AT(186,143),USE(?FCP:Iva27:Prompt),TRN
                           ENTRY(@n-13.2b),AT(235,143,49,10),USE(FCP:Iva27),RIGHT(1)
                           PROMPT('Percepción IVA:'),AT(172,156),USE(?FCP:PercepIVA:Prompt),TRN
                           ENTRY(@n-13.2b),AT(235,156,49,10),USE(FCP:PercepIVA),RIGHT(1)
                           PROMPT('Percepción IB:'),AT(176,169),USE(?FCP:PercepIB:Prompt),TRN
                           ENTRY(@n-13.2b),AT(235,169,49,10),USE(FCP:PercepIB),RIGHT(1)
                           PROMPT('Impuestos Internos:'),AT(162,182),USE(?FCP:ImpuestosInternos:Prompt),TRN
                           ENTRY(@n-13.2b),AT(235,182,49,10),USE(FCP:ImpuestosInternos),RIGHT(1)
                           STRING('Comentario:'),AT(13,139),USE(?String2),TRN
                           TEXT,AT(13,147,138,46),USE(FCP:Comentario),SKIP,BOXED,VSCROLL
                         END
                       END
                       BUTTON(' OK'),AT(94,207,55,16),USE(?OK),LEFT,FONT(,,,FONT:bold),ICON('C:\Comisiones\ComisionesSRL\botones\Ok1.ico'),DEFAULT
                       BUTTON('Cancelar'),AT(156,207,55,16),USE(?Cancel),LEFT,ICON('C:\Comisiones\ComisionesSRL\botones\Cancel1.ico')
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
PrimeFields            PROCEDURE(),PROC,DERIVED            ! Method added to host embed code
Reset                  PROCEDURE(BYTE Force=0),DERIVED     ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

FDCB6                CLASS(FileDropClass)                  ! File drop manager
Q                      &Queue:FileDrop                !Reference to display queue
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(COMPROBANTES:Record)
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
CalculoGravado ROUTINE

  FCP:NetoGravado = FCP:Importe-(FCP:NoGravado+FCP:Exento+FCP:Iva10+FCP:Iva21+FCP:Iva27+FCP:PercepIVA+|
                                 FCP:PercepOtros+FCP:PercepIB+FCP:PercepMunicipal+FCP:ImpuestosInternos)

  DISPLAY
  EXIT

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Vista de Ficha'
  OF InsertRecord
    ActionMessage = 'Agregando'
  OF ChangeRecord
    ActionMessage = 'Modificando'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateFACPROV')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Box2
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(FCP:Record,History::FCP:Record)
  SELF.AddHistoryField(?FCP:CodProveedor,3)
  SELF.AddHistoryField(?FCP:FechaEmision,4)
  SELF.AddHistoryField(?FCP:FechaPresentacion,5)
  SELF.AddHistoryField(?FCP:Letra,8)
  SELF.AddHistoryField(?FCP:Lugar,9)
  SELF.AddHistoryField(?FCP:Numero,10)
  SELF.AddHistoryField(?FCP:Importe,24)
  SELF.AddHistoryField(?FCP:NetoGravado,11)
  SELF.AddHistoryField(?FCP:NoGravado,12)
  SELF.AddHistoryField(?FCP:Exento,13)
  SELF.AddHistoryField(?FCP:Iva10,14)
  SELF.AddHistoryField(?FCP:Iva21,15)
  SELF.AddHistoryField(?FCP:Iva27,16)
  SELF.AddHistoryField(?FCP:PercepIVA,17)
  SELF.AddHistoryField(?FCP:PercepIB,19)
  SELF.AddHistoryField(?FCP:ImpuestosInternos,21)
  SELF.AddHistoryField(?FCP:Comentario,32)
  SELF.AddUpdateFile(Access:FACPROV)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:COMPROBANTES.SetOpenRelated()
  Relate:COMPROBANTES.Open                                 ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  Relate:PARAMETRO.Open                                    ! File PARAMETRO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:FACPROV
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.InsertAction = Insert:Batch
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?FCP:CodProveedor{PROP:ReadOnly} = True
    DISABLE(?SelectPROVEEDOR)
    ?FCP:FechaEmision{PROP:ReadOnly} = True
    ?FCP:FechaPresentacion{PROP:ReadOnly} = True
    DISABLE(?CPTE:Descripcion)
    ?FCP:Letra{PROP:ReadOnly} = True
    ?FCP:Lugar{PROP:ReadOnly} = True
    ?FCP:Numero{PROP:ReadOnly} = True
    ?FCP:Importe{PROP:ReadOnly} = True
    ?FCP:NetoGravado{PROP:ReadOnly} = True
    ?FCP:NoGravado{PROP:ReadOnly} = True
    ?FCP:Exento{PROP:ReadOnly} = True
    ?FCP:Iva10{PROP:ReadOnly} = True
    DISABLE(?RecalculoIVA)
    ?FCP:Iva21{PROP:ReadOnly} = True
    ?FCP:Iva27{PROP:ReadOnly} = True
    ?FCP:PercepIVA{PROP:ReadOnly} = True
    ?FCP:PercepIB{PROP:ReadOnly} = True
    ?FCP:ImpuestosInternos{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  FDCB6.Init(?CPTE:Descripcion,Queue:FileDrop.ViewPosition,FDB7::View:FileDrop,Queue:FileDrop,Relate:COMPROBANTES,ThisWindow)
  FDCB6.Q &= Queue:FileDrop
  FDCB6.AddSortOrder(CPTE:Por_Descripcion)
  FDCB6.AddField(CPTE:Descripcion,FDCB6.Q.CPTE:Descripcion)
  FDCB6.AddField(CPTE:Codigo,FDCB6.Q.CPTE:Codigo)
  FDCB6.AddUpdateField(CPTE:Codigo,FCP:Comprobante)
  FDCB6.AddUpdateField(CPTE:Letra,FCP:Letra)
  ThisWindow.AddItem(FDCB6.WindowComponent)
  FDCB6.DefaultFill = 0
  SELF.SetAlerts()
  EnhancedFocusManager.Init(1,65535,0,0,65535,0,65535,0,2,65535,0,0,8421504,'»',8)
  EnterByTabManager.ExcludeControl(?Cancel)
  EnterByTabManager.ExcludeControl(?OK)
  EnterByTabManager.Init(False)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:COMPROBANTES.Close
    Relate:PARAMETRO.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
    FCP:Empresa = PAR:Registro
    PROV:Nombre = ''
    PROV:CUIT = ''
    IVA:Descripcion = ''
    FCP:Comprobante = 1
    FCP:FormaPago = 2
    FCP:Moneda = 'PES'
    FCP:TipoCambio = 1
    FCP:CAI = ''
    FCP:VencimientoCAI = ''
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  PROV:CodProveedor = FCP:CodProveedor                     ! Assign linking field value
  Access:PROVEEDORES.Fetch(PROV:Por_CodProveedor)
  IVA:CodCatIVA = PROV:PosicionIVA                         ! Assign linking field value
  Access:CATIVA.Fetch(IVA:Por_CodIVA)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    SelectPROVEEDORES
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
    OF ?FCP:NoGravado
      DO CalculoGravado
    OF ?FCP:Exento
      DO CalculoGravado
    OF ?FCP:Iva10
      DO CalculoGravado
    OF ?RecalculoIVA
      FCP:NetoGravado = (FCP:Importe-(FCP:NoGravado+FCP:Exento+FCP:Iva10+FCP:Iva27+FCP:PercepIVA+|
                         FCP:PercepOtros+FCP:PercepIB+FCP:PercepMunicipal+FCP:ImpuestosInternos)) / 1.21
      
      FCP:Iva21 = (FCP:Importe-(FCP:NoGravado+FCP:Exento+FCP:Iva10+FCP:Iva27+FCP:PercepIVA+|
                   FCP:PercepOtros+FCP:PercepIB+FCP:PercepMunicipal+FCP:ImpuestosInternos))-|
                  (FCP:Importe-(FCP:NoGravado+FCP:Exento+FCP:Iva10+FCP:Iva27+FCP:PercepIVA+|
                   FCP:PercepOtros+FCP:PercepIB+FCP:PercepMunicipal+FCP:ImpuestosInternos)) / 1.21
      DISPLAY
    OF ?FCP:Iva27
      DO CalculoGravado
    OF ?FCP:PercepIVA
      DO CalculoGravado
    OF ?FCP:PercepIB
      DO CalculoGravado
    OF ?FCP:ImpuestosInternos
      DO CalculoGravado
    OF ?OK
      IF INCOMPLETE() THEN CYCLE.
      
      IF (FCP:FechaPresentacion < (TODAY()-60)) OR (FCP:FechaPresentacion > (TODAY()+60)) THEN
        MESSAGE('Verifique la Fecha de Presentación.','Fecha Inválida!!!',ICON:Exclamation)
        SELECT(?FCP:FechaPresentacion)
        CYCLE
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?FCP:CodProveedor
      IF FCP:CodProveedor OR ?FCP:CodProveedor{Prop:Req}
        PROV:CodProveedor = FCP:CodProveedor
        IF Access:PROVEEDORES.TryFetch(PROV:Por_CodProveedor)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            FCP:CodProveedor = PROV:CodProveedor
          ELSE
            SELECT(?FCP:CodProveedor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
      IF PROV:PosicionIVA <> 1 THEN
        FDCB6.SetFilter('CPTE:Letra = ''C''')
        CLEAR(FCP:Iva10)
        CLEAR(FCP:Iva21)
        CLEAR(FCP:Iva27)
        ?FCP:Iva10{PROP:Background} = 0EEEEEEH
        ?FCP:Iva21{PROP:Background} = 0EEEEEEH
        ?FCP:Iva27{PROP:Background} = 0EEEEEEH
        ?FCP:PercepIVA{PROP:Background} = 0EEEEEEH
        DISABLE(?FCP:Iva10:Prompt)
        DISABLE(?FCP:Iva21:Prompt)
        DISABLE(?FCP:Iva27:Prompt)
        DISABLE(?FCP:PercepIVA:Prompt)
        DISABLE(?FCP:Iva10)
        DISABLE(?FCP:Iva21)
        DISABLE(?FCP:Iva27)
        DISABLE(?FCP:PercepIVA)
      ELSE
        FDCB6.SetFilter('CPTE:Codigo < 97')
        ?FCP:Iva10{PROP:Background} = COLOR:White
        ?FCP:Iva21{PROP:Background} = COLOR:White
        ?FCP:Iva27{PROP:Background} = COLOR:White
        ?FCP:PercepIVA{PROP:Background} = COLOR:White
        ENABLE(?FCP:Iva10:Prompt)
        ENABLE(?FCP:Iva21:Prompt)
        ENABLE(?FCP:Iva27:Prompt)
        ENABLE(?FCP:PercepIVA:Prompt)
        ENABLE(?FCP:Iva10)
        ENABLE(?FCP:Iva21)
        ENABLE(?FCP:Iva27)
        ENABLE(?FCP:PercepIVA)
      END
      ThisWindow.Reset(TRUE)
    OF ?SelectPROVEEDOR
      ThisWindow.Update
      PROV:CodProveedor = FCP:CodProveedor
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        FCP:CodProveedor = PROV:CodProveedor
      END
      ThisWindow.Reset(1)
      IF PROV:PosicionIVA <> 1 THEN
        FDCB6.SetFilter('CPTE:Letra = ''C''')
        CLEAR(FCP:Iva10)
        CLEAR(FCP:Iva21)
        CLEAR(FCP:Iva27)
        ?FCP:Iva10{PROP:Background} = 0EEEEEEH
        ?FCP:Iva21{PROP:Background} = 0EEEEEEH
        ?FCP:Iva27{PROP:Background} = 0EEEEEEH
        ?FCP:PercepIVA{PROP:Background} = 0EEEEEEH
        DISABLE(?FCP:Iva10:Prompt)
        DISABLE(?FCP:Iva21:Prompt)
        DISABLE(?FCP:Iva27:Prompt)
        DISABLE(?FCP:PercepIVA:Prompt)
        DISABLE(?FCP:Iva10)
        DISABLE(?FCP:Iva21)
        DISABLE(?FCP:Iva27)
        DISABLE(?FCP:PercepIVA)
      ELSE
        FDCB6.SetFilter('CPTE:Codigo < 97')
        ?FCP:Iva10{PROP:Background} = COLOR:White
        ?FCP:Iva21{PROP:Background} = COLOR:White
        ?FCP:Iva27{PROP:Background} = COLOR:White
        ?FCP:PercepIVA{PROP:Background} = COLOR:White
        ENABLE(?FCP:Iva10:Prompt)
        ENABLE(?FCP:Iva21:Prompt)
        ENABLE(?FCP:Iva27:Prompt)
        ENABLE(?FCP:PercepIVA:Prompt)
        ENABLE(?FCP:Iva10)
        ENABLE(?FCP:Iva21)
        ENABLE(?FCP:Iva27)
        ENABLE(?FCP:PercepIVA)
      END
      ThisWindow.Reset(TRUE)
    OF ?FCP:FechaEmision
      IF NOT(FCP:FechaPresentacion) THEN FCP:FechaPresentacion = FCP:FechaEmision.
      DISPLAY
    OF ?OK
      ThisWindow.Update
      IF CPTE:Debito_Credito = 'D' THEN
        FCP:NetoGravado = ABS(FCP:NetoGravado)
        FCP:NoGravado = ABS(FCP:NoGravado)
        FCP:Exento = ABS(FCP:Exento)
        FCP:Iva10 = ABS(FCP:Iva10)
        FCP:Iva21 = ABS(FCP:Iva21)
        FCP:Iva27 = ABS(FCP:Iva27)
        FCP:PercepIVA = ABS(FCP:PercepIVA)
        FCP:PercepOtros = ABS(FCP:PercepOtros)
        FCP:PercepIB = ABS(FCP:PercepIB)
        FCP:PercepMunicipal = ABS(FCP:PercepMunicipal)
        FCP:ImpuestosInternos = ABS(FCP:ImpuestosInternos)
      ELSE
        FCP:NetoGravado *= -1
        FCP:NoGravado *= -1
        FCP:Exento *= -1
        FCP:Iva10 *= -1
        FCP:Iva21 *= -1
        FCP:Iva27 *= -1
        FCP:PercepIVA *= -1
        FCP:PercepOtros *= -1
        FCP:PercepIB *= -1
        FCP:PercepMunicipal *= -1
        FCP:ImpuestosInternos *= -1
      END
      IF FCP:FormaPago = 2 THEN FCP:Aplicado = FCP:Importe * -1.
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
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


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  CASE FIELD()
  OF ?FCP:Importe
    IF NOT ThisWindow{PROP:AcceptAll} THEN
      IF FCP:Letra = 'A' THEN
        FCP:NetoGravado = FCP:Importe / 1.21
        FCP:Iva21 = FCP:Importe - (FCP:Importe / 1.21)
      ELSE
        FCP:NetoGravado = FCP:Importe
        CLEAR(FCP:Iva21)
      END
    END
    DISPLAY
  END
  ReturnValue = PARENT.TakeFieldEvent()
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
    OF ?CPTE:Descripcion
      DISPLAY
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
    CASE EVENT()
    OF EVENT:OpenWindow
      CPTE:Codigo = FCP:Comprobante
      GET(COMPROBANTES,CPTE:Por_Codigo)
      
      IF ThisWindow.Request <> InsertRecord AND CPTE:Debito_Credito = 'C' THEN
        FCP:NetoGravado = ABS(FCP:NetoGravado)
        FCP:NoGravado = ABS(FCP:NoGravado)
        FCP:Exento = ABS(FCP:Exento)
        FCP:Iva10 = ABS(FCP:Iva10)
        FCP:Iva21 = ABS(FCP:Iva21)
        FCP:Iva27 = ABS(FCP:Iva27)
        FCP:PercepIVA = ABS(FCP:PercepIVA)
        FCP:PercepOtros = ABS(FCP:PercepOtros)
        FCP:PercepIB = ABS(FCP:PercepIB)
        FCP:PercepMunicipal = ABS(FCP:PercepMunicipal)
        FCP:ImpuestosInternos = ABS(FCP:ImpuestosInternos)
        FCP:Importe = ABS(FCP:Importe)
      END
      
      IF ThisWindow.Request = ViewRecord THEN DISABLE(?OK).
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


FDCB6.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue

