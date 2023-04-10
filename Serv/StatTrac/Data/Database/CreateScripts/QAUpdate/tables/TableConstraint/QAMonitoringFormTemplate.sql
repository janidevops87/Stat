/******************************************************************************
**		File: CreateConstraintTable_QAMonitoringFormTemplate.sql
**		Name: CreateConstraintTable_QAMonitoringFormTemplate
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QAMonitoringFormTemplate')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QAMonitoringFormTemplate'
		ALTER TABLE QAMonitoringFormTemplate
			ADD CONSTRAINT [PK_QAMonitoringFormTemplate] PRIMARY KEY  NONCLUSTERED 
			 (
				[QAMonitoringFormTemplateID]
			 )  ON [IDX]
	END
