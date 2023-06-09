if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OnlineHospitalAccount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OnlineHospitalAccount]
GO

CREATE TABLE [dbo].[OnlineHospitalAccount] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[WebPersonID] [int] NULL ,
	[GroupOwnerID] [int] NULL ,
	[ReportGroupID] [int] NULL ,
	[HospitalID] [int] NULL ,
	[DefaultSourceCodeID] [int] NULL ,
	[PersonID] [int] NULL 
) ON [PRIMARY]
GO


