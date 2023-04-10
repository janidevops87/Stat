IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyArteryUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyArteryUpdate'
		DROP Procedure TcssDonorDiagnosisKidneyArteryUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyArteryUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyArteryUpdate
(
	@TcssDonorDiagnosisKidneyArteryId int,
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
**	Name: TcssDonorDiagnosisKidneyArteryUpdate
**	Desc: Update Data in table TcssDonorDiagnosisKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisKidneyArtery
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListKidneyId = @TcssListKidneyId,
	TcssListKidneyArteryId = @TcssListKidneyArteryId,
	Length = @Length,
	Diameter = @Diameter,
	Distance = @Distance,
	ArteriesOnCommonCuff = @ArteriesOnCommonCuff
WHERE
	TcssDonorDiagnosisKidneyArteryId = @TcssDonorDiagnosisKidneyArteryId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyArteryUpdate TO PUBLIC
GO
