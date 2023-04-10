/******************************************************************************
**		File: CreateConstraintTable_AddrType.sql
**		Name: CreateConstraintTable_AddrType
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_AddrType')
	BEGIN
		PRINT 'Creating Table Constraint: PK_AddrType'
			ALTER TABLE AddrType
				ADD	 CONSTRAINT [PK_AddrType] PRIMARY KEY  NONCLUSTERED 
					 (
						[AddrTypeID]
					 )  ON [IDX]
	END
	