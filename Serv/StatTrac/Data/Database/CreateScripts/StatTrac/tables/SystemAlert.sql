if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SystemAlert]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SystemAlert]
GO

CREATE TABLE [dbo].[SystemAlert] (
	[SystemAlertID] [int] IDENTITY (1, 1) NOT NULL ,
	[SystemAlertDate] [smalldatetime] NULL ,
	[StatEmployeeID] [int] NULL ,
	[SystemAlertMessage] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SystemAlertResolved] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


