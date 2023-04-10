IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorLogHowIdentified]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorLogHowIdentified]
	PRINT 'Dropping Procedure: GetQAErrorLogHowIdentified'
END
	PRINT 'Creating Procedure: GetQAErrorLogHowIdentified'
GO

CREATE PROCEDURE [dbo].[GetQAErrorLogHowIdentified]

/******************************************************************************
**		File: GetQAErrorLogHowIdentified.sql
**		Name: GetQAErrorLogHowIdentified
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
**      02/09       jth         should use no parms
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[QAErrorLogHowIdentifiedID],
		[QAErrorLogHowIdentifiedDescription]
	
	FROM
			[QAErrorLogHowIdentified]



	RETURN @@Error
GO

