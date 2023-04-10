IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_DonorTracGetMDICallId')
	BEGIN
		PRINT 'Dropping Procedure spi_DonorTracGetMDICallId'
		DROP  Procedure  spi_DonorTracGetMDICallId
	END
GO

PRINT 'Creating Procedure spi_DonorTracGetMDICallId'
GO

CREATE Procedure [dbo].[spi_DonorTracGetMDICallId]
(
			@vUserName as varchar(20),
			@vPassword as varchar(20)				
)
AS
/******************************************************************************
**	File: spi_DonorTracGetMDICallId.sql
**	Name: spi_DonorTracGetMDICallId
**	Desc: Inserts StatTrac call Id and returns referral number to DonorTrac 
**	Auth: Chris Carroll	
**	Date: 05/06/2014
**	Called By: DonorTrac: MDI Log 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	05/06/2014		Chris Carroll	Initial Sproc Creation
*******************************************************************************/

/* Declare default values */
DECLARE 
		@CallId int = -1, -- default value 
		@CallTypeID int = 1, --referral
		@CallDateTime smalldatetime = GetDate(),
		@StatEmployeeID smallint = null,
		@CallTotalTime varchar(15) = '00:00:00',
		@CallTempExclusive smallint = null,
		@Inactive smallint = null,
		@CallSeconds smallint = 0,
		@LastModified datetime = GetDate(),
		@CallTemp smallint = 0,
		@SourceCodeID int = null,
		@CallOpenByID int = null,
		@CallTempSavedByID int = null,
		@CallExtension numeric(5,0) = -1,
		@UpdatedFlag smallint = 0,
		@CallOpenByWebPersonId int = null,
		@RecycleNCFlag smallint = 2,
		@CallActive smallint = null,
		@CallSaveLastByID int = null,

		/* Declare constants */
		@Insert int = 1,
		@Delete int = 4,
		@ReferralType int = 1;

/* Get and Set user SourceCodeId and WebPersonId */
	   SELECT @SourceCodeId = sc.SourceCodeID,
			  @CallOpenByWebPersonId = w.WebPersonID  
	     FROM WebPerson w
			INNER JOIN Person p ON p.PersonID = w.PersonID
			INNER JOIN sourceCodeOrganization sco ON sco.OrganizationID = p.OrganizationID
			INNER JOIN SourceCode sc ON sc.SourceCodeID = sco.SourceCodeID
			WHERE PATINDEX(@vUserName, w.WebPersonUserName) > 0
			AND PATINDEX(@vPassword, w.WebPersonPassword) > 0
			AND sc.SourceCodeType = @ReferralType;

/* IF user has a valid Source Code for referral and
   if user credentials match, then allow user to get referral number for MDI
   if user is unable to validate or is not configured correctly in 
   StatTrac then return StatTacId = -1 */
IF  COALESCE(@SourceCodeId, 0) > 0
BEGIN
/* Insert Call with default values */
INSERT	dbo.Call
	(
		CallTypeID,
		CallDateTime,
		StatEmployeeID,
		CallTotalTime,
		CallTempExclusive,
		Inactive,
		CallSeconds,
		LastModified,
		CallTemp,
		SourceCodeID,
		CallOpenByID,
		CallTempSavedByID,
		CallExtension,
		UpdatedFlag,
		CallOpenByWebPersonId,
		RecycleNCFlag,
		CallActive,
		CallSaveLastByID,
		AuditLogTypeID
	)
VALUES
	(
		@CallTypeID,
		@CallDateTime,
		@StatEmployeeID,
		@CallTotalTime,
		@CallTempExclusive,
		@Inactive,
		@CallSeconds,
		@LastModified,
		@CallTemp,
		@SourceCodeID,
		@CallOpenByID,
		@CallTempSavedByID,
		@CallExtension,
		@UpdatedFlag,
		@CallOpenByWebPersonId,
		@RecycleNCFlag,
		@CallActive,
		@StatEmployeeID,
		@Insert 
	);

SET @CallId = SCOPE_IDENTITY();

	IF @CallId > 0
	BEGIN
		/* Update the record in Audit Trail to show the delete */
		UPDATE dbo.Call 
		SET CallNumber = CAST(@CallId AS varchar),
			LastModified = GetDate(),
			CallSaveLastByID = COALESCE(@CallSaveLastByID, @StatEmployeeID),
			AuditLogTypeID = @Delete
		WHERE CallID = @CallId;

		/* Delete the record */
		DELETE dbo.Call WHERE CallID = @CallId;
	END

END
/* return StatTacId possible values: 
   1. StatTracId > 0 :Pass
   2. StatTracId = -1 :Fail */

SELECT @CallId AS [StatTracId];

GO

