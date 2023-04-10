/******************************************************************************
**		File: CreateConstraintTable_IDologyLog.sql
**		Name: CreateConstraintTable_IDologyLog
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_IDologyLog')
	BEGIN
		PRINT 'Creating Table Constraint: PK_IDologyLog'
			ALTER TABLE IDologyLog
				ADD	 CONSTRAINT [PK_IDologyLog] PRIMARY KEY  NONCLUSTERED 
					 (
						[IDologyLogID]
					 )  ON [IDX]
	END
	