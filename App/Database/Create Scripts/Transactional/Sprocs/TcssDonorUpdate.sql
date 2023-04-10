IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorUpdate'
		DROP Procedure TcssDonorUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorUpdate
(
	@TcssDonorId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@OptnNumber varchar(20) = null,
	@CallTakenBy varchar(20) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorUpdate
**	Desc: Update Data in table TcssDonor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonor
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	OptnNumber = @OptnNumber
WHERE
	TcssDonorId = @TcssDonorId
GO

GRANT EXEC ON TcssDonorUpdate TO PUBLIC
GO
