IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileInsert'
		DROP Procedure TcssDonorLabProfileInsert
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileInsert'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileInsert
(
	@TcssDonorLabProfileId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@SampleDateTime smalldatetime = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileInsert
**	Desc: Insert Data into table TcssDonorLabProfile
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorLabProfile
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	SampleDateTime
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@SampleDateTime
)

-- Return the new identity value
SET @TcssDonorLabProfileId = @@Identity

GO

GRANT EXEC ON TcssDonorLabProfileInsert TO PUBLIC
GO
