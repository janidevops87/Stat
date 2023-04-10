 /******************************************************************************
**		File: CreateConstraintForeign_RegistryOwnerEnrollmentText.sql
**		Name: CreateConstraintForeign_RegistryOwnerEnrollmentText
**		Desc: Create foreign key constraint(s) on table
**
**		Auth: ccarroll
**		Date: 02/09/2010 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/09/2010	ccarroll			initial
**		07/09/2013	ccarroll			Note for build CCRST152
*******************************************************************************/
  /***FK_RegistryOwnerEnrollmentText***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_RegistryOwnerEnrollmentText_RegistryOwner')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_RegistryOwnerEnrollmentText_RegistryOwner'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD CONSTRAINT [FK_RegistryOwnerEnrollmentText_RegistryOwner] FOREIGN KEY ([RegistryOwnerID]) REFERENCES [RegistryOwner]([RegistryOwnerID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_RegistryOwnerEnrollmentText_RegistryOwner'
	END
GO

