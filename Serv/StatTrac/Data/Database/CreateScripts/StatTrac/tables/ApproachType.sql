if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ApproachType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ApproachType]
GO

CREATE TABLE [dbo].[ApproachType] (
	[ApproachTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[ApproachTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


