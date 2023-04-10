/******************************************************************************
**		File: CreateTable_QAMonitoringForm.sql
**		Name: CreateTable_QAMonitoringForm
**		Desc: Create table: QAMonitoringForm
**		FOREIGN KEY Creation Sequence: 6
**
**		Auth: ccarroll
**		Date: 01/14/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------------
**      01/14/2009	ccarroll		initial
*       04/29       jth             comment out columns not needed 
*******************************************************************************/
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QAMonitoringForm')
	BEGIN
		PRINT 'Table Exists: QAMonitoringForm, updating..'
		/*** Add Table script changes here ***/
		
	END
 ELSE
	BEGIN
		PRINT 'Creating Table: QAMonitoringForm'
		CREATE TABLE [QAMonitoringForm] (
		 [QAMonitoringFormID] [int] IDENTITY (1, 1) NOT NULL,
		 [OrganizationID] [int] NULL,
		 [QATrackingTypeID] [int] NULL,
		 [QAMonitoringFormName] [varchar](255) NULL,
		 --[QAMonitoringFormLogo] [image] NULL,
		 --[QAMonitoringFormStatTracLink] [varchar](255) NULL,
		 [QAMonitoringFormCalculateScore] [smallint] Default(0),
		 [QAMonitoringFormRequireReview] [smallint] Default(0),
		 [QAMonitoringFormActive] [smallint] Default(1),
		 [QAMonitoringFormInactiveComments] [varchar](1000) NULL,
		 [QAMonitoringFormScore] [decimal](5, 5)  NULL ,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)
	END
