IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyArteryInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyArteryInsert'
		DROP Procedure TcssDonorDiagnosisKidneyArteryInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyArteryInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyArteryInsert
(
	@TcssDonorDiagnosisKidneyArteryId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListKidneyId int = null,
	@TcssListKidneyArteryId int = null,
	@Length float = null,
	@Diameter float = null,
	@Distance float = null,
	@ArteriesOnCommonCuff bit = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyArteryInsert
**	Desc: Insert Data into table TcssDonorDiagnosisKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisKidneyArtery
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListKidneyId,
	TcssListKidneyArteryId,
	Length,
	Diameter,
	Distance,
	ArteriesOnCommonCuff
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListKidneyId,
	@TcssListKidneyArteryId,
	@Length,
	@Diameter,
	@Distance,
	@ArteriesOnCommonCuff
)

-- Return the new identity value
SET @TcssDonorDiagnosisKidneyArteryId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisKidneyArteryInsert TO PUBLIC
GO
