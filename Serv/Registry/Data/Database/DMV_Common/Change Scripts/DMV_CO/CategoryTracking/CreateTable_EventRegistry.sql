IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'EventRegistry')
	BEGIN
		PRINT 'Dropping Table EventRegistry'
		DROP  Table EventRegistry
	END
GO

/******************************************************************************
**		File: 
**		Name: EventRegistry
**		Desc: 
**
**		This template can be customized:
**              
**
**		Auth: ccarroll
**		Date: 12/03/2007 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      12/03/2007		ccarroll				initial
*******************************************************************************/

PRINT 'Creating Table EventRegistry'
GO
CREATE TABLE [EventRegistry] (
 [EventRegistryID] [int] IDENTITY (1, 1) NOT NULL,
 [RegistryID] [int],
 [EventCategoryID] [int],
 [EventSubCategoryID] [int],
 [EventCategorySpecifyText] [varchar](255),
 [EventSubCategorySpecifyText] [varchar](255),
 [LastModified] [datetime] NULL,
 [CreateDate] [datetime] NULL,  
 CONSTRAINT [PK_EventRegistry] PRIMARY KEY  NONCLUSTERED 
 (
	[EventRegistryID]
 )  ON [IDX] 
) ON [PRIMARY]
GO
