if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AuditLogDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AuditLogDetail]
GO

CREATE TABLE [dbo].[AuditLogDetail] (
	[AuditLogDetailId] [int] IDENTITY (1, 1) NOT NULL ,
	[AuditLogId] [int] NOT NULL ,
	[AuditLogDetailFieldName] [varchar] (75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[AuditLogDetailPreviousValue] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditLogDetailNewValue] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


