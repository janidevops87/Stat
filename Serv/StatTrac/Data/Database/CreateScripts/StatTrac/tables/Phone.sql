if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Phone]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Phone]
GO

CREATE TABLE [dbo].[Phone] (
	[PhoneID] [int] IDENTITY (1, 1) NOT NULL ,
	[PhoneAreaCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PhonePrefix] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PhoneNumber] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PhonePin] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PhoneTypeID] [int] NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[Unused] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


