/******************************************************************************
**		File: CreateTable_QAMonitoringFormTemplate.sql
**		Name: CreateTable_QAMonitoringFormTemplate
**		Desc: Create table: QAMonitoringFormTemplate
**
**		Auth: ccarroll
**		Date: 01/14/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/14/2009	ccarroll			initial
*******************************************************************************/
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QAMonitoringFormTemplate')
	BEGIN
		PRINT 'Table Exists: QAMonitoringFormTemplate, updating..'
		/*** Add Table script changes here ***/

	END
 ELSE
	BEGIN
		PRINT 'Creating Table: QAMonitoringFormTemplate'
			
		CREATE TABLE [QAMonitoringFormTemplate] (
		 [QAMonitoringFormTemplateID] [int] IDENTITY (1, 1) NOT NULL,
		 [QAMonitoringFormID] [int] NULL,
		 [QAErrorTypeID] [int] NOT NULL,
		 [QAMonitoringFormTemplateOrder] [int] NULL,
		 [QAMonitoringFormTemplateActive] [smallint] NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)

	END
