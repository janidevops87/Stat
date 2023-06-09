SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorHla](
	[TcssDonorHlaId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListAboId] [int] NULL,
	[DateOfBirth] [smalldatetime] NULL,
	[Age] [int] NULL,
	[TcssListAgeUnitId] [int] NULL,
	[TcssListGenderId] [int] NULL,
	[HeightFeet] [int] NULL,
	[HeightInches] [int] NULL,
	[Weight] [decimal](18, 3) NULL,
	[Bmi] [decimal](18, 4) NULL,
	[TcssListEthnicityId] [int] NULL,
	[TcssListRaceId] [int] NULL,
	[TcssListCauseOfDeathId] [int] NULL,
	[TcssListMechanismOfDeathId] [int] NULL,
	[TcssListCircumstancesOfDeathId] [int] NULL,
	[TcssListDonorDefinitionId] [int] NULL,
	[TcssListDonorDbdSubDefinitionId] [int] NULL,
	[TcssListDonorDcdSubDefinitionId] [int] NULL,
	[TcssListBreathingOverVentId] [int] NULL,
	[UwScore] [varchar](50) NULL,
	[TcssListHemodynamicallyStableId] [int] NULL,
	[AdmitDateTime] [smalldatetime] NULL,
	[PronouncedDateTime] [smalldatetime] NULL,
	[CardiacArrestDateTime] [smalldatetime] NULL,
	[CrossClampDateTime] [smalldatetime] NULL,
	[ColdSchemeticTime] [varchar](50) NULL,
	[TcssListDonorMeetsEcdCriteriaId] [int] NULL,
	[TcssListDonorMeetsDcdCriteriaId] [int] NULL,
	[TcssListCardiacArrestDownTimeId] [int] NULL,
	[EstimattedDownTime] [int] NULL,
	[TcssListCprAdministeredId] [int] NULL,
	[Duration] [int] NULL,
	[DonorHighlights] [varchar](5000) NULL,
	[AdmissionCourseComments] [varchar](2000) NULL,
 CONSTRAINT [PK_TcssDonorHla] PRIMARY KEY CLUSTERED 
(
	[TcssDonorHlaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]') AND name = N'IX_TcssDonorHla_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorHla_TcssDonorId] ON [dbo].[TcssDonorHla]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorHla_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorHla] ADD  CONSTRAINT [DF_TcssDonorHla_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListAboId_dbo_TcssListAbo_TcssListAboId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListAboId_dbo_TcssListAbo_TcssListAboId] FOREIGN KEY([TcssListAboId])
REFERENCES [dbo].[TcssListAbo] ([TcssListAboId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListAboId_dbo_TcssListAbo_TcssListAboId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListAboId_dbo_TcssListAbo_TcssListAboId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListAgeUnitId_dbo_TcssListAgeUnit_TcssListAgeUnitId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListAgeUnitId_dbo_TcssListAgeUnit_TcssListAgeUnitId] FOREIGN KEY([TcssListAgeUnitId])
REFERENCES [dbo].[TcssListAgeUnit] ([TcssListAgeUnitId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListAgeUnitId_dbo_TcssListAgeUnit_TcssListAgeUnitId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListAgeUnitId_dbo_TcssListAgeUnit_TcssListAgeUnitId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListCardiacArrestDownTimeId_dbo_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListCardiacArrestDownTimeId_dbo_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId] FOREIGN KEY([TcssListCardiacArrestDownTimeId])
REFERENCES [dbo].[TcssListCardiacArrestDownTime] ([TcssListCardiacArrestDownTimeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListCardiacArrestDownTimeId_dbo_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListCardiacArrestDownTimeId_dbo_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListCauseOfDeathId_dbo_TcssListCauseOfDeath_TcssListCauseOfDeathId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListCauseOfDeathId_dbo_TcssListCauseOfDeath_TcssListCauseOfDeathId] FOREIGN KEY([TcssListCauseOfDeathId])
REFERENCES [dbo].[TcssListCauseOfDeath] ([TcssListCauseOfDeathId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListCauseOfDeathId_dbo_TcssListCauseOfDeath_TcssListCauseOfDeathId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListCauseOfDeathId_dbo_TcssListCauseOfDeath_TcssListCauseOfDeathId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListCircumstancesOfDeathId_dbo_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListCircumstancesOfDeathId_dbo_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId] FOREIGN KEY([TcssListCircumstancesOfDeathId])
REFERENCES [dbo].[TcssListCircumstancesOfDeath] ([TcssListCircumstancesOfDeathId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListCircumstancesOfDeathId_dbo_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListCircumstancesOfDeathId_dbo_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListCprAdministeredId_dbo_TcssListCprAdministered_TcssListCprAdministeredId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListCprAdministeredId_dbo_TcssListCprAdministered_TcssListCprAdministeredId] FOREIGN KEY([TcssListCprAdministeredId])
REFERENCES [dbo].[TcssListCprAdministered] ([TcssListCprAdministeredId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListCprAdministeredId_dbo_TcssListCprAdministered_TcssListCprAdministeredId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListCprAdministeredId_dbo_TcssListCprAdministered_TcssListCprAdministeredId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorDbdSubDefinitionId_dbo_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorDbdSubDefinitionId_dbo_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId] FOREIGN KEY([TcssListDonorDbdSubDefinitionId])
REFERENCES [dbo].[TcssListDonorDbdSubDefinition] ([TcssListDonorDbdSubDefinitionId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorDbdSubDefinitionId_dbo_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorDbdSubDefinitionId_dbo_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorDcdSubDefinitionId_dbo_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorDcdSubDefinitionId_dbo_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId] FOREIGN KEY([TcssListDonorDcdSubDefinitionId])
REFERENCES [dbo].[TcssListDonorDcdSubDefinition] ([TcssListDonorDcdSubDefinitionId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorDcdSubDefinitionId_dbo_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorDcdSubDefinitionId_dbo_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorDefinitionId_dbo_TcssListDonorDefinition_TcssListDonorDefinitionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorDefinitionId_dbo_TcssListDonorDefinition_TcssListDonorDefinitionId] FOREIGN KEY([TcssListDonorDefinitionId])
REFERENCES [dbo].[TcssListDonorDefinition] ([TcssListDonorDefinitionId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorDefinitionId_dbo_TcssListDonorDefinition_TcssListDonorDefinitionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorDefinitionId_dbo_TcssListDonorDefinition_TcssListDonorDefinitionId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_dbo_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_dbo_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId] FOREIGN KEY([TcssListDonorMeetsDcdCriteriaId])
REFERENCES [dbo].[TcssListDonorMeetsDcdCriteria] ([TcssListDonorMeetsDcdCriteriaId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_dbo_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_dbo_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_dbo_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_dbo_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId] FOREIGN KEY([TcssListDonorMeetsEcdCriteriaId])
REFERENCES [dbo].[TcssListDonorMeetsEcdCriteria] ([TcssListDonorMeetsEcdCriteriaId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_dbo_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_dbo_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListEthnicityId_dbo_TcssListEthnicity_TcssListEthnicityId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListEthnicityId_dbo_TcssListEthnicity_TcssListEthnicityId] FOREIGN KEY([TcssListEthnicityId])
REFERENCES [dbo].[TcssListEthnicity] ([TcssListEthnicityId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListEthnicityId_dbo_TcssListEthnicity_TcssListEthnicityId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListEthnicityId_dbo_TcssListEthnicity_TcssListEthnicityId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListGenderId_dbo_TcssListGender_TcssListGenderId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListGenderId_dbo_TcssListGender_TcssListGenderId] FOREIGN KEY([TcssListGenderId])
REFERENCES [dbo].[TcssListGender] ([TcssListGenderId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListGenderId_dbo_TcssListGender_TcssListGenderId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListGenderId_dbo_TcssListGender_TcssListGenderId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListMechanismOfDeathId_dbo_TcssListMechanismOfDeath_TcssListMechanismOfDeathId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListMechanismOfDeathId_dbo_TcssListMechanismOfDeath_TcssListMechanismOfDeathId] FOREIGN KEY([TcssListMechanismOfDeathId])
REFERENCES [dbo].[TcssListMechanismOfDeath] ([TcssListMechanismOfDeathId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListMechanismOfDeathId_dbo_TcssListMechanismOfDeath_TcssListMechanismOfDeathId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListMechanismOfDeathId_dbo_TcssListMechanismOfDeath_TcssListMechanismOfDeathId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListRaceId_dbo_TcssListRace_TcssListRaceId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHla_TcssListRaceId_dbo_TcssListRace_TcssListRaceId] FOREIGN KEY([TcssListRaceId])
REFERENCES [dbo].[TcssListRace] ([TcssListRaceId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHla_TcssListRaceId_dbo_TcssListRace_TcssListRaceId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHla]'))
ALTER TABLE [dbo].[TcssDonorHla] CHECK CONSTRAINT [FK_dbo_TcssDonorHla_TcssListRaceId_dbo_TcssListRace_TcssListRaceId]
GO
