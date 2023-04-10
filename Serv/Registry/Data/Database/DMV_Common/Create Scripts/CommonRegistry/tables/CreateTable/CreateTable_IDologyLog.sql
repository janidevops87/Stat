/******************************************************************************
**		File: CreateTable_IDologyLog.sql
**		Name: IDologyLog
**		Desc: Create table: IDologyLog
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/19/2009	ccarroll			initial
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IDologyLog')
	BEGIN
		PRINT 'Table Exists: IDologyLog updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: IDologyLog'
		CREATE TABLE [dbo].[IDologyLog](
		[IDologyLogID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryID] [int] NULL,
		[IDologyLogNumberID] [int] NULL,
		[IDologyLogRequest] [nvarchar] (2000) NULL,
		[IDologyLogResponse] [nvarchar] (2000) NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END

