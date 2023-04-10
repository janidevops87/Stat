/******************************************************************************
**		File: CreateConstraintForeign_QAErrorLog.sql
**		Name: CreateConstraintForeign_QAErrorLog
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

  /***FK_ErrorLogQATracking***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ErrorLogQATracking')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAErrorLog.FK_ErrorLogQATracking'
		ALTER TABLE QAErrorLog
			ADD
 			 CONSTRAINT [FK_ErrorLogQATracking] FOREIGN KEY ([QATrackingID]) REFERENCES [QATracking]([QATrackingID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAErrorLog.FK_ErrorLogQATracking'
	END

  /***FK_ErrorLogQAProcessStep***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ErrorLogQAProcessStep')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAErrorLog.FK_ErrorLogQAProcessStep'
		ALTER TABLE QAErrorLog
			ADD
 			 CONSTRAINT [FK_ErrorLogQAProcessStep] FOREIGN KEY ([QAProcessStepID]) REFERENCES [QAProcessStep]([QAProcessStepID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAErrorLog.FK_ErrorLogQAProcessStep'
	END

  /***FK_ErrorLogQAErrorLocation***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ErrorLogQAErrorLocation')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAErrorLog.FK_ErrorLogQAErrorLocation'
		ALTER TABLE QAErrorLog
			ADD
 			 CONSTRAINT [FK_ErrorLogQAErrorLocation] FOREIGN KEY ([QAErrorLocationID]) REFERENCES [QAErrorLocation]([QAErrorLocationID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAErrorLog.FK_ErrorLogQAErrorLocation'
	END
	
  /***FK_ErrorLogQAErrorType***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ErrorLogQAErrorType')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAErrorLog.FK_ErrorLogQAErrorType'
		ALTER TABLE QAErrorLog
			ADD
 			 CONSTRAINT [FK_ErrorLogQAErrorType] FOREIGN KEY ([QAErrorTypeID]) REFERENCES [QAErrorType]([QAErrorTypeID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAErrorLog.FK_ErrorLogQAErrorType'
	END

  /***FK_ErrorLogQAErrorLogHowIdentified***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ErrorLogQAErrorLogHowIdentified')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAErrorLog.FK_ErrorLogQAErrorLogHowIdentified'
		ALTER TABLE QAErrorLog
			ADD
 			 CONSTRAINT [FK_ErrorLogQAErrorLogHowIdentified] FOREIGN KEY ([QAErrorLogHowIdentifiedID]) REFERENCES [QAErrorLogHowIdentified]([QAErrorLogHowIdentifiedID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAErrorLog.FK_ErrorLogQAErrorLogHowIdentified'
	END

  /***FK_ErrorLogQAErrorStatus***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ErrorLogQAErrorStatus')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAErrorLog.FK_ErrorLogQAErrorStatus'
		ALTER TABLE QAErrorLog
			ADD
 			 CONSTRAINT [FK_ErrorLogQAErrorStatus] FOREIGN KEY ([QAErrorStatusID]) REFERENCES [QAErrorStatus]([QAErrorStatusID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAErrorLog.FK_ErrorLogQAErrorStatus'
	END
	
	