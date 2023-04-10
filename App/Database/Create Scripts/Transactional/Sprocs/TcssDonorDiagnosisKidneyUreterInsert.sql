IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyUreterInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyUreterInsert'
		DROP Procedure TcssDonorDiagnosisKidneyUreterInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyUreterInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyUreterInsert
(
	@TcssDonorDiagnosisKidneyUreterId int output,
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
**	Name: TcssDonorDiagnosisKidneyUreterInsert
**	Desc: Insert Data into table TcssDonorDiagnosisKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisKidneyUreter
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListKidneyId,
	TcssListKidneyUreterId,
	Length,
	TcssListKidneyUreterTissueQualityId
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListKidneyId,
	@TcssListKidneyUreterId,
	@Length,
	@TcssListKidneyUreterTissueQualityId
)

-- Return the new identity value
SET @TcssDonorDiagnosisKidneyUreterId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisKidneyUreterInsert TO PUBLIC
GO
