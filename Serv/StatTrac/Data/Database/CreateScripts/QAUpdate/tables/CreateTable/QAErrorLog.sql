/******************************************************************************
**		File: CreateTable_QAErrorLog.sql
**		Name: ErrorStatus
**		Desc: Create table: QAErrorLog
**
**		Auth: ccarroll
**		Date: 01/14/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/14/2009	ccarroll			initial
**      06/2009     jth   removed varchar(150) correctionlog field and added correctionlogpersonid and lastmod
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QAErrorLog')
	BEGIN
		PRINT 'Table Exists: QAErrorLog, updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE
	BEGIN
		PRINT 'Creating Table: QAErrorLog'
		CREATE TABLE [QAErrorLog] (
		 [QAErrorLogID] [int] IDENTITY (1, 1) NOT NULL,
		 [QATrackingID] [int],
		 [QAProcessStepID] [int] NULL,
		 [QAErrorLocationID] [int] NULL,
		 [QAErrorTypeID] [int] NULL,
		 [QAMonitoringFormTemplateID] [int] NULL,
		 [StatEmployeeID] [int] NULL,
		 [QAErrorLogNumberOfErrors] [int] NULL,
		 [QAErrorLogDateTime] [datetime] NULL,
		 [QAErrorLogHowIdentifiedID] [int] NULL,
		 [QAErrorLogTicketNumber] [varchar] (20) NULL,
		 [QAErrorLogComments] [varchar] (1000) NULL,
		 [QAErrorLogCorrection] [varchar] (1000) NULL,
		 [QAErrorLogCorrectionPersonID] [int]  NULL,
		 [QAErrorLogCorrectionLastModified] [datetime] NULL,
		 [QAErrorLogPointsYes] [smallint] NULL,
		 [QAErrorLogPointsNo] [smallint] NULL,
		 [QAErrorLogPointsNA] [smallint] NULL,
		 [QAErrorStatusID] [int] NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)

END
