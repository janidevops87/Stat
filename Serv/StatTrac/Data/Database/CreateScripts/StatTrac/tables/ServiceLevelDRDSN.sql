if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceLevelDRDSN]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceLevelDRDSN]
GO

CREATE TABLE [dbo].[ServiceLevelDRDSN] (
	[ServiceLevelDRDSNID] [int] IDENTITY (1, 1) NOT NULL ,
	[DRDSNID] [smallint] NOT NULL ,
	[ServiceLevelID] [int] NOT NULL ,
	[LastModified] [smalldatetime] NULL ,
	[CreateDate] [smalldatetime] NULL 
) ON [PRIMARY]
GO


