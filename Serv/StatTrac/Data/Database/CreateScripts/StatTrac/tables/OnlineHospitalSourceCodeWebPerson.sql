if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OnlineHospitalSourceCodeWebPerson]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OnlineHospitalSourceCodeWebPerson]
GO

CREATE TABLE [dbo].[OnlineHospitalSourceCodeWebPerson] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[webPersonID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[SourceCodeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Locked] [smallint] NULL 
) ON [PRIMARY]
GO


