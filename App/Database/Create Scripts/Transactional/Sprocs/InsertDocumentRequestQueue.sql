IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertDocumentRequestQueue')
	BEGIN
		PRINT 'Dropping Procedure InsertDocumentRequestQueue'
		DROP  Procedure  InsertDocumentRequestQueue
	END

GO

PRINT 'Creating Procedure InsertDocumentRequestQueue'
GO
CREATE Procedure InsertDocumentRequestQueue
    @CallId int = NULL ,
    @DocumentSentById int = NULL ,
    @DocumentTo varchar(50) = NULL ,
    @DocumentOrganization varchar(50) = NULL ,
    @DocumentOrganizationId int = NULL ,
    @FaxNumber varchar(11) = NULL ,
	@Email varchar(100) = NULL ,
    @SubmitDate datetime = NULL ,
	@DmvId int = NULL,
	@RegId int = NULL,
	@FormName varchar(50) = NULL,
	@UserID int = NULL,
	@LastModified datetime = NULL,
	@DSNID smallint = NULL
AS

/******************************************************************************
**		File: InsertDocumentRequestQueue.sql
**		Name: InsertDocumentRequestQueue
**		Desc: 
**

**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List.
**
**		Auth: Robert Hudson
**		Date: 12/27/2019
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      12/27/2019	Robert Hudson		Initial sproc creation
*******************************************************************************/
INSERT
	DocumentRequestQueue
	(
    CallId,
    DocumentSentById,
    DocumentTo,
    DocumentOrganization,
    DocumentOrganizationId,
    FaxNumber,
	Email,
    SubmitDate,
	DmvId,
	RegId,
	FormName,
	UserID,
	LastModified,
	DSNID
	)
VALUES
	(		
    @CallId,
    @DocumentSentById,
    @DocumentTo,
    @DocumentOrganization,
    @DocumentOrganizationId,
    @FaxNumber,
	@Email,
    @SubmitDate,
	@DmvId,
	@RegId,
	@FormName,
	@UserID,
	@LastModified,
	@DSNID
	)

SELECT
    DocumentRequestQueueId,
    CallId,
    DocumentSentById,
    DocumentTo,
    DocumentOrganization,
    DocumentOrganizationId,
    FaxNumber,
    Email,
    SubmitDate,
    SentDate,
	JobId,
	ConfirmedDate,
	DeleteDate,
	DmvTable,
	DmvId,
	RegId,
	FormName,
	UserID,
	LastModified,
	DSNID
FROM
	DocumentRequestQueue
WHERE
	DocumentRequestQueueId = SCOPE_IDENTITY() 




GO

GRANT EXEC ON InsertDocumentRequestQueue TO PUBLIC

GO
