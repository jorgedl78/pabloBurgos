

   MEMBER('comision.clw')                                  ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('COMIS132.INC'),ONCE        !Local module procedure declarations
                     END


Leer_Respuesta_RECE PROCEDURE                              ! Generated from procedure template - Window

EnhancedFocusManager EnhancedFocusClassType
LocEnableEnterByTab  BYTE(1)                               !Used by the ENTER Instead of Tab template
EnterByTabManager    EnterByTabClass
Window               WINDOW,AT(,,260,100),CENTER,WALLPAPER('fondo.jpg'),CENTERED,GRAY
                       PANEL,AT(13,10,234,79),USE(?Panel1),BEVEL(-1)
                       PROMPT('Recibiendo Respuesta'),AT(93,45),USE(?Prompt1),TRN
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

  CODE
? DEBUGHOOK(FE_Respuesta_RECE:Record)
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
  GlobalErrors.SetProcedureName('Leer_Respuesta_RECE')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:FE_Respuesta_RECE.Open                            ! File FE_Respuesta_RECE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
   set(FE_Respuesta_Rece,1)
   next(FE_Respuesta_Rece)
    if errorcode()>0 then
      message('Se generó un error al buscar la 1ra linea de respuesta del RECE.|Error: '&errorcode()&'|El proceso funcionara incorrectamente','Error',icon:hand)
   else
      if FE_Resp:Linea[1:1]='E'
         message('Error Tipo E Nº: ' & FE_Resp:Linea[2:7] &'<13,10>'&FE_Resp:Linea[8:len(FE_Resp:Linea)])
         !mensajes
         
         Return Level:Fatal
      end!if
   end!if
   next(FE_Respuesta_Rece)
   if errorcode()>0 then message('Se generó un error al buscar la 2da linea de respuesta del RECE.|Error: '&errorcode()&'|El proceso funcionara incorrectamente','Error',icon:hand).
   next(FE_Respuesta_Rece)
   if errorcode()>0 then message('Se generó un error al buscar la 3da linea de respuesta del RECE.|Error: '&errorcode()&'|El proceso funcionara incorrectamente','Error',icon:hand).
  
   if FE_Resp:Linea[1:1]='C' !!! CAE OBTENIDO
      Glo:NroCAE      = FE_Resp:Linea[22:36]
      Glo:FechaCAE    = date(FE_Resp:Linea[41:42],FE_Resp:Linea[43:44],FE_Resp:Linea[37:40])
      !message('Glo:NroCAE: ' & Glo:NroCAE)
   end!if
  
   if FE_Resp:Linea[1:1]='O' !!! OBSERVACION
      message('Error Tipo O Nº: ' & FE_Resp:Linea[18:23] &'<13,10>'&FE_Resp:Linea[24:len(FE_Resp:Linea)])
      !mensajes
   end!if
  
  
   Return Level:Fatal
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
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
    Relate:FE_Respuesta_RECE.Close
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

