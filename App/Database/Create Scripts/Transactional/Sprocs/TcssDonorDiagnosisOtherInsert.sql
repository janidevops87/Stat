IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisOtherInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisOtherInsert'
		DROP Procedure TcssDonorDiagnosisOtherInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisOtherInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisOtherInsert
(
	@TcssDonorDiagnosisOtherId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListOtherOrganId int = null,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisOtherInsert
**	Desc: Insert Data into table TcssDonorDiagnosisOther
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisOther
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListOtherOrganId,
	Comment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListOtherOrganId,
	@Comment
)

-- Return the new identity value
SET @TcssDonorDiagnosisOtherId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisOtherInsert TO PUBLIC
GO
