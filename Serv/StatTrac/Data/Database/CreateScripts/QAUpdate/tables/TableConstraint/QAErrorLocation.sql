 /******************************************************************************
**		File: CreateConstraintTable_QAErrorLocation.sql
**		Name: CreateConstraintTable_QAErrorLocation
**		Desc: Create table constraints on QA update tables
**
**		Auth: ccarroll
**		Date: 01/20/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/20/2009	ccarroll			initial
*******************************************************************************/
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QAErrorLocation')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QAErrorLocation'
			ALTER TABLE QAErrorLocation
				ADD	 CONSTRAINT [PK_QAErrorLocation] PRIMARY KEY  NONCLUSTERED 
					 (
						[QAErrorLocationID]
					 )  ON [IDX]
	END 
