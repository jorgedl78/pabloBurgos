

   MEMBER('comision.clw')                                  ! This is a MEMBER module

                     MAP
                       INCLUDE('COMIS136.INC'),ONCE        !Local module procedure declarations
                     END


Pie_mail             PROCEDURE                             ! Declare Procedure
loc_pie              STRING(10000)                         !
ThreadNo 	LONG,STATIC
Running		LONG	
  CODE
 loc_pie='</html>' & |
         '<p class="Estilo3"><br>' & |
         '<strong>' & GETINI('MAIL','RSocial',,'.\DATOS.INI') & '</strong><br>' & |
         '<br></p>' & |
         '<p class="Estilo4">' & |
         'Este email es confeccionado y enviado en forma automatica por nuestro sistema informatico.<br>' & |
         '<br></p>' & |
         '</body>'
 Return(clip(loc_pie))
