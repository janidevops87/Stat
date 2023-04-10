IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileDetailSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileDetailSelect'
		DROP Procedure TcssDonorLabProfileDetailSelect
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileDetailSelect'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileDetailSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileDetailSelect
**	Desc: Update Data in table TcssDonorLabProfileDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdlpd.TcssDonorLabProfileDetailId,
	tdlpd.LastUpdateStatEmployeeId,
	tdlpd.LastUpdateDate,
	tdlpd.TcssDonorId,
	tdlpd.TcssDonorLabProfileId,
	tdlpd.TcssListLabId,
	tdlpd.Answer
FROM dbo.TcssDonorLabProfileDetail tdlpd
WHERE
	tdlpd.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorLabProfileDetailSelect TO PUBLIC
GO
