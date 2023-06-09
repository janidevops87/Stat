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
	[hdQuest3_4a] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


