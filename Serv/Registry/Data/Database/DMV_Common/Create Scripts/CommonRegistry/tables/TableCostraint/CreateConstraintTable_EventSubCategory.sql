/******************************************************************************
**		File: CreateConstraintTable_EventSubCategory.sql
**		Name: CreateConstraintTable_EventSubCategory
**		Desc: Create table indexes and foregin keys on tables
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_EventSubCategory')
	BEGIN
		PRINT 'Creating Table Constraint: PK_EventSubCategory'
			ALTER TABLE EventSubCategory
				ADD	 CONSTRAINT [PK_EventSubCategory] PRIMARY KEY  NONCLUSTERED 
					 (
						[EventSubCategoryID]
					 )  ON [IDX]
	END
	