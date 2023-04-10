IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisIntestineInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisIntestineInsert'
		DROP Procedure TcssDonorDiagnosisIntestineInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisIntestineInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisIntestineInsert
(
	@TcssDonorDiagnosisIntestineId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisIntestineInsert
**	Desc: Insert Data into table TcssDonorDiagnosisIntestine
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisIntestine
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	Comment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@Comment
)

-- Return the new identity value
SET @TcssDonorDiagnosisIntestineId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisIntestineInsert TO PUBLIC
GO
