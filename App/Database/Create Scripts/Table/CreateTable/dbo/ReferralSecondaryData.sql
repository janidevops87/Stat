SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReferralSecondaryData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReferralSecondaryData](
	[ReferralID] [int] NOT NULL,
	[ReferralSecondaryHistory] [varchar](500) NULL,
	[LastModified] [smalldatetime] NULL,
	[hdBloodRecv48] [smallint] NULL,
	[hdWholeBloodUnits] [float] NULL,
	[hdWholeBloodAmt] [float] NULL,
	[hdRedBloodUnits] [float] NULL,
	[hdRedBloodAmt] [float] NULL,
	[hdColloid_1] [float] NULL,
	[hdColloid_2] [float] NULL,
	[hdColloid_3] [float] NULL,
	[hdColloid_4] [float] NULL,
	[hdColloid_List] [varchar](50) NULL,
	[hdCrystalloid_1] [float] NULL,
	[hdCrystalloid_2] [float] NULL,
	[hdCrystalloid_3] [float] NULL,
	[hdCrystalloid_4] [float] NULL,
	[hdCrystalloid_List] [varchar](50) NULL,
	[hdQuest1_1] [smallint] NULL,
	[hdQuest2_1] [smallint] NULL,
	[hdQuest2_2] [smallint] NULL,
	[hdQuest2_3] [smallint] NULL,
	[hdQuest2_4] [smallint] NULL,
	[hdQuest3_1] [smallint] NULL,
	[hdQuest3_2] [smallint] NULL,
	[hdQuest3_3] [smallint] NULL,
	[hdQuest3_4] [smallint] NULL,
	[fscUserID] [int] NULL,
	[hdLastModified] [datetime] NULL,
	[hdQuest3_2a] [varchar](50) NULL,
	[hdQuest3_3a] [varchar](50) NULL,
	[hdQuest3_4a] [varchar](50) NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_ReferralSecondaryData] PRIMARY KEY NONCLUSTERED 
(
	[ReferralID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReferralSecondaryData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReferralSecondaryData]'))
ALTER TABLE [dbo].[ReferralSecondaryData]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReferralSecondaryData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReferralSecondaryData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReferralSecondaryData]'))
ALTER TABLE [dbo].[ReferralSecondaryData] CHECK CONSTRAINT [FK_dbo_ReferralSecondaryData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
