IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'EventSubCategory')
	BEGIN
		PRINT 'Dropping Table EventSubCategory'
		DROP  Table EventSubCategory
	END
GO

/******************************************************************************
**		File: CreateTable_EventSubCategory.sql
**		Name: EventSubCategory
**		Desc: 
**
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      12/03/2007		ccarroll				
*******************************************************************************/

PRINT 'Creating Table EventSubCategory'
GO
CREATE TABLE [EventSubCategory] (
 [EventSubCategoryID] [int] IDENTITY (1, 1) NOT NULL,
 [EventCategoryID] [int],
 [EventSubCategoryName] [varchar](255),
 [EventSubCategorySourceCode] [varchar](255),
 [EventSubCategoryActive] [bit] NOT NULL,
 [EventSubCategorySpecifyText] [bit] NOT NULL,
 [WebUserID] int NULL,
 [LastModified] [datetime] NULL,
 [CreateDate] [datetime] NULL,  
 CONSTRAINT [PK_EventSubCategory] PRIMARY KEY  NONCLUSTERED 
 (
	[EventSubCategoryID]
 )  ON [IDX] 
) ON [PRIMARY]
GO
