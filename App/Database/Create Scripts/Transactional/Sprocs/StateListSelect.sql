IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[StateListSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[StateListSelect]
	PRINT 'Dropping Procedure: StateListSelect'
END
	PRINT 'Creating Procedure: StateListSelect'
GO

CREATE PROCEDURE [dbo].[StateListSelect]
(
	@StateID int = NULL
)
/******************************************************************************
**		File: StateListSelect.sql
**		Name: StateListSelect
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		6/19/2009	bret		initial
**		7/14/2010	Bret		Update to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[StateID] AS ListId,
		[StateName] AS FieldValue
	
	FROM
		[State]	
	ORDER BY StateName

	RETURN @@Error
GO