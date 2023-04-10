

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'callSelect')
	BEGIN
		PRINT 'Dropping Procedure callSelect'
		DROP Procedure callSelect
	END
GO

PRINT 'Creating Procedure callSelect'
GO
CREATE Procedure callSelect
(
		@CallID int = null output
)
AS
/******************************************************************************
**	File: callSelect.sql
**	Name: callSelect
**	Desc: Selects multiple rows of call Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/14/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		call.CallID,
		call.CallNumber,
		call.CallTypeID,
		call.CallDateTime,
		call.StatEmployeeID,
		call.CallTotalTime,
		call.CallTempExclusive,
		call.Inactive,
		call.CallSeconds,
		call.LastModified,
		call.CallTemp,
		call.SourceCodeID,
		call.CallOpenByID,
		call.CallTempSavedByID,
		call.CallExtension,
		call.UpdatedFlag,
		call.CallOpenByWebPersonId,
		call.RecycleNCFlag,
		call.CallActive,
		call.CallSaveLastByID,
		call.AuditLogTypeID
	FROM 
		dbo.call 
	WHERE 
		call.CallID = ISNULL(@CallID, call.CallID)
	ORDER BY 1
GO

GRANT EXEC ON callSelect TO PUBLIC
GO
