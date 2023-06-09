if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Indication]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Indication]
GO

CREATE TABLE [dbo].[Indication] (
	[IndicationID] [int] IDENTITY (1, 1) NOT NULL ,
	[IndicationName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[IndicationNote] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[IndicationHighRisk] [smallint] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


