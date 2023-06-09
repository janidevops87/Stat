SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LifeLink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LifeLink](
	[FacilityID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[HospitalName] [varchar](50) NULL,
	[HospitalAddress] [varchar](50) NULL,
	[HospitalCity] [varchar](50) NULL,
	[HospitalState] [varchar](5) NULL,
	[HospitalCounty] [varchar](50) NULL,
	[HospitalPhone] [varchar](15) NULL,
	[Organs] [varchar](25) NULL,
	[Tissues] [varchar](25) NULL,
	[Eyes] [varchar](25) NULL
) ON [PRIMARY]
END
GO
