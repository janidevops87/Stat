if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[customeraddress]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[customeraddress]
GO

CREATE TABLE [dbo].[customeraddress] (
	[!CUST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NAME] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[REFNUM] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TIMESTAMP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR3] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR4] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR5] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SADDR2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SADDR3] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SADDR4] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SADDR5] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PHONE1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PHONE2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FAXNUM] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[EMAIL] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOTE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CTYPE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TERMS] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TAXABLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SALESTAXCODE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LIMIT] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RESALENUM] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[REP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TAXITEM] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOTEPAD] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SALUTATION] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[COMPANYNAME] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRSTNAME] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDINIT] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LASTNAME] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD3] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD4] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD5] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD6] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD7] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD8] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD9] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD10] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD11] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD12] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD13] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD14] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CUSTFLD15] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[JOBDESC] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[JOBTYPE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[JOBSTATUS] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[JOBSTART] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[JOBPROJEND] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[JOBEND] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HIDDEN] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DELCOUNT] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PRICELEVEL] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


