 /******************************************************************************
**		File: CreateConstraintForeign_QAMonitoringForm.sql
**		Name: CreateConstraintForeign_QAMonitoringForm
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
  /***FK_QATrackingType***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_QAMonitoringFormQATrackingType')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAMonitoringForm.FK_QATrackingType'
			ALTER TABLE QAErrorType
				ADD CONSTRAINT [FK_QAMonitoringFormQATrackingType] FOREIGN KEY ([QATrackingTypeID]) REFERENCES [QATrackingType]([QATrackingTypeID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAMonitoringForm.FK_QATrackingType'
	END