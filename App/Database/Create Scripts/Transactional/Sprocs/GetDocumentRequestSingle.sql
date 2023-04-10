IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetDocumentRequestSingle]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetDocumentRequestSingle];
	PRINT 'Dropping Procedure: GetDocumentRequestSingle';
END
	PRINT 'Creating Procedure: GetDocumentRequestSingle'
GO

CREATE PROCEDURE [dbo].[GetDocumentRequestSingle]
(
	@JobID varchar(50)
)
/******************************************************************************
**		File: GetDocumentRequestSingle.sql
**		Name: GetDocumentRequestSingle
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: pls
**		Date: 08/2019
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		08/2019		pls     	initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  

	SELECT *,(SELECT StatEmployeeFirstName + ' ' + StatEmployeeLastName 
FROM StatEmployee 
where StatEmployeeID = DocumentRequestQueue.DocumentSentById) AS 'DocumentSentByName',
(SELECT stateid
FROM organization 
where DocumentRequestQueue.DocumentSentById = Organization.OrganizationID) AS 'stateID'
FROM DocumentRequestQueue
    WHERE JobID= @JobID;
	


	RETURN @@Error;
GO


  