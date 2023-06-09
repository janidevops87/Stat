if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GeneralAlert]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[GeneralAlert]
GO

CREATE TABLE [dbo].[GeneralAlert] (
	[GeneralAlertID] [int] IDENTITY (1, 1) NOT NULL ,
	[GeneralAlertExpires] [smalldatetime] NULL ,
	[GeneralAlertOrg] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GeneralAlertMessage] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[OrganizationID] [int] NULL 
) ON [PRIMARY]
GO


