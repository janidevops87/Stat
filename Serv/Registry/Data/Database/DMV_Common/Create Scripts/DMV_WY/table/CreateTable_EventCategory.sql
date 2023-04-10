IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'EventCategory')
	BEGIN
		PRINT 'Dropping Table EventCategory'
		DROP  Table EventCategory
	END
GO

/******************************************************************************
**		File: CreateTable_EventCategory.sql
**		Name: EventCategory
**		Desc: 
**
**              
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		12/03/2007		ccarroll				initial
*******************************************************************************/

PRINT 'Creating Table EventCategory'
GO
CREATE TABLE [EventCategory] (
 [EventCategoryID] [int] IDENTITY (1, 1) NOT NULL,
 [EventCategoryName] [varchar](255),
 [EventCategoryActive] [bit] NOT NULL,
 [EventCategorySpecifyText] [bit] NOT NULL,
 [WebUserID] int NULL,
 [LastModified] [datetime] NULL,
 [CreateDate] [datetime] NULL,  
 CONSTRAINT [PK_EventCategory] PRIMARY KEY  NONCLUSTERED 
 (
	[EventCategoryID]
 )  ON [PRIMARY] 
) ON [PRIMARY]

GO

