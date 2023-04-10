IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisIntestineUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisIntestineUpdate'
		DROP Procedure TcssDonorDiagnosisIntestineUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisIntestineUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisIntestineUpdate
(
	@TcssDonorDiagnosisIntestineId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisIntestineUpdate
**	Desc: Update Data in table TcssDonorDiagnosisIntestine
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisIntestine
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	Comment = @Comment
WHERE
	TcssDonorDiagnosisIntestineId = @TcssDonorDiagnosisIntestineId
GO

GRANT EXEC ON TcssDonorDiagnosisIntestineUpdate TO PUBLIC
GO
