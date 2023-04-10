IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyVeinDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyVeinDelete'
		DROP Procedure TcssDonorDiagnosisKidneyVeinDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyVeinDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyVeinDelete
(
	@TcssDonorDiagnosisKidneyVeinId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyVeinDelete
**	Desc: Delete Data from table TcssDonorDiagnosisKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisKidneyVein
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisKidneyVeinId = @TcssDonorDiagnosisKidneyVeinId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisKidneyVein
WHERE TcssDonorDiagnosisKidneyVeinId = @TcssDonorDiagnosisKidneyVeinId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyVeinDelete TO PUBLIC
GO
