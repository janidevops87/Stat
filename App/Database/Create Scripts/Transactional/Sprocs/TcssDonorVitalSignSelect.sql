IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignSelect'
		DROP Procedure TcssDonorVitalSignSelect
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignSelect'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignSelect
**	Desc: Update Data in table TcssDonorVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	tdvs.TcssDonorVitalSignId,
	tdvs.LastUpdateStatEmployeeId,
	tdvs.LastUpdateDate,
	tdvs.TcssDonorId,
	tdvs.FromDateTime,
	tdvs.ToDateTime
FROM dbo.TcssDonorVitalSign tdvs
WHERE
	tdvs.TcssDonorId = @TcssDonorId
ORDER BY tdvs.FromDateTime, tdvs.ToDateTime

GO

GRANT EXEC ON TcssDonorVitalSignSelect TO PUBLIC
GO
