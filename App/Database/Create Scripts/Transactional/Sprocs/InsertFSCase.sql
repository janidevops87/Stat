IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertFSCase')
	BEGIN
		PRINT 'Dropping Procedure InsertFSCase'
		DROP  Procedure  InsertFSCase
	END

GO

PRINT 'Creating Procedure InsertFSCase'
GO
CREATE Procedure InsertFSCase
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
**		File: InsertFSCase.sql
**		Name: InsertFSCase
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
**		see list.
**
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
INSERT
	FSCase
	(
		CallId, 
		FSCaseCreateUserId, 
		FSCaseCreateDateTime, 
		FSCaseOpenUserId, 
		FSCaseOpenDateTime, 
		FSCaseSysEventsUserId, 
		FSCaseSysEventsDateTime, 
		FSCaseSecCompUserId, 
		FSCaseSecCompDateTime, 
		FSCaseApproachUserId, 
		FSCaseApproachDateTime, 
		FSCaseFinalUserId, 
		FSCaseFinalDateTime, 
		FSCaseUpdate, 
		FSCaseUserId, 
		FSCaseBillSecondaryUserID, 
		FSCaseBillDateTime, 
		FSCaseBillApproachUserID, 
		FSCaseBillApproachDateTime, 
		FSCaseBillMedSocUserID, 
		FSCaseBillMedSocDateTime, 
		SecondaryManualBillPersonId, 
		SecondaryUpdatedFlag, 
		FSCaseTotalTime, 
		FSCaseSeconds, 
		FSCaseBillFamUnavailUserId, 
		FSCaseBillFamUnavailDateTime, 
		FSCaseBillCryoFormUserId, 
		FSCaseBillCryoFormDateTime, 
		FSCaseBillApproachCount, 
		FSCaseBillMedSocCount, 
		FSCaseBillCryoFormCount, 
		FSCaseBillOTEPerson, 
		FSCaseBillOTEUserID, 
		FSCaseBillOTEDateTime, 
		FSCaseBillOTECount, 
		LastStatEmployeeID, 
		AuditLogTypeID, 
		LastModified	
	)
VALUES
	(
		@CallId, 
		@FSCaseCreateUserId, 
		ISNULL
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
				NULL
			), 		
		ISNULL(@FSCaseOpenUserId, 0),
		ISNULL
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
					),	
				NULL
			), 
		ISNULL(@FSCaseSysEventsUserId, 0), 
		ISNULL
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
				NULL
			), 		 
		ISNULL(@FSCaseSecCompUserId, 0), 
		ISNULL
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
				NULL
			), 		 
		ISNULL(@FSCaseApproachUserId, 0), 
		ISNULL
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
				NULL
			), 		 
		ISNULL(@FSCaseFinalUserId, 0), 
		ISNULL
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
				NULL
			), 		 
		ISNULL
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
				NULL
			), 		 
		ISNULL(@FSCaseUserId, 0), 
		@FSCaseBillSecondaryUserID, 
		ISNULL
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
				NULL
			), 		 
		@FSCaseBillApproachUserID, 
		ISNULL
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
				NULL
			), 		 
		@FSCaseBillMedSocUserID, 
		ISNULL
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
				NULL
			), 		 		
		@SecondaryManualBillPersonId, 
		@SecondaryUpdatedFlag, 
		@FSCaseTotalTime, 
		@FSCaseSeconds, 
		@FSCaseBillFamUnavailUserId, 
		ISNULL
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
				NULL
			),
		@FSCaseBillCryoFormUserId, 
		ISNULL
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
				NULL
			),		 
		@FSCaseBillApproachCount, 
		@FSCaseBillMedSocCount, 
		@FSCaseBillCryoFormCount, 
		@FSCaseBillOTEPerson, 
		@FSCaseBillOTEUserID, 
		ISNULL
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
				NULL
			),		 
		@FSCaseBillOTECount, 
		@LastStatEmployeeID, 
		1, -- @AuditLogTypeID 1 = Create
		GetDate() 	
	)

SELECT
	FSCaseId, 
	CallId, 
	FSCaseCreateUserId, 
	FSCaseCreateDateTime, 
	FSCaseOpenUserId, 
	FSCaseOpenDateTime, 
	FSCaseSysEventsUserId, 
	FSCaseSysEventsDateTime, 
	FSCaseSecCompUserId, 
	FSCaseSecCompDateTime, 
	FSCaseApproachUserId, 
	FSCaseApproachDateTime, 
	FSCaseFinalUserId, 
	FSCaseFinalDateTime, 
	FSCaseUpdate, 
	FSCaseUserId, 
	FSCaseBillSecondaryUserID, 
	FSCaseBillDateTime, 
	FSCaseBillApproachUserID, 
	FSCaseBillApproachDateTime, 
	FSCaseBillMedSocUserID, 
	FSCaseBillMedSocDateTime, 
	SecondaryManualBillPersonId, 
	SecondaryUpdatedFlag, 
	FSCaseTotalTime, 
	FSCaseSeconds, 
	FSCaseBillFamUnavailUserId, 
	FSCaseBillFamUnavailDateTime, 
	FSCaseBillCryoFormUserId, 
	FSCaseBillCryoFormDateTime, 
	FSCaseBillApproachCount, 
	FSCaseBillMedSocCount, 
	FSCaseBillCryoFormCount, 
	FSCaseBillOTEPerson, 
	FSCaseBillOTEUserID, 
	FSCaseBillOTEDateTime, 
	FSCaseBillOTECount
FROM
	FSCase
WHERE
	FSCaseId = SCOPE_IDENTITY() 


GO

GRANT EXEC ON InsertFSCase TO PUBLIC

GO
