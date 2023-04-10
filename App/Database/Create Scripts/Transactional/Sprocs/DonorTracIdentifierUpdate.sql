IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracIdentifierUpdate')
	BEGIN
		PRINT 'Dropping Procedure DonorTracIdentifierUpdate'
		DROP Procedure DonorTracIdentifierUpdate
	END
GO

PRINT 'Creating Procedure DonorTracIdentifierUpdate'
GO
CREATE Procedure DonorTracIdentifierUpdate
(
		@DonorTracIdentifierID int = null output,
		@SourceCodeID int = null,
		@DonorTracIdentifier varchar(200) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: DonorTracIdentifierUpdate.sql
**	Name: DonorTracIdentifierUpdate
**	Desc: Updates DonorTracIdentifier Based on Id field 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.DonorTracIdentifier 	
SET 
		SourceCodeID = @SourceCodeID,
		DonorTracIdentifier = @DonorTracIdentifier,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	DonorTracIdentifierID = @DonorTracIdentifierID 				

GO

GRANT EXEC ON DonorTracIdentifierUpdate TO PUBLIC
GO
