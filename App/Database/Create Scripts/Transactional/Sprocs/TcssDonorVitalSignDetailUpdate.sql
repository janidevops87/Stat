IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignDetailUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignDetailUpdate'
		DROP Procedure TcssDonorVitalSignDetailUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignDetailUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignDetailUpdate
(
	@TcssDonorVitalSignDetailId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssDonorVitalSignId int = null,
	@TcssListVitalSignId int = null,
	@Answer varchar(200) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignDetailUpdate
**	Desc: Update Data in table TcssDonorVitalSignDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorVitalSignDetail
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssDonorVitalSignId = @TcssDonorVitalSignId,
	TcssListVitalSignId = @TcssListVitalSignId,
	Answer = @Answer
WHERE
	TcssDonorVitalSignDetailId = @TcssDonorVitalSignDetailId
GO

GRANT EXEC ON TcssDonorVitalSignDetailUpdate TO PUBLIC
GO
