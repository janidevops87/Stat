if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebReportGroupAccessDate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WebReportGroupAccessDate]
GO

CREATE TABLE [dbo].[WebReportGroupAccessDate] (
	[WebReportGroupAccessDateID] [int] IDENTITY (1, 1) NOT NULL ,
	[WebReportGroupID] [int] NULL ,
	[AccessStartDate] [datetime] NULL ,
	[AccessEndDate] [datetime] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


