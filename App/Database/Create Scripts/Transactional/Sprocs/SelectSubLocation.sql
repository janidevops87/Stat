

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectSubLocation')
	BEGIN
		PRINT 'Dropping Procedure SelectSubLocation'
		PRINT GETDATE()
		DROP Procedure SelectSubLocation
	END
GO

PRINT 'Creating Procedure SelectSubLocation'
PRINT GETDATE()
GO
CREATE Procedure SelectSubLocation
(
		@SubLocationID int = null output					
)
AS
/******************************************************************************
**	File: SelectSubLocation.sql
**	Name: SelectSubLocation
**	Desc: Selects multiple rows of SubLocation Based on Id  fields 
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
		SubLocation.SubLocationID,
		SubLocation.SubLocationName,
		SubLocation.Verified,
		SubLocation.Inactive,
		SubLocation.LastModified,
		SubLocation.UpdatedFlag
	FROM 
		dbo.SubLocation 

	WHERE 
		SubLocation.SubLocationID = ISNULL(@SubLocationID, SubLocation.SubLocationID)				

GO

GRANT EXEC ON SelectSubLocation TO PUBLIC
GO
