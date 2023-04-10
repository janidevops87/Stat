IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisLiverUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisLiverUpdate'
		DROP Procedure TcssDonorDiagnosisLiverUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisLiverUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisLiverUpdate
(
	@TcssDonorDiagnosisLiverId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListLiverBiopsyId int = null,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisLiverUpdate
**	Desc: Update Data in table TcssDonorDiagnosisLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisLiver
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListLiverBiopsyId = @TcssListLiverBiopsyId,
	Comment = @Comment
WHERE
	TcssDonorDiagnosisLiverId = @TcssDonorDiagnosisLiverId
GO

GRANT EXEC ON TcssDonorDiagnosisLiverUpdate TO PUBLIC
GO
