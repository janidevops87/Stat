PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:12/10/2018 10:57:11 AM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Table\DataLoad\LogEventType.sql
-- C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Functions\fn_CreateReferralType.sql
-- C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Sprocs\GetLogEvent.sql
-- C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Sprocs\GetLogEventList.sql
-- C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Sprocs\sps_FSCaseWithSecondaryBilling.sql
-- C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Sprocs\UpdateCurrentReferralType.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Table\DataLoad\LogEventType.sql'
GO
/* ****************************************************************************************************
**	Name: LogEventType
**	Desc: Data Load for table LogEventType

****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date		Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/08/2011	ccarroll		Added events for Online Review
**  09/06/2011	ccarroll		Added events for Declared CTOD
**	06/13/2012	ccarroll		Add event for Case Hand Off
**	07/16/2014	ccarroll		Added events for Organ Med RO CCRST175
************************************************************************************************** */
SET NOCOUNT ON

DECLARE @EventTypeName AS NVARCHAR(50)
DECLARE @EventColor AS NVARCHAR(50)
DECLARE @Code AS NVARCHAR(50)

/* Add Online Review Pending */
SET @EventTypeName = 'Online Review Pending'
SET @EventColor = '205'
SET @Code = 'P'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Online Review Response */
SET @EventTypeName = 'Online Review Response'
SET @EventColor = '13444733'
SET @Code = 'O'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Declared CTOD Pending */
SET @EventTypeName = 'Declared CTOD Pending'
SET @EventColor = '205'
SET @Code = 'P'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Declared CTOD Confirmed */
SET @EventTypeName = 'Declared CTOD Confirmed'
SET @EventColor = '13444733'
SET @Code = 'O'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END


/* Add Case Handoff LogEventTypeId:47 */
SET @EventTypeName = 'Case Hand Off'
SET @EventColor = '0'
SET @Code = ''
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Organ Med RO Pending LogEventTypeId:48 */
SET @EventTypeName = 'Organ Med RO Pending'
SET @EventColor = '205'
SET @Code = 'P'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Organ Med RO Confirmed LogEventTypeId:49 */
SET @EventTypeName = 'Organ Med RO Confirmed'
SET @EventColor = '13444733'
SET @Code = 'O'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Functions\fn_CreateReferralType.sql'
GO
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'FN' AND name = 'fn_CreateReferralType')
	BEGIN
		PRINT 'Dropping Function fn_CreateReferralType';
		DROP Function fn_CreateReferralType;
	END
GO

PRINT 'Creating Function fn_CreateReferralType';
GO 

CREATE FUNCTION dbo.fn_CreateReferralType 
(
	@RecoveryId		INT,
	@ConsentId		INT,
	@AppropriateId	INT,
	@ApproachId		INT
)  
RETURNS BIT
AS
/******************************************************************************
**		File: 
**		Name: dbo.fn_CreateReferralType
**		Desc: 
**
**		This function determines whether a referral should be set to a new 
**		ReferralType based on recovery, consent, appropriate, and approach values.
** 
**		Called by:  
**      UpdateCurrentReferralType.sql (called by StatSave.UpdateCurrentReferralType)
**
**		Auth: Mike Berenson
**		Date: 12/4/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
BEGIN

	--Check Recovery
	IF @RecoveryId = 1
	BEGIN
		RETURN 1;
	END;

	--Check Consent
	IF @ConsentId = 1
	BEGIN
		RETURN 1;
	END;

	--Check Approach
	IF @ApproachId = 1
	BEGIN
		RETURN 1;
	END
	ELSE IF @ApproachId <> 1 AND @ApproachId <> -1
	BEGIN
		RETURN 0;
	END;

	--Check Appropriate
	IF @AppropriateId = 1
	BEGIN
		RETURN 1;
	END;

	RETURN 0;

END;
GO



GO
PRINT 'C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Sprocs\GetLogEvent.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetLogEventList')
	BEGIN
		PRINT 'Dropping Procedure GetLogEventList'
		DROP  Procedure  GetLogEventList
	END

GO

PRINT 'Creating Procedure GetLogEventList'
GO
CREATE Procedure GetLogEventList
	@CallID INT,
	@TimeZone VARCHAR(2),
	@ViewLogEventDeleted BIT = NULL
AS

/******************************************************************************
**		File: 
**		Name: GetLogEventList
**		Desc: Obtains the list of LogEvents
**
**              
**		Return values:
** 
**		Called by:   
**		 StatTrac.ModStatQuery.QueryOpenLogEvent
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret 
**		Date: Knoll
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		6/11/07		Bret Knoll			8.4.3.9 LogEvent Number
*******************************************************************************/

SELECT 
	LogEventID, 	
	DATEADD(
				hh, 
				dbo.fn_TimeZoneDifference(
											@TimeZone, 
											LogEventDateTime
										), 
				LogEventDateTime
			) AS LogEventDateTime, 
	LogEventTypeName, 
	LogEventName, 
	LogEventOrg,
	PersonFirst + ' ' + PersonLast,
	LogEventDesc,
	LogEventNumber,
	Code,	
	EventColor,
	LogEventCallBackPending
FROM 
	LogEvent 
LEFT JOIN 
	LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
JOIN 
	StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID 
JOIN 
	Person ON Person.PersonID = StatEmployee.PersonID 
WHERE 
	LogEvent.CallID = @CallID 
AND										--  0 = not deleted
										--  1 = deleted
	ISNULL(LogEvent.LogEventDeleted, 0) = CASE
									WHEN
										-- if @ViewLogEventDeleted  = 1
										ISNULL(@ViewLogEventDeleted , 0) = 1																THEN
										-- show all events deleted and not 
										LogEvent.LogEventDeleted
									ELSE
										-- otherwise only show
										0 -- DEFAULT NOT DELETED
								END		
ORDER BY 
	-- LogEventNumber ASC, -- sequence based on Date and time not LogEventNumber
	LogEventDateTime ASC,
	LogEventNumber ASC;

GO

GRANT EXEC ON GetLogEventList TO PUBLIC

GO

GO
PRINT 'C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Sprocs\GetLogEventList.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetLogEventList')
	BEGIN
		PRINT 'Dropping Procedure GetLogEventList'
		DROP  Procedure  GetLogEventList
	END

GO

PRINT 'Creating Procedure GetLogEventList'
GO
CREATE Procedure GetLogEventList
	@CallID INT,
	@TimeZone VARCHAR(2),
	@ViewLogEventDeleted BIT = NULL
AS

/******************************************************************************
**		File: 
**		Name: GetLogEventList
**		Desc: Obtains the list of LogEvents
**
**              
**		Return values:
** 
**		Called by:   
**		 StatTrac.ModStatQuery.QueryOpenLogEvent
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret 
**		Date: Knoll
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		6/11/07		Bret Knoll			8.4.3.9 LogEvent Number
*******************************************************************************/

SELECT 
	LogEventID, 	
	DATEADD(
				hh, 
				dbo.fn_TimeZoneDifference(
											@TimeZone, 
											LogEventDateTime
										), 
				LogEventDateTime
			) AS LogEventDateTime, 
	LogEventTypeName,                        
	LogEventName, 
	LogEventOrg,
	PersonFirst + ' ' + PersonLast,
	LogEventDesc,
	LogEventNumber,
	Code,	
	EventColor,
	LogEventCallBackPending
FROM 
	LogEvent 
LEFT JOIN 
	LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
JOIN 
	StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID 
JOIN 
	Person ON Person.PersonID = StatEmployee.PersonID 
WHERE 
	LogEvent.CallID = @CallID 
AND										--  0 = not deleted
										--  1 = deleted
	ISNULL(LogEvent.LogEventDeleted, 0) = CASE
									WHEN
										-- if @ViewLogEventDeleted  = 1
										ISNULL(@ViewLogEventDeleted , 0) = 1																THEN
										-- show all events deleted and not 
										LogEvent.LogEventDeleted
									ELSE
										-- otherwise only show
										0 -- DEFAULT NOT DELETED
								END		
ORDER BY 
	-- LogEventNumber ASC, -- sequence based on Date and time not LogEventNumber
	LogEventDateTime ASC,
	LogEventNumber ASC;

GO

GRANT EXEC ON GetLogEventList TO PUBLIC

GO

GO
PRINT 'C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Sprocs\sps_FSCaseWithSecondaryBilling.sql'
GO
if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSCaseWithSecondaryBilling]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
begin
	print 'drop procedure [dbo].[sps_FSCaseWithSecondaryBilling]';
	drop procedure [dbo].[sps_FSCaseWithSecondaryBilling];
end
GO
	print 'create procedure [dbo].[sps_FSCaseWithSecondaryBilling]';
GO




-- exec sps_FSCaseWithSecondaryBilling 1953974 , MT
CREATE PROCEDURE sps_FSCaseWithSecondaryBilling
		@CallId INT = 0,
		@vTZ	VARCHAR(2)

AS

/******************************************************************************
**		File: sps_FSCaseWithSecondaryBilling.sql
**		Name: sps_FSCaseWithSecondaryBilling
**		Desc: Loads FSCase and SecondaryBilling data
**
**              
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**
**		Auth: Mike Berenson
**		Date: 11/27/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/

DECLARE @TZ int;      

EXEC spf_TZDif @vTZ, @TZ OUTPUT;

SELECT	FSCaseId, 
	CallId, 
	FSCaseCreateUserId, 
	DATEADD(hh,@TZ,FSCaseCreateDateTime) as 'FSCaseCreateDateTime', 
	FSCaseOpenUserId, 
	DATEADD(hh,@TZ,FSCaseOpenDateTime) as 'FSCaseOpenDateTime',
	FSCaseSysEventsUserId, 
	DATEADD(hh,@TZ,FSCaseSysEventsDateTime) as 'FSCaseSysEventsDateTime', 
	FSCaseSecCompUserId, 
	DATEADD(hh,@TZ,FSCaseSecCompDateTime) as 'FSCaseSecCompDateTime', 
	FSCaseApproachUserId, 
	DATEADD(hh,@TZ,FSCaseApproachDateTime) as 'FSCaseApproachDateTime', 
	FSCaseFinalUserId, 
	DATEADD(hh,@TZ,FSCaseFinalDateTime) as 'FSCaseFinalDateTime', 
	FSCaseUpdate, 
	FSCaseUserId, 
	seo.StatEmployeeFirstName + ' ' + SUBSTRING(seo.StatEmployeeLastName,1,1) AS FSCaseOpenPerson,
	see.StatEmployeeFirstName + ' ' + SUBSTRING(see.StatEmployeeLastName,1,1) AS FSCaseSysEventsPerson,
	sec.StatEmployeeFirstName + ' ' + SUBSTRING(sec.StatEmployeeLastName,1,1) AS FSCaseSecCompPerson,
	sea.StatEmployeeFirstName + ' ' + SUBSTRING(sea.StatEmployeeLastName,1,1) AS FSCaseApproachedPerson,
	sef.StatEmployeeFirstName + ' ' + SUBSTRING(sef.StatEmployeeLastName,1,1) AS FSCaseFinalPerson,
	
	--Billing Fields
	FSCaseBillSecondaryUserId,	
	DATEADD(hh,@TZ,FSCaseBillDateTime) as 'FSCaseBillDateTime', 	
	FSCaseBillFamUnavailUserId, 								
	DATEADD(hh,@TZ,FSCaseBillFamUnavailDateTime) as 'FSCaseBillFamUnavailDateTime',
	FSCaseBillApproachUserId, 
	DATEADD(hh,@TZ,FSCaseBillApproachDateTime) as 'FSCaseBillApproachDateTime',
	FSCaseBillApproachCount,								
	FSCaseBillMedSocUserId, 
	DATEADD(hh,@TZ,FSCaseBillMedSocDateTime) as 'FSCaseBillMedSocDateTime',
	FSCaseBillMedSocCount,								
	FSCaseBillCryoFormUserId, 							
	DATEADD(hh,@TZ,FSCaseBillCryoFormDateTime) as 'FSCaseBillCryoFormDateTime',	
	FSCaseBillCryoFormCount,	
	sebs.StatEmployeeFirstName + ' ' + SUBSTRING(sebs.StatEmployeeLastName,1,1) AS FSCaseBillSecondaryPerson,
	sebf.StatEmployeeFirstName + ' ' + SUBSTRING(sebf.StatEmployeeLastName,1,1) AS FSCaseBillFamUnavailPerson,
	seba.StatEmployeeFirstName + ' ' + SUBSTRING(seba.StatEmployeeLastName,1,1) AS FSCaseBillApproachPerson,
	sebm.StatEmployeeFirstName + ' ' + SUBSTRING(sebm.StatEmployeeLastName,1,1) AS FSCaseBillMedSocPerson,
	sebc.StatEmployeeFirstName + ' ' + SUBSTRING(sebc.StatEmployeeLastName,1,1) AS FSCaseBillCryoFormPerson,
	sebo.StatEmployeeFirstName + ' ' + SUBSTRING(sebo.StatEmployeeLastName,1,1) AS FSCaseBillOTEPerson, 
	FSCaseBillOTEUserID,
	DATEADD(hh,@TZ,FSCaseBillOTEDateTime) as 'FSCaseBillOTEDateTime',
	FSCaseBillOTECount		

FROM 	FSCase
	LEFT JOIN statemployee seo ON seo.statemployeeid = fscase.FSCaseOpenUserId
	LEFT JOIN statemployee see ON see.statemployeeid = fscase.FSCaseSysEventsUserId
	LEFT JOIN statemployee sec ON sec.statemployeeid = fscase.FSCaseSecCompUserId
	LEFT JOIN statemployee sea ON sea.statemployeeid = fscase.FSCaseApproachUserId
	LEFT JOIN statemployee sef ON sef.statemployeeid = fscase.FSCaseFinalUserId
	LEFT JOIN statemployee sebs ON sebs.statemployeeid = fscase.FSCaseBillSecondaryUserId
	LEFT JOIN statemployee sebf ON sebf.statemployeeid = fscase.FSCaseBillFamUnavailUserId
	LEFT JOIN statemployee seba ON seba.statemployeeid = fscase.FSCaseBillApproachUserId
	LEFT JOIN statemployee sebm ON sebm.statemployeeid = fscase.FSCaseBillMedSocUserId
	LEFT JOIN statemployee sebc ON sebc.statemployeeid = fscase.FSCaseBillCryoFormUserId
	LEFT JOIN statemployee sebo ON sebo.statemployeeid = fscase.FSCaseBillOTEUserId
WHERE 	callid = @CallId;




GO

GO
PRINT 'C:\Statline\StatTrac\Development\CCRST289PerformanceIssuesAndBugs\App\Database\Create Scripts\Transactional\Sprocs\UpdateCurrentReferralType.sql'
GO
 IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'UpdateCurrentReferralType')
	BEGIN
		PRINT 'Dropping Procedure UpdateCurrentReferralType';
		DROP  Procedure  UpdateCurrentReferralType;
	END
GO

PRINT 'Creating Procedure UpdateCurrentReferralType';
GO

CREATE Procedure UpdateCurrentReferralType
	@CallID				INT,
	@ServiceLevelID		INT,
	@LastStatEmployeeID	INT
AS
/******************************************************************************
**		File: 
**		Name: UpdateCurrentReferralType
**		Desc: Update the referral record with the appropriate CurrentReferralType
**				duplicating functionality in StatValidate.ReferralTypeDefault 
**				(called by FrmReferral)
**              
**		Return values: returns the update call table row
** 
**		Called by:  StatSave.UpdateCurrentReferralType
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		@CallID 			[INT]
**		@ServiceLevelID		[INT]
**		@LastStatEmployeeID	[INT]
**
**		Auth: Mike Berenson
**		Date: 11/28/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/05/2018	Mike Berenson		Changed default referral type to ruleout
*******************************************************************************/

DECLARE	
	@ReferralOrganAppropriateID			INT,
	@ReferralOrganApproachID			INT,
	@ReferralOrganConsentID				INT,
	@ReferralOrganRecoveryID			INT,
	@ReferralBoneAppropriateID			INT,
	@ReferralBoneApproachID				INT,
	@ReferralBoneConsentID				INT,
	@ReferralBoneRecoveryID				INT,
	@ReferralTissueAppropriateID		INT,
	@ReferralTissueApproachID			INT,
	@ReferralTissueConsentID			INT,
	@ReferralTissueRecoveryID			INT,
	@ReferralSkinAppropriateID			INT,
	@ReferralSkinApproachID				INT,
	@ReferralSkinConsentID				INT,
	@ReferralSkinRecoveryID				INT,
	@ReferralValvesAppropriateID		INT,
	@ReferralValvesApproachID			INT,
	@ReferralValvesConsentID			INT,
	@ReferralValvesRecoveryID			INT,	
	@ReferralResearchAppropriateID		INT,
	@ReferralResearchApproachID			INT,
	@ReferralResearchConsentID			INT,
	@ReferralResearchRecoveryID			INT,
	@ReferralEyesAppropriateID			INT,
	@ReferralEyesApproachID				INT,
	@ReferralEyesConsentID				INT,
	@ReferralEyesRecoveryID				INT,	
	@ServiceLevelAppropriateOrganID		INT,
	@ServiceLevelAppropriateBoneID		INT,
	@ServiceLevelAppropriateTissueID	INT,
	@ServiceLevelAppropriateSkinID		INT,
	@ServiceLevelAppropriateValvesID	INT,
	@ServiceLevelAppropriateEyesID		INT,
	@CurrentReferralTypeIdOriginal		INT,
	@CurrentReferralTypeIdNew			INT = 4, --Ruleout
	@ReferralTypeEyeOnly				INT = 3,
	@ReferralTypeOrgan					INT = 7,
	@ReferralTypeTissue					INT = 8;

--Look up referral data
SELECT TOP (1)
	@ReferralOrganAppropriateID = ReferralOrganAppropriateID,
	@ReferralOrganApproachID = ReferralOrganApproachID,
	@ReferralOrganConsentID = ReferralOrganConsentID,
	@ReferralOrganRecoveryID = ReferralOrganConversionID,
	@ReferralBoneAppropriateID = ReferralBoneAppropriateID,
	@ReferralBoneApproachID = ReferralBoneApproachID,
	@ReferralBoneConsentID = ReferralBoneConsentID,
	@ReferralBoneRecoveryID = ReferralBoneConversionID,
	@ReferralTissueAppropriateID = ReferralTissueAppropriateID,
	@ReferralTissueApproachID = ReferralTissueApproachID,
	@ReferralTissueConsentID = ReferralTissueConsentID,
	@ReferralTissueRecoveryID = ReferralTissueConversionID,
	@ReferralSkinAppropriateID = ReferralSkinAppropriateID,
	@ReferralSkinApproachID = ReferralSkinApproachID,
	@ReferralSkinConsentID = ReferralSkinConsentID,
	@ReferralSkinRecoveryID = ReferralSkinConversionID,
	@ReferralValvesAppropriateID = ReferralValvesAppropriateID,
	@ReferralValvesApproachID = ReferralValvesApproachID,
	@ReferralValvesConsentID = ReferralValvesConsentID,
	@ReferralValvesRecoveryID = ReferralValvesConversionID,
	@ReferralEyesAppropriateID = ReferralEyesTransAppropriateID,
	@ReferralEyesApproachID = ReferralEyesTransApproachID,
	@ReferralEyesConsentID = ReferralEyesTransConsentID,
	@ReferralEyesRecoveryID = ReferralEyesTransConversionID,
	@ReferralResearchAppropriateID = ReferralEyesRschAppropriateID,
	@ReferralResearchApproachID = ReferralEyesRschApproachID,
	@ReferralResearchConsentID = ReferralEyesRschConsentID,
	@ReferralResearchRecoveryID = ReferralEyesRschConversionID,
	@CurrentReferralTypeIdOriginal = CurrentReferralTypeId
FROM Referral
WHERE CallID = @CallID;

--Look up service level data
SELECT TOP (1)
	@ServiceLevelAppropriateOrganID = ServiceLevelAppropriateOrgan,
	@ServiceLevelAppropriateBoneID = ServiceLevelAppropriateBone,
	@ServiceLevelAppropriateTissueID = ServiceLevelAppropriateTissue,
	@ServiceLevelAppropriateSkinID = ServiceLevelAppropriateSkin,
	@ServiceLevelAppropriateValvesID = ServiceLevelAppropriateValves,
	@ServiceLevelAppropriateEyesID = ServiceLevelAppropriateEyes
FROM ServiceLevel
WHERE ServiceLevelID = @ServiceLevelID;

--Make sure we have an appropriate service level value
IF (@ServiceLevelAppropriateOrganID = -1 OR @ServiceLevelAppropriateBoneID = -1 OR @ServiceLevelAppropriateTissueID = -1 OR @ServiceLevelAppropriateSkinID = -1 OR @ServiceLevelAppropriateValvesID = -1 OR @ServiceLevelAppropriateEyesID = -1)
BEGIN
	DECLARE @returnValue BIT;

	--Check Organ
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralOrganRecoveryID, @ConsentID = @ReferralOrganConsentID, @AppropriateId = @ReferralOrganAppropriateID, @ApproachId = @ReferralOrganApproachID;
	IF @returnValue = 1
	BEGIN
		SET @CurrentReferralTypeIdNew = @ReferralTypeOrgan;
	END

	--Check Tissue
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralTissueRecoveryID, @ConsentID = @ReferralTissueConsentID, @AppropriateId = @ReferralTissueAppropriateID, @ApproachId = @ReferralTissueApproachID;
	IF @returnValue = 1
	BEGIN
		SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
	END

	--Check Bone
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralBoneRecoveryID, @ConsentID = @ReferralBoneConsentID, @AppropriateId = @ReferralBoneAppropriateID, @ApproachId = @ReferralBoneApproachID;
		IF @returnValue = 1
		BEGIN
			SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
		END
	END

	--Check Skin
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralSkinRecoveryID, @ConsentID = @ReferralSkinConsentID, @AppropriateId = @ReferralSkinAppropriateID, @ApproachId = @ReferralSkinApproachID;
		IF @returnValue = 1
		BEGIN
			SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
		END
	END	
	
	--Check Valves
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralValvesRecoveryID, @ConsentID = @ReferralValvesConsentID, @AppropriateId = @ReferralValvesAppropriateID, @ApproachId = @ReferralValvesApproachID;
		IF @returnValue = 1
		BEGIN
			SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
		END
	END
	
	--Check Research
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralResearchRecoveryID, @ConsentID = @ReferralResearchConsentID, @AppropriateId = @ReferralResearchAppropriateID, @ApproachId = @ReferralResearchApproachID;
		IF @returnValue = 1
		BEGIN
			SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
		END
	END
	
	--Check Eyes
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralEyesRecoveryID, @ConsentID = @ReferralEyesConsentID, @AppropriateId = @ReferralEyesAppropriateID, @ApproachId = @ReferralEyesApproachID;
	IF @returnValue = 1
	BEGIN
		SET @CurrentReferralTypeIdNew = @ReferralTypeEyeOnly;
	END	

END

--Save New CurrentReferralTypeID If There Was A Change
IF @CurrentReferralTypeIdNew <> @CurrentReferralTypeIdOriginal
BEGIN

	UPDATE Referral 
	SET CurrentReferralTypeID = @CurrentReferralTypeIdNew,
		LastModified = GETDATE(),
		LastStatEmployeeID = @LastStatEmployeeID		
	WHERE CallID = @callID;

	RETURN @@ERROR;
END
ELSE
BEGIN
	RETURN 1;
END

GO

GRANT EXEC ON UpdateCurrentReferralType TO PUBLIC;
GO
GO
