

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS033.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COMIS034.INC'),ONCE        !Req'd for module callout resolution
                     END


AGENDA PROCEDURE                                           ! Generated from procedure template - Window

FilesOpened          BYTE                                  !
BRW1::View:Browse    VIEW(VISITAS)
                       PROJECT(VIS:Hora)
                       PROJECT(VIS:Cliente)
                       PROJECT(VIS:Dia)
                       JOIN(DIA:Por_Codigo,VIS:Dia)
                         PROJECT(DIA:Codigo)
                       END
                       JOIN(CLI:Por_Codigo,VIS:Cliente)
                         PROJECT(CLI:Nombre)
                         PROJECT(CLI:Direccion)
                         PROJECT(CLI:CodCliente)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
VIS:Hora               LIKE(VIS:Hora)                 !List box control field - type derived from field
CLI:Nombre             LIKE(CLI:Nombre)               !List box control field - type derived from field
CLI:Direccion          LIKE(CLI:Direccion)            !List box control field - type derived from field
VIS:Cliente            LIKE(VIS:Cliente)              !Primary key field - type derived from field
VIS:Dia                LIKE(VIS:Dia)                  !Primary key field - type derived from field
DIA:Codigo             LIKE(DIA:Codigo)               !Related join file key field - type derived from field
CLI:CodCliente         LIKE(CLI:CodCliente)           !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW('AGENDA'),AT(,0,364,116),FONT('MS Sans Serif',8,,FONT:regular),CENTER,ICON('C:\Comisiones\ComisionesSRL\botones\agenda.ico'),WALLPAPER('anillado.gif'),TILED,SYSTEM,GRAY,DOUBLE,MDI,IMM
                       SHEET,AT(311,16,47,92),USE(?CurrentTab),RIGHT(46)
                         TAB(' &Lunes'),USE(?Lunes)
                         END
                         TAB(' &Martes'),USE(?Martes)
                         END
                         TAB(' M&iercoles'),USE(?Miercoles)
                         END
                         TAB(' &Jueves'),USE(?Jueves)
                         END
                         TAB(' &Viernes'),USE(?Viernes)
                         END
                         TAB(' &Sábado'),USE(?Sabado)
                         END
                         TAB(' &Domingo'),USE(?Domingo)
                         END
                       END
                       LIST,AT(37,17,274,91),USE(?List),IMM,COLOR(0F4F4F4H),FORMAT('28R(4)|_F~Hora~L(2)@T1b@139L(2)_F~Cliente~@s40@98L(2)|_F~Dirección~@s30@'),FROM(Queue:Browse)
                       BUTTON('Agregar'),AT(123,4,39,12),USE(?Insert),SKIP
                       BUTTON('Modificar'),AT(163,4,39,12),USE(?Change),SKIP
                       BUTTON('Borrar'),AT(203,4,39,12),USE(?Delete),SKIP
                     END

ThreadNo 	LONG,STATIC
Running		LONG	
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


  CODE
? DEBUGHOOK(VISITAS:Record)
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
  GlobalErrors.SetProcedureName('AGENDA')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:VISITAS.SetOpenRelated()
  Relate:VISITAS.Open                                      ! File VISITAS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:VISITAS,SELF) ! Initialize the browse manager
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,VIS:Por_Dia)                          ! Add the sort order for VIS:Por_Dia for sort order 1
  BRW1.SetFilter('(VIS:Dia = 3)')                          ! Apply filter expression to browse
  BRW1.AddSortOrder(,VIS:Por_Dia)                          ! Add the sort order for VIS:Por_Dia for sort order 2
  BRW1.SetFilter('(VIS:Dia = 4)')                          ! Apply filter expression to browse
  BRW1.AddSortOrder(,VIS:Por_Dia)                          ! Add the sort order for VIS:Por_Dia for sort order 3
  BRW1.SetFilter('(VIS:Dia = 5)')                          ! Apply filter expression to browse
  BRW1.AddSortOrder(,VIS:Por_Dia)                          ! Add the sort order for VIS:Por_Dia for sort order 4
  BRW1.SetFilter('(VIS:Dia = 6)')                          ! Apply filter expression to browse
  BRW1.AddSortOrder(,VIS:Por_Dia)                          ! Add the sort order for VIS:Por_Dia for sort order 5
  BRW1.SetFilter('(VIS:Dia = 7)')                          ! Apply filter expression to browse
  BRW1.AddSortOrder(,VIS:Por_Dia)                          ! Add the sort order for VIS:Por_Dia for sort order 6
  BRW1.SetFilter('(VIS:Dia = 1)')                          ! Apply filter expression to browse
  BRW1.AddSortOrder(,VIS:Por_Dia)                          ! Add the sort order for VIS:Por_Dia for sort order 7
  BRW1.SetFilter('(VIS:Dia = 2)')                          ! Apply filter expression to browse
  BRW1.AddField(VIS:Hora,BRW1.Q.VIS:Hora)                  ! Field VIS:Hora is a hot field or requires assignment from browse
  BRW1.AddField(CLI:Nombre,BRW1.Q.CLI:Nombre)              ! Field CLI:Nombre is a hot field or requires assignment from browse
  BRW1.AddField(CLI:Direccion,BRW1.Q.CLI:Direccion)        ! Field CLI:Direccion is a hot field or requires assignment from browse
  BRW1.AddField(VIS:Cliente,BRW1.Q.VIS:Cliente)            ! Field VIS:Cliente is a hot field or requires assignment from browse
  BRW1.AddField(VIS:Dia,BRW1.Q.VIS:Dia)                    ! Field VIS:Dia is a hot field or requires assignment from browse
  BRW1.AddField(DIA:Codigo,BRW1.Q.DIA:Codigo)              ! Field DIA:Codigo is a hot field or requires assignment from browse
  BRW1.AddField(CLI:CodCliente,BRW1.Q.CLI:CodCliente)      ! Field CLI:CodCliente is a hot field or requires assignment from browse
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
    Relate:VISITAS.Close
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
    UpdateVISITAS
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
    OF ?CurrentTab
      CASE CHOICE(?CurrentTab)
      OF 1
        glo:Dia = 2
      OF 2
        glo:Dia = 3
      OF 3
        glo:Dia = 4
      OF 4
        glo:Dia = 5
      OF 5
        glo:Dia = 6
      OF 6
        glo:Dia = 7
      OF 7
        glo:Dia = 1
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
    CASE EVENT()
    OF EVENT:OpenWindow
      glo:Dia = 2
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
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
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
  ELSIF CHOICE(?CurrentTab) = 5
    RETURN SELF.SetSort(4,Force)
  ELSIF CHOICE(?CurrentTab) = 6
    RETURN SELF.SetSort(5,Force)
  ELSIF CHOICE(?CurrentTab) = 7
    RETURN SELF.SetSort(6,Force)
  ELSE
    RETURN SELF.SetSort(7,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue

