if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[HospitalReportTimeRange]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[HospitalReportTimeRange]
GO

CREATE TABLE [dbo].[HospitalReportTimeRange] (
	[HospitalReportTimeRangeID] [int] IDENTITY (1, 1) NOT NULL ,
	[TimeRangeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TimeRangeStart] [int] NULL ,
	[TimeRangeEnd] [int] NULL 
) ON [PRIMARY]
GO


