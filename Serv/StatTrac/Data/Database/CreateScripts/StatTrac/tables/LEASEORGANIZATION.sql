if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LEASEORGANIZATION]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LEASEORGANIZATION]
GO

CREATE TABLE [dbo].[LEASEORGANIZATION] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[LEASEORGANIZATIONID] [int] NOT NULL ,
	[LEASEORGANIZATIONAME] [char] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LEASEORGANIZATIONType] [int] NOT NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
GO


