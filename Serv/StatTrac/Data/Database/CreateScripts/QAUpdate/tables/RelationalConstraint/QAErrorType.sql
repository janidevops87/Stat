/******************************************************************************
**		File: CreateConstraintForeign_QAErrorType.sql
**		Name: CreateConstraintForeign_QAErrorType
**		Desc: Create foreign constraints on QA update tables
**
**		Auth: ccarroll
**		Date: 01/20/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/21/2009	ccarroll			initial
*******************************************************************************/

  /***FK_QAErrorTypeLocation***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_QAErrorTypeLocation')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAErrorType.FK_QAErrorTypeLocation'
			ALTER TABLE QAErrorType
				ADD CONSTRAINT [FK_QAErrorTypeLocation] FOREIGN KEY ([QAErrorLocationID]) REFERENCES [QAErrorLocation]([QAErrorLocationID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAErrorType.FK_QAErrorTypeLocation'
	END

  /***FK_QATrackingType***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_QAErrorTypeQATrackingType')
	BEGIN
		PRINT 'Creating Foreign Constraint: QAErrorType.FK_QATrackingType'
			ALTER TABLE QAErrorType
				ADD CONSTRAINT [FK_QAErrorTypeQATrackingType] FOREIGN KEY ([QATrackingTypeID]) REFERENCES [QATrackingType]([QATrackingTypeID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QAErrorType.FK_QATrackingType'
	END