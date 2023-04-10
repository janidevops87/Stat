IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorSerologiesSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorSerologiesSelect'
		DROP Procedure TcssDonorSerologiesSelect
	END
GO

PRINT 'Creating Procedure TcssDonorSerologiesSelect'
GO

CREATE PROCEDURE dbo.TcssDonorSerologiesSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorSerologiesSelect
**	Desc: Update Data in table TcssDonorSerologies
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tds.TcssDonorSerologiesId,
	tds.LastUpdateStatEmployeeId,
	tds.LastUpdateDate,
	tds.TcssDonorId,
	tds.TcssListSerologyQuestionId,
	tds.TcssListSerologyAnswerId
FROM dbo.TcssDonorSerologies tds
WHERE
	tds.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorSerologiesSelect TO PUBLIC
GO
