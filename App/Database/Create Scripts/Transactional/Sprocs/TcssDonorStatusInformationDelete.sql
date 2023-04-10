IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorStatusInformationDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorStatusInformationDelete'
		DROP Procedure TcssDonorStatusInformationDelete
	END
GO

PRINT 'Creating Procedure TcssDonorStatusInformationDelete'
GO

CREATE PROCEDURE dbo.TcssDonorStatusInformationDelete
(
	@TcssDonorStatusInformationId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorStatusInformationDelete
**	Desc: Delete Data from table TcssDonorStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorStatusInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorStatusInformationId = @TcssDonorStatusInformationId

-- Delete The Record
DELETE FROM dbo.TcssDonorStatusInformation
WHERE TcssDonorStatusInformationId = @TcssDonorStatusInformationId
GO

GRANT EXEC ON TcssDonorStatusInformationDelete TO PUBLIC
GO
