IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyVeinUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyVeinUpdate'
		DROP Procedure TcssDonorDiagnosisKidneyVeinUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyVeinUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyVeinUpdate
(
	@TcssDonorDiagnosisKidneyVeinId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListKidneyId int = null,
	@TcssListKidneyVeinId int = null,
	@Length float = null,
	@Diameter float = null,
	@Distance float = null,
	@VeinsOnVenaCava bit = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyVeinUpdate
**	Desc: Update Data in table TcssDonorDiagnosisKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisKidneyVein
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListKidneyId = @TcssListKidneyId,
	TcssListKidneyVeinId = @TcssListKidneyVeinId,
	Length = @Length,
	Diameter = @Diameter,
	Distance = @Distance,
	VeinsOnVenaCava = @VeinsOnVenaCava
WHERE
	TcssDonorDiagnosisKidneyVeinId = @TcssDonorDiagnosisKidneyVeinId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyVeinUpdate TO PUBLIC
GO
