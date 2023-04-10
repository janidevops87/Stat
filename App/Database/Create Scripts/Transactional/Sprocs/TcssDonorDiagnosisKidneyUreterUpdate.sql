IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyUreterUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyUreterUpdate'
		DROP Procedure TcssDonorDiagnosisKidneyUreterUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyUreterUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyUreterUpdate
(
	@TcssDonorDiagnosisKidneyUreterId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListKidneyId int = null,
	@TcssListKidneyUreterId int = null,
	@Length float = null,
	@TcssListKidneyUreterTissueQualityId int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyUreterUpdate
**	Desc: Update Data in table TcssDonorDiagnosisKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisKidneyUreter
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListKidneyId = @TcssListKidneyId,
	TcssListKidneyUreterId = @TcssListKidneyUreterId,
	Length = @Length,
	TcssListKidneyUreterTissueQualityId = @TcssListKidneyUreterTissueQualityId
WHERE
	TcssDonorDiagnosisKidneyUreterId = @TcssDonorDiagnosisKidneyUreterId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyUreterUpdate TO PUBLIC
GO
