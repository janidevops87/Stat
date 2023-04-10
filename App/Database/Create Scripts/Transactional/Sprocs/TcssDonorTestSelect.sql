IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorTestSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorTestSelect'
		DROP Procedure TcssDonorTestSelect
	END
GO

PRINT 'Creating Procedure TcssDonorTestSelect'
GO

CREATE PROCEDURE dbo.TcssDonorTestSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorTestSelect
**	Desc: Update Data in table TcssDonorTest
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdt.TcssDonorTestId,
	tdt.LastUpdateStatEmployeeId,
	tdt.LastUpdateDate,
	tdt.TcssDonorId,
	tdt.TcssListTestTypeId,
	tdt.TestDateTime,
	tdt.Interpretation
FROM dbo.TcssDonorTest tdt
WHERE
	tdt.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorTestSelect TO PUBLIC
GO
