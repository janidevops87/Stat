if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[StatFileOrgFrequency]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[StatFileOrgFrequency]
GO

CREATE TABLE [dbo].[StatFileOrgFrequency] (
	[OrgID] [int] NOT NULL ,
	[FrequencyID] [int] NOT NULL ,
	[RecordsReturned] [int] NOT NULL 
) ON [PRIMARY]
GO


