if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PersonPhone]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PersonPhone]
GO

CREATE TABLE [dbo].[PersonPhone] (
	[PersonPhoneID] [int] IDENTITY (1, 1) NOT NULL ,
	[PersonID] [int] NULL ,
	[PhoneID] [int] NULL ,
	[Unused] [int] NULL ,
	[PersonPhonePin] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[PhoneAlphaPagerEmail] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


