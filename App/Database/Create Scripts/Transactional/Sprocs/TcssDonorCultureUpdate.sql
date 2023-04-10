IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorCultureUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorCultureUpdate'
		DROP Procedure TcssDonorCultureUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorCultureUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorCultureUpdate
(
	@TcssDonorCultureId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@SampleDateTime smalldatetime = null,
	@TcssListCultureTypeId int = null,
	@TcssListCultureResultId int = null,
	@Comment varchar(2500) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorCultureUpdate
**	Desc: Update Data in table TcssDonorCulture
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorCulture
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	SampleDateTime = @SampleDateTime,
	TcssListCultureTypeId = @TcssListCultureTypeId,
	TcssListCultureResultId = @TcssListCultureResultId,
	Comment = @Comment
WHERE
	TcssDonorCultureId = @TcssDonorCultureId
GO

GRANT EXEC ON TcssDonorCultureUpdate TO PUBLIC
GO
