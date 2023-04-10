

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectAlert')
	BEGIN
		PRINT 'Dropping Procedure SelectAlert'
		PRINT GETDATE()
		DROP Procedure SelectAlert
	END
GO

PRINT 'Creating Procedure SelectAlert'
PRINT GETDATE()
GO
CREATE Procedure SelectAlert
(
		@AlertID int = null output,
		@AlertTypeID int = null					
)
AS
/******************************************************************************
**	File: SelectAlert.sql
**	Name: SelectAlert
**	Desc: Selects multiple rows of Alert Based on Id  fields 
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
		Alert.AlertID,
		Alert.AlertGroupName,
		Alert.AlertMessage1,
		Alert.AlertMessage2,
		Alert.LastModified,
		Alert.AlertTypeID,
		Alert.AlertLookupCode,
		Alert.AlertScheduleMessage,
		Alert.UpdatedFlag,
		Alert.AlertQAMessage1,
		Alert.AlertQAMessage2
	FROM 
		dbo.Alert 
	WHERE 
		Alert.AlertID = ISNULL(@AlertID, Alert.AlertID)
	AND
		Alert.AlertTypeID = ISNULL(@AlertTypeID, Alert.AlertTypeID)				

GO

GRANT EXEC ON SelectAlert TO PUBLIC
GO
