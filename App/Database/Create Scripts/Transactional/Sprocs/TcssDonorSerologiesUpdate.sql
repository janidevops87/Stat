IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorSerologiesUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorSerologiesUpdate'
		DROP Procedure TcssDonorSerologiesUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorSerologiesUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorSerologiesUpdate
(
	@TcssDonorSerologiesId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListSerologyQuestionId int = null,
	@TcssListSerologyAnswerId int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorSerologiesUpdate
**	Desc: Update Data in table TcssDonorSerologies
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorSerologies
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListSerologyQuestionId = @TcssListSerologyQuestionId,
	TcssListSerologyAnswerId = @TcssListSerologyAnswerId
WHERE
	TcssDonorSerologiesId = @TcssDonorSerologiesId
GO

GRANT EXEC ON TcssDonorSerologiesUpdate TO PUBLIC
GO
