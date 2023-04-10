/******************************************************************************
**		File: CreateConstraintTable_RegisteredBy.sql
**		Name: CreateConstraintTable_RegisteredBy
**		Desc: Create table indexes and foregin keys on tables
**
**		Auth: ccarroll
**		Date: 02/28/2012 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/28/2012	ccarroll			initial
*******************************************************************************/
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_RegisteredBy')
	BEGIN
		PRINT 'Creating Table Constraint: PK_RegisteredBy'
			ALTER TABLE RegisteredBy
				ADD	 CONSTRAINT [PK_RegisteredBy] PRIMARY KEY  NONCLUSTERED 
					 (
						[RegisteredByID]
					 )  ON [IDX]
	END
	