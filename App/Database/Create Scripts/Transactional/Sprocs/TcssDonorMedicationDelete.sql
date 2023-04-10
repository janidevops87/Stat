IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorMedicationDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorMedicationDelete'
		DROP Procedure TcssDonorMedicationDelete
	END
GO

PRINT 'Creating Procedure TcssDonorMedicationDelete'
GO

CREATE PROCEDURE dbo.TcssDonorMedicationDelete
(
	@TcssDonorMedicationId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorMedicationDelete
**	Desc: Delete Data from table TcssDonorMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorMedication
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorMedicationId = @TcssDonorMedicationId

-- Delete The Record
DELETE FROM dbo.TcssDonorMedication
WHERE TcssDonorMedicationId = @TcssDonorMedicationId
GO

GRANT EXEC ON TcssDonorMedicationDelete TO PUBLIC
GO
