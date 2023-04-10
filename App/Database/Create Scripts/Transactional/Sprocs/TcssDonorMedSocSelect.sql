IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorMedSocSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorMedSocSelect'
		DROP Procedure TcssDonorMedSocSelect
	END
GO

PRINT 'Creating Procedure TcssDonorMedSocSelect'
GO

CREATE PROCEDURE dbo.TcssDonorMedSocSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorMedSocSelect
**	Desc: Update Data in table TcssDonorMedSoc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdms.TcssDonorMedSocId,
	tdms.LastUpdateStatEmployeeId,
	tdms.LastUpdateDate,
	tdms.TcssDonorId,
	tdms.TcssListHistoryOfDiabetesId,
	tdms.TcssListHistoryOfCancerId,
	tdms.TcssListHypertensionHistoryId,
	tdms.TcssListCompliantWithTreatmentId,
	tdms.TcssListHistoryOfCoronaryArteryDiseaseId,
	tdms.TcssListHistoryOfGastrointestinalDiseaseId,
	tdms.TcssListChestTraumaId,
	tdms.TcssListCigaretteUseId,
	tdms.TcssListCigaretteUseContinuedId,
	tdms.TcssListOtherDrugUseId,
	tdms.TcssListHeavyAlcoholUseId,
	tdms.TcssListDonorMeetCdcGuidelinesId,
	tdms.Comments
FROM dbo.TcssDonorMedSoc tdms
WHERE
	tdms.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorMedSocSelect TO PUBLIC
GO
