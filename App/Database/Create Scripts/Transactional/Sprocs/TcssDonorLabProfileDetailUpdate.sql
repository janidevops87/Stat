IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileDetailUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileDetailUpdate'
		DROP Procedure TcssDonorLabProfileDetailUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileDetailUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileDetailUpdate
(
	@TcssDonorLabProfileDetailId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssDonorLabProfileId int = null,
	@TcssListLabId int = null,
	@Answer varchar(50) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileDetailUpdate
**	Desc: Update Data in table TcssDonorLabProfileDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorLabProfileDetail
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssDonorLabProfileId = @TcssDonorLabProfileId,
	TcssListLabId = @TcssListLabId,
	Answer = @Answer
WHERE
	TcssDonorLabProfileDetailId = @TcssDonorLabProfileDetailId
GO

GRANT EXEC ON TcssDonorLabProfileDetailUpdate TO PUBLIC
GO
