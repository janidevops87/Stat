IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileUpdate'
		DROP Procedure TcssDonorLabProfileUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileUpdate
(
	@TcssDonorLabProfileId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@SampleDateTime smalldatetime = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileUpdate
**	Desc: Update Data in table TcssDonorLabProfile
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorLabProfile
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	SampleDateTime = @SampleDateTime
WHERE
	TcssDonorLabProfileId = @TcssDonorLabProfileId
GO

GRANT EXEC ON TcssDonorLabProfileUpdate TO PUBLIC
GO
