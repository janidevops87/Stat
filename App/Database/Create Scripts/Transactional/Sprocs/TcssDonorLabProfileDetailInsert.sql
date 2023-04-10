IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileDetailInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileDetailInsert'
		DROP Procedure TcssDonorLabProfileDetailInsert
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileDetailInsert'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileDetailInsert
(
	@TcssDonorLabProfileDetailId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssDonorLabProfileId int = null,
	@TcssListLabId int = null,
	@Answer varchar(50) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileDetailInsert
**	Desc: Insert Data into table TcssDonorLabProfileDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorLabProfileDetail
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssDonorLabProfileId,
	TcssListLabId,
	Answer
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssDonorLabProfileId,
	@TcssListLabId,
	@Answer
)

-- Return the new identity value
SET @TcssDonorLabProfileDetailId = @@Identity

GO

GRANT EXEC ON TcssDonorLabProfileDetailInsert TO PUBLIC
GO
