

   MEMBER('comision.clw')                                  ! This is a MEMBER module

                     MAP
                       INCLUDE('COMIS129.INC'),ONCE        !Local module procedure declarations
                     END


Ejecuta_Ws           PROCEDURE                             ! Declare Procedure
ThreadNo 	LONG,STATIC
Running		LONG	
  CODE
 if glo:Test=1 then Glo:Parametros=clip(Glo:Parametros) & ' --test'.
 setclipboard(clip(Glo:Ejecutable) &' '& clip(Glo:Parametros))
 run(clip(Glo:Ejecutable) &' '& clip(Glo:Parametros),1)
