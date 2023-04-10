IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorCompleteBloodCountSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorCompleteBloodCountSelect'
		DROP Procedure TcssDonorCompleteBloodCountSelect
	END
GO

PRINT 'Creating Procedure TcssDonorCompleteBloodCountSelect'
GO

CREATE PROCEDURE dbo.TcssDonorCompleteBloodCountSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorCompleteBloodCountSelect
**	Desc: Update Data in table TcssDonorCompleteBloodCount
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdcbc.TcssDonorCompleteBloodCountId,
	tdcbc.LastUpdateStatEmployeeId,
	tdcbc.LastUpdateDate,
	tdcbc.TcssDonorId,
	tdcbc.SampleDateTime,
	tdcbc.Wbc,
	tdcbc.Rbc,
	tdcbc.Hgb,
	tdcbc.Hct,
	tdcbc.Plt,
	tdcbc.Bands
FROM dbo.TcssDonorCompleteBloodCount tdcbc
WHERE
	tdcbc.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorCompleteBloodCountSelect TO PUBLIC
GO
