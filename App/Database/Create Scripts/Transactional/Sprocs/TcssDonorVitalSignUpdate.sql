IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignUpdate'
		DROP Procedure TcssDonorVitalSignUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignUpdate
(
	@TcssDonorVitalSignId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@FromDateTime smalldatetime = null,
	@ToDateTime smalldatetime = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignUpdate
**	Desc: Update Data in table TcssDonorVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorVitalSign
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	FromDateTime = @FromDateTime,
	ToDateTime = @ToDateTime
WHERE
	TcssDonorVitalSignId = @TcssDonorVitalSignId
GO

GRANT EXEC ON TcssDonorVitalSignUpdate TO PUBLIC
GO
