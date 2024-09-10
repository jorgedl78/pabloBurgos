  MEMBER('comision.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
COMISBC1:DctInit    PROCEDURE
COMISBC1:DctKill    PROCEDURE
COMISBC1:FilesInit  PROCEDURE
  END

Hide:Access:PARAMFE  CLASS(FileManager),TYPE               ! FileManager for PARAMFE
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:PARAMFE  CLASS(RelationManager),TYPE           ! RelationManager for PARAMFE
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:PARAMFE3 CLASS(FileManager),TYPE               ! FileManager for PARAMFE3
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:PARAMFE3 CLASS(RelationManager),TYPE           ! RelationManager for PARAMFE3
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:ITEMGUIA CLASS(FileManager),TYPE               ! FileManager for ITEMGUIA
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:ITEMGUIA CLASS(RelationManager),TYPE           ! RelationManager for ITEMGUIA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:PROVINCI CLASS(FileManager),TYPE               ! FileManager for PROVINCI
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:PROVINCI CLASS(RelationManager),TYPE           ! RelationManager for PROVINCI
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:TRANSPOR CLASS(FileManager),TYPE               ! FileManager for TRANSPOR
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:TRANSPOR CLASS(RelationManager),TYPE           ! RelationManager for TRANSPOR
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:CATIVA   CLASS(FileManager),TYPE               ! FileManager for CATIVA
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CATIVA   CLASS(RelationManager),TYPE           ! RelationManager for CATIVA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:DIAS     CLASS(FileManager),TYPE               ! FileManager for DIAS
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:DIAS     CLASS(RelationManager),TYPE           ! RelationManager for DIAS
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:DISTRIBUIDORES CLASS(FileManager),TYPE         ! FileManager for DISTRIBUIDORES
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:DISTRIBUIDORES CLASS(RelationManager),TYPE     ! RelationManager for DISTRIBUIDORES
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:VALORES  CLASS(FileManager),TYPE               ! FileManager for VALORES
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:VALORES  CLASS(RelationManager),TYPE           ! RelationManager for VALORES
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:BANCOS   CLASS(FileManager),TYPE               ! FileManager for BANCOS
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:BANCOS   CLASS(RelationManager),TYPE           ! RelationManager for BANCOS
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:TRANSLOC CLASS(FileManager),TYPE               ! FileManager for TRANSLOC
BindFields             PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:TRANSLOC CLASS(RelationManager),TYPE           ! RelationManager for TRANSLOC
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:CATIVADES CLASS(FileManager),TYPE              ! FileManager for CATIVADES
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CATIVADES CLASS(RelationManager),TYPE          ! RelationManager for CATIVADES
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:CATIVAREM CLASS(FileManager),TYPE              ! FileManager for CATIVAREM
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:CATIVAREM CLASS(RelationManager),TYPE          ! RelationManager for CATIVAREM
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:RECIBOS  CLASS(FileManager),TYPE               ! FileManager for RECIBOS
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:RECIBOS  CLASS(RelationManager),TYPE           ! RelationManager for RECIBOS
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:REMITENTE CLASS(FileManager),TYPE              ! FileManager for REMITENTE
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:REMITENTE CLASS(RelationManager),TYPE          ! RelationManager for REMITENTE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:DESTINATARIO CLASS(FileManager),TYPE           ! FileManager for DESTINATARIO
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:DESTINATARIO CLASS(RelationManager),TYPE       ! RelationManager for DESTINATARIO
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

Hide:Access:LOCALIDAD2 CLASS(FileManager),TYPE             ! FileManager for LOCALIDAD2
Init                   PROCEDURE(),DERIVED                 ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED ! Method added to host embed code
                     END


Hide:Relate:LOCALIDAD2 CLASS(RelationManager),TYPE         ! RelationManager for LOCALIDAD2
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END


_Hide:Access:PARAMFE &Hide:Access:PARAMFE,AUTO,THREAD
_Hide:Relate:PARAMFE &Hide:Relate:PARAMFE,AUTO,THREAD
_Hide:Access:PARAMFE3 &Hide:Access:PARAMFE3,AUTO,THREAD
_Hide:Relate:PARAMFE3 &Hide:Relate:PARAMFE3,AUTO,THREAD
_Hide:Access:ITEMGUIA &Hide:Access:ITEMGUIA,AUTO,THREAD
_Hide:Relate:ITEMGUIA &Hide:Relate:ITEMGUIA,AUTO,THREAD
_Hide:Access:PROVINCI &Hide:Access:PROVINCI,AUTO,THREAD
_Hide:Relate:PROVINCI &Hide:Relate:PROVINCI,AUTO,THREAD
_Hide:Access:TRANSPOR &Hide:Access:TRANSPOR,AUTO,THREAD
_Hide:Relate:TRANSPOR &Hide:Relate:TRANSPOR,AUTO,THREAD
_Hide:Access:CATIVA  &Hide:Access:CATIVA,AUTO,THREAD
_Hide:Relate:CATIVA  &Hide:Relate:CATIVA,AUTO,THREAD
_Hide:Access:DIAS    &Hide:Access:DIAS,AUTO,THREAD
_Hide:Relate:DIAS    &Hide:Relate:DIAS,AUTO,THREAD
_Hide:Access:DISTRIBUIDORES &Hide:Access:DISTRIBUIDORES,AUTO,THREAD
_Hide:Relate:DISTRIBUIDORES &Hide:Relate:DISTRIBUIDORES,AUTO,THREAD
_Hide:Access:VALORES &Hide:Access:VALORES,AUTO,THREAD
_Hide:Relate:VALORES &Hide:Relate:VALORES,AUTO,THREAD
_Hide:Access:BANCOS  &Hide:Access:BANCOS,AUTO,THREAD
_Hide:Relate:BANCOS  &Hide:Relate:BANCOS,AUTO,THREAD
_Hide:Access:TRANSLOC &Hide:Access:TRANSLOC,AUTO,THREAD
_Hide:Relate:TRANSLOC &Hide:Relate:TRANSLOC,AUTO,THREAD
_Hide:Access:CATIVADES &Hide:Access:CATIVADES,AUTO,THREAD
_Hide:Relate:CATIVADES &Hide:Relate:CATIVADES,AUTO,THREAD
_Hide:Access:CATIVAREM &Hide:Access:CATIVAREM,AUTO,THREAD
_Hide:Relate:CATIVAREM &Hide:Relate:CATIVAREM,AUTO,THREAD
_Hide:Access:RECIBOS &Hide:Access:RECIBOS,AUTO,THREAD
_Hide:Relate:RECIBOS &Hide:Relate:RECIBOS,AUTO,THREAD
_Hide:Access:REMITENTE &Hide:Access:REMITENTE,AUTO,THREAD
_Hide:Relate:REMITENTE &Hide:Relate:REMITENTE,AUTO,THREAD
_Hide:Access:DESTINATARIO &Hide:Access:DESTINATARIO,AUTO,THREAD
_Hide:Relate:DESTINATARIO &Hide:Relate:DESTINATARIO,AUTO,THREAD
_Hide:Access:LOCALIDAD2 &Hide:Access:LOCALIDAD2,AUTO,THREAD
_Hide:Relate:LOCALIDAD2 &Hide:Relate:LOCALIDAD2,AUTO,THREAD


COMISBC1:DctInit PROCEDURE
  CODE
  _Hide:Access:PARAMFE &= NEW(Hide:Access:PARAMFE)
  _Hide:Relate:PARAMFE &= NEW(Hide:Relate:PARAMFE)
  _Hide:Access:PARAMFE3 &= NEW(Hide:Access:PARAMFE3)
  _Hide:Relate:PARAMFE3 &= NEW(Hide:Relate:PARAMFE3)
  _Hide:Access:ITEMGUIA &= NEW(Hide:Access:ITEMGUIA)
  _Hide:Relate:ITEMGUIA &= NEW(Hide:Relate:ITEMGUIA)
  _Hide:Access:PROVINCI &= NEW(Hide:Access:PROVINCI)
  _Hide:Relate:PROVINCI &= NEW(Hide:Relate:PROVINCI)
  _Hide:Access:TRANSPOR &= NEW(Hide:Access:TRANSPOR)
  _Hide:Relate:TRANSPOR &= NEW(Hide:Relate:TRANSPOR)
  _Hide:Access:CATIVA &= NEW(Hide:Access:CATIVA)
  _Hide:Relate:CATIVA &= NEW(Hide:Relate:CATIVA)
  _Hide:Access:DIAS &= NEW(Hide:Access:DIAS)
  _Hide:Relate:DIAS &= NEW(Hide:Relate:DIAS)
  _Hide:Access:DISTRIBUIDORES &= NEW(Hide:Access:DISTRIBUIDORES)
  _Hide:Relate:DISTRIBUIDORES &= NEW(Hide:Relate:DISTRIBUIDORES)
  _Hide:Access:VALORES &= NEW(Hide:Access:VALORES)
  _Hide:Relate:VALORES &= NEW(Hide:Relate:VALORES)
  _Hide:Access:BANCOS &= NEW(Hide:Access:BANCOS)
  _Hide:Relate:BANCOS &= NEW(Hide:Relate:BANCOS)
  _Hide:Access:TRANSLOC &= NEW(Hide:Access:TRANSLOC)
  _Hide:Relate:TRANSLOC &= NEW(Hide:Relate:TRANSLOC)
  _Hide:Access:CATIVADES &= NEW(Hide:Access:CATIVADES)
  _Hide:Relate:CATIVADES &= NEW(Hide:Relate:CATIVADES)
  _Hide:Access:CATIVAREM &= NEW(Hide:Access:CATIVAREM)
  _Hide:Relate:CATIVAREM &= NEW(Hide:Relate:CATIVAREM)
  _Hide:Access:RECIBOS &= NEW(Hide:Access:RECIBOS)
  _Hide:Relate:RECIBOS &= NEW(Hide:Relate:RECIBOS)
  _Hide:Access:REMITENTE &= NEW(Hide:Access:REMITENTE)
  _Hide:Relate:REMITENTE &= NEW(Hide:Relate:REMITENTE)
  _Hide:Access:DESTINATARIO &= NEW(Hide:Access:DESTINATARIO)
  _Hide:Relate:DESTINATARIO &= NEW(Hide:Relate:DESTINATARIO)
  _Hide:Access:LOCALIDAD2 &= NEW(Hide:Access:LOCALIDAD2)
  _Hide:Relate:LOCALIDAD2 &= NEW(Hide:Relate:LOCALIDAD2)
  Relate:PARAMFE &= _Hide:Relate:PARAMFE
  Relate:PARAMFE3 &= _Hide:Relate:PARAMFE3
  Relate:ITEMGUIA &= _Hide:Relate:ITEMGUIA
  Relate:PROVINCI &= _Hide:Relate:PROVINCI
  Relate:TRANSPOR &= _Hide:Relate:TRANSPOR
  Relate:CATIVA &= _Hide:Relate:CATIVA
  Relate:DIAS &= _Hide:Relate:DIAS
  Relate:DISTRIBUIDORES &= _Hide:Relate:DISTRIBUIDORES
  Relate:VALORES &= _Hide:Relate:VALORES
  Relate:BANCOS &= _Hide:Relate:BANCOS
  Relate:TRANSLOC &= _Hide:Relate:TRANSLOC
  Relate:CATIVADES &= _Hide:Relate:CATIVADES
  Relate:CATIVAREM &= _Hide:Relate:CATIVAREM
  Relate:RECIBOS &= _Hide:Relate:RECIBOS
  Relate:REMITENTE &= _Hide:Relate:REMITENTE
  Relate:DESTINATARIO &= _Hide:Relate:DESTINATARIO
  Relate:LOCALIDAD2 &= _Hide:Relate:LOCALIDAD2


COMISBC1:FilesInit PROCEDURE
  CODE
  _Hide:Relate:PARAMFE.Init
  _Hide:Relate:PARAMFE3.Init
  _Hide:Relate:ITEMGUIA.Init
  _Hide:Relate:PROVINCI.Init
  _Hide:Relate:TRANSPOR.Init
  _Hide:Relate:CATIVA.Init
  _Hide:Relate:DIAS.Init
  _Hide:Relate:DISTRIBUIDORES.Init
  _Hide:Relate:VALORES.Init
  _Hide:Relate:BANCOS.Init
  _Hide:Relate:TRANSLOC.Init
  _Hide:Relate:CATIVADES.Init
  _Hide:Relate:CATIVAREM.Init
  _Hide:Relate:RECIBOS.Init
  _Hide:Relate:REMITENTE.Init
  _Hide:Relate:DESTINATARIO.Init
  _Hide:Relate:LOCALIDAD2.Init


COMISBC1:DctKill PROCEDURE
  CODE
  _Hide:Relate:PARAMFE.Kill
  DISPOSE(_Hide:Relate:PARAMFE)
  _Hide:Relate:PARAMFE3.Kill
  DISPOSE(_Hide:Relate:PARAMFE3)
  _Hide:Relate:ITEMGUIA.Kill
  DISPOSE(_Hide:Relate:ITEMGUIA)
  _Hide:Relate:PROVINCI.Kill
  DISPOSE(_Hide:Relate:PROVINCI)
  _Hide:Relate:TRANSPOR.Kill
  DISPOSE(_Hide:Relate:TRANSPOR)
  _Hide:Relate:CATIVA.Kill
  DISPOSE(_Hide:Relate:CATIVA)
  _Hide:Relate:DIAS.Kill
  DISPOSE(_Hide:Relate:DIAS)
  _Hide:Relate:DISTRIBUIDORES.Kill
  DISPOSE(_Hide:Relate:DISTRIBUIDORES)
  _Hide:Relate:VALORES.Kill
  DISPOSE(_Hide:Relate:VALORES)
  _Hide:Relate:BANCOS.Kill
  DISPOSE(_Hide:Relate:BANCOS)
  _Hide:Relate:TRANSLOC.Kill
  DISPOSE(_Hide:Relate:TRANSLOC)
  _Hide:Relate:CATIVADES.Kill
  DISPOSE(_Hide:Relate:CATIVADES)
  _Hide:Relate:CATIVAREM.Kill
  DISPOSE(_Hide:Relate:CATIVAREM)
  _Hide:Relate:RECIBOS.Kill
  DISPOSE(_Hide:Relate:RECIBOS)
  _Hide:Relate:REMITENTE.Kill
  DISPOSE(_Hide:Relate:REMITENTE)
  _Hide:Relate:DESTINATARIO.Kill
  DISPOSE(_Hide:Relate:DESTINATARIO)
  _Hide:Relate:LOCALIDAD2.Kill
  DISPOSE(_Hide:Relate:LOCALIDAD2)


Hide:Relate:PARAMFE.Init PROCEDURE
  CODE
  _Hide:Access:PARAMFE.Init
  SELF.Init(Access:PARAMFE,1)


Hide:Access:PARAMFE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PARFE:Record
  SELF.FileNameValue = 'PARAMFE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PARAMFE
  PARENT.Init
  Access:PARAMFE &= SELF


Hide:Access:PARAMFE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PARAMFE &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PARAMFE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PARAMFE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PARFE:ParametrosFE_x_ID,'PARFE:ParametrosFE_x_ID',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PARAMFE.Kill PROCEDURE

  CODE
  _Hide:Access:PARAMFE.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:PARAMFE &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PARAMFE)                            ! destroy the file manager


Hide:Relate:PARAMFE3.Init PROCEDURE
  CODE
  _Hide:Access:PARAMFE3.Init
  SELF.Init(Access:PARAMFE3,1)


Hide:Access:PARAMFE3.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PARFE3:Record
  SELF.FileNameValue = 'PARAMFE3'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PARAMFE3
  PARENT.Init
  Access:PARAMFE3 &= SELF


Hide:Access:PARAMFE3.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PARAMFE3 &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PARAMFE3.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PARAMFE3,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PARFE3:ParametrosFE_x_ID,'PARFE3:ParametrosFE_x_ID',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PARAMFE3.Kill PROCEDURE

  CODE
  _Hide:Access:PARAMFE3.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:PARAMFE3 &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PARAMFE3)                           ! destroy the file manager


Hide:Relate:ITEMGUIA.Init PROCEDURE
  CODE
  _Hide:Access:ITEMGUIA.Init
  SELF.Init(Access:ITEMGUIA,1)


Hide:Access:ITEMGUIA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ITGUIA:Record
  SELF.FileNameValue = 'ITEMGUIA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ITEMGUIA
  PARENT.Init
  Access:ITEMGUIA &= SELF


Hide:Access:ITEMGUIA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ITEMGUIA &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ITEMGUIA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ITEMGUIA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ITGUIA:Por_Guia,'Por Guia',0)
    SELF.AddKey(ITGUIA:Por_Item,'Por Item',1)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ITEMGUIA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:GUIAS)


Hide:Relate:ITEMGUIA.Kill PROCEDURE

  CODE
  _Hide:Access:ITEMGUIA.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:ITEMGUIA &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ITEMGUIA)                           ! destroy the file manager


Hide:Relate:PROVINCI.Init PROCEDURE
  CODE
  _Hide:Access:PROVINCI.Init
  SELF.Init(Access:PROVINCI,1)


Hide:Access:PROVINCI.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PCIA:Record
  SELF.FileNameValue = 'PROVINCI'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PROVINCI
  PARENT.Init
  Access:PROVINCI &= SELF


Hide:Access:PROVINCI.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PROVINCI &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PROVINCI.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PROVINCI,GlobalErrors)
    SELF.Create = 0
    SELF.LockRecover = 10
    SELF.AddKey(PCIA:Por_Codigo,'Por Código',0)
    SELF.AddKey(PCIA:Por_Denominacion,'Por Denominación',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PROVINCI.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:PROVEEDORES,RI:CASCADE,RI:RESTRICT,PROV:Por_Provincia)
  SELF.AddRelationLink(PCIA:CodProvincia,PROV:Provincia)

  SELF.AddRelation(Relate:TRANSPOR,RI:CASCADE,RI:RESTRICT,TRA:Por_Provincia)
  SELF.AddRelationLink(PCIA:CodProvincia,TRA:Provincia)

  SELF.AddRelation(Relate:DISTRIBUIDORES,RI:CASCADE,RI:RESTRICT,DIS:Por_Provincia)
  SELF.AddRelationLink(PCIA:CodProvincia,DIS:Provincia)

  SELF.AddRelation(Relate:CLIENTES,RI:CASCADE,RI:RESTRICT,CLI:Por_Provincia)
  SELF.AddRelationLink(PCIA:CodProvincia,CLI:Provincia)


Hide:Relate:PROVINCI.Kill PROCEDURE

  CODE
  _Hide:Access:PROVINCI.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:PROVINCI &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PROVINCI)                           ! destroy the file manager


Hide:Relate:TRANSPOR.Init PROCEDURE
  CODE
  _Hide:Access:TRANSPOR.Init
  SELF.Init(Access:TRANSPOR,1)


Hide:Access:TRANSPOR.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= TRA:Record
  SELF.FileNameValue = 'TRANSPOR'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= TRANSPOR
  PARENT.Init
  Access:TRANSPOR &= SELF


Hide:Access:TRANSPOR.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:TRANSPOR &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:TRANSPOR.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(TRANSPOR,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(TRA:Por_Codigo,'TRA:Por_Codigo',1)
    SELF.AddKey(TRA:Por_Denominacion,'TRA:Por_Denominacion',0)
    SELF.AddKey(TRA:Por_Provincia,'TRA:Por_Provincia',0)
    SELF.AddKey(TRA:Por_CategoriaIVA,'TRA:Por_CategoriaIVA',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:TRANSPOR.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:TRANSLOC,RI:CASCADE,RI:CASCADE,TRL:Por_Transporte)
  SELF.AddRelationLink(TRA:CodTransporte,TRL:Transporte)

  SELF.AddRelation(Relate:PROVINCI)

  SELF.AddRelation(Relate:CATIVA)

  SELF.AddRelation(Relate:GUIAS,RI:CASCADE,RI:RESTRICT,GUIA:Por_Redespacho)
  SELF.AddRelationLink(TRA:CodTransporte,GUIA:Redespacho)


Hide:Relate:TRANSPOR.Kill PROCEDURE

  CODE
  _Hide:Access:TRANSPOR.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:TRANSPOR &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:TRANSPOR)                           ! destroy the file manager


Hide:Relate:CATIVA.Init PROCEDURE
  CODE
  _Hide:Access:CATIVA.Init
  SELF.Init(Access:CATIVA,1)


Hide:Access:CATIVA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= IVA:Record
  SELF.FileNameValue = 'CATIVA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= CATIVA
  PARENT.Init
  Access:CATIVA &= SELF


Hide:Access:CATIVA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CATIVA &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CATIVA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(CATIVA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(IVA:Por_CodIVA,'IVA:Por_CodIVA',1)
    SELF.AddKey(IVA:Por_Descripcion,'IVA:Por_Descripcion',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:CATIVA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:PROVEEDORES,RI:CASCADE,RI:RESTRICT,PROV:Por_TipoIVA)
  SELF.AddRelationLink(IVA:CodCatIVA,PROV:PosicionIVA)

  SELF.AddRelation(Relate:TRANSPOR,RI:CASCADE,RI:RESTRICT,TRA:Por_CategoriaIVA)
  SELF.AddRelationLink(IVA:CodCatIVA,TRA:CatIVA)

  SELF.AddRelation(Relate:CLIENTES,RI:CASCADE,RI:RESTRICT,CLI:Por_CategoriaIVA)
  SELF.AddRelationLink(IVA:CodCatIVA,CLI:PosicionIVA)


Hide:Relate:CATIVA.Kill PROCEDURE

  CODE
  _Hide:Access:CATIVA.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:CATIVA &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CATIVA)                             ! destroy the file manager


Hide:Relate:DIAS.Init PROCEDURE
  CODE
  _Hide:Access:DIAS.Init
  SELF.Init(Access:DIAS,1)


Hide:Access:DIAS.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= DIA:Record
  SELF.FileNameValue = 'DIAS'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= DIAS
  PARENT.Init
  Access:DIAS &= SELF


Hide:Access:DIAS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:DIAS &= NULL                                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:DIAS.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(DIAS,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(DIA:Por_Codigo,'Por Código',1)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:DIAS.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:VISITAS,RI:CASCADE,RI:RESTRICT,VIS:Por_Dia)
  SELF.AddRelationLink(DIA:Codigo,VIS:Dia)


Hide:Relate:DIAS.Kill PROCEDURE

  CODE
  _Hide:Access:DIAS.Kill                                   ! Kill the file manager
  PARENT.Kill
  Relate:DIAS &= NULL                                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:DIAS)                               ! destroy the file manager


Hide:Relate:DISTRIBUIDORES.Init PROCEDURE
  CODE
  _Hide:Access:DISTRIBUIDORES.Init
  SELF.Init(Access:DISTRIBUIDORES,1)


Hide:Access:DISTRIBUIDORES.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= DIS:Record
  SELF.FileNameValue = 'DISTRIBUIDORES'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= DISTRIBUIDORES
  PARENT.Init
  Access:DISTRIBUIDORES &= SELF


Hide:Access:DISTRIBUIDORES.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:DISTRIBUIDORES &= NULL                            ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:DISTRIBUIDORES.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(DISTRIBUIDORES,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(DIS:Por_Codigo,'Por Codigo',1)
    SELF.AddKey(DIS:Por_Nombre,'Por Nombre',0)
    SELF.AddKey(DIS:Por_Provincia,'Provincia',0)
    SELF.AddKey(DIS:Por_Zona,'Por Zona',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:DISTRIBUIDORES.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACTURAS,RI:CASCADE,RI:RESTRICT,FAC:Por_Distribuidor)
  SELF.AddRelationLink(DIS:CodDistribuidor,FAC:Distribuidor)

  SELF.AddRelation(Relate:ZONAS)

  SELF.AddRelation(Relate:PROVINCI)

  SELF.AddRelation(Relate:CLIENTES,RI:CASCADE,RI:RESTRICT,CLI:Por_Distribuidor)
  SELF.AddRelationLink(DIS:CodDistribuidor,CLI:Distribuidor)

  SELF.AddRelation(Relate:GUIAS,RI:CASCADE,RI:RESTRICT,GUIA:Por_Distribuidor)
  SELF.AddRelationLink(DIS:CodDistribuidor,GUIA:Distribuidor)


Hide:Relate:DISTRIBUIDORES.Kill PROCEDURE

  CODE
  _Hide:Access:DISTRIBUIDORES.Kill                         ! Kill the file manager
  PARENT.Kill
  Relate:DISTRIBUIDORES &= NULL                            ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:DISTRIBUIDORES)                     ! destroy the file manager


Hide:Relate:VALORES.Init PROCEDURE
  CODE
  _Hide:Access:VALORES.Init
  SELF.Init(Access:VALORES,1)


Hide:Access:VALORES.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= VAL:Record
  SELF.FileNameValue = 'VALORES'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= VALORES
  PARENT.Init
  Access:VALORES &= SELF


Hide:Access:VALORES.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:VALORES &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:VALORES.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(VALORES,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(VAL:Por_CodigoInterno,'Por Código Interno',1)
    SELF.AddKey(VAL:Por_Recibo,'Por Recibo',0)
    SELF.AddKey(VAL:Por_Banco,'Por Banco/Número',0)
    SELF.AddKey(VAL:Por_Numero,'Por Número',0)
    SELF.AddKey(VAL:Por_Fecha,'Por Fecha',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:VALORES.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('VAL:Tipo')
    IF INSTRING(']' & CLIP(VAL:Tipo) & '[', ']Efectivo[]Cheque[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Efectivo'',''Cheque''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:VALORES.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACTURAS)

  SELF.AddRelation(Relate:BANCOS)


Hide:Relate:VALORES.Kill PROCEDURE

  CODE
  _Hide:Access:VALORES.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:VALORES &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:VALORES)                            ! destroy the file manager


Hide:Relate:BANCOS.Init PROCEDURE
  CODE
  _Hide:Access:BANCOS.Init
  SELF.Init(Access:BANCOS,1)


Hide:Access:BANCOS.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= BCO:Record
  SELF.FileNameValue = 'BANCOS'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= BANCOS
  PARENT.Init
  Access:BANCOS &= SELF


Hide:Access:BANCOS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:BANCOS &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:BANCOS.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(BANCOS,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(BCO:Por_Nombre,'BCO:Por_Nombre',0)
    SELF.AddKey(BCO:Por_Codigo,'BCO:Por_Codigo',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:BANCOS.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:VALORES,RI:CASCADE,RI:RESTRICT,VAL:Por_Banco)
  SELF.AddRelationLink(BCO:Codigo,VAL:Banco)


Hide:Relate:BANCOS.Kill PROCEDURE

  CODE
  _Hide:Access:BANCOS.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:BANCOS &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:BANCOS)                             ! destroy the file manager


Hide:Relate:TRANSLOC.Init PROCEDURE
  CODE
  _Hide:Access:TRANSLOC.Init
  SELF.Init(Access:TRANSLOC,1)


Hide:Access:TRANSLOC.BindFields PROCEDURE

  CODE
  PARENT.BindFields
  BIND('TRL:Observacion',TRL:Observacion)                  ! Bind memo field


Hide:Access:TRANSLOC.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= TRL:Record
  SELF.FileNameValue = 'TRANSLOC'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= TRANSLOC
  PARENT.Init
  Access:TRANSLOC &= SELF


Hide:Access:TRANSLOC.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:TRANSLOC &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:TRANSLOC.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(TRANSLOC,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(TRL:Por_Transporte,'Por Transporte/Localidad/Día',0)
    SELF.AddKey(TRL:Por_Localidad,'Por Localidad',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:TRANSLOC.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:TRANSPOR)


Hide:Relate:TRANSLOC.Kill PROCEDURE

  CODE
  _Hide:Access:TRANSLOC.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:TRANSLOC &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:TRANSLOC)                           ! destroy the file manager


Hide:Relate:CATIVADES.Init PROCEDURE
  CODE
  _Hide:Access:CATIVADES.Init
  SELF.Init(Access:CATIVADES,1)
  SELF.SetAlias(Relate:CATIVA)


Hide:Access:CATIVADES.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= IVAD:Record
  SELF.AliasedFile &= Access:CATIVA                        !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'CATIVADES'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= CATIVADES
  PARENT.Init
  Access:CATIVADES &= SELF


Hide:Access:CATIVADES.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CATIVADES &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CATIVADES.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(CATIVADES,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(IVAD:Por_CodIVA,'IVAD:Por_CodIVA',1)
    SELF.AddKey(IVAD:Por_Descripcion,'IVAD:Por_Descripcion',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:CATIVADES.Kill PROCEDURE

  CODE
  _Hide:Access:CATIVADES.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:CATIVADES &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CATIVADES)                          ! destroy the file manager


Hide:Relate:CATIVAREM.Init PROCEDURE
  CODE
  _Hide:Access:CATIVAREM.Init
  SELF.Init(Access:CATIVAREM,1)
  SELF.SetAlias(Relate:CATIVA)


Hide:Access:CATIVAREM.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= IVAR:Record
  SELF.AliasedFile &= Access:CATIVA                        !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'CATIVAREM'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= CATIVAREM
  PARENT.Init
  Access:CATIVAREM &= SELF


Hide:Access:CATIVAREM.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:CATIVAREM &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:CATIVAREM.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(CATIVAREM,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(IVAR:Por_CodIVA,'IVAR:Por_CodIVA',1)
    SELF.AddKey(IVAR:Por_Descripcion,'IVAR:Por_Descripcion',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:CATIVAREM.Kill PROCEDURE

  CODE
  _Hide:Access:CATIVAREM.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:CATIVAREM &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:CATIVAREM)                          ! destroy the file manager


Hide:Relate:RECIBOS.Init PROCEDURE
  CODE
  _Hide:Access:RECIBOS.Init
  SELF.Init(Access:RECIBOS,1)
  SELF.SetAlias(Relate:FACTURAS)


Hide:Access:RECIBOS.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= REC:Record
  SELF.AliasedFile &= Access:FACTURAS                      !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'RECIBOS'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= RECIBOS
  PARENT.Init
  Access:RECIBOS &= SELF


Hide:Access:RECIBOS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:RECIBOS &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:RECIBOS.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(RECIBOS,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(REC:Por_Registro,'Por Registro',1)
    SELF.AddKey(REC:Por_NroComprobante,'Por Número',0)
    SELF.AddKey(REC:Por_Comprobante,'Por Comprobante',0)
    SELF.AddKey(REC:Por_FechaA,'Por Fecha',0)
    SELF.AddKey(REC:Por_FechaD,'Por Fecha',0)
    SELF.AddKey(REC:Por_Cliente,'Por Cliente',0)
    SELF.AddKey(REC:Por_Remitente,'Por Remitente',0)
    SELF.AddKey(REC:Por_Destinatario,'Por Destinatario',0)
    SELF.AddKey(REC:Por_Distribuidor,'Por Distribuidor',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:RECIBOS.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:APLIFAC,RI:CASCADE,RI:RESTRICT,APFAC:Por_Recibo)
  SELF.AddRelationLink(REC:RegFactura,APFAC:Recibo)


Hide:Relate:RECIBOS.Kill PROCEDURE

  CODE
  _Hide:Access:RECIBOS.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:RECIBOS &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:RECIBOS)                            ! destroy the file manager


Hide:Relate:REMITENTE.Init PROCEDURE
  CODE
  _Hide:Access:REMITENTE.Init
  SELF.Init(Access:REMITENTE,1)
  SELF.SetAlias(Relate:CLIENTES)


Hide:Access:REMITENTE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= RTE:Record
  SELF.AliasedFile &= Access:CLIENTES                      !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'REMITENTE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= REMITENTE
  PARENT.Init
  Access:REMITENTE &= SELF


Hide:Access:REMITENTE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:REMITENTE &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:REMITENTE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(REMITENTE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(RTE:Por_Codigo,'RTE:Por_Codigo',1)
    SELF.AddKey(RTE:Por_Nombre,'RTE:Por_Nombre',0)
    SELF.AddKey(RTE:Por_Localidad,'RTE:Por_Localidad',0)
    SELF.AddKey(RTE:Por_Zona,'RTE:Por_Zona',0)
    SELF.AddKey(RTE:Por_Distribuidor,'RTE:Por_Distribuidor',0)
    SELF.AddKey(RTE:Por_CategoriaIVA,'RTE:Por_CategoriaIVA',0)
    SELF.AddKey(RTE:Por_Provincia,'Por Provincia',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:REMITENTE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACTURAS,RI:CASCADE,RI:RESTRICT,FAC:Por_Remitente)
  SELF.AddRelationLink(RTE:CodCliente,FAC:Remitente)

  SELF.AddRelation(Relate:GUIAS,RI:CASCADE,RI:RESTRICT,GUIA:Por_Remitente)
  SELF.AddRelationLink(RTE:CodCliente,GUIA:Remitente)


Hide:Relate:REMITENTE.Kill PROCEDURE

  CODE
  _Hide:Access:REMITENTE.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:REMITENTE &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:REMITENTE)                          ! destroy the file manager


Hide:Relate:DESTINATARIO.Init PROCEDURE
  CODE
  _Hide:Access:DESTINATARIO.Init
  SELF.Init(Access:DESTINATARIO,1)
  SELF.SetAlias(Relate:CLIENTES)


Hide:Access:DESTINATARIO.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= DES:Record
  SELF.AliasedFile &= Access:CLIENTES                      !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'DESTINATARIO'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= DESTINATARIO
  PARENT.Init
  Access:DESTINATARIO &= SELF


Hide:Access:DESTINATARIO.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:DESTINATARIO &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:DESTINATARIO.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(DESTINATARIO,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(DES:Por_Codigo,'DES:Por_Codigo',1)
    SELF.AddKey(DES:Por_Nombre,'DES:Por_Nombre',0)
    SELF.AddKey(DES:Por_Localidad,'DES:Por_Localidad',0)
    SELF.AddKey(DES:Por_Zona,'DES:Por_Zona',0)
    SELF.AddKey(DES:Por_Distribuidor,'DES:Por_Distribuidor',0)
    SELF.AddKey(DES:Por_CategoriaIVA,'DES:Por_CategoriaIVA',0)
    SELF.AddKey(DES:Por_Provincia,'Por Provincia',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:DESTINATARIO.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FACTURAS,RI:CASCADE,RI:RESTRICT,FAC:Por_Destinatario)
  SELF.AddRelationLink(DES:CodCliente,FAC:Destinatario)

  SELF.AddRelation(Relate:GUIAS,RI:CASCADE,RI:RESTRICT,GUIA:Por_Destinatario)
  SELF.AddRelationLink(DES:CodCliente,GUIA:Destinatario)


Hide:Relate:DESTINATARIO.Kill PROCEDURE

  CODE
  _Hide:Access:DESTINATARIO.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:DESTINATARIO &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:DESTINATARIO)                       ! destroy the file manager


Hide:Relate:LOCALIDAD2.Init PROCEDURE
  CODE
  _Hide:Access:LOCALIDAD2.Init
  SELF.Init(Access:LOCALIDAD2,1)
  SELF.SetAlias(Relate:LOCALIDA)


Hide:Access:LOCALIDAD2.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= LOC2:Record
  SELF.AliasedFile &= Access:LOCALIDA                      !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'LOCALIDAD2'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= LOCALIDAD2
  PARENT.Init
  Access:LOCALIDAD2 &= SELF


Hide:Access:LOCALIDAD2.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:LOCALIDAD2 &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:LOCALIDAD2.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(LOCALIDAD2,GlobalErrors)
    SELF.Create = 0
    SELF.LockRecover = 10
    SELF.AddKey(LOC2:Por_Localidad,'LOC2:Por_Localidad',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:LOCALIDAD2.Kill PROCEDURE

  CODE
  _Hide:Access:LOCALIDAD2.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:LOCALIDAD2 &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:LOCALIDAD2)                         ! destroy the file manager

