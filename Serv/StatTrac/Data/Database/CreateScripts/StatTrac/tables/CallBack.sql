if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CallBack]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CallBack]
GO

CREATE TABLE [dbo].[CallBack] (
	[CallBackID] [int] IDENTITY (1, 1) NOT NULL ,
	[PhoneID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


