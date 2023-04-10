/******************************************************************************
**		File: CreateTable_EventRegistry.sql
**		Name: EventRegistry
**		Desc: Create table: EventRegistry
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
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'EventRegistry')
	BEGIN
		PRINT 'Table Exists: EventRegistry updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: EventRegistry'
		CREATE TABLE [dbo].[EventRegistry](
		[EventRegistryID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryID] [int] NULL,
		[EventCategoryID] [int] NULL,
		[EventSubCategoryID] [int] NULL,
		[EventCategorySpecifyText] [varchar](255) NULL,
		[EventSubCategorySpecifyText] [varchar](255) NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END

