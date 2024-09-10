  MEMBER('comision.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
COMISBC0:DctInit    PROCEDURE
COMISBC0:DctKill    PROCEDURE
COMISBC0:FilesInit  PROCEDURE
  END

Hide:Access:CLIENTES CLASS(FileManager),TYPE               ! FileManager for CLIENTES
BindFields             PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CLIENTES CLASS(RelationManager),TYPE           ! RelationManager for CLIENTES
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:CITI     CLASS(FileManager),TYPE               ! FileManager for CITI
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CITI     CLASS(RelationManager),TYPE           ! RelationManager for CITI
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:CITICA   CLASS(FileManager),TYPE               ! FileManager for CITICA
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CITICA   CLASS(RelationManager),TYPE           ! RelationManager for CITICA
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:CITIC    CLASS(FileManager),TYPE               ! FileManager for CITIC
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CITIC    CLASS(RelationManager),TYPE           ! RelationManager for CITIC
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:CITIA    CLASS(FileManager),TYPE               ! FileManager for CITIA
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CITIA    CLASS(RelationManager),TYPE           ! RelationManager for CITIA
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:COMPROBANTES CLASS(FileManager),TYPE           ! FileManager for COMPROBANTES
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:COMPROBANTES CLASS(RelationManager),TYPE       ! RelationManager for COMPROBANTES
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:REDESPACHO CLASS(FileManager),TYPE             ! FileManager for REDESPACHO
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:REDESPACHO CLASS(RelationManager),TYPE         ! RelationManager for REDESPACHO
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:PROVEEDORES CLASS(FileManager),TYPE            ! FileManager for PROVEEDORES
BindFields             PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:PROVEEDORES CLASS(RelationManager),TYPE        ! RelationManager for PROVEEDORES
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:PARAMETRO CLASS(FileManager),TYPE              ! FileManager for PARAMETRO
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:PARAMETRO CLASS(RelationManager),TYPE          ! RelationManager for PARAMETRO
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:VISITAS  CLASS(FileManager),TYPE               ! FileManager for VISITAS
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:VISITAS  CLASS(RelationManager),TYPE           ! RelationManager for VISITAS
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:FACTURAS CLASS(FileManager),TYPE               ! FileManager for FACTURAS
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:FACTURAS CLASS(RelationManager),TYPE           ! RelationManager for FACTURAS
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:GUIAS    CLASS(FileManager),TYPE               ! FileManager for GUIAS
BindFields             PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:GUIAS    CLASS(RelationManager),TYPE           ! RelationManager for GUIAS
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:FACPROV  CLASS(FileManager),TYPE               ! FileManager for FACPROV
BindFields             PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:FACPROV  CLASS(RelationManager),TYPE           ! RelationManager for FACPROV
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:LOCALIDA CLASS(FileManager),TYPE               ! FileManager for LOCALIDA
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:LOCALIDA CLASS(RelationManager),TYPE           ! RelationManager for LOCALIDA
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:FE_RECE  CLASS(FileManager),TYPE               ! FileManager for FE_RECE
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:FE_RECE  CLASS(RelationManager),TYPE           ! RelationManager for FE_RECE
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:FE_Respuesta_RECE CLASS(FileManager),TYPE      ! FileManager for FE_Respuesta_RECE
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:FE_Respuesta_RECE CLASS(RelationManager),TYPE  ! RelationManager for FE_Respuesta_RECE
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:APLIFAC  CLASS(FileManager),TYPE               ! FileManager for APLIFAC
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:APLIFAC  CLASS(RelationManager),TYPE           ! RelationManager for APLIFAC
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:APLIGUIA CLASS(FileManager),TYPE               ! FileManager for APLIGUIA
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:APLIGUIA CLASS(RelationManager),TYPE           ! RelationManager for APLIGUIA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:ITEMFAC  CLASS(FileManager),TYPE               ! FileManager for ITEMFAC
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:ITEMFAC  CLASS(RelationManager),TYPE           ! RelationManager for ITEMFAC
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:ZONAS    CLASS(FileManager),TYPE               ! FileManager for ZONAS
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:ZONAS    CLASS(RelationManager),TYPE           ! RelationManager for ZONAS
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


_Hide:Access:CLIENTES &Hide:Access:CLIENTES,AUTO,THREAD
_Hide:Relate:CLIENTES &Hide:Relate:CLIENTES,AUTO,THREAD
_Hide:Access:CITI    &Hide:Access:CITI,AUTO,THREAD
_Hide:Relate:CITI    &Hide:Relate:CITI,AUTO,THREAD
_Hide:Access:CITICA  &Hide:Access:CITICA,AUTO,THREAD
_Hide:Relate:CITICA  &Hide:Relate:CITICA,AUTO,THREAD
_Hide:Access:CITIC   &Hide:Access:CITIC,AUTO,THREAD
_Hide:Relate:CITIC   &Hide:Relate:CITIC,AUTO,THREAD
_Hide:Access:CITIA   &Hide:Access:CITIA,AUTO,THREAD
_Hide:Relate:CITIA   &Hide:Relate:CITIA,AUTO,THREAD
_Hide:Access:COMPROBANTES &Hide:Access:COMPROBANTES,AUTO,THREAD
_Hide:Relate:COMPROBANTES &Hide:Relate:COMPROBANTES,AUTO,THREAD
_Hide:Access:REDESPACHO &Hide:Access:REDESPACHO,AUTO,THREAD
_Hide:Relate:REDESPACHO &Hide:Relate:REDESPACHO,AUTO,THREAD
_Hide:Access:PROVEEDORES &Hide:Access:PROVEEDORES,AUTO,THREAD
_Hide:Relate:PROVEEDORES &Hide:Relate:PROVEEDORES,AUTO,THREAD
_Hide:Access:PARAMETRO &Hide:Access:PARAMETRO,AUTO,THREAD
_Hide:Relate:PARAMETRO &Hide:Relate:PARAMETRO,AUTO,THREAD
_Hide:Access:VISITAS &Hide:Access:VISITAS,AUTO,THREAD
_Hide:Relate:VISITAS &Hide:Relate:VISITAS,AUTO,THREAD
_Hide:Access:FACTURAS &Hide:Access:FACTURAS,AUTO,THREAD
_Hide:Relate:FACTURAS &Hide:Relate:FACTURAS,AUTO,THREAD
_Hide:Access:GUIAS   &Hide:Access:GUIAS,AUTO,THREAD
_Hide:Relate:GUIAS   &Hide:Relate:GUIAS,AUTO,THREAD
_Hide:Access:FACPROV &Hide:Access:FACPROV,AUTO,THREAD
_Hide:Relate:FACPROV &Hide:Relate:FACPROV,AUTO,THREAD
_Hide:Access:LOCALIDA &Hide:Access:LOCALIDA,AUTO,THREAD
_Hide:Relate:LOCALIDA &Hide:Relate:LOCALIDA,AUTO,THREAD
_Hide:Access:FE_RECE &Hide:Access:FE_RECE,AUTO,THREAD
_Hide:Relate:FE_RECE &Hide:Relate:FE_RECE,AUTO,THREAD
_Hide:Access:FE_Respuesta_RECE &Hide:Access:FE_Respuesta_RECE,AUTO,THREAD
_Hide:Relate:FE_Respuesta_RECE &Hide:Relate:FE_Respuesta_RECE,AUTO,THREAD
_Hide:Access:APLIFAC &Hide:Access:APLIFAC,AUTO,THREAD
_Hide:Relate:APLIFAC &Hide:Relate:APLIFAC,AUTO,THREAD
_Hide:Access:APLIGUIA &Hide:Access:APLIGUIA,AUTO,THREAD
_Hide:Relate:APLIGUIA &Hide:Relate:APLIGUIA,AUTO,THREAD
_Hide:Access:ITEMFAC &Hide:Access:ITEMFAC,AUTO,THREAD
_Hide:Relate:ITEMFAC &Hide:Relate:ITEMFAC,AUTO,THREAD
_Hide:Access:ZONAS   &Hide:Access:ZONAS,AUTO,THREAD
_Hide:Relate:ZONAS   &Hide:Relate:ZONAS,AUTO,THREAD


COMISBC0:DctInit PROCEDURE
  CODE
  _Hide:Access:CLIENTES &= NEW(Hide:Access:CLIENTES)
  _Hide:Relate:CLIENTES &= NEW(Hide:Relate:CLIENTES)
  _Hide:Access:CITI &= NEW(Hide:Access:CITI)
  _Hide:Relate:CITI &= NEW(Hide:Relate:CITI)
  _Hide:Access:CITICA &= NEW(Hide:Access:CITICA)
  _Hide:Relate:CITICA &= NEW(Hide:Relate:CITICA)
  _Hide:Access:CITIC &= NEW(Hide:Access:CITIC)
  _Hide:Relate:CITIC &= NEW(Hide:Relate:CITIC)
  _Hide:Access:CITIA &= NEW(Hide:Access:CITIA)
  _Hide:Relate:CITIA &= NEW(Hide:Relate:CITIA)
  _Hide:Access:COMPROBANTES &= NEW(Hide:Access:COMPROBANTES)
  _Hide:Relate:COMPROBANTES &= NEW(Hide:Relate:COMPROBANTES)
  _Hide:Access:REDESPACHO &= NEW(Hide:Access:REDESPACHO)
  _Hide:Relate:REDESPACHO &= NEW(Hide:Relate:REDESPACHO)
  _Hide:Access:PROVEEDORES &= NEW(Hide:Access:PROVEEDORES)
  _Hide:Relate:PROVEEDORES &= NEW(Hide:Relate:PROVEEDORES)
  _Hide:Access:PARAMETRO &= NEW(Hide:Access:PARAMETRO)
  _Hide:Relate:PARAMETRO &= NEW(Hide:Relate:PARAMETRO)
  _Hide:Access:VISITAS &= NEW(Hide:Access:VISITAS)
  _Hide:Relate:VISITAS &= NEW(Hide:Relate:VISITAS)
  _Hide:Access:FACTURAS &= NEW(Hide:Access:FACTURAS)
  _Hide:Relate:FACTURAS &= NEW(Hide:Relate:FACTURAS)
  _Hide:Access:GUIAS &= NEW(Hide:Access:GUIAS)
  _Hide:Relate:GUIAS &= NEW(Hide:Relate:GUIAS)
  _Hide:Access:FACPROV &= NEW(Hide:Access:FACPROV)
  _Hide:Relate:FACPROV &= NEW(Hide:Relate:FACPROV)
  _Hide:Access:LOCALIDA &= NEW(Hide:Access:LOCALIDA)
  _Hide:Relate:LOCALIDA &= NEW(Hide:Relate:LOCALIDA)
  _Hide:Access:FE_RECE &= NEW(Hide:Access:FE_RECE)
  _Hide:Relate:FE_RECE &= NEW(Hide:Relate:FE_RECE)
  _Hide:Access:FE_Respuesta_RECE &= NEW(Hide:Access:FE_Respuesta_RECE)
  _Hide:Relate:FE_Respuesta_RECE &= NEW(Hide:Relate:FE_Respuesta_RECE)
  _Hide:Access:APLIFAC &= NEW(Hide:Access:APLIFAC)
  _Hide:Relate:APLIFAC &= NEW(Hide:Relate:APLIFAC)
  _Hide:Access:APLIGUIA &= NEW(Hide:Access:APLIGUIA)
  _Hide:Relate:APLIGUIA &= NEW(Hide:Relate:APLIGUIA)
  _Hide:Access:ITEMFAC &= NEW(Hide:Access:ITEMFAC)
  _Hide:Relate:ITEMFAC &= NEW(Hide:Relate:ITEMFAC)
  _Hide:Access:ZONAS &= NEW(Hide:Access:ZONAS)
  _Hide:Relate:ZONAS &= NEW(Hide:Relate:ZONAS)
  Relate:CLIENTES &= _Hide:Relate:CLIENTES
  Relate:CITI &= _Hide:Relate:CITI
  Relate:CITICA &= _Hide:Relate:CITICA
  Relate:CITIC &= _Hide:Relate:CITIC
  Relate:CITIA &= _Hide:Relate:CITIA
  Relate:COMPROBANTES &= _Hide:Relate:COMPROBANTES
  Relate:REDESPACHO &= _Hide:Relate:REDESPACHO
  Relate:PROVEEDORES &= _Hide:Relate:PROVEEDORES
  Relate:PARAMETRO &= _Hide:Relate:PARAMETRO
  Relate:VISITAS &= _Hide:Relate:VISITAS
  Relate:FACTURAS &= _Hide:Relate:FACTURAS
  Relate:GUIAS &= _Hide:Relate:GUIAS
  Relate:FACPROV &= _Hide:Relate:FACPROV
  Relate:LOCALIDA &= _Hide:Relate:LOCALIDA
  Relate:FE_RECE &= _Hide:Relate:FE_RECE
  Relate:FE_Respuesta_RECE &= _Hide:Relate:FE_Respuesta_RECE
  Relate:APLIFAC &= _Hide:Relate:APLIFAC
  Relate:APLIGUIA &= _Hide:Relate:APLIGUIA
  Relate:ITEMFAC &= _Hide:Relate:ITEMFAC
  Relate:ZONAS &= _Hide:Relate:ZONAS


COMISBC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:CLIENTES.Init
  _Hide:Relate:CITI.Init
  _Hide:Relate:CITICA.Init
  _Hide:Relate:CITIC.Init
  _Hide:Relate:CITIA.Init
  _Hide:Relate:COMPROBANTES.Init
  _Hide:Relate:REDESPACHO.Init
  _Hide:Relate:PROVEEDORES.Init
  _Hide:Relate:PARAMETRO.Init
  _Hide:Relate:VISITAS.Init
  _Hide:Relate:FACTURAS.Init
  _Hide:Relate:GUIAS.Init
  _Hide:Relate:FACPROV.Init
  _Hide:Relate:LOCALIDA.Init
  _Hide:Relate:FE_RECE.Init
  _Hide:Relate:FE_Respuesta_RECE.Init
  _Hide:Relate:APLIFAC.Init
  _Hide:Relate:APLIGUIA.Init
  _Hide:Relate:ITEMFAC.Init
  _Hide:Relate:ZONAS.Init


COMISBC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:CLIENTES.Kill
  DISPOSE(_Hide:Relate:CLIENTES)
  _Hide:Relate:CITI.Kill
  DISPOSE(_Hide:Relate:CITI)
  _Hide:Relate:CITICA.Kill
  DISPOSE(_Hide:Relate:CITICA)
  _Hide:Relate:CITIC.Kill
  DISPOSE(_Hide:Relate:CITIC)
  _Hide:Relate:CITIA.Kill
  DISPOSE(_Hide:Relate:CITIA)
  _Hide:Relate:COMPROBANTES.Kill
  DISPOSE(_Hide:Relate:COMPROBANTES)
  _Hide:Relate:REDESPACHO.Kill
  DISPOSE(_Hide:Relate:REDESPACHO)
  _Hide:Relate:PROVEEDORES.Kill
  DISPOSE(_Hide:Relate:PROVEEDORES)
  _Hide:Relate:PARAMETRO.Kill
  DISPOSE(_Hide:Relate:PARAMETRO)
  _Hide:Relate:VISITAS.Kill
  DISPOSE(_Hide:Relate:VISITAS)
  _Hide:Relate:FACTURAS.Kill
  DISPOSE(_Hide:Relate:FACTURAS)
  _Hide:Relate:GUIAS.Kill
  DISPOSE(_Hide:Relate:GUIAS)
  _Hide:Relate:FACPROV.Kill
  DISPOSE(_Hide:Relate:FACPROV)
  _Hide:Relate:LOCALIDA.Kill
  DISPOSE(_Hide:Relate:LOCALIDA)
  _Hide:Relate:FE_RECE.Kill
  DISPOSE(_Hide:Relate:FE_RECE)
  _Hide:Relate:FE_Respuesta_RECE.Kill
  DISPOSE(_Hide:Relate:FE_Respuesta_RECE)
  _Hide:Relate:APLIFAC.Kill
  DISPOSE(_Hide:Relate:APLIFAC)
  _Hide:Relate:APLIGUIA.Kill
  DISPOSE(_Hide:Relate:APLIGUIA)
  _Hide:Relate:ITEMFAC.Kill
  DISPOSE(_Hide:Relate:ITEMFAC)
  _Hide:Relate:ZONAS.Kill
  DISPOSE(_Hide:Relate:ZONAS)


Hide:Relate:CLIENTES.Init PROCEDURE
  CODE
  _Hide:Access:CLIENTES.Init
  SELF.Init(Access:CLIENTES,1)


Hide:Access:CLIENTES.BindFields PROCEDURE

  CODE
  PARENT.BindFields
  BIND('CLI:Notas',CLI:Notas)                              ! Bind memo field


Hide:Access:CLIENTES.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= CLI:Record
  SELF.FileNameValue = 'CLIENTES'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= CLIENTES
  PARENT.Init
  Access:CLIENTES &= SELF


Hide:Access:CLIENTES.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CLIENTES &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CLIENTES.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(CLIENTES,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(CLI:Por_Codigo,'CLI:Por_Codigo',1)
    SELF.AddKey(CLI:Por_Nombre,'CLI:Por_Nombre',0)
    SELF.AddKey(CLI:Por_Localidad,'CLI:Por_Localidad',0)
    SELF.AddKey(CLI:Por_Zona,'CLI:Por_Zona',0)
    SELF.AddKey(CLI:Por_Distribuidor,'CLI:Por_Distribuidor',0)
    SELF.AddKey(CLI:Por_CategoriaIVA,'CLI:Por_CategoriaIVA',0)
    SELF.AddKey(CLI:Por_Provincia,'Por Provincia',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:CLIENTES.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACTURAS,RI:CASCADE,RI:RESTRICT,FAC:Por_Cliente)
  SELF.AddRelationLink(CLI:CodCliente,FAC:ClienteFacturar)

  SELF.AddRelation(Relate:VISITAS,RI:CASCADE,RI:CASCADE,VIS:Por_Cliente)
  SELF.AddRelationLink(CLI:CodCliente,VIS:Cliente)

  SELF.AddRelation(Relate:DISTRIBUIDORES)

  SELF.AddRelation(Relate:CATIVA)

  SELF.AddRelation(Relate:PROVINCI)

  SELF.AddRelation(Relate:ZONAS)

  SELF.AddRelation(Relate:GUIAS,RI:CASCADE,RI:RESTRICT,GUIA:Por_Cliente_FechaA)
  SELF.AddRelationLink(CLI:CodCliente,GUIA:ClienteFacturar)


Hide:Relate:CLIENTES.Kill PROCEDURE

  CODE
  _Hide:Access:CLIENTES.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:CLIENTES &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CLIENTES)                           ! destroy the file manager


Hide:Relate:CITI.Init PROCEDURE
  CODE
  _Hide:Access:CITI.Init
  SELF.Init(Access:CITI,1)


Hide:Access:CITI.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= CITI:Record
  SELF.FileNameValue = 'CITI'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= CITI
  PARENT.Init
  Access:CITI &= SELF


Hide:Access:CITI.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CITI &= NULL                                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CITI.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(CITI,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:CITI.Kill PROCEDURE

  CODE
  _Hide:Access:CITI.Kill                                   ! Kill the file manager
  PARENT.Kill
  Relate:CITI &= NULL                                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CITI)                               ! destroy the file manager


Hide:Relate:CITICA.Init PROCEDURE
  CODE
  _Hide:Access:CITICA.Init
  SELF.Init(Access:CITICA,1)


Hide:Access:CITICA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= CITICA:Record
  SELF.FileNameValue = 'CITICA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= CITICA
  PARENT.Init
  Access:CITICA &= SELF


Hide:Access:CITICA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CITICA &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CITICA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(CITICA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:CITICA.Kill PROCEDURE

  CODE
  _Hide:Access:CITICA.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:CITICA &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CITICA)                             ! destroy the file manager


Hide:Relate:CITIC.Init PROCEDURE
  CODE
  _Hide:Access:CITIC.Init
  SELF.Init(Access:CITIC,1)


Hide:Access:CITIC.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= CITIC:Record
  SELF.FileNameValue = 'CITIC'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= CITIC
  PARENT.Init
  Access:CITIC &= SELF


Hide:Access:CITIC.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CITIC &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CITIC.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(CITIC,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:CITIC.Kill PROCEDURE

  CODE
  _Hide:Access:CITIC.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:CITIC &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CITIC)                              ! destroy the file manager


Hide:Relate:CITIA.Init PROCEDURE
  CODE
  _Hide:Access:CITIA.Init
  SELF.Init(Access:CITIA,1)


Hide:Access:CITIA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= CITIA:Record
  SELF.FileNameValue = 'CITIA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= CITIA
  PARENT.Init
  Access:CITIA &= SELF


Hide:Access:CITIA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CITIA &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CITIA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(CITIA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:CITIA.Kill PROCEDURE

  CODE
  _Hide:Access:CITIA.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:CITIA &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CITIA)                              ! destroy the file manager


Hide:Relate:COMPROBANTES.Init PROCEDURE
  CODE
  _Hide:Access:COMPROBANTES.Init
  SELF.Init(Access:COMPROBANTES,1)


Hide:Access:COMPROBANTES.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= CPTE:Record
  SELF.FileNameValue = 'COMPROBANTES'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= COMPROBANTES
  PARENT.Init
  Access:COMPROBANTES &= SELF


Hide:Access:COMPROBANTES.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:COMPROBANTES &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:COMPROBANTES.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(COMPROBANTES,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(CPTE:Por_Codigo,'CPTE:Por_Codigo',0)
    SELF.AddKey(CPTE:Por_Descripcion,'CPTE:Por_Descripcion',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:COMPROBANTES.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACPROV,RI:CASCADE,RI:RESTRICT,FCP:Por_Comprobante)
  SELF.AddRelationLink(CPTE:Codigo,FCP:Comprobante)


Hide:Relate:COMPROBANTES.Kill PROCEDURE

  CODE
  _Hide:Access:COMPROBANTES.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:COMPROBANTES &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:COMPROBANTES)                       ! destroy the file manager


Hide:Relate:REDESPACHO.Init PROCEDURE
  CODE
  _Hide:Access:REDESPACHO.Init
  SELF.Init(Access:REDESPACHO,1)


Hide:Access:REDESPACHO.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= RD:Record
  SELF.FileNameValue = 'REDESPACHO'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= REDESPACHO
  PARENT.Init
  Access:REDESPACHO &= SELF


Hide:Access:REDESPACHO.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:REDESPACHO &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:REDESPACHO.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(REDESPACHO,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(RD:Por_Guia,'Por Guía',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:REDESPACHO.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:GUIAS)


Hide:Relate:REDESPACHO.Kill PROCEDURE

  CODE
  _Hide:Access:REDESPACHO.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:REDESPACHO &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:REDESPACHO)                         ! destroy the file manager


Hide:Relate:PROVEEDORES.Init PROCEDURE
  CODE
  _Hide:Access:PROVEEDORES.Init
  SELF.Init(Access:PROVEEDORES,1)


Hide:Access:PROVEEDORES.BindFields PROCEDURE

  CODE
  PARENT.BindFields
  BIND('PROV:Notas',PROV:Notas)                            ! Bind memo field


Hide:Access:PROVEEDORES.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PROV:Record
  SELF.FileNameValue = 'PROVEEDORES'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PROVEEDORES
  PARENT.Init
  Access:PROVEEDORES &= SELF


Hide:Access:PROVEEDORES.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PROVEEDORES &= NULL                               ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PROVEEDORES.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PROVEEDORES,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PROV:Por_CodProveedor,'Por Código',1)
    SELF.AddKey(PROV:Por_Nombre,'Por Nombre',0)
    SELF.AddKey(PROV:Por_Localidad,'Por Localidad',0)
    SELF.AddKey(PROV:Por_Tipo,'Por Tipo',0)
    SELF.AddKey(PROV:Por_Provincia,'Por Provincia',0)
    SELF.AddKey(PROV:Por_TipoIVA,'Por Categoría de IVA',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PROVEEDORES.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACPROV,RI:CASCADE,RI:RESTRICT,FCP:Por_Proveedor_Fecha)
  SELF.AddRelationLink(PROV:CodProveedor,FCP:CodProveedor)

  SELF.AddRelation(Relate:PROVINCI)

  SELF.AddRelation(Relate:CATIVA)


Hide:Relate:PROVEEDORES.Kill PROCEDURE

  CODE
  _Hide:Access:PROVEEDORES.Kill                            ! Kill the file manager
  PARENT.Kill
  Relate:PROVEEDORES &= NULL                               ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PROVEEDORES)                        ! destroy the file manager


Hide:Relate:PARAMETRO.Init PROCEDURE
  CODE
  _Hide:Access:PARAMETRO.Init
  SELF.Init(Access:PARAMETRO,1)


Hide:Access:PARAMETRO.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PAR:Record
  SELF.FileNameValue = 'PARAMETRO'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PARAMETRO
  PARENT.Init
  Access:PARAMETRO &= SELF


Hide:Access:PARAMETRO.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PARAMETRO &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PARAMETRO.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PARAMETRO,GlobalErrors)
    SELF.Create = 0
    SELF.LockRecover = 10
    SELF.AddKey(PAR:Por_Registro,'Por Registro',1)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PARAMETRO.Kill PROCEDURE

  CODE
  _Hide:Access:PARAMETRO.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:PARAMETRO &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PARAMETRO)                          ! destroy the file manager


Hide:Relate:VISITAS.Init PROCEDURE
  CODE
  _Hide:Access:VISITAS.Init
  SELF.Init(Access:VISITAS,1)


Hide:Access:VISITAS.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= VIS:Record
  SELF.FileNameValue = 'VISITAS'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= VISITAS
  PARENT.Init
  Access:VISITAS &= SELF


Hide:Access:VISITAS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:VISITAS &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:VISITAS.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(VISITAS,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(VIS:Por_Cliente,'Por Cliente',0)
    SELF.AddKey(VIS:Por_Dia,'Por Día',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:VISITAS.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:DIAS)

  SELF.AddRelation(Relate:CLIENTES)


Hide:Relate:VISITAS.Kill PROCEDURE

  CODE
  _Hide:Access:VISITAS.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:VISITAS &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:VISITAS)                            ! destroy the file manager


Hide:Relate:FACTURAS.Init PROCEDURE
  CODE
  _Hide:Access:FACTURAS.Init
  SELF.Init(Access:FACTURAS,1)


Hide:Access:FACTURAS.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FAC:Record
  SELF.FileNameValue = 'FACTURAS'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FACTURAS
  PARENT.Init
  Access:FACTURAS &= SELF


Hide:Access:FACTURAS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FACTURAS &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FACTURAS.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FACTURAS,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FAC:Por_Registro,'Por Registro',1)
    SELF.AddKey(FAC:Por_NroComprobante,'Por Número',0)
    SELF.AddKey(FAC:Por_Comprobante,'Por Comprobante',0)
    SELF.AddKey(FAC:Por_FechaA,'Por Fecha',0)
    SELF.AddKey(FAC:Por_FechaD,'Por Fecha',0)
    SELF.AddKey(FAC:Por_Cliente,'Por Cliente',0)
    SELF.AddKey(FAC:Por_Remitente,'Por Remitente',0)
    SELF.AddKey(FAC:Por_Destinatario,'Por Destinatario',0)
    SELF.AddKey(FAC:Por_Distribuidor,'Por Distribuidor',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FACTURAS.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:CLIENTES)

  SELF.AddRelation(Relate:VALORES,RI:CASCADE,RI:RESTRICT,VAL:Por_Recibo)
  SELF.AddRelationLink(FAC:RegFactura,VAL:Recibo)

  SELF.AddRelation(Relate:APLIFAC,RI:CASCADE,RI:RESTRICT,APFAC:Por_Factura)
  SELF.AddRelationLink(FAC:RegFactura,APFAC:Factura)

  SELF.AddRelation(Relate:REMITENTE)

  SELF.AddRelation(Relate:DESTINATARIO)

  SELF.AddRelation(Relate:ITEMFAC,RI:CASCADE,RI:RESTRICT,ITFAC:Por_Factura)
  SELF.AddRelationLink(FAC:RegFactura,ITFAC:RegFactura)

  SELF.AddRelation(Relate:APLIGUIA,RI:CASCADE,RI:RESTRICT,APGUIA:Por_Factura)
  SELF.AddRelationLink(FAC:RegFactura,APGUIA:Factura)

  SELF.AddRelation(Relate:DISTRIBUIDORES)


Hide:Relate:FACTURAS.Kill PROCEDURE

  CODE
  _Hide:Access:FACTURAS.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:FACTURAS &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FACTURAS)                           ! destroy the file manager


Hide:Relate:GUIAS.Init PROCEDURE
  CODE
  _Hide:Access:GUIAS.Init
  SELF.Init(Access:GUIAS,1)


Hide:Access:GUIAS.BindFields PROCEDURE

  CODE
  PARENT.BindFields
  BIND('GUIA:Observacion',GUIA:Observacion)                ! Bind memo field


Hide:Access:GUIAS.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= GUIA:Record
  SELF.FileNameValue = 'GUIAS'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= GUIAS
  PARENT.Init
  Access:GUIAS &= SELF


Hide:Access:GUIAS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:GUIAS &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:GUIAS.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(GUIAS,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(GUIA:Por_Registro,'Por Registro',1)
    SELF.AddKey(GUIA:Por_Fecha,'Por Fecha',0)
    SELF.AddKey(GUIA:Por_Cliente_FechaA,'Por Cliente',0)
    SELF.AddKey(GUIA:Por_Cliente_FechaD,'GUIA:Por_Cliente_FechaD',0)
    SELF.AddKey(GUIA:Por_Numero,'Por Número',0)
    SELF.AddKey(GUIA:Por_Comprobante,'Por Comprobante',0)
    SELF.AddKey(GUIA:Por_Distribuidor,'Por Distribuidor',0)
    SELF.AddKey(GUIA:Por_Redespacho,'Por Redespacho',0)
    SELF.AddKey(GUIA:Por_Remitente,'Por Remitente',0)
    SELF.AddKey(GUIA:Por_Destinatario,'Por Destinatario',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:GUIAS.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 7
    GlobalErrors.SetField('GUIA:FacturarA')
    IF INSTRING(']' & CLIP(GUIA:FacturarA) & '[', ']R[]D[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Remitente'',''Destinatario''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:GUIAS.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:REDESPACHO,RI:None,RI:RESTRICT,RD:Por_Guia)
  SELF.AddRelationLink(GUIA:RegGuia,RD:Guia)

  SELF.AddRelation(Relate:REMITENTE)

  SELF.AddRelation(Relate:DESTINATARIO)

  SELF.AddRelation(Relate:APLIGUIA,RI:CASCADE,RI:RESTRICT,APGUIA:Por_Guia)
  SELF.AddRelationLink(GUIA:RegGuia,APGUIA:Guia)

  SELF.AddRelation(Relate:ITEMGUIA,RI:None,RI:RESTRICT,ITGUIA:Por_Guia)
  SELF.AddRelationLink(GUIA:RegGuia,ITGUIA:RegGuia)

  SELF.AddRelation(Relate:TRANSPOR)

  SELF.AddRelation(Relate:DISTRIBUIDORES)

  SELF.AddRelation(Relate:CLIENTES)


Hide:Relate:GUIAS.Kill PROCEDURE

  CODE
  _Hide:Access:GUIAS.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:GUIAS &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:GUIAS)                              ! destroy the file manager


Hide:Relate:FACPROV.Init PROCEDURE
  CODE
  _Hide:Access:FACPROV.Init
  SELF.Init(Access:FACPROV,1)


Hide:Access:FACPROV.BindFields PROCEDURE

  CODE
  PARENT.BindFields
  BIND('FCP:Comentario',FCP:Comentario)                    ! Bind memo field


Hide:Access:FACPROV.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FCP:Record
  SELF.FileNameValue = 'FACPROV'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FACPROV
  PARENT.Init
  Access:FACPROV &= SELF


Hide:Access:FACPROV.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FACPROV &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FACPROV.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FACPROV,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FCP:Por_Fecha_Presentacion,'FCP:Por_Fecha_Presentacion',0)
    SELF.AddKey(FCP:Por_FechaPresentacionD,'FCP:Por_FechaPresentacionD',0)
    SELF.AddKey(FCP:Por_NroComprobante,'FCP:Por_NroComprobante',0)
    SELF.AddKey(FCP:Por_Proveedor_Fecha,'FCP:Por_Proveedor_Fecha',0)
    SELF.AddKey(FCP:Por_Comprobante,'Por Comprobante',0)
    SELF.AddKey(FCP:Por_Registro,'FCP:Por_Registro',0)
    SELF.AddKey(FCP:Por_Fecha_Cpte,'FCP:Por_Fecha_Cpte',0)
    SELF.AddKey(FCP:Por_Cuenta,'FCP:Por_Cuenta',0)
    SELF.AddKey(FCP:Por_Caja,'FCP:Por_Caja',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FACPROV.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:COMPROBANTES)

  SELF.AddRelation(Relate:PROVEEDORES)


Hide:Relate:FACPROV.Kill PROCEDURE

  CODE
  _Hide:Access:FACPROV.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:FACPROV &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FACPROV)                            ! destroy the file manager


Hide:Relate:LOCALIDA.Init PROCEDURE
  CODE
  _Hide:Access:LOCALIDA.Init
  SELF.Init(Access:LOCALIDA,1)


Hide:Access:LOCALIDA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= LOC:Record
  SELF.FileNameValue = 'LOCALIDA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= LOCALIDA
  PARENT.Init
  Access:LOCALIDA &= SELF


Hide:Access:LOCALIDA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:LOCALIDA &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:LOCALIDA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(LOCALIDA,GlobalErrors)
    SELF.Create = 0
    SELF.LockRecover = 10
    SELF.AddKey(LOC:Por_Localidad,'LOC:Por_Localidad',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:LOCALIDA.Kill PROCEDURE

  CODE
  _Hide:Access:LOCALIDA.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:LOCALIDA &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:LOCALIDA)                           ! destroy the file manager


Hide:Relate:FE_RECE.Init PROCEDURE
  CODE
  _Hide:Access:FE_RECE.Init
  SELF.Init(Access:FE_RECE,1)


Hide:Access:FE_RECE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FRECE:Record
  SELF.FileNameValue = 'FE_RECE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FE_RECE
  SELF.FileName &= Glo:ArchivoRECE
  PARENT.Init
  Access:FE_RECE &= SELF


Hide:Access:FE_RECE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FE_RECE &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FE_RECE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FE_RECE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FE_RECE.Kill PROCEDURE

  CODE
  _Hide:Access:FE_RECE.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:FE_RECE &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FE_RECE)                            ! destroy the file manager


Hide:Relate:FE_Respuesta_RECE.Init PROCEDURE
  CODE
  _Hide:Access:FE_Respuesta_RECE.Init
  SELF.Init(Access:FE_Respuesta_RECE,1)


Hide:Access:FE_Respuesta_RECE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FE_Resp:Record
  SELF.FileNameValue = 'FE_Respuesta_RECE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FE_Respuesta_RECE
  PARENT.Init
  Access:FE_Respuesta_RECE &= SELF


Hide:Access:FE_Respuesta_RECE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FE_Respuesta_RECE &= NULL                         ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FE_Respuesta_RECE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FE_Respuesta_RECE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FE_Respuesta_RECE.Kill PROCEDURE

  CODE
  _Hide:Access:FE_Respuesta_RECE.Kill                      ! Kill the file manager
  PARENT.Kill
  Relate:FE_Respuesta_RECE &= NULL                         ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FE_Respuesta_RECE)                  ! destroy the file manager


Hide:Relate:APLIFAC.Init PROCEDURE
  CODE
  _Hide:Access:APLIFAC.Init
  SELF.Init(Access:APLIFAC,1)


Hide:Access:APLIFAC.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= APFAC:Record
  SELF.FileNameValue = 'APLIFAC'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= APLIFAC
  PARENT.Init
  Access:APLIFAC &= SELF


Hide:Access:APLIFAC.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:APLIFAC &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:APLIFAC.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(APLIFAC,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(APFAC:Por_Recibo,'Por Recibo',0)
    SELF.AddKey(APFAC:Por_Factura,'Por Factura',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:APLIFAC.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:RECIBOS)

  SELF.AddRelation(Relate:FACTURAS)


Hide:Relate:APLIFAC.Kill PROCEDURE

  CODE
  _Hide:Access:APLIFAC.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:APLIFAC &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:APLIFAC)                            ! destroy the file manager


Hide:Relate:APLIGUIA.Init PROCEDURE
  CODE
  _Hide:Access:APLIGUIA.Init
  SELF.Init(Access:APLIGUIA,1)


Hide:Access:APLIGUIA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= APGUIA:Record
  SELF.FileNameValue = 'APLIGUIA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= APLIGUIA
  PARENT.Init
  Access:APLIGUIA &= SELF


Hide:Access:APLIGUIA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:APLIGUIA &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:APLIGUIA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(APLIGUIA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(APGUIA:Por_Factura,'APGUIA:Por_Factura',0)
    SELF.AddKey(APGUIA:Por_Guia,'Por Guía',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:APLIGUIA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACTURAS)

  SELF.AddRelation(Relate:GUIAS)


Hide:Relate:APLIGUIA.Kill PROCEDURE

  CODE
  _Hide:Access:APLIGUIA.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:APLIGUIA &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:APLIGUIA)                           ! destroy the file manager


Hide:Relate:ITEMFAC.Init PROCEDURE
  CODE
  _Hide:Access:ITEMFAC.Init
  SELF.Init(Access:ITEMFAC,1)


Hide:Access:ITEMFAC.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ITFAC:Record
  SELF.FileNameValue = 'ITEMFAC'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ITEMFAC
  PARENT.Init
  Access:ITEMFAC &= SELF


Hide:Access:ITEMFAC.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ITEMFAC &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ITEMFAC.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ITEMFAC,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ITFAC:Por_Factura,'Por Factura',0)
    SELF.AddKey(ITFAC:Por_Item,'Por Item',1)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ITEMFAC.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACTURAS)


Hide:Relate:ITEMFAC.Kill PROCEDURE

  CODE
  _Hide:Access:ITEMFAC.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:ITEMFAC &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ITEMFAC)                            ! destroy the file manager


Hide:Relate:ZONAS.Init PROCEDURE
  CODE
  _Hide:Access:ZONAS.Init
  SELF.Init(Access:ZONAS,1)


Hide:Access:ZONAS.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ZON:Record
  SELF.FileNameValue = 'ZONAS'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ZONAS
  PARENT.Init
  Access:ZONAS &= SELF


Hide:Access:ZONAS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ZONAS &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ZONAS.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ZONAS,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ZON:Por_Codigo,'Por Código',1)
    SELF.AddKey(ZON:Por_Nombre,'Por Nombre',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ZONAS.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:DISTRIBUIDORES,RI:CASCADE,RI:RESTRICT,DIS:Por_Zona)
  SELF.AddRelationLink(ZON:CodZona,DIS:Zona)

  SELF.AddRelation(Relate:CLIENTES,RI:CASCADE,RI:RESTRICT,CLI:Por_Zona)
  SELF.AddRelationLink(ZON:CodZona,CLI:Zona)


Hide:Relate:ZONAS.Kill PROCEDURE

  CODE
  _Hide:Access:ZONAS.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:ZONAS &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ZONAS)                              ! destroy the file manager

