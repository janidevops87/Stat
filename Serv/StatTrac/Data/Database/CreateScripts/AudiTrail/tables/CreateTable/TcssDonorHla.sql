/***************************************************************************************************
**	Name: TcssDonorHla
**	Desc: Creates new table TcssDonorHla
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorHla')
BEGIN
	-- DROP TABLE dbo.TcssDonorHla
	PRINT 'Creating table TcssDonorHla'
	CREATE TABLE dbo.TcssDonorHla
	(
		TcssDonorHlaId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListAboId int NULL,
		DateOfBirth smalldatetime NULL,
		Age int NULL,
		TcssListAgeUnitId int NULL,
		TcssListGenderId int NULL,
		HeightFeet int NULL,
		HeightInches int NULL,
		Weight decimal(18,2),
		Bmi decimal(18,2),
		TcssListEthnicityId int NULL,
		TcssListRaceId int NULL,
		TcssListCauseOfDeathId int NULL,
		TcssListMechanismOfDeathId int NULL,
		TcssListCircumstancesOfDeathId int NULL,
		TcssListDonorDefinitionId int NULL,
		TcssListDonorDbdSubDefinitionId int NULL,
		TcssListDonorDcdSubDefinitionId int NULL,
		TcssListBreathingOverVentId int NULL,
		UwScore varchar(50) NULL,
		TcssListHemodynamicallyStableId int NULL,
		AdmitDateTime smalldatetime NULL,
		PronouncedDateTime smalldatetime NULL,
		CardiacArrestDateTime smalldatetime NULL,
		CrossClampDateTime smalldatetime NULL,
		ColdSchemeticTime smallint NULL,
		TcssListDonorMeetsEcdCriteriaId int NULL,
		TcssListDonorMeetsDcdCriteriaId int NULL,
		TcssListCardiacArrestDownTimeId int NULL,
		EstimattedDownTime int NULL,
		TcssListCprAdministeredId int NULL,
		Duration int NULL,
		DonorHighlights varchar(5000) NULL,
		AdmissionCourseComments varchar(500) NULL
	)
END
GO
IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorHla') AND name = 'Weight')
BEGIN
	ALTER TABLE dbo.TcssDonorHla ALTER COLUMN Weight decimal(18,3) NULL
END

IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorHla') AND name = 'Bmi')
BEGIN
	ALTER TABLE dbo.TcssDonorHla ALTER COLUMN Bmi decimal(18,4) NULL
END
IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorHla') AND name = 'AdmissionCourseComments')
BEGIN
	ALTER TABLE dbo.TcssDonorHla ALTER COLUMN AdmissionCourseComments varchar(2000) NULL
END
IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorHla') AND name = 'ColdSchemeticTime')
BEGIN
	ALTER TABLE dbo.TcssDonorHla ALTER COLUMN ColdSchemeticTime varchar(50) NULL
END
GO

GRANT SELECT ON TcssDonorHla TO PUBLIC
GO
