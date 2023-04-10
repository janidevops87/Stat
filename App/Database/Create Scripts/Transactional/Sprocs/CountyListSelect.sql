 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[CountyListSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[CountyListSelect]
	PRINT 'Dropping Procedure: CountyListSelect'
END
	PRINT 'Creating Procedure: CountyListSelect'
GO

CREATE PROCEDURE [dbo].[CountyListSelect]
	@stateID int = null

/******************************************************************************
**		File: CountyListSelect.sql
**		Name: CountyListSelect
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
**		7/6/2009	bret		initial
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[CountyID] AS ListId,
		[CountyName] AS FieldValue
	
	FROM
		[County]	
	WHERE StateID = ISNULL(@stateID, StateID)
	ORDER BY 2


	RETURN @@Error
GO
