IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignDetailSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignDetailSelect'
		DROP Procedure TcssDonorVitalSignDetailSelect
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignDetailSelect'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignDetailSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignDetailSelect
**	Desc: Update Data in table TcssDonorVitalSignDetail
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
	tdvsd.TcssDonorVitalSignDetailId,
	tdvsd.LastUpdateStatEmployeeId,
	tdvsd.LastUpdateDate,
	tdvsd.TcssDonorId,
	tdvsd.TcssDonorVitalSignId,
	tdvsd.TcssListVitalSignId,
	tdvsd.Answer
FROM dbo.TcssDonorVitalSignDetail tdvsd
WHERE
	tdvsd.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorVitalSignDetailSelect TO PUBLIC
GO
