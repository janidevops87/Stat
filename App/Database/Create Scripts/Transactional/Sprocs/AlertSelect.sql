

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AlertSelect')
	BEGIN
		PRINT 'Dropping Procedure AlertSelect'
		DROP Procedure AlertSelect
	END
GO

PRINT 'Creating Procedure AlertSelect'
GO
CREATE Procedure AlertSelect
(
		@AlertID int = null 				
)
AS
/******************************************************************************
**	File: AlertSelect.sql
**	Name: AlertSelect
**	Desc: Selects multiple rows of Alert Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
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
	ORDER BY 1
GO

GRANT EXEC ON AlertSelect TO PUBLIC
GO
