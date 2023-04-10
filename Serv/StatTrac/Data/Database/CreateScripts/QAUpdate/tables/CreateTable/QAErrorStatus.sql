/******************************************************************************
**		File: CreateTable_QAErrorStatus.sql
**		Name: CreateTable_QAErrorStatus
**		Desc: Create table: QAErrorStatus
**
**		Auth: ccarroll
**		Date: 01/14/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------------
**      01/14/2007	ccarroll		initial
*******************************************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QAErrorStatus')
	BEGIN
		PRINT 'Table Exists: QAErrorStatus, updating..'
		/*** Add Table script changes here ***/

	END
 ELSE
	BEGIN
		PRINT 'Creating Table: QAErrorStatus'
		CREATE TABLE [QAErrorStatus] (
		 [QAErrorStatusID] [int] IDENTITY (1, 1) NOT NULL,
		 [QAErrorStatusDescription] [varchar](255),
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)
END