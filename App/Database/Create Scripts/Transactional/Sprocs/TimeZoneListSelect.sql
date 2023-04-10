IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[TimeZoneListSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[TimeZoneListSelect]
	PRINT 'Dropping Procedure: TimeZoneListSelect'
END
	PRINT 'Creating Procedure: TimeZoneListSelect'
GO

CREATE PROCEDURE [dbo].[TimeZoneListSelect]
(
	@TimeZoneID int = NULL,
	@LastStatEmployeeId int = NULL,
	@AuditLogTypeId int = NULL
)
/******************************************************************************
**		File: TimeZoneListSelect.sql
**		Name: TimeZoneListSelect
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 7/6/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/6/2009	bret	initial
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[TimeZoneID] AS ListId,
		[TimeZoneName] AS FieldValue
	
	FROM
			[TimeZone]	


	RETURN @@Error
GO
 