

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TimeZoneSelect')
	BEGIN
		PRINT 'Dropping Procedure TimeZoneSelect'
		DROP Procedure TimeZoneSelect
	END
GO

PRINT 'Creating Procedure TimeZoneSelect'
GO
CREATE Procedure TimeZoneSelect
(
		@TimeZoneID int = null output					
)
AS
/******************************************************************************
**	File: TimeZoneSelect.sql
**	Name: TimeZoneSelect
**	Desc: Selects multiple rows of TimeZone Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 11/29/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/29/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		TimeZone.TimeZoneID,
		TimeZone.TimeZoneName,
		TimeZone.TimeZoneAbbreviation,
		TimeZone.ObservesDaylightSavings,
		TimeZone.DayLightSavingsStartTime,
		TimeZone.LastModified,
		TimeZone.LastStatEmployeeId,
		TimeZone.AuditLogTypeId
	FROM 
		dbo.TimeZone 

	WHERE 
		TimeZone.TimeZoneID = ISNULL(@TimeZoneID, TimeZone.TimeZoneID)				
	ORDER BY 1
GO

GRANT EXEC ON TimeZoneSelect TO PUBLIC
GO
