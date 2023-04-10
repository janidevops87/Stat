IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisHeartUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisHeartUpdate'
		DROP Procedure TcssDonorDiagnosisHeartUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisHeartUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisHeartUpdate
(
	@TcssDonorDiagnosisHeartId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@LvEjectionFraction decimal(18,2) = null,
	@TcssListDiagnosisHeartMethodId int = null,
	@ShorteningFraction decimal(18,2) = null,
	@SeptalWallThickness int = null,
	@LvPosteriorWallThickness int = null,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisHeartUpdate
**	Desc: Update Data in table TcssDonorDiagnosisHeart
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisHeart
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	LvEjectionFraction = @LvEjectionFraction,
	TcssListDiagnosisHeartMethodId = @TcssListDiagnosisHeartMethodId,
	ShorteningFraction = @ShorteningFraction,
	SeptalWallThickness = @SeptalWallThickness,
	LvPosteriorWallThickness = @LvPosteriorWallThickness,
	Comment = @Comment
WHERE
	TcssDonorDiagnosisHeartId = @TcssDonorDiagnosisHeartId
GO

GRANT EXEC ON TcssDonorDiagnosisHeartUpdate TO PUBLIC
GO
