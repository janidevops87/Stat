SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_FSCase]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_FSCase'
		DROP procedure [dbo].[spu_Audit_FSCase]
	END
GO

	PRINT 'Creating Procedure spu_Audit_FSCase'
GO
create procedure "spu_Audit_FSCase" 
	@c1 int,
	@c2 int,
	@c3 int,
	@c4 datetime,
	@c5 int,
	@c6 datetime,
	@c7 int,
	@c8 datetime,
	@c9 int,
	@c10 datetime,
	@c11 int,
	@c12 datetime,
	@c13 int,
	@c14 datetime,
	@c15 datetime,
	@c16 int,
	@c17 int,
	@c18 datetime,
	@c19 int,
	@c20 datetime,
	@c21 int,
	@c22 datetime,
	@c23 int,
	@c24 smallint,
	@c25 varchar(15),
	@c26 int,
	@c27 int,
	@c28 datetime,
	@c29 int,
	@c30 datetime,
	@c31 smallint,
	@c32 smallint,
	@c33 smallint,
	@c34 varchar(50),
	@c35 smallint,
	@c36 datetime,
	@c37 smallint,
	@c38 int,
	@c39 int,
	@c40 smalldatetime,
	@pkc1 int,
	@bitmap binary(6)
AS
/******************************************************************************
**		File: spu_Audit_FSCase.sql
**		Name: spu_Audit_FSCase
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
**		05/15/2008	ccarroll			Added CASE statement for ILB insert values
*******************************************************************************/
	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int,
		@callID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- FSCaseId
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallId
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- FSCaseCreateUserId
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- FSCaseCreateDateTime
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- FSCaseOpenUserId
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- FSCaseOpenDateTime
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- FSCaseSysEventsUserId
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- FSCaseSysEventsDateTime
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- FSCaseSecCompUserId
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- FSCaseSecCompDateTime
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- FSCaseApproachUserId
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- FSCaseApproachDateTime
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- FSCaseFinalUserId
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- FSCaseFinalDateTime
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- FSCaseUpdate
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- FSCaseUserId
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- FSCaseBillSecondaryUserID
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- FSCaseBillDateTime
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- FSCaseBillApproachUserID
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- FSCaseBillApproachDateTime
		AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- FSCaseBillMedSocUserID
		AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- FSCaseBillMedSocDateTime
		AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- SecondaryManualBillPersonId
		AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- SecondaryUpdatedFlag
		-- AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- FSCaseTotalTime
		-- AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- FSCaseSeconds
		AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- FSCaseBillFamUnavailUserId
		AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- FSCaseBillFamUnavailDateTime
		AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- FSCaseBillCryoFormUserId
		AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- FSCaseBillCryoFormDateTime
		AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- FSCaseBillApproachCount
		AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- FSCaseBillMedSocCount
		AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- FSCaseBillCryoFormCount
		AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- FSCaseBillOTEPerson
		AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- FSCaseBillOTEUserID
		AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- FSCaseBillOTEDateTime
		AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- FSCaseBillOTECount
		AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 5, 1) & 64 <> 64 -- AuditLogTypeID
		AND SUBSTRING(@bitmap, 5, 1) & 128 = 128 -- LastModified

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c39, AuditLogTypeID),
		@callID = CallID
	FROM
		FSCase
	WHERE 
		FSCaseId = 	@pkc1
	ORDER BY
		LastModified DESC	


	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- FSCaseId
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallId
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- FSCaseCreateUserId
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- FSCaseCreateDateTime
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- FSCaseOpenUserId
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- FSCaseOpenDateTime
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- FSCaseSysEventsUserId
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- FSCaseSysEventsDateTime
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- FSCaseSecCompUserId
	AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- FSCaseSecCompDateTime
	AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- FSCaseApproachUserId
	AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- FSCaseApproachDateTime
	AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- FSCaseFinalUserId
	AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- FSCaseFinalDateTime
	AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- FSCaseUpdate
	AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- FSCaseUserId
	AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- FSCaseBillSecondaryUserID
	AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- FSCaseBillDateTime
	AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- FSCaseBillApproachUserID
	AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- FSCaseBillApproachDateTime
	AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- FSCaseBillMedSocUserID
	AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- FSCaseBillMedSocDateTime
	AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- SecondaryManualBillPersonId
	AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- SecondaryUpdatedFlag
	--AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- FSCaseTotalTime
	--AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- FSCaseSeconds
	AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- FSCaseBillFamUnavailUserId
	AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- FSCaseBillFamUnavailDateTime
	AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- FSCaseBillCryoFormUserId
	AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- FSCaseBillCryoFormDateTime
	AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- FSCaseBillApproachCount
	AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- FSCaseBillMedSocCount
	AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- FSCaseBillCryoFormCount
	AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- FSCaseBillOTEPerson
	AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- FSCaseBillOTEUserID
	AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- FSCaseBillOTEDateTime
	AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- FSCaseBillOTECount
	--AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- LastStatEmployeeID
	--AND SUBSTRING(@bitmap, 5, 1) & 64 <> 64 -- AuditLogTypeID
	AND SUBSTRING(@bitmap, 5, 1) & 128 = 128 -- LastModified
	AND @auditLogTypeID = 3	
	)
BEGIN
		SET @auditLogTypeID = 2	-- Review
END


insert into "FSCase"( 
	"FSCaseId", -- c1
	"CallId", -- c2
	"FSCaseCreateUserId", -- c3
	"FSCaseCreateDateTime", -- c4
	"FSCaseOpenUserId", -- c5
	"FSCaseOpenDateTime", -- c6
	"FSCaseSysEventsUserId", -- c7
	"FSCaseSysEventsDateTime", -- c8
	"FSCaseSecCompUserId", -- c9
	"FSCaseSecCompDateTime", -- c10
	"FSCaseApproachUserId", -- c11
	"FSCaseApproachDateTime", -- c12
	"FSCaseFinalUserId", -- c13
	"FSCaseFinalDateTime", -- c14
	"FSCaseUpdate", -- c15
	"FSCaseUserId", -- c16
	"FSCaseBillSecondaryUserID", -- c17
	"FSCaseBillDateTime", -- c18
	"FSCaseBillApproachUserID", -- c19
	"FSCaseBillApproachDateTime", -- c20
	"FSCaseBillMedSocUserID", -- c21
	"FSCaseBillMedSocDateTime", -- c22
	"SecondaryManualBillPersonId", -- c23
	"SecondaryUpdatedFlag", -- c24
	"FSCaseTotalTime", -- c25
	"FSCaseSeconds", -- c26
	"FSCaseBillFamUnavailUserId", -- c27
	"FSCaseBillFamUnavailDateTime", -- c28
	"FSCaseBillCryoFormUserId", -- c29
	"FSCaseBillCryoFormDateTime", -- c30
	"FSCaseBillApproachCount", -- c31
	"FSCaseBillMedSocCount", -- c32
	"FSCaseBillCryoFormCount", -- c33
	"FSCaseBillOTEPerson", -- c34
	"FSCaseBillOTEUserID", -- c35
	"FSCaseBillOTEDateTime", -- c36
	"FSCaseBillOTECount", -- c37
	"LastStatEmployeeID", -- c38
	"AuditLogTypeID", -- c39
	"LastModified" --c40
 		
 )

values ( 
	@pkc1,
	@callID,
	CASE WHEN /*FSCaseCreateUserId*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
	CASE WHEN /*FSCaseCreateDateTime*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN '01/01/1900' ELSE @c4 END,
	CASE WHEN /*FSCaseOpenUserId*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
	CASE WHEN /*FSCaseOpenDateTime*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, '') = '' THEN '01/01/1900' ELSE @c6 END,
	CASE WHEN /*FSCaseSysEventsUserId*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, -1) IN ( -1, 0) THEN -2 ELSE @c7 END,
	CASE WHEN /*FSCaseSysEventsDateTime*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, '') = '' THEN '01/01/1900' ELSE @c8 END,
	CASE WHEN /*FSCaseSecCompUserId*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, -1) IN ( -1, 0) THEN -2 ELSE @c9 END,
	CASE WHEN /*FSCaseSecCompDateTime*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, '') = '' THEN '01/01/1900' ELSE @c10 END,
	CASE WHEN /*FSCaseApproachUserId*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, -1) IN ( -1, 0) THEN -2 ELSE @c11 END,
	CASE WHEN /*FSCaseApproachDateTime*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, '') = '' THEN '01/01/1900' ELSE @c12 END,
	CASE WHEN /*FSCaseFinalUserId*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, -1) IN ( -1, 0) THEN -2 ELSE @c13 END,
	CASE WHEN /*FSCaseFinalDateTime*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, '') = '' THEN '01/01/1900' ELSE @c14 END,
	CASE WHEN /*FSCaseUpdate*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, '') = '' THEN '01/01/1900' ELSE @c15 END,
	CASE WHEN /*FSCaseUserId*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, -1) IN ( -1, 0) THEN -2 ELSE @c16 END,
	CASE WHEN /*FSCaseBillSecondaryUserID*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND IsNull(@c17, -1) IN ( -1, 0) THEN -2 ELSE @c17 END,
	CASE WHEN /*FSCaseBillDateTime*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 AND IsNull(@c18, '') = '' THEN '01/01/1900' ELSE @c18 END,
	CASE WHEN /*FSCaseBillApproachUserID*/ SUBSTRING(@bitmap, 3, 1) & 4 = 4 AND IsNull(@c19, -1) IN ( -1, 0) THEN -2 ELSE @c19 END,
	CASE WHEN /*FSCaseBillApproachDateTime*/ SUBSTRING(@bitmap, 3, 1) & 8 = 8 AND IsNull(@c20, '') = '' THEN '01/01/1900' ELSE @c20 END,
	CASE WHEN /*FSCaseBillMedSocUserID*/ SUBSTRING(@bitmap, 3, 1) & 16 = 16 AND IsNull(@c21, -1) IN ( -1, 0) THEN -2 ELSE @c21 END,
	CASE WHEN /*FSCaseBillMedSocDateTime*/ SUBSTRING(@bitmap, 3, 1) & 32 = 32 AND IsNull(@c22, '') = '' THEN '01/01/1900' ELSE @c22 END,
	CASE WHEN /*SecondaryManualBillPersonId*/ SUBSTRING(@bitmap, 3, 1) & 64 = 64 AND IsNull(@c23, -1) IN ( -1, 0) THEN -2 ELSE @c23 END,
	CASE WHEN /*SecondaryUpdatedFlag*/ SUBSTRING(@bitmap, 3, 1) & 128 = 128 AND IsNull(@c24, -1) IN ( -1, 0) THEN -2 ELSE @c24 END,
	CASE WHEN /*FSCaseTotalTime*/ SUBSTRING(@bitmap, 4, 1) & 1 = 1 AND IsNull(@c25, '') = '' THEN 'ILB' ELSE @c25 END,
	CASE WHEN /*FSCaseSeconds*/ SUBSTRING(@bitmap, 4, 1) & 2 = 2 AND IsNull(@c26, -1) IN ( -1, 0) THEN -2 ELSE @c26 END,
	CASE WHEN /*FSCaseBillFamUnavailUserId*/ SUBSTRING(@bitmap, 4, 1) & 4 = 4 AND IsNull(@c27, -1) IN ( -1, 0) THEN -2 ELSE @c27 END,
	CASE WHEN /*FSCaseBillFamUnavailDateTime*/ SUBSTRING(@bitmap, 4, 1) & 8 = 8 AND IsNull(@c28, '') = '' THEN '01/01/1900' ELSE @c28 END,
	CASE WHEN /*FSCaseBillCryoFormUserId*/ SUBSTRING(@bitmap, 4, 1) & 16 = 16 AND IsNull(@c29, -1) IN ( -1, 0) THEN -2 ELSE @c29 END,
	CASE WHEN /*FSCaseBillCryoFormDateTime*/ SUBSTRING(@bitmap, 4, 1) & 32 = 32 AND IsNull(@c30, '') = '' THEN '01/01/1900' ELSE @c30 END,
	CASE WHEN /*FSCaseBillApproachCount*/ SUBSTRING(@bitmap, 4, 1) & 64 = 64 AND IsNull(@c31, -1) IN ( -1, 0) THEN -2 ELSE @c31 END,
	CASE WHEN /*FSCaseBillMedSocCount*/ SUBSTRING(@bitmap, 4, 1) & 128 = 128 AND IsNull(@c32, -1) IN ( -1, 0) THEN -2 ELSE @c32 END,
	CASE WHEN /*FSCaseBillCryoFormCount*/ SUBSTRING(@bitmap, 5, 1) & 1 = 1 AND IsNull(@c33, -1) IN ( -1, 0) THEN -2 ELSE @c33 END,
	CASE WHEN /*FSCaseBillOTEPerson*/ SUBSTRING(@bitmap, 5, 1) & 2 = 2 AND IsNull(@c34, '') = '' THEN 'ILB' ELSE @c34 END,
	CASE WHEN /*FSCaseBillOTEUserID*/ SUBSTRING(@bitmap, 5, 1) & 4 = 4 AND IsNull(@c35, -1) IN ( -1, 0) THEN -2 ELSE @c35 END,
	CASE WHEN /*FSCaseBillOTEDateTime*/ SUBSTRING(@bitmap, 5, 1) & 8 = 8 AND IsNull(@c36, '') = '' THEN '01/01/1900' ELSE @c36 END,
	CASE WHEN /*FSCaseBillOTECount*/ SUBSTRING(@bitmap, 5, 1) & 16 = 16 AND IsNull(@c37, -1) IN ( -1, 0) THEN -2 ELSE @c37 END,
	ISNULL(@c38, @LastStatEmployeeID),
	@auditLogTypeID,
	ISNULL(@c40, @lastModified)
 )

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

