/******************************************************************************
**		File: CreateConstraintTable_EventRegistry.sql
**		Name: CreateConstraintTable_EventRegistry
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_EventRegistry')
	BEGIN
		PRINT 'Creating Table Constraint: PK_EventRegistry'
			ALTER TABLE EventRegistry
				ADD	 CONSTRAINT [PK_EventRegistry] PRIMARY KEY  NONCLUSTERED 
					 (
						[EventRegistryID]
					 )  ON [IDX]
	END
	