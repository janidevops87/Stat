/******************************************************************************
**		File: CreateConstraintTable_QAProcessStep.sql
**		Name: CreateConstraintTable_QAProcessStep
**		Desc: Create table indexes and foregin keys on QA tables
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QAProcessStep')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QAProcessStep'
			ALTER TABLE QAProcessStep
				ADD	 CONSTRAINT [PK_QAProcessStep] PRIMARY KEY  NONCLUSTERED 
					 (
						[QAProcessStepID]
					 )  ON [IDX]
	END
 