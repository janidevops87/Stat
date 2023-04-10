IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorContactInformationDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorContactInformationDelete'
		DROP Procedure TcssDonorContactInformationDelete
	END
GO

PRINT 'Creating Procedure TcssDonorContactInformationDelete'
GO

CREATE PROCEDURE dbo.TcssDonorContactInformationDelete
(
	@TcssDonorContactInformationId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorContactInformationDelete
**	Desc: Delete Data from table TcssDonorContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorContactInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorContactInformationId = @TcssDonorContactInformationId

-- Delete The Record
DELETE FROM dbo.TcssDonorContactInformation
WHERE TcssDonorContactInformationId = @TcssDonorContactInformationId
GO

GRANT EXEC ON TcssDonorContactInformationDelete TO PUBLIC
GO
