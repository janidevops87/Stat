/******************************************************************************
**		File: CreateConstraintForeign_EventSubCategory.sql
**		Name: CreateConstraintForeign_EventSubCategory
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
  /***FK_EventSubCategory***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_EventSubCategory_EventCategory')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_EventSubCategory_EventCategory'
			ALTER TABLE EventSubCategory
				ADD CONSTRAINT [FK_EventSubCategory_EventCategory] FOREIGN KEY ([EventCategoryID]) REFERENCES [EventCategory]([EventCategoryID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_EventSubCategory_EventCategory'
	END
