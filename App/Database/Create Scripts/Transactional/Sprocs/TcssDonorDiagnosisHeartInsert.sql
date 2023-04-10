IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisHeartInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisHeartInsert'
		DROP Procedure TcssDonorDiagnosisHeartInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisHeartInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisHeartInsert
(
	@TcssDonorDiagnosisHeartId int output,
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
**	Name: TcssDonorDiagnosisHeartInsert
**	Desc: Insert Data into table TcssDonorDiagnosisHeart
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisHeart
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	LvEjectionFraction,
	TcssListDiagnosisHeartMethodId,
	ShorteningFraction,
	SeptalWallThickness,
	LvPosteriorWallThickness,
	Comment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@LvEjectionFraction,
	@TcssListDiagnosisHeartMethodId,
	@ShorteningFraction,
	@SeptalWallThickness,
	@LvPosteriorWallThickness,
	@Comment
)

-- Return the new identity value
SET @TcssDonorDiagnosisHeartId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisHeartInsert TO PUBLIC
GO
