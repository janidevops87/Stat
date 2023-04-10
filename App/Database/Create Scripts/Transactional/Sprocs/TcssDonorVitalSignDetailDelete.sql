IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignDetailDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignDetailDelete'
		DROP Procedure TcssDonorVitalSignDetailDelete
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignDetailDelete'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignDetailDelete
(
	@TcssDonorVitalSignDetailId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignDetailDelete
**	Desc: Delete Data from table TcssDonorVitalSignDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorVitalSignDetail
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorVitalSignDetailId = @TcssDonorVitalSignDetailId

-- Delete The Record
DELETE FROM dbo.TcssDonorVitalSignDetail
WHERE TcssDonorVitalSignDetailId = @TcssDonorVitalSignDetailId
GO

GRANT EXEC ON TcssDonorVitalSignDetailDelete TO PUBLIC
GO
