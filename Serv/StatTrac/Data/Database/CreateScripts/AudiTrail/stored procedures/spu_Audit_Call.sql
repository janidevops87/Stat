SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Call]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_Call'
		DROP procedure [dbo].[spu_Audit_Call]
	END
GO

	PRINT 'Creating Procedure spu_Audit_Call'
GO

create procedure "spu_Audit_Call" 
	@c1 int,
	@c2 varchar(15),
	@c3 int,
	@c4 smalldatetime,
	@c5 smallint,
	@c6 varchar(15),
	@c7 smallint,
	@c8 smallint,
	@c9 smallint,
	@c10 datetime,
	@c11 smallint,
	@c12 int,
	@c13 int,
	@c14 int,
	@c15 numeric(5,0),
	@c16 smallint,
	@c17 int,
	@c18 smallint,
	@c19 smallint,
	@c20 int,
	@c21 int,
	@pkc1 int,
	@bitmap binary(3)
AS
/******************************************************************************
**		File: spu_Audit_Call.sql
**		Name: spu_Audit_Call
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
**		01/06/2009	ccarroll			Added locking for CallOpenByWebPersonId 
*******************************************************************************/
	DECLARE 
		@lastModified datetime,
		@callSaveLastByID int,
		@auditLogTypeID int

IF ( -- if any of these items have changed add the information to the audittrail
		SUBSTRING(@bitmap, 1, 1) & 1 = 1 -- CallID
		-- DO NOT DISPLAY OR SUBSTRING(@bitmap, 1, 1) & 2 = 2 -- CallNumber
		OR SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- CallTypeID
		--OR SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- CallDateTime
		OR SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- StatEmployeeID
		--OR SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- CallTotalTime
		OR	SUBSTRING(@bitmap, 1, 1) & 64 = 64 -- CallTempExclusive
		OR SUBSTRING(@bitmap, 1, 1) & 128 = 128 -- Inactive
		--OR SUBSTRING(@bitmap, 2, 1) & 1 = 1 -- CallSeconds
		-- DO NOT CARE IF LASTMODIFIED HAS CHANGED OR SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- LastModified
		OR SUBSTRING(@bitmap, 2, 1) & 4 = 4 -- CallTemp
		OR SUBSTRING(@bitmap, 2, 1) & 8 = 8 -- SourceCodeID
		OR (
			SUBSTRING(@bitmap, 2, 1) & 16 = 16 -- CallOpenByID
			AND @c13 <> -1 -- so a user has saved or reviewed the call
			)
		OR SUBSTRING(@bitmap, 2, 1) & 32 = 32 -- CallTempSavedByID
		OR SUBSTRING(@bitmap, 2, 1) & 64 = 64 -- CallExtension
		OR SUBSTRING(@bitmap, 2, 1) & 128 = 128 -- UpdatedFlag
		OR (
			SUBSTRING(@bitmap, 3, 1) & 1 = 1 -- CallOpenByWebPersonId
			AND @c17 <> -1 -- so a web user has saved or reviewed the call
			)
		-- See Below: OR SUBSTRING(@bitmap, 3, 1) & 2 = 2 -- RecycleNCFlag
		-- DO NOT DISPLAY OR SUBSTRING(@bitmap, 3, 1) & 4 = 4 -- CallActive
		--OR SUBSTRING(@bitmap, 3, 1) & 8 = 8 -- CallSaveLastByID
		--OR SUBSTRING(@bitmap, 3, 1) & 16 = 16 -- AuditLogTypeID
		OR @c21 = 4
		)
		AND IsNull(@c18, 0) <> 2 /* RecycleNCFlag
		StatTrac saves RecycleNCFlag = 2 After a Message is created. This condition removes 
		the behaviour from the AuditTrail */
		
BEGIN		

	SELECT TOP 1
		@lastModified = LastModified,
		@callSaveLastByID = CallSaveLastByID,
		@auditLogTypeID = ISNULL(@c21, AuditLogTypeID)
	FROM
		CALL
	WHERE 
		CallID = 	@pkc1
	ORDER BY
		LastModified DESC


	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF 
	(
		( 
			SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallID
		-- DO NOT DISPLAY AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallNumber
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- CallTypeID
		--AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- CallDateTime
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- StatEmployeeID
		--AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- CallTotalTime
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- CallTempExclusive
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- Inactive
		--AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- CallSeconds
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- CallTemp
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- SourceCodeID
		-- DO NOT DISPLAY AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- CallOpenByID
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- CallTempSavedByID
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- CallExtension
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- UpdatedFlag
		-- AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- CallOpenByWebPersonId
		-- DO NOT DISPLAY AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- RecycleNCFlag
		-- DO NOT DISPLAY AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- CallActive
		-- AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- CallSaveLastByID
		-- AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- AuditLogTypeID
	)
	AND SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- LastModified
	)
BEGIN
	IF IsNull(@auditLogTypeID, 2) <> 4 --Deleted
		BEGIN
			SET @auditLogTypeID = 2	-- Review
			SET @c20 = @c13 --Catch who reviewed Call 
		END
	ELSE
		BEGIN
			SET @auditLogTypeID = 4	-- Deleted
		END
END
ELSE
BEGIN
	SET @auditLogTypeID = 3	-- Modify
	--SET @c20 = IsNull(@c20, @c13)
	/* This is a modify, so remove the review which was just created */
	DELETE Call WHERE CallID = @pkc1 AND AuditLogTypeID = 2 AND LastModified = @lastModified
END
insert into "Call"
	( 
		"CallID", -- pkc1
		"CallNumber", --c2
		"CallTypeID", -- c3
		"CallDateTime", -- c4
		"StatEmployeeID", -- c5
		"CallTotalTime", -- c6
		"CallTempExclusive", --c7
		"Inactive",  --c8
		"CallSeconds", --c9
		"LastModified", --c10
		"CallTemp", -- c11
		"SourceCodeID", -- c12
		"CallOpenByID",  -- c13
		"CallTempSavedByID", -- c14
		"CallExtension", -- c15
		"UpdatedFlag", -- c16
		"CallOpenByWebPersonId", -- c17
		"RecycleNCFlag", -- c18
		"CallActive", -- c19
		"CallSaveLastByID", -- c20
		"AuditLogTypeID" --c21
	 )

values 
	( 
		@pkc1,
		@c2,
		CASE WHEN /*CallTypeID*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
		CASE WHEN /*CallDateTime*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN '01/01/1900' ELSE @c4 END,
		CASE WHEN /*StatEmployeeID*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
		CASE WHEN /*CallTotalTime*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, '') = '' THEN 'ILB' ELSE @c6 END,
		CASE WHEN /*CallTempExclusive*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 THEN @c7 END, --do not show ILB
		CASE WHEN /*Inactive*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 THEN @c8 END, --do not show ILB
		@c9,
		ISNULL(@c10, @lastModified),
		CASE WHEN /*CallTemp*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 THEN @c11 END, --do not show ILB
		CASE WHEN /*SourceCodeID*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, -1) IN ( -1, 0) THEN -2 ELSE @c12 END,
		CASE WHEN /*CallOpenByID*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 THEN @c13 END, --do not show ILB
		CASE WHEN /*CallTempSavedByID*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 THEN @c14 END, --do not show ILB
		CASE WHEN /*CallExtension*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, -1) IN ( -1, 0) THEN -2 ELSE @c15 END,
		CASE WHEN /*UpdatedFlag*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 THEN @c16 END, --do not show ILB
		CASE WHEN /*CallOpenByWebPersonId*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 THEN @c17 END, --do not show ILB
		@c18,
		@c19,
		ISNULL(@c20, @CallSaveLastByID), -- if CallLastSaveBy is null then it has not changed so use the existing value.
		@AuditLogTypeID
	)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

