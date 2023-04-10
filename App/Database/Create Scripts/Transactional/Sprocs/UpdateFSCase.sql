IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateFSCase')
	BEGIN
		PRINT 'Dropping Procedure UpdateFSCase'
		DROP  Procedure  UpdateFSCase
	END

GO

PRINT 'Creating Procedure UpdateFSCase'
GO
CREATE Procedure UpdateFSCase
    @FSCaseId int = NULL , 
    @CallId int = NULL , 
    @FSCaseCreateUserId int = NULL , 
    @FSCaseCreateDateTime datetime = NULL , 
    @FSCaseOpenUserId int = NULL , 
    @FSCaseOpenDateTime datetime = NULL , 
    @FSCaseSysEventsUserId int = NULL , 
    @FSCaseSysEventsDateTime datetime = NULL , 
    @FSCaseSecCompUserId int = NULL , 
    @FSCaseSecCompDateTime datetime = NULL , 
    @FSCaseApproachUserId int = NULL , 
    @FSCaseApproachDateTime datetime = NULL , 
    @FSCaseFinalUserId int = NULL , 
    @FSCaseFinalDateTime datetime = NULL , 
    @FSCaseUpdate datetime = NULL , 
    @FSCaseUserId int = NULL , 
    @FSCaseBillSecondaryUserID int = NULL , 
    @FSCaseBillDateTime datetime = NULL , 
    @FSCaseBillApproachUserID int = NULL , 
    @FSCaseBillApproachDateTime datetime = NULL , 
    @FSCaseBillMedSocUserID int = NULL , 
    @FSCaseBillMedSocDateTime datetime = NULL , 
    @SecondaryManualBillPersonId int = NULL , 
    @SecondaryUpdatedFlag smallint = NULL , 
    @FSCaseTotalTime varchar(15) = NULL , 
    @FSCaseSeconds int = NULL , 
    @FSCaseBillFamUnavailUserId int = NULL , 
    @FSCaseBillFamUnavailDateTime datetime = NULL , 
    @FSCaseBillCryoFormUserId int = NULL , 
    @FSCaseBillCryoFormDateTime datetime = NULL , 
    @FSCaseBillApproachCount smallint = NULL , 
    @FSCaseBillMedSocCount smallint = NULL , 
    @FSCaseBillCryoFormCount smallint = NULL , 
    @FSCaseBillOTEPerson varchar(50) = NULL , 
    @FSCaseBillOTEUserID smallint = NULL , 
    @FSCaseBillOTEDateTime datetime = NULL , 
    @FSCaseBillOTECount smallint = NULL , 
    @LastStatEmployeeID int = NULL , 
    @AuditLogTypeID int = NULL ,
    @timeZone varchar(2) 
AS

/******************************************************************************
**		File: UpdateFSCase.sql
**		Name: UpdateFSCase
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
**		See List
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail 
*******************************************************************************/

UPDATE
	FSCase
SET
	FSCaseCreateUserId = ISNULL(@FSCaseCreateUserId, FSCaseCreateUserId), 
	FSCaseCreateDateTime = ISNULL
							(
								DATEADD
									(
										hh,
										-dbo.fn_TimeZoneDifference
											(
												@timeZone,
												@FSCaseCreateDateTime				
											),
										@FSCaseCreateDateTime
									), 									
								FSCaseCreateDateTime
							), 
	FSCaseOpenUserId = ISNULL(@FSCaseOpenUserId, FSCaseOpenUserId), 
	FSCaseOpenDateTime = ISNULL
							(
								DATEADD
									(
										hh,
										-dbo.fn_TimeZoneDifference
											(
												@timeZone,
												@FSCaseOpenDateTime				
											),
										@FSCaseOpenDateTime
									)									, 
								FSCaseOpenDateTime
							), 
	FSCaseSysEventsUserId = ISNULL(@FSCaseSysEventsUserId, FSCaseSysEventsUserId), 
	FSCaseSysEventsDateTime = ISNULL
								(
									DATEADD
									(
										hh,
										-dbo.fn_TimeZoneDifference
											(
												@timeZone,
												@FSCaseSysEventsDateTime			
											),
										@FSCaseSysEventsDateTime
									), 
									FSCaseSysEventsDateTime
								), 
	FSCaseSecCompUserId = ISNULL(@FSCaseSecCompUserId, FSCaseSecCompUserId), 
	FSCaseSecCompDateTime = ISNULL
								(
									DATEADD
									(
										hh,
										-dbo.fn_TimeZoneDifference
											(
												@timeZone,
												@FSCaseSecCompDateTime			
											),
										@FSCaseSecCompDateTime
									),  
									FSCaseSecCompDateTime
								), 
	FSCaseApproachUserId = ISNULL(@FSCaseApproachUserId, FSCaseApproachUserId), 
	FSCaseApproachDateTime = ISNULL
								(
									DATEADD
									(
										hh,
										-dbo.fn_TimeZoneDifference
											(
												@timeZone,
												@FSCaseApproachDateTime			
											),
										@FSCaseApproachDateTime
									), 
									FSCaseApproachDateTime
								), 
	FSCaseFinalUserId = ISNULL(@FSCaseFinalUserId, FSCaseFinalUserId), 
	FSCaseFinalDateTime = ISNULL
							(
								DATEADD
									(
										hh,
										-dbo.fn_TimeZoneDifference
											(
												@timeZone,
												@FSCaseFinalDateTime			
											),
										@FSCaseFinalDateTime
									),  
								FSCaseFinalDateTime
							), 
	FSCaseUpdate = ISNULL
					(
						DATEADD
									(
										hh,
										-dbo.fn_TimeZoneDifference
											(
												@timeZone,
												@FSCaseUpdate			
											),
										@FSCaseUpdate
									),   
						FSCaseUpdate
					), 
	FSCaseUserId = ISNULL(@FSCaseUserId, FSCaseUserId), 
	FSCaseBillSecondaryUserID = ISNULL(@FSCaseBillSecondaryUserID, FSCaseBillSecondaryUserID), 
	FSCaseBillDateTime = ISNULL
							(
								DATEADD
									(
										hh,
										-dbo.fn_TimeZoneDifference
											(
												@timeZone,
												@FSCaseBillDateTime			
											),
										@FSCaseBillDateTime
									), 
								FSCaseBillDateTime
							), 
	FSCaseBillApproachUserID = ISNULL(@FSCaseBillApproachUserID, FSCaseBillApproachUserID), 
	FSCaseBillApproachDateTime = ISNULL
									(
										DATEADD
											(
												hh,
												-dbo.fn_TimeZoneDifference
													(
														@timeZone,
														@FSCaseBillApproachDateTime	
													),
												@FSCaseBillApproachDateTime
											), 
										FSCaseBillApproachDateTime
									), 
	FSCaseBillMedSocUserID = ISNULL(@FSCaseBillMedSocUserID, FSCaseBillMedSocUserID), 
	FSCaseBillMedSocDateTime = ISNULL
									(
										DATEADD
											(
												hh,
												-dbo.fn_TimeZoneDifference
													(
														@timeZone,
														@FSCaseBillMedSocDateTime	
													),
												@FSCaseBillMedSocDateTime
											), 
										FSCaseBillMedSocDateTime
									), 
	SecondaryManualBillPersonId = ISNULL(@SecondaryManualBillPersonId, SecondaryManualBillPersonId), 
	SecondaryUpdatedFlag = ISNULL(@SecondaryUpdatedFlag, SecondaryUpdatedFlag), 
	FSCaseTotalTime = ISNULL(@FSCaseTotalTime, FSCaseTotalTime), 
	FSCaseSeconds = ISNULL(@FSCaseSeconds, FSCaseSeconds), 
	FSCaseBillFamUnavailUserId = ISNULL(@FSCaseBillFamUnavailUserId, FSCaseBillFamUnavailUserId), 
	FSCaseBillFamUnavailDateTime = ISNULL
										(
											DATEADD
												(
													hh,
													-dbo.fn_TimeZoneDifference
														(
															@timeZone,
															@FSCaseBillFamUnavailDateTime
														),
													@FSCaseBillFamUnavailDateTime
												), 
											FSCaseBillFamUnavailDateTime
										), 
	FSCaseBillCryoFormUserId = ISNULL(@FSCaseBillCryoFormUserId, FSCaseBillCryoFormUserId), 
	FSCaseBillCryoFormDateTime = ISNULL
									(
										DATEADD
												(
													hh,
													-dbo.fn_TimeZoneDifference
														(
															@timeZone,
															@FSCaseBillCryoFormDateTime
														),
													@FSCaseBillCryoFormDateTime
												), 
										FSCaseBillCryoFormDateTime
									), 
	FSCaseBillApproachCount = ISNULL(@FSCaseBillApproachCount, FSCaseBillApproachCount), 
	FSCaseBillMedSocCount = ISNULL(@FSCaseBillMedSocCount, FSCaseBillMedSocCount), 
	FSCaseBillCryoFormCount = ISNULL(@FSCaseBillCryoFormCount, FSCaseBillCryoFormCount), 
	FSCaseBillOTEPerson = ISNULL(@FSCaseBillOTEPerson, FSCaseBillOTEPerson), 
	FSCaseBillOTEUserID = ISNULL(@FSCaseBillOTEUserID, FSCaseBillOTEUserID), 
	FSCaseBillOTEDateTime = ISNULL
								(
									DATEADD
												(
													hh,
													-dbo.fn_TimeZoneDifference
														(
															@timeZone,
															@FSCaseBillOTEDateTime
														),
													@FSCaseBillOTEDateTime
												),  
									FSCaseBillOTEDateTime
								), 
	FSCaseBillOTECount = ISNULL(@FSCaseBillOTECount, FSCaseBillOTECount), 
	LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID), 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify
	LastModified = GetDate() 

WHERE
	CallID = @CallID


-- Close all the pending events when the user closes the family services case
If(@FSCaseFinalUserId > 0)
Begin
	Update 
		LogEvent  
	SET	
		LastModified = GetDate(), 
		PersonID = ISNULL(@PersonID, PersonID), 
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify	
		LogEventCallbackPending = 0
	WHERE
		CallID = @CallID
		AND LogEventCallbackPending = -1
End
GO

GRANT EXEC ON UpdateFSCase TO PUBLIC

GO
