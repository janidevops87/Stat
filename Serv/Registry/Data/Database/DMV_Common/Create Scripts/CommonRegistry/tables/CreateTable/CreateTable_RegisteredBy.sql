/******************************************************************************
**		File: CreateTable_RegisteredBy.sql
**		Name: RegisteredBy
**		Desc: Create table: RegisteredBy
**
**		Auth: ccarroll
**		Date: 02/28/2012 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/28/2012	ccarroll			initial
**		03/13/2012  ccarroll			Added for inclusion in release
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'RegisteredBy')
	BEGIN
		PRINT 'Table Exists: RegisteredBy updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: RegisteredBy'
		CREATE TABLE [dbo].[RegisteredBy](
		[RegisteredByID] [int] IDENTITY(1,1) NOT NULL,
		[Name] nvarchar(100) NUll,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END
