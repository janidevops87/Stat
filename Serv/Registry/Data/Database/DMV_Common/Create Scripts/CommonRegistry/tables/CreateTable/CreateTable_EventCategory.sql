/******************************************************************************
**		File: CreateTable_EventCategory.sql
**		Name: EventCategory
**		Desc: Create table: EventCategory
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
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'EventCategory')
	BEGIN
		PRINT 'Table Exists: EventCategory updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: EventCategory'
		CREATE TABLE [dbo].[EventCategory](
		[EventCategoryID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryOwnerID] [int] NOT NULL,
		[EventCategoryName] [varchar](255) NULL,
		[EventCategoryActive] [bit] NOT NULL,
		[EventCategorySpecifyText] [bit] NOT NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END

