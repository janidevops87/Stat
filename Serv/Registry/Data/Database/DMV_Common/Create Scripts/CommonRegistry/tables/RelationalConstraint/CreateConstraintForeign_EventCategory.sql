/******************************************************************************
**		File: CreateConstraintForeign_EventCategory.sql
**		Name: CreateConstraintForeign_EventCategory
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
  /***FK_EventCategory***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_EventCategory_RegistryOwner')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_EventCategory_RegistryOwner'
			ALTER TABLE EventCategory
				ADD CONSTRAINT [FK_EventCategory_RegistryOwner] FOREIGN KEY ([RegistryOwnerID]) REFERENCES [RegistryOwner]([RegistryOwnerID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_EventCategory_RegistryOwner'
	END