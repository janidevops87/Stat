/******************************************************************************
**		File: CreateTable_QAProcessStep.sql
**		Name: CreateTable_QAProcessStep
**		Desc: Create table: QAProcessStep
**
**		Auth: ccarroll
**		Date: 01/14/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------------
**      01/14/2009	ccarroll		initial
*******************************************************************************/
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QAProcessStep')
	BEGIN
		PRINT 'Table Exists: QAProcessStep  updating..'
		/*** Add Table script changes here ***/

	END
 ELSE
	BEGIN
		PRINT 'Creating Table: QAProcessStep'
		CREATE TABLE [QAProcessStep] (
		 [QAProcessStepID] [int] IDENTITY (1, 1) NOT NULL,
		 [OrganizationID] [int] NULL,
		 [QAProcessStepDescription] [varchar](255) NULL,
		 [QAProcessStepActive] [smallint] NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)
END
