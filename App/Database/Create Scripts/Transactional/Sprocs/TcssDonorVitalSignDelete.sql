IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignDelete'
		DROP Procedure TcssDonorVitalSignDelete
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignDelete'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignDelete
(
	@TcssDonorVitalSignId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignDelete
**	Desc: Delete Data from table TcssDonorVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

---- Flag the User and time the record is being delete
--UPDATE dbo.TcssDonorVitalSignDetail
--SET
--	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
--	LastUpdateDate = GetUtcDate()
--WHERE TcssDonorVitalSignId = @TcssDonorVitalSignId

---- Delete The Record
--DELETE FROM dbo.TcssDonorVitalSignDetail
--WHERE TcssDonorVitalSignId = @TcssDonorVitalSignId

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorVitalSign
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorVitalSignId = @TcssDonorVitalSignId

-- Delete The Record
DELETE FROM dbo.TcssDonorVitalSign
WHERE TcssDonorVitalSignId = @TcssDonorVitalSignId
GO

GRANT EXEC ON TcssDonorVitalSignDelete TO PUBLIC
GO
