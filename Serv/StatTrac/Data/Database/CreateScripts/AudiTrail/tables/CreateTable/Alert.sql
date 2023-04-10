/****************************************************************************
**  
**  File:   
**  Name: Alert.sql  
**  Desc:   
**  
**  Date:		Author:			Description:  
**  --------	--------		-------------------------------------------  
**  05/19/2011  Steve Barron	Drop and Create DDL script for DBO.Alert Audit Trail
**    
*******************************************************************************/

GO

PRINT 'Create TABLE: dbo.Alert' 
GO
 
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Alert]') AND type in (N'U'))
	BEGIN
		PRINT 'Drop TABLE: dbo.Alert'  
CREATE TABLE [dbo].[Alert](
	[AlertID] [int] NOT NULL,
	[AlertGroupName] [varchar](80) NULL,
	[AlertMessage1] [ntext] NULL,
	[AlertMessage2] [ntext] NULL,
	[LastModified] [datetime] NULL,
	[AlertTypeID] [int] NULL,
	[AlertLookupCode] [varchar](8) NULL,
	[AlertScheduleMessage] [ntext] NULL,
	[UpdatedFlag] [smallint] NULL,
	[AlertQAMessage1] [ntext] NULL,
	[AlertQAMessage2] [ntext] NULL,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

GO

/****** Object:  Index [PK_Alert_CallId]    Script Date: 06/16/2011 08:34:42 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Alert]') AND name = N'PK_Alert')
BEGIN
	PRINT 'DROP INDEX [PK_Alert] '
	CREATE NONCLUSTERED INDEX [PK_Alert] ON [dbo].[Alert] 
	(
		[AlertID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
	
END	

GO
ALTER TABLE dbo.Alert SET (LOCK_ESCALATION = TABLE)


SET ANSI_PADDING OFF
GO



