/******************************************************************************
**		File: CreateConstraintTable_QAErrorStatus.sql
**		Name: CreateConstraintTable_QAErrorStatus
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QAErrorStatus')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QAErrorStatus'
			ALTER TABLE QAErrorStatus
				ADD	 CONSTRAINT [PK_QAErrorStatus] PRIMARY KEY  NONCLUSTERED 
					 (
						[QAErrorStatusID]
					 )  ON [IDX]
	END

