 /******************************************************************************
**		File: CreateConstraintTable_QAErrorLogHowIdentified.sql
**		Name: CreateConstraintTable_QAErrorLogHowIdentified
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
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QAErrorLogHowIdentified')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QAErrorLogHowIdentified'
			ALTER TABLE QAErrorLogHowIdentified
				ADD	 CONSTRAINT [PK_QAErrorLogHowIdentified] PRIMARY KEY  NONCLUSTERED 
					 (
						[QAErrorLogHowIdentifiedID]
					 )  ON [IDX]
	END
	
	