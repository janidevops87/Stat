/******************************************************************************
**		File: CreateConstraintForeign_RegistryOwnerStateConfig.sql
**		Name: CreateConstraintForeign_RegistryOwnerStateConfig
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
**		07/15/2013	ccarroll			Added note for CCRST152
*******************************************************************************/
  /***FK_RegistryOwnerStateConfig***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_RegistryOwnerStateConfig_RegistryOwner')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_RegistryOwnerStateConfig_RegistryOwner'
			ALTER TABLE RegistryOwnerStateConfig
				ADD CONSTRAINT [FK_RegistryOwnerStateConfig_RegistryOwner] FOREIGN KEY ([RegistryOwnerID]) REFERENCES [RegistryOwner]([RegistryOwnerID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_RegistryOwnerStateConfig_RegistryOwner'
	END
GO	