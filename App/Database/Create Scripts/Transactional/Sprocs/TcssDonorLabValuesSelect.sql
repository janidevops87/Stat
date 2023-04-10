IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabValuesSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabValuesSelect'
		DROP Procedure TcssDonorLabValuesSelect
	END
GO

PRINT 'Creating Procedure TcssDonorLabValuesSelect'
GO

CREATE PROCEDURE dbo.TcssDonorLabValuesSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabValuesSelect
**	Desc: Update Data in table TcssDonorLabValues
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdlv.TcssDonorLabValuesId,
	tdlv.LastUpdateStatEmployeeId,
	tdlv.LastUpdateDate,
	tdlv.TcssDonorId,
	tdlv.SampleDateTime,
	tdlv.Cpk,
	tdlv.Ckmb,
	tdlv.TroponinL,
	tdlv.TroponinT
FROM dbo.TcssDonorLabValues tdlv
WHERE
	tdlv.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorLabValuesSelect TO PUBLIC
GO
