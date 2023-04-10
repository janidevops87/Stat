/******************************************************************************
**		File: CreateConstraintTable_QAErrorType.sql
**		Name: CreateConstraintTable_QAErrorType
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QAErrorType')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QAErrorType'
			ALTER TABLE QAErrorType
				ADD CONSTRAINT [PK_QAErrorType] PRIMARY KEY  NONCLUSTERED
					 (
						[QAErrorTypeID]
					 )  ON [IDX] 
	END
	