/******************************************************************************
**		File: QATrackingFormErrors.sql
**		Name: QATrackingFormErrors
**		Desc: QATrackingFormErrors
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
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QATrackingFormErrors')
	BEGIN
		PRINT 'Table Exists: QATrackingFormErrors, updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
		PRINT 'Creating Table: QATrackingFormErrors'

		CREATE TABLE [QATrackingFormErrors] (
		 [QATrackingFormErrorsID] [int] IDENTITY (1, 1) NOT NULL,
		 [QATrackingFormID] [int] NULL,
		 [QAErrorLogID] [int] NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)
	END
  