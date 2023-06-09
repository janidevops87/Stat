if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReferralSecondaryData]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ReferralSecondaryData]
GO

CREATE TABLE [dbo].[ReferralSecondaryData] (
	[ReferralID] [int] NOT NULL ,
	[ReferralSecondaryHistory] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [smalldatetime] NULL ,
	[hdBloodRecv48] [smallint] NULL ,
	[hdWholeBloodUnits] [float] NULL ,
	[hdWholeBloodAmt] [float] NULL ,
	[hdRedBloodUnits] [float] NULL ,
	[hdRedBloodAmt] [float] NULL ,
	[hdColloid_1] [float] NULL ,
	[hdColloid_2] [float] NULL ,
	[hdColloid_3] [float] NULL ,
	[hdColloid_4] [float] NULL ,
	[hdColloid_List] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hdCrystalloid_1] [float] NULL ,
	[hdCrystalloid_2] [float] NULL ,
	[hdCrystalloid_3] [float] NULL ,
	[hdCrystalloid_4] [float] NULL ,
	[hdCrystalloid_List] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hdQuest1_1] [smallint] NULL ,
	[hdQuest2_1] [smallint] NULL ,
	[hdQuest2_2] [smallint] NULL ,
	[hdQuest2_3] [smallint] NULL ,
	[hdQuest2_4] [smallint] NULL ,
	[hdQuest3_1] [smallint] NULL ,
	[hdQuest3_2] [smallint] NULL ,
	[hdQuest3_3] [smallint] NULL ,
	[hdQuest3_4] [smallint] NULL ,
	[fscUserID] [int] NULL ,
	[hdLastModified] [datetime] NULL ,
	[hdQuest3_2a] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hdQuest3_3a] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hdQuest3_4a] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [LastModified] ON [dbo].[ReferralSecondaryData] ([LastModified]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdBloodRecv48] ON [dbo].[ReferralSecondaryData] ([hdBloodRecv48]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdWholeBloodUnits] ON [dbo].[ReferralSecondaryData] ([hdWholeBloodUnits]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdWholeBloodAmt] ON [dbo].[ReferralSecondaryData] ([hdWholeBloodAmt]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdRedBloodUnits] ON [dbo].[ReferralSecondaryData] ([hdRedBloodUnits]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdRedBloodAmt] ON [dbo].[ReferralSecondaryData] ([hdRedBloodAmt]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdColloid_1] ON [dbo].[ReferralSecondaryData] ([hdColloid_1]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdColloid_2] ON [dbo].[ReferralSecondaryData] ([hdColloid_2]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdColloid_3] ON [dbo].[ReferralSecondaryData] ([hdColloid_3]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdColloid_4] ON [dbo].[ReferralSecondaryData] ([hdColloid_4]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdColloid_List] ON [dbo].[ReferralSecondaryData] ([hdColloid_List]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdCrystalloid_1] ON [dbo].[ReferralSecondaryData] ([hdCrystalloid_1]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdCrystalloid_2] ON [dbo].[ReferralSecondaryData] ([hdCrystalloid_2]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdCrystalloid_3] ON [dbo].[ReferralSecondaryData] ([hdCrystalloid_3]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdCrystalloid_4] ON [dbo].[ReferralSecondaryData] ([hdCrystalloid_4]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdCrystalloid_List] ON [dbo].[ReferralSecondaryData] ([hdCrystalloid_List]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest1_1] ON [dbo].[ReferralSecondaryData] ([hdQuest1_1]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest2_1] ON [dbo].[ReferralSecondaryData] ([hdQuest2_1]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest2_2] ON [dbo].[ReferralSecondaryData] ([hdQuest2_2]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest2_3] ON [dbo].[ReferralSecondaryData] ([hdQuest2_3]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest2_4] ON [dbo].[ReferralSecondaryData] ([hdQuest2_4]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest3_1] ON [dbo].[ReferralSecondaryData] ([hdQuest3_1]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest3_2] ON [dbo].[ReferralSecondaryData] ([hdQuest3_2]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest3_3] ON [dbo].[ReferralSecondaryData] ([hdQuest3_3]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest3_4] ON [dbo].[ReferralSecondaryData] ([hdQuest3_4]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [fscUserID] ON [dbo].[ReferralSecondaryData] ([fscUserID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdLastModified] ON [dbo].[ReferralSecondaryData] ([hdLastModified]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest3_2a] ON [dbo].[ReferralSecondaryData] ([hdQuest3_2a]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest3_3a] ON [dbo].[ReferralSecondaryData] ([hdQuest3_3a]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hdQuest3_4a] ON [dbo].[ReferralSecondaryData] ([hdQuest3_4a]) ')
GO

 CREATE    INDEX [PK_ReferralSecondaryData] ON [dbo].[ReferralSecondaryData]([ReferralID]) WITH FILLFACTOR = 90 ON [IDX]
GO


