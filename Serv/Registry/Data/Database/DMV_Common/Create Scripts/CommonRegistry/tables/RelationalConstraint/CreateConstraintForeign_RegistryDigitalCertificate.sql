 /******************************************************************************
**		File: CreateConstraintForeign_RegistryDigitalCertificate.sql
**		Name: CreateConstraintForeign_RegistryDigitalCertificate
**		Desc: Create foreign key constraint(s) on table
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/25/2009	ccarroll			initial
*******************************************************************************/
  /***FK_RegistryDigitalCertificate***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_RegistryDigitalCertificate_Registry')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_RegistryDigitalCertificate_Registry'
			ALTER TABLE RegistryDigitalCertificate
				ADD CONSTRAINT [FK_RegistryDigitalCertificate_Registry] FOREIGN KEY ([RegistryID]) REFERENCES [Registry]([RegistryID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_RegistryDigitalCertificate_Registry'
	END