if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DisableCallTrigger]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DisableCallTrigger]
GO

CREATE TABLE [dbo].[DisableCallTrigger] (
	[UserSPID] [int] NOT NULL 
) ON [PRIMARY]
GO


