

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IndicationResponseSelect')
	BEGIN
		PRINT 'Dropping Procedure IndicationResponseSelect'
		DROP Procedure IndicationResponseSelect
	END
GO

PRINT 'Creating Procedure IndicationResponseSelect'
GO
CREATE Procedure IndicationResponseSelect
(
		@IndicationResponseID int = null output					
)
AS
/******************************************************************************
**	File: IndicationResponseSelect.sql
**	Name: IndicationResponseSelect
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

	SELECT
		IndicationResponse.IndicationResponseID,
		IndicationResponse.IndicationResponseName,
		IndicationResponse.LastModified,
		IndicationResponse.LastStatEmployeeID,
		IndicationResponse.AuditLogTypeID
	FROM 
		dbo.IndicationResponse 

	WHERE 
		IndicationResponse.IndicationResponseID = ISNULL(@IndicationResponseID, IndicationResponse.IndicationResponseID)				
	ORDER BY 1
GO

GRANT EXEC ON IndicationResponseSelect TO PUBLIC
GO
