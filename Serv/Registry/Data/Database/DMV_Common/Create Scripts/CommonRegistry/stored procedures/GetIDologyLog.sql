IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetIDologyLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetIDologyLog]
	PRINT 'Dropping Procedure: GetIDologyLog'
END
	PRINT 'Creating Procedure: GetIDologyLog'
GO

CREATE PROCEDURE [dbo].[GetIDologyLog]
(
	@RegistryID int = NULL
)
/******************************************************************************
**		File: GetIDologyLog.sql
**		Name: GetIDologyLog
**		Desc:  common Web Registry
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
**		03/02/2009	ccarroll	initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[IDologyLogID],
		[RegistryID],
		[IDologyLogNumberID],
		[IDologyLogResponse],
		[CreateDate],
		[LastModified]
	
	FROM
			[IDologyLog]
	WHERE 
		[RegistryID] = @RegistryID


	RETURN @@Error
GO

