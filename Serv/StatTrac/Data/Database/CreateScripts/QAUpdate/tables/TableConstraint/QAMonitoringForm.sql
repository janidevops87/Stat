/******************************************************************************
**		File: CreateConstraintTable_QAMonitoringForm.sql
**		Name: CreateConstraintTable_QAMonitoringForm
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QAMonitoringForm')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QAMonitoringForm'
			ALTER TABLE QAMonitoringForm
				ADD	 CONSTRAINT [PK_QAMonitoringForm] PRIMARY KEY  NONCLUSTERED 
					 (
						[QAMonitoringFormID]
					 )  ON [IDX]
	END
	