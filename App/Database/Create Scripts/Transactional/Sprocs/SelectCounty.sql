

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectCounty')
	BEGIN
		PRINT 'Dropping Procedure SelectCounty'
		PRINT GETDATE()
		DROP Procedure SelectCounty
	END
GO

PRINT 'Creating Procedure SelectCounty'
PRINT GETDATE()
GO
CREATE Procedure SelectCounty
(
		@CountyID int = null output,
		@StateID int = null					
)
AS
/******************************************************************************
**	File: SelectCounty.sql
**	Name: SelectCounty
**	Desc: Selects multiple rows of County Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		County.CountyID,
		County.CountyName,
		County.StateID,
		County.Verified,
		County.Inactive,
		County.LastModified,
		County.UpdatedFlag
	FROM 
		dbo.County 
	WHERE 
		County.CountyID = ISNULL(@CountyID, County.CountyID)
	AND
		County.StateID = ISNULL(@StateID, County.StateID)				

GO

GRANT EXEC ON SelectCounty TO PUBLIC
GO
