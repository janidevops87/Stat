IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetEventRegistry]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetEventRegistry]
	PRINT 'Dropping Procedure: GetEventRegistry'
END
	PRINT 'Creating Procedure: GetEventRegistry'
GO

CREATE PROCEDURE [dbo].[GetEventRegistry]
(
	@RegistryID int = NULL
)
/******************************************************************************
**		File: GetEventRegistry.sql
**		Name: GetEventRegistry
**		Desc:  National Web Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/19/2009	ccarroll	initial
**		06/01/2009	ccarroll	Added EventCategoryID, EventSubCategoryID to IsNull lines 
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[EventRegistryID],
		[RegistryID],
		IsNull([EventCategoryID], 0) AS 'EventCategoryID',
		IsNull([EventSubCategoryID], 0) AS 'EventSubCategoryID',
		[EventCategorySpecifyText],
		[EventSubCategorySpecifyText],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[EventRegistry]
	WHERE 
		[RegistryID] = @RegistryID


	RETURN @@Error
GO

