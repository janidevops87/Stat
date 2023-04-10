IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisLiverInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisLiverInsert'
		DROP Procedure TcssDonorDiagnosisLiverInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisLiverInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisLiverInsert
(
	@TcssDonorDiagnosisLiverId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListLiverBiopsyId int = null,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisLiverInsert
**	Desc: Insert Data into table TcssDonorDiagnosisLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisLiver
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListLiverBiopsyId,
	Comment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListLiverBiopsyId,
	@Comment
)

-- Return the new identity value
SET @TcssDonorDiagnosisLiverId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisLiverInsert TO PUBLIC
GO
