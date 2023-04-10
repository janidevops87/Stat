/***************************************************************************************************
**	Name: TcssDonorHla
**	Desc: Add Foreign keys to TcssDonorHla
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListAboId_TcssListAbo_TcssListAboId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListAboId_TcssListAbo_TcssListAboId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListAboId_TcssListAbo_TcssListAboId
			FOREIGN KEY(TcssListAboId) REFERENCES dbo.TcssListAbo(TcssListAboId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListAgeUnitId_TcssListAgeUnit_TcssListAgeUnitId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListAgeUnitId_TcssListAgeUnit_TcssListAgeUnitId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListAgeUnitId_TcssListAgeUnit_TcssListAgeUnitId
			FOREIGN KEY(TcssListAgeUnitId) REFERENCES dbo.TcssListAgeUnit(TcssListAgeUnitId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListGenderId_TcssListGender_TcssListGenderId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListGenderId_TcssListGender_TcssListGenderId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListGenderId_TcssListGender_TcssListGenderId
			FOREIGN KEY(TcssListGenderId) REFERENCES dbo.TcssListGender(TcssListGenderId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListEthnicityId_TcssListEthnicity_TcssListEthnicityId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListEthnicityId_TcssListEthnicity_TcssListEthnicityId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListEthnicityId_TcssListEthnicity_TcssListEthnicityId
			FOREIGN KEY(TcssListEthnicityId) REFERENCES dbo.TcssListEthnicity(TcssListEthnicityId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListRaceId_TcssListRace_TcssListRaceId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListRaceId_TcssListRace_TcssListRaceId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListRaceId_TcssListRace_TcssListRaceId
			FOREIGN KEY(TcssListRaceId) REFERENCES dbo.TcssListRace(TcssListRaceId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListCauseOfDeathId_TcssListCauseOfDeath_TcssListCauseOfDeathId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListCauseOfDeathId_TcssListCauseOfDeath_TcssListCauseOfDeathId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListCauseOfDeathId_TcssListCauseOfDeath_TcssListCauseOfDeathId
			FOREIGN KEY(TcssListCauseOfDeathId) REFERENCES dbo.TcssListCauseOfDeath(TcssListCauseOfDeathId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListMechanismOfDeathId_TcssListMechanismOfDeath_TcssListMechanismOfDeathId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListMechanismOfDeathId_TcssListMechanismOfDeath_TcssListMechanismOfDeathId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListMechanismOfDeathId_TcssListMechanismOfDeath_TcssListMechanismOfDeathId
			FOREIGN KEY(TcssListMechanismOfDeathId) REFERENCES dbo.TcssListMechanismOfDeath(TcssListMechanismOfDeathId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListCircumstancesOfDeathId_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListCircumstancesOfDeathId_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListCircumstancesOfDeathId_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId
			FOREIGN KEY(TcssListCircumstancesOfDeathId) REFERENCES dbo.TcssListCircumstancesOfDeath(TcssListCircumstancesOfDeathId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListDonorDefinitionId_TcssListDonorDefinition_TcssListDonorDefinitionId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListDonorDefinitionId_TcssListDonorDefinition_TcssListDonorDefinitionId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListDonorDefinitionId_TcssListDonorDefinition_TcssListDonorDefinitionId
			FOREIGN KEY(TcssListDonorDefinitionId) REFERENCES dbo.TcssListDonorDefinition(TcssListDonorDefinitionId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListDonorDbdSubDefinitionId_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListDonorDbdSubDefinitionId_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListDonorDbdSubDefinitionId_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId
			FOREIGN KEY(TcssListDonorDbdSubDefinitionId) REFERENCES dbo.TcssListDonorDbdSubDefinition(TcssListDonorDbdSubDefinitionId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListDonorDcdSubDefinitionId_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListDonorDcdSubDefinitionId_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListDonorDcdSubDefinitionId_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId
			FOREIGN KEY(TcssListDonorDcdSubDefinitionId) REFERENCES dbo.TcssListDonorDcdSubDefinition(TcssListDonorDcdSubDefinitionId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListBreathingOverVentId_TcssListBreathingOverVent_TcssListBreathingOverVentId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListBreathingOverVentId_TcssListBreathingOverVent_TcssListBreathingOverVentId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListBreathingOverVentId_TcssListBreathingOverVent_TcssListBreathingOverVentId
			FOREIGN KEY(TcssListBreathingOverVentId) REFERENCES dbo.TcssListBreathingOverVent(TcssListBreathingOverVentId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListHemodynamicallyStableId_TcssListHemodynamicallyStable_TcssListHemodynamicallyStableId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListHemodynamicallyStableId_TcssListHemodynamicallyStable_TcssListHemodynamicallyStableId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListHemodynamicallyStableId_TcssListHemodynamicallyStable_TcssListHemodynamicallyStableId
			FOREIGN KEY(TcssListHemodynamicallyStableId) REFERENCES dbo.TcssListHemodynamicallyStable(TcssListHemodynamicallyStableId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId
			FOREIGN KEY(TcssListDonorMeetsEcdCriteriaId) REFERENCES dbo.TcssListDonorMeetsEcdCriteria(TcssListDonorMeetsEcdCriteriaId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId
			FOREIGN KEY(TcssListDonorMeetsDcdCriteriaId) REFERENCES dbo.TcssListDonorMeetsDcdCriteria(TcssListDonorMeetsDcdCriteriaId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListCardiacArrestDownTimeId_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListCardiacArrestDownTimeId_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListCardiacArrestDownTimeId_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId
			FOREIGN KEY(TcssListCardiacArrestDownTimeId) REFERENCES dbo.TcssListCardiacArrestDownTime(TcssListCardiacArrestDownTimeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHla_TcssListCprAdministeredId_TcssListCprAdministered_TcssListCprAdministeredId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHla_TcssListCprAdministeredId_TcssListCprAdministered_TcssListCprAdministeredId'
		ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT FK_TcssDonorHla_TcssListCprAdministeredId_TcssListCprAdministered_TcssListCprAdministeredId
			FOREIGN KEY(TcssListCprAdministeredId) REFERENCES dbo.TcssListCprAdministered(TcssListCprAdministeredId) 
	END
GO
