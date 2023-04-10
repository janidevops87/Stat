IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyVeinInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyVeinInsert'
		DROP Procedure TcssDonorDiagnosisKidneyVeinInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyVeinInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyVeinInsert
(
	@TcssDonorDiagnosisKidneyVeinId int output,
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
**	Name: TcssDonorDiagnosisKidneyVeinInsert
**	Desc: Insert Data into table TcssDonorDiagnosisKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisKidneyVein
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListKidneyId,
	TcssListKidneyVeinId,
	Length,
	Diameter,
	Distance,
	VeinsOnVenaCava
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListKidneyId,
	@TcssListKidneyVeinId,
	@Length,
	@Diameter,
	@Distance,
	@VeinsOnVenaCava
)

-- Return the new identity value
SET @TcssDonorDiagnosisKidneyVeinId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisKidneyVeinInsert TO PUBLIC
GO
