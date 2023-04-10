/******************************************************************************
**		File: CreateConstraintForeign_RegistryOwnerGrantedAccess.sql
**		Name: CreateConstraintForeign_RegistryOwnerGrantedAccess
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
*******************************************************************************/
  /***FK_RegistryOwnerGrantedAccess***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_RegistryOwnerGrantedAccess_RegistryOwner')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_RegistryOwnerGrantedAccess_RegistryOwner'
			ALTER TABLE RegistryOwnerGrantedAccess
				ADD CONSTRAINT [FK_RegistryOwnerGrantedAccess_RegistryOwner] FOREIGN KEY ([RegistryOwnerID]) REFERENCES [RegistryOwner]([RegistryOwnerID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_RegistryOwnerGrantedAccess_RegistryOwner'
	END