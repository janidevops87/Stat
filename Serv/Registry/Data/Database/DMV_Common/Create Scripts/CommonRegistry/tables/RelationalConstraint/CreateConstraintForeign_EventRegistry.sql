/******************************************************************************
**		File: CreateConstraintForeign_EventRegistry.sql
**		Name: CreateConstraintForeign_EventRegistry
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
  /***FK_EventRegistry***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_EventRegistry_Registry')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_EventRegistry_Registry'
			ALTER TABLE EventRegistry
				ADD CONSTRAINT [FK_EventRegistry_Registry] FOREIGN KEY ([RegistryID]) REFERENCES [Registry]([RegistryID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_EventRegistry_Registry'
	END

  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_EventRegistry_EventCategory')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_EventRegistry_EventCategory'
			ALTER TABLE EventRegistry
				ADD CONSTRAINT [FK_EventRegistry_EventCategory] FOREIGN KEY ([EventCategoryID]) REFERENCES [EventCategory]([EventCategoryID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_EventRegistry_EventSubCategory'
	END
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_EventRegistry_EventSubCategory')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_EventRegistry_EventSubCategory'
			ALTER TABLE EventRegistry
				ADD CONSTRAINT [FK_EventRegistry_EventSubCategory] FOREIGN KEY ([EventSubCategoryID]) REFERENCES [EventSubCategory]([EventSubCategoryID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_EventRegistry_EventSubCategory'
	END