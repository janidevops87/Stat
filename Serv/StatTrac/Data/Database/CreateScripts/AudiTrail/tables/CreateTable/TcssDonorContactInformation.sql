/***************************************************************************************************
**	Name: TcssDonorContactInformation
**	Desc: Creates new table TcssDonorContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorContactInformation')
BEGIN
	-- DROP TABLE dbo.TcssDonorContactInformation
	PRINT 'Creating table TcssDonorContactInformation'
	CREATE TABLE dbo.TcssDonorContactInformation
	(
		TcssDonorContactInformationId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		DonorHospital varchar(50) NULL,
		TcssListTimeZoneId int NULL,
		TcssListDaylightSavingsObservedId int NULL,
		Opo varchar(50) NULL,
		DonorHospitalPhone varchar(10) NULL,
		DonorHospitalContact varchar(100) NULL,
		OpoContact varchar(50) NULL,
		TransplantSurgeonContactId int NULL,
		TransplantSurgeonContactOther varchar(100) NULL,
		ClinicalCoordinatorId int NULL,
		ClinicalCoordinatorOther varchar(100) NULL,
	)
END
GO

-- Increase the column so that we can store the formating
ALTER TABLE TcssDonorContactInformation ALTER COLUMN DonorHospitalPhone varchar(15);

GRANT SELECT ON TcssDonorContactInformation TO PUBLIC
GO
