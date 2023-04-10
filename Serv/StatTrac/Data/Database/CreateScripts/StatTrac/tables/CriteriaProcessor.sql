if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CriteriaProcessor]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CriteriaProcessor]
GO

CREATE TABLE [dbo].[CriteriaProcessor] (
	[CriteriaProcessorID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaID] [int] NOT NULL ,
	[OrganizationID] [int] NOT NULL 
) ON [PRIMARY]
GO


