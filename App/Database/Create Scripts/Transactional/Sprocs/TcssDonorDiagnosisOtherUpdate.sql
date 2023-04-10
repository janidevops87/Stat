IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisOtherUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisOtherUpdate'
		DROP Procedure TcssDonorDiagnosisOtherUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisOtherUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisOtherUpdate
(
	@TcssDonorDiagnosisOtherId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListOtherOrganId int = null,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisOtherUpdate
**	Desc: Update Data in table TcssDonorDiagnosisOther
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisOther
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListOtherOrganId = @TcssListOtherOrganId,
	Comment = @Comment
WHERE
	TcssDonorDiagnosisOtherId = @TcssDonorDiagnosisOtherId
GO

GRANT EXEC ON TcssDonorDiagnosisOtherUpdate TO PUBLIC
GO
