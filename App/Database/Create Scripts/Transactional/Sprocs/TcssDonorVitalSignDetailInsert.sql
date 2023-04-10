IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignDetailInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignDetailInsert'
		DROP Procedure TcssDonorVitalSignDetailInsert
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignDetailInsert'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignDetailInsert
(
	@TcssDonorVitalSignDetailId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssDonorVitalSignId int = null,
	@TcssListVitalSignId int = null,
	@Answer varchar(200) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignDetailInsert
**	Desc: Insert Data into table TcssDonorVitalSignDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorVitalSignDetail
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssDonorVitalSignId,
	TcssListVitalSignId,
	Answer
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssDonorVitalSignId,
	@TcssListVitalSignId,
	@Answer
)

-- Return the new identity value
SET @TcssDonorVitalSignDetailId = @@Identity

GO

GRANT EXEC ON TcssDonorVitalSignDetailInsert TO PUBLIC
GO
