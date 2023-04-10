/******************************************************************************
**		File: CreateTable_EventSubCategory.sql
**		Name: EventSubCategory
**		Desc: Create table: EventSubCategory
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
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'EventSubCategory')
	BEGIN
		PRINT 'Table Exists: EventSubCategory updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: EventSubCategory'
		CREATE TABLE [dbo].[EventSubCategory](
		[EventSubCategoryID] [int] IDENTITY(1,1) NOT NULL,
		[EventCategoryID] [int] NULL,
		[EventSubCategoryName] [varchar](255) NULL,
		[EventSubCategorySourceCode] [varchar](255) NULL,
		[EventSubCategoryActive] [bit] NOT NULL,
		[EventSubCategorySpecifyText] [bit] NOT NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END

