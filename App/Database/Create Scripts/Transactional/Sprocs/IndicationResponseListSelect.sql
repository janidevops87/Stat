

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IndicationResponseListSelect')
	BEGIN
		PRINT 'Dropping Procedure IndicationResponseListSelect'
		DROP Procedure IndicationResponseListSelect
	END
GO

PRINT 'Creating Procedure IndicationResponseListSelect'
GO
CREATE Procedure IndicationResponseListSelect
(
		@IndicationResponseID int = null output					
)
AS
/******************************************************************************
**	File: IndicationResponseListSelect.sql
**	Name: IndicationResponseListSelect
**	Desc: Selects multiple rows of IndicationResponse Based on Id  fields 
**	Auth: ccarroll
**	Date: 11/20/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/20/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
If IsNull(@IndicationResponseID, 0) = 0
BEGIN
	SET @IndicationResponseID = Null
END


	SELECT
		IndicationResponse.IndicationResponseID AS ListId,
		IndicationResponse.IndicationResponseName AS FieldValue
	FROM 
		dbo.IndicationResponse 
	WHERE 
		IndicationResponse.IndicationResponseID = ISNULL(@IndicationResponseID, IndicationResponse.IndicationResponseID)				
	ORDER BY 1
GO

GRANT EXEC ON IndicationResponseListSelect TO PUBLIC
GO
