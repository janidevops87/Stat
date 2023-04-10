IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyArteryDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyArteryDelete'
		DROP Procedure TcssDonorDiagnosisKidneyArteryDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyArteryDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyArteryDelete
(
	@TcssDonorDiagnosisKidneyArteryId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyArteryDelete
**	Desc: Delete Data from table TcssDonorDiagnosisKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisKidneyArtery
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisKidneyArteryId = @TcssDonorDiagnosisKidneyArteryId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisKidneyArtery
WHERE TcssDonorDiagnosisKidneyArteryId = @TcssDonorDiagnosisKidneyArteryId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyArteryDelete TO PUBLIC
GO
