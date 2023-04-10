IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracIdentifierSelect')
	BEGIN
		PRINT 'Dropping Procedure DonorTracIdentifierSelect'
		DROP Procedure DonorTracIdentifierSelect
	END
GO

PRINT 'Creating Procedure DonorTracIdentifierSelect'
GO
CREATE Procedure DonorTracIdentifierSelect
(
		@DonorTracIdentifierID int = null output,
		@SourceCodeID int = null,
		@DonorTracIdentifier varchar(200) = null					
)
AS
/******************************************************************************
**	File: DonorTracIdentifierSelect.sql
**	Name: DonorTracIdentifierSelect
**	Desc: Selects multiple rows of DonorTracIdentifier Based on Id  fields 
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
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DonorTracIdentifier.DonorTracIdentifierID,
		DonorTracIdentifier.SourceCodeID,
		DonorTracIdentifier.DonorTracIdentifier,
		DonorTracIdentifier.LastModified,
		DonorTracIdentifier.LastStatEmployeeID,
		DonorTracIdentifier.AuditLogTypeID
	FROM 
		dbo.DonorTracIdentifier 
	WHERE 
		DonorTracIdentifier.DonorTracIdentifierID = ISNULL(@DonorTracIdentifierID, DonorTracIdentifier.DonorTracIdentifierID)
	AND
		DonorTracIdentifier.SourceCodeID = ISNULL(@SourceCodeID, DonorTracIdentifier.SourceCodeID)
	AND
		DonorTracIdentifier.DonorTracIdentifier = ISNULL(@DonorTracIdentifier, DonorTracIdentifier.DonorTracIdentifier)				
	ORDER BY 1
GO

GRANT EXEC ON DonorTracIdentifierSelect TO PUBLIC
GO
