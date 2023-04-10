 /******************************************************************************
**		File: CreateConstraintTable_QAErrorLog.sql
**		Name: CreateConstraintTable_QAErrorLog
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
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QAErrorLog')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QAErrorLog'
		ALTER TABLE QAErrorLog
			ADD CONSTRAINT [PK_QAErrorLog] PRIMARY KEY  NONCLUSTERED 
			 (
				[QAErrorLogID]
			 )  ON [IDX]
	END	


