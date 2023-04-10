PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:3/13/2017 2:55:34 PM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST217DataLossFix\App\Database\Create Scripts\Transactional\Sprocs\spi_DonorTracGetMDICallId.sql
-- C:\Statline\StatTrac\Development\CCRST217DataLossFix\App\Database\Create Scripts\Transactional\Sprocs\UpdateCall.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST217DataLossFix\App\Database\Create Scripts\Transactional\Sprocs\spi_DonorTracGetMDICallId.sql'
GO
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


GO
PRINT 'C:\Statline\StatTrac\Development\CCRST217DataLossFix\App\Database\Create Scripts\Transactional\Sprocs\UpdateCall.sql'
GO
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateCall')
	BEGIN
		PRINT 'Dropping Procedure UpdateCall'
		DROP  Procedure  UpdateCall
	END

GO

PRINT 'Creating Procedure UpdateCall'
GO
CREATE Procedure UpdateCall
	@CallID int = NULL , 
	@CallNumber varchar(15) = NULL , 
	@CallTypeID int = NULL , 
	@CallDateTime smalldatetime = NULL , 
	@StatEmployeeID smallint = NULL , 
	@CallTotalTime varchar(15) = NULL , 
	@CallTempExclusive smallint = NULL , 
	@Inactive smallint = NULL , 
	@CallSeconds smallint = NULL , 
	@CallTemp smallint = NULL , 
	@SourceCodeID int = NULL , 
	@CallOpenByID int = NULL , 
	@CallTempSavedByID int = NULL , 
	@CallExtension numeric = NULL , 
	@CallOpenByWebPersonId int = NULL , 
	@RecycleNCFlag smallint = NULL , 
	@CallActive smallint = NULL , 
	@CallSaveLastByID int,
	@AuditLogTypeID int = null,
	@CheckCallOpenByID INT = NULL -- SEE NOTE BELOW
AS
/******************************************************************************
**		File: 
**		Name: UpdateCall
**		Desc: Update a  call record into the call table
**
**              
**		Return values: returns the update call table row
** 
**		Called by:   
**			Statline.StatTrac.Data.Tables.CallDB.UpdateCall
**			StatTrac.ModStatSave.SaveCall
**			StatTrac.ModStatSave.SaveCallOpenBy
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		@CallID 	[int],
**		@StatEmployeeID int,
**		@SourceCodeID int,
**		@CallExtension int
**		@CallTypeID int,
**		@CallDateTime datetime,
**		@CallTotalTime varchar(50),
**		@CallSeconds   varchar(50),
**		@CallTemp int,
**		@CallOpenByID int,
**		@CallTempExclusive int,
**		@CallTempSavedByID int,
**		@RecycleNCFlag int,
**		@CallActive int,
**		@CallSaveLastByID int,
**		@CheckCallOpenByID is used to only update the record with the users number 
**							if the value is -1
**
**		Auth: Thien Ta
**		Date: 4/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		4/13/07			Thien Ta				initial    
**		04/05/07		Bret Knoll				8.4.3.8 Audit Call table 
**												add AuditLogTypeID
**												added LastModied Update
**		1/30/2017		Mike Berenson			Removed transactional/rollback logic
*******************************************************************************/

UPDATE 
	Call 
SET
	--CallNumber = ISNULL(@CallNumber, CallNumber), 
	CallTypeID = ISNULL(@CallTypeID, CallTypeID), 
	CallDateTime = ISNULL(@CallDateTime, CallDateTime), 
	StatEmployeeID = ISNULL(@StatEmployeeID, StatEmployeeID), 
	CallTotalTime = ISNULL(@CallTotalTime, CallTotalTime), 
	CallTempExclusive = ISNULL(@CallTempExclusive, CallTempExclusive), 
	Inactive = ISNULL(@Inactive, Inactive), 
	CallSeconds = ISNULL(@CallSeconds, CallSeconds), 
	LastModified = GetDate(),
	CallTemp = ISNULL(@CallTemp, CallTemp), 
	SourceCodeID = ISNULL(@SourceCodeID, SourceCodeID), 						 
	CallOpenByID =	ISNULL(@CallOpenByID, CallOpenByID),
	CallTempSavedByID = ISNULL(@CallTempSavedByID, CallTempSavedByID), 
	-- Only save initial value of Call Extension CallExtension = ISNULL(@CallExtension, CallExtension), 
	CallOpenByWebPersonId = ISNULL(@CallOpenByWebPersonId, CallOpenByWebPersonId), 
	RecycleNCFlag = ISNULL(@RecycleNCFlag, RecycleNCFlag), 
	CallActive = ISNULL(@CallActive, CallActive), 
	CallSaveLastByID = @CallSaveLastByID,
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE
	callID = @callID
AND
	CallOpenByID = ISNULL(@CheckCallOpenByID, CallOpenByID)

RETURN @@ERROR

GO

GRANT EXEC ON UpdateCall TO PUBLIC

GO
GO
