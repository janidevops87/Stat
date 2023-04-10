IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracURLSelect')
	BEGIN
		PRINT 'Dropping Procedure DonorTracURLSelect'
		DROP Procedure DonorTracURLSelect
	END
GO

PRINT 'Creating Procedure DonorTracURLSelect'
GO
CREATE Procedure DonorTracURLSelect
(
		@DonorTracURLID int = null output,
		@SourceCodeID int = null					
)
AS
/******************************************************************************
**	File: DonorTracURLSelect.sql
**	Name: DonorTracURLSelect
**	Desc: Selects multiple rows of DonorTracURL Based on Id  fields 
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
		DonorTracURL.DonorTracURLID,
		DonorTracURL.DonorTracProductionURL,
		DonorTracURL.SourceCode,
		DonorTracURL.SourceCodeID,
		DonorTracURL.LastModified,
		DonorTracURL.LastStatEmployeeID,
		DonorTracURL.AuditLogTypeID
	FROM 
		dbo.DonorTracURL 
	WHERE 
		DonorTracURL.DonorTracURLID = ISNULL(@DonorTracURLID, DonorTracURL.DonorTracURLID)
	AND
		DonorTracURL.SourceCodeID = ISNULL(@SourceCodeID, DonorTracURL.SourceCodeID)				
	ORDER BY 1
GO

GRANT EXEC ON DonorTracURLSelect TO PUBLIC
GO
