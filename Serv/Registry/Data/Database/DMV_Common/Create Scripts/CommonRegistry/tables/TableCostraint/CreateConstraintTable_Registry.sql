/******************************************************************************
**		File: CreateConstraintTable_Registry.sql
**		Name: CreateConstraintTable_Registry
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_Registry')
	BEGIN
		PRINT 'Creating Table Constraint: PK_Registry'
			ALTER TABLE Registry
				ADD	 CONSTRAINT [PK_Registry] PRIMARY KEY  NONCLUSTERED 
					 (
						[RegistryID]
					 )  ON [IDX]
	END
	