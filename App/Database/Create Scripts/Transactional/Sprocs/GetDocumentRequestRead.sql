IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetDocumentRequestRead]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetDocumentRequestRead];
	PRINT 'Dropping Procedure: GetDocumentRequestRead';
END
	PRINT 'Creating Procedure: GetDocumentRequestRead'
GO

CREATE PROCEDURE [dbo].[GetDocumentRequestRead]

/******************************************************************************
**		File: GetDocumentRequestRead.sql
**		Name: GetDocumentRequestRead
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: Pam Scheichenost
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
SELECT 
	d.DocumentRequestQueueId, 
	d.CallId, DocumentSentById, 
	d.DocumentTo, 
	d.DocumentOrganization, 
	d.DocumentOrganizationId, 
	CASE
		WHEN LEN(d.faxNumber) <= 10 THEN '+1' + d.FaxNumber
		ELSE '+' + d.FaxNumber
	END as FaxNumber, 
	d.Email, 
	d.SubmitDate, 
	d.SentDate,
	d.JobId, 
	d.ConfirmedDate, 
	d.DmvId,
	d.DmvTable, 
	d.RegId, 
	d.FormName, 
	d.UserID, 
	d.LastModified, 
	d.DSNID,
	Coalesce(se.StatEmployeeFirstName + ' ', '') + Coalesce(se.StatEmployeeLastName,'') AS 'DocumentSentByName'
FROM DocumentRequestQueue  d
LEFT JOIN StatEmployee se ON d.DocumentSentById = se.StatEmployeeID
WHERE SentDate is null
ORDER BY SubmitDate ASC;
	


RETURN @@Error;
GO


    