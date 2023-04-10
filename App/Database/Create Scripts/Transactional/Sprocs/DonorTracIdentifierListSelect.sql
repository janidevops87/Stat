 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracIdentifierListSelect')
	BEGIN
		PRINT 'Dropping Procedure DonorTracIdentifierListSelect'
		DROP Procedure DonorTracIdentifierListSelect
	END
GO

PRINT 'Creating Procedure DonorTracIdentifierListSelect'
GO
CREATE Procedure DonorTracIdentifierListSelect
(
		@SourceCodeID int = null
)
AS
/******************************************************************************
**	File: DonorTracIdentifierListSelect.sql
**	Name: DonorTracIdentifierListSelect
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
		DonorTracIdentifier.DonorTracIdentifierID AS ListId,
		DonorTracIdentifier.DonorTracIdentifier AS FieldValue
	FROM 
		dbo.DonorTracIdentifier 
	WHERE 
		DonorTracIdentifier.SourceCodeID = ISNULL(@SourceCodeID, DonorTracIdentifier.SourceCodeID)
	ORDER BY 2
GO

GRANT EXEC ON DonorTracIdentifierListSelect TO PUBLIC
GO
