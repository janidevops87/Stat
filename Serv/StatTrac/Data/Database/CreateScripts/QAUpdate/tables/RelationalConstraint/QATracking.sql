 /******************************************************************************
**		File: CreateConstraintForeign_QATracking.sql
**		Name: CreateConstraintForeign_QATracking
**		Desc: Create foreign key constraint(s) on QA update table
**
**		Auth: ccarroll
**		Date: 01/30/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/30/2009	ccarroll			initial
**      04/09       jth                 process step is in qatrackingform table
*******************************************************************************/

  /***FK_TrackingQATrackingStatus***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TrackingQATrackingStatus')
	BEGIN
		PRINT 'Creating Foreign Constraint: QATracking.FK_TrackingQATrackingStatus'
		ALTER TABLE QATracking
			ADD
 			 CONSTRAINT [FK_TrackingQATrackingStatus] FOREIGN KEY ([QATrackingStatusID]) REFERENCES [QATrackingStatus]([QATrackingStatusID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QATracking.FK_TrackingQATrackingStatus'
	END
	
	  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TrackingQAProcessStepID')
	BEGIN
		PRINT 'Creating Foreign Constraint: QATrackingForm.FK_TrackingQAProcessStepID'
		ALTER TABLE QATrackingForm
			ADD
 			 CONSTRAINT [FK_TrackingQAProcessStepID] FOREIGN KEY ([QAProcessStepID]) REFERENCES [QAProcessStep]([QAProcessStepID])
	END
  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: QATrackingForm.FK_TrackingQAProcessStepID'
	END