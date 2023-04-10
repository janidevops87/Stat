if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[StatFileFrequency]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[StatFileFrequency]
GO

CREATE TABLE [dbo].[StatFileFrequency] (
	[FrequencyID] [int] IDENTITY (1, 1) NOT NULL ,
	[Quantity] [int] NOT NULL ,
	[Units] [int] NOT NULL ,
	[Display] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO


