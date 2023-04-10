IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorAbgSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorAbgSelect'
		DROP Procedure TcssDonorAbgSelect
	END
GO

PRINT 'Creating Procedure TcssDonorAbgSelect'
GO

CREATE PROCEDURE dbo.TcssDonorAbgSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorAbgSelect
**	Desc: Update Data in table TcssDonorAbg
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tda.TcssDonorAbgId,
	tda.LastUpdateStatEmployeeId,
	tda.LastUpdateDate,
	tda.TcssDonorId,
	tda.SampleDateTime,
	tda.Ph,
	tda.Pco2,
	tda.Po2,
	tda.Hco3,
	tda.O2sat,
	tda.TcssListVentSettingModeId,
	tda.ModeOther,
	tda.Fio2,
	tda.Rate,
	tda.Vt,
	tda.Peep,
	tda.Pip
FROM dbo.TcssDonorAbg tda
WHERE
	tda.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorAbgSelect TO PUBLIC
GO
