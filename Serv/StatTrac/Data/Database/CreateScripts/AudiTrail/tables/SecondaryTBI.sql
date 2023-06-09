if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SecondaryTBI]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SecondaryTBI]
GO

CREATE TABLE [dbo].[SecondaryTBI] (
	[CallID] [int] NOT NULL ,
	[SecondaryTBINumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryTBIIssuedStatEmployeeID] [int] NULL ,
	[SecondaryTBIPrefixDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryTBIAssignmentNotNeeded] [smallint] NULL ,
	[SecondaryTBIAssignmentNotNeededStatEmployeeID] [int] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[SecondaryTBIComment] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CreateDate] [smalldatetime] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[AuditLogTypeID] [int] NULL 
) ON [PRIMARY]
GO

CREATE INDEX PK_SecondaryTBI_1__13 ON dbo.SecondaryTBI
	(
	CallID
	) WITH FILLFACTOR = 90 ON [IDX]
GO



