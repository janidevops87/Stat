IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisPancreasSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisPancreasSelect'
		DROP Procedure TcssDonorDiagnosisPancreasSelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisPancreasSelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisPancreasSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisPancreasSelect
**	Desc: Update Data in table TcssDonorDiagnosisPancreas
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddp.TcssDonorDiagnosisPancreasId,
	tddp.LastUpdateStatEmployeeId,
	tddp.LastUpdateDate,
	tddp.TcssDonorId,
	tddp.Comment
FROM dbo.TcssDonorDiagnosisPancreas tddp
WHERE
	tddp.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorDiagnosisPancreasSelect TO PUBLIC
GO
