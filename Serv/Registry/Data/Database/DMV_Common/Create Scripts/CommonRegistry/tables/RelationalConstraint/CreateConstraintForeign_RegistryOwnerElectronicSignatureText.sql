/******************************************************************************
**		File: CreateConstraintForeign_RegistryOwnerElectronicSignatureText.sql
**		Name: CreateConstraintForeign_RegistryOwnerElectronicSignatureText
**		Desc: Create foreign key constraint(s) on table
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/19/2009	ccarroll			initial
**		07/09/2013	ccarroll			Note for build CCRST152
*******************************************************************************/
  /***FK_RegistryOwnerElectronicSignatureText***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_RegistryOwnerElectronicSignatureText_RegistryOwner')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_RegistryOwnerElectronicSignatureText_RegistryOwner'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ADD CONSTRAINT [FK_RegistryOwnerElectronicSignatureText_RegistryOwner] FOREIGN KEY ([RegistryOwnerID]) REFERENCES [RegistryOwner]([RegistryOwnerID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_RegistryOwnerElectronicSignatureText_RegistryOwner'
	END
GO

