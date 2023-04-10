IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileSelect'
		DROP Procedure TcssDonorLabProfileSelect
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileSelect'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileSelect
**	Desc: Update Data in table TcssDonorLabProfile
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdlp.TcssDonorLabProfileId,
	tdlp.LastUpdateStatEmployeeId,
	tdlp.LastUpdateDate,
	tdlp.TcssDonorId,
	tdlp.SampleDateTime
FROM dbo.TcssDonorLabProfile tdlp
WHERE
	tdlp.TcssDonorId = @TcssDonorId
ORDER BY tdlp.SampleDateTime

GO

GRANT EXEC ON TcssDonorLabProfileSelect TO PUBLIC
GO
