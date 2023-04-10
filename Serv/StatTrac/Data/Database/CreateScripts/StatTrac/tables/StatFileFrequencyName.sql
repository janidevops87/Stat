if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[StatFileFrequencyName]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[StatFileFrequencyName]
GO

CREATE TABLE [dbo].[StatFileFrequencyName] (
	[FrequencyID] [int] IDENTITY (1, 1) NOT NULL ,
	[Frequencynum] [int] NULL ,
	[FrequencyName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


