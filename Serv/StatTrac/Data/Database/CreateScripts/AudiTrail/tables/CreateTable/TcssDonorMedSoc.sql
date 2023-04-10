/***************************************************************************************************
**	Name: TcssDonorMedSoc
**	Desc: Creates new table TcssDonorMedSoc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorMedSoc')
BEGIN
	-- DROP TABLE dbo.TcssDonorMedSoc
	PRINT 'Creating table TcssDonorMedSoc'
	CREATE TABLE dbo.TcssDonorMedSoc
	(
		TcssDonorMedSocId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListHistoryOfDiabetesId int NULL,
		TcssListHistoryOfCancerId int NULL,
		TcssListHypertensionHistoryId int NULL,
		TcssListCompliantWithTreatmentId int NULL,
		TcssListHistoryOfCoronaryArteryDiseaseId int NULL,
		TcssListHistoryOfGastrointestinalDiseaseId int NULL,
		TcssListChestTraumaId int NULL,
		TcssListCigaretteUseId int NULL,
		TcssListCigaretteUseContinuedId int NULL,
		TcssListOtherDrugUseId int NULL,
		TcssListHeavyAlcoholUseId int NULL,
		TcssListDonorMeetCdcGuidelinesId int NULL,
		Comments varchar(5000) NULL
	)
END
GO

GRANT SELECT ON TcssDonorMedSoc TO PUBLIC
GO
