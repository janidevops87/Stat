if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[StatEmployee]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[StatEmployee]
GO

CREATE TABLE [dbo].[StatEmployee] (
	[StatEmployeeID] [int] IDENTITY (1, 1) NOT NULL ,
	[StatEmployeeFirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StatEmployeeLastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StatEmployeeUserID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StatEmployeePassword] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[AllowCallDelete] [smallint] NULL ,
	[AllowMaintainAccess] [smallint] NULL ,
	[AllowSecurityAccess] [smallint] NULL ,
	[AllowLicenseAccess] [smallint] NULL ,
	[PersonID] [int] NULL ,
	[StatEmployeeEmail] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AllowStopTimerAccess] [smallint] NULL ,
	[AllowIncompleteAccess] [smallint] NULL ,
	[AllowScheduleAccess] [smallint] NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[AllowRecoveryAccess] [smallint] NULL ,
	[AllowInternetAccess] [smallint] NULL ,
	[IntranetSecurityLevel] [smallint] NULL ,
	[AllowEmployeeMaintTC] [smallint] NULL ,
	[AllowEmployeeMaintFS] [smallint] NULL ,
	[AllowEmployeeMaintAdmin] [smallint] NULL ,
	[AllowEmployeeScheduleTC] [smallint] NULL ,
	[AllowEmployeeScheduleFS] [smallint] NULL ,
	[AllowQAReview] [smallint] NULL ,
	[AllowRecycleCase] [smallint] NULL ,
	[AllowCloseReferral] [smallint] NULL ,
	[AllowASPSave] [int] NULL 
) ON [PRIMARY]
GO


