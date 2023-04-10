/******************************************************************************
**		File: CreateConstraintForeign_QAMonitoringFormTemplate.sql
**		Name: CreateConstraintForeign_QAMonitoringFormTemplate
**		Desc: Create foreign key constraint(s) on QA update table
**
**		Auth: ccarroll
**		Date: 01/21/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/21/2009	ccarroll			initial
*******************************************************************************/

  /***FK_QAErrorTypeLocation***/
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_QAMonitoringForm')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAMonitoringFormTemplate.FK_QAMonitoringForm'
		ALTER TABLE QAMonitoringFormTemplate
			ADD 
			 CONSTRAINT [FK_QAMonitoringForm] FOREIGN KEY ([QAMonitoringFormID]) REFERENCES [QAMonitoringForm]([QAMonitoringFormID])
	END
 ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAMonitoringFormTemplate.FK_QAMonitoringForm'
	END

  /***FK_QAErrorTypeLocation***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_QAErrorType')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAMonitoringFormTemplate.FK_QAErrorType'
		ALTER TABLE QAMonitoringFormTemplate
			ADD 
			 CONSTRAINT [FK_QAErrorType] FOREIGN KEY ([QAErrorTypeID]) REFERENCES [QAErrorType]([QAErrorTypeID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAMonitoringFormTemplate.FK_QAErrorType'
	END

