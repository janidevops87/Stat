/******************************************************************************
**		File: QATrackingForm.sql
**		Name: QATrackingForm
**		Desc: QATrackingForm
**
**		Auth: jth
**		Date: 04/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      04/2009		jth					initial
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QATrackingForm')
	BEGIN
		PRINT 'Table Exists: QATrackingForm, updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
		PRINT 'Creating Table: QATrackingForm'

		CREATE TABLE [QATrackingForm] (
		 [QATrackingFormID] [int] IDENTITY (1, 1) NOT NULL,
		 [QAProcessStepID] [int] NULL,
		 [PersonID] [int] NULL,
		 [QATrackingEventDateTime] [datetime] NULL,
		 [QATrackingCAPANumber] [varchar](20) NULL,
		 [QATrackingApproved] [smallint] NULL,
		 [QATrackingStatusID] [int] NULL,
		 QATrackingFormPoints numeric (5,4),
		 [QATrackingFormComments] [varchar] (1000) NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)
	END
 