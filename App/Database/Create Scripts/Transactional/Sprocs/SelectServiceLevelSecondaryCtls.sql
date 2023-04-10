

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectServiceLevelSecondaryCtls')
	BEGIN
		PRINT 'Dropping Procedure SelectServiceLevelSecondaryCtls';
		PRINT GETDATE();
		DROP Procedure SelectServiceLevelSecondaryCtls;
	END
GO

PRINT 'Creating Procedure SelectServiceLevelSecondaryCtls';
PRINT GETDATE();
GO
CREATE Procedure SelectServiceLevelSecondaryCtls
(
		@ServiceLevelSecondaryCtlsID int = null output,
		@ServiceLevelID int = null
)
AS
/******************************************************************************
**	File: SelectServiceLevelSecondaryCtls.sql
**	Name: SelectServiceLevelSecondaryCtls
**	Desc: Selects multiple rows of ServiceLevelSecondaryCtls Based on Id  fields 
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
		ServiceLevelSecondaryCtls.ServiceLevelSecondaryCtlsID,
		ServiceLevelSecondaryCtls.ServiceLevelID,
		ServiceLevelSecondaryCtls.ParentID,
		ServiceLevelSecondaryCtls.ControlName,
		ServiceLevelSecondaryCtls.DisplayName,
		ServiceLevelSecondaryCtls.DisplayOrder,
		ServiceLevelSecondaryCtls.Visible,
		ServiceLevelSecondaryCtls.X,
		ServiceLevelSecondaryCtls.Y,
		ServiceLevelSecondaryCtls.Height,
		ServiceLevelSecondaryCtls.LeftPos,
		ServiceLevelSecondaryCtls.MaxChar
	FROM 
		dbo.ServiceLevelSecondaryCtls 
	WHERE 
		(
			@ServiceLevelSecondaryCtlsID IS NULL OR ServiceLevelSecondaryCtls.ServiceLevelSecondaryCtlsID = @ServiceLevelSecondaryCtlsID
		)
	AND
		(
			@ServiceLevelID IS NULL OR ServiceLevelSecondaryCtls.ServiceLevelID = @ServiceLevelID
		)
	ORDER BY parentid, displayorder ASC;
	
GO

GRANT EXEC ON SelectServiceLevelSecondaryCtls TO PUBLIC;
GO
