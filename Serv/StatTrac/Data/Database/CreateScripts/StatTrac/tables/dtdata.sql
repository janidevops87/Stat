if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dtdata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[dtdata]
GO

CREATE TABLE [dbo].[dtdata] (
	[StatTracID] [int] NULL 
) ON [PRIMARY]
GO


