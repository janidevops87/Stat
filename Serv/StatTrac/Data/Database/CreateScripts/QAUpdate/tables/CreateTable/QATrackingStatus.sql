/******************************************************************************
**		File: CreateTable_QATrackingStatus.sql
**		Name: CreateTable_QATrackingStatus
**		Desc: Create table: QATrackingStatus
**
**		Auth: ccarroll
**		Date: 01/14/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------------
**      01/30/2009	ccarroll		initial
*******************************************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QATrackingStatus')
	BEGIN
		PRINT 'Table Exists: QATrackingStatus, updating..'
		/*** Add Table script changes here ***/

	END
 ELSE
	BEGIN
		PRINT 'Creating Table: QATrackingStatus'
		CREATE TABLE [QATrackingStatus] (
		 [QATrackingStatusID] [int] IDENTITY (1, 1) NOT NULL,
		 [QATrackingStatusDescription] [varchar](250),
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)
END 