IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorToRecipientDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorToRecipientDelete'
		DROP Procedure TcssDonorToRecipientDelete
	END
GO

PRINT 'Creating Procedure TcssDonorToRecipientDelete'
GO

CREATE PROCEDURE dbo.TcssDonorToRecipientDelete
(
	@TcssDonorToRecipientId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorToRecipientDelete
**	Desc: Delete Data from table TcssDonorToRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorToRecipient
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorToRecipientId = @TcssDonorToRecipientId

-- Delete The Record
DELETE FROM dbo.TcssDonorToRecipient
WHERE TcssDonorToRecipientId = @TcssDonorToRecipientId
GO

GRANT EXEC ON TcssDonorToRecipientDelete TO PUBLIC
GO
