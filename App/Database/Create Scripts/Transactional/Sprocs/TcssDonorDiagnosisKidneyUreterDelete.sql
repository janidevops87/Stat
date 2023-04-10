IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyUreterDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyUreterDelete'
		DROP Procedure TcssDonorDiagnosisKidneyUreterDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyUreterDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyUreterDelete
(
	@TcssDonorDiagnosisKidneyUreterId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyUreterDelete
**	Desc: Delete Data from table TcssDonorDiagnosisKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisKidneyUreter
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisKidneyUreterId = @TcssDonorDiagnosisKidneyUreterId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisKidneyUreter
WHERE TcssDonorDiagnosisKidneyUreterId = @TcssDonorDiagnosisKidneyUreterId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyUreterDelete TO PUBLIC
GO
