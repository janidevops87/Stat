SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_SecondaryApproach]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spu_Audit_SecondaryApproach]
GO

create procedure "spu_Audit_SecondaryApproach" 
	@c1 int,
	@c2 smallint,
	@c3 int,
	@c4 smallint,
	@c5 smallint,
	@c6 smallint,
	@c7 smallint,
	@c8 int,
	@c9 smallint,
	@c10 smallint,
	@c11 varchar(50),
	@c12 smallint,
	@c13 int,
	@c14 smallint,
	@c15 smallint,
	@c16 int,
	@c17 smallint,
	@c18 varchar(50),
	@c19 smallint,
	@c20 int,
	@c21 int,
	@c22 smalldatetime,
	@pkc1 int,
	@bitmap binary(3)
as
	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallId
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- SecondaryApproached
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SecondaryApproachedBy
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryApproachType
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryApproachOutcome
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryApproachReason
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryConsented
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryConsentBy
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- SecondaryConsentOutcome
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- SecondaryConsentResearch
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- SecondaryRecoveryLocation
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- SecondaryHospitalApproach
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- SecondaryHospitalApproachedBy
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- SecondaryHospitalOutcome
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- SecondaryConsentMedSocPaperwork
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- SecondaryConsentMedSocObtainedBy
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- SecondaryConsentFuneralPlans
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- SecondaryConsentFuneralPlansOther
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- SecondaryConsentLongSleeves
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- AuditLogTypeID
		AND SUBSTRING(@bitmap, 3, 1) & 32 = 32 -- LastModified

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c21, AuditLogTypeID)
	FROM
		SecondaryApproach
	WHERE 
		CallId = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallId
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- SecondaryApproached
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SecondaryApproachedBy
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryApproachType
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryApproachOutcome
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryApproachReason
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryConsented
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryConsentBy
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- SecondaryConsentOutcome
	AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- SecondaryConsentResearch
	AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- SecondaryRecoveryLocation
	AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- SecondaryHospitalApproach
	AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- SecondaryHospitalApproachedBy
	AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- SecondaryHospitalOutcome
	AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- SecondaryConsentMedSocPaperwork
	AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- SecondaryConsentMedSocObtainedBy
	AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- SecondaryConsentFuneralPlans
	AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- SecondaryConsentFuneralPlansOther
	AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- SecondaryConsentLongSleeves
	-- AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- LastStatEmployeeID
	-- AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- AuditLogTypeID
	AND SUBSTRING(@bitmap, 3, 1) & 32 = 32 -- LastModified
	AND IsNull(@auditLogTypeID, 2) IN (2, 3, 4) --Review, Modify, Delete	
	)
BEGIN 	/* Only LastModified Changed. Check for Deleted record */
		IF  @auditLogTypeID <> 4
			BEGIN
				SET @auditLogTypeID = 2	-- Review
			END
		ELSE
			BEGIN
				SET @auditLogTypeID = 4	-- Deleted
			END
END
ELSE
		BEGIN
				SET @auditLogTypeID = 3	-- Modified
		END

insert into 
	"SecondaryApproach"
	( 
		CallId,  --c1
		SecondaryApproached,  --c2
		SecondaryApproachedBy,  --c3
		SecondaryApproachType,  --c4
		SecondaryApproachOutcome,  --c5
		SecondaryApproachReason,  --c6
		SecondaryConsented,  --c7
		SecondaryConsentBy,  --c8
		SecondaryConsentOutcome,  --c9
		SecondaryConsentResearch,  --c10
		SecondaryRecoveryLocation,  --c11
		SecondaryHospitalApproach,  --c12
		SecondaryHospitalApproachedBy,  --c13
		SecondaryHospitalOutcome,  --c14
		SecondaryConsentMedSocPaperwork,  --c15
		SecondaryConsentMedSocObtainedBy,  --c16
		SecondaryConsentFuneralPlans,  --c17
		SecondaryConsentFuneralPlansOther,  --c18
		SecondaryConsentLongSleeves,  --c19
		LastStatEmployeeID,  --c20
		AuditLogTypeID,  --c21
		LastModified  --c22
	)

values 
	( 
		@pkc1,
		CASE WHEN /*SecondaryApproached*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, -1) IN ( -1, 0) THEN -2 ELSE @c2 END,
		CASE WHEN /*SecondaryApproachedBy*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
		CASE WHEN /*SecondaryApproachType*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, -1) IN ( -1, 0) THEN -2 ELSE @c4 END,
		CASE WHEN /*SecondaryApproachOutcome*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
		CASE WHEN /*SecondaryApproachReason*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
		CASE WHEN /*SecondaryConsented*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, -1) IN ( -1, 0) THEN -2 ELSE @c7 END,
		CASE WHEN /*SecondaryConsentBy*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, -1) IN ( -1, 0) THEN -2 ELSE @c8 END,
		CASE WHEN /*SecondaryConsentOutcome*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, -1) IN ( -1, 0) THEN -2 ELSE @c9 END,
		CASE WHEN /*SecondaryConsentResearch*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, -1) IN ( -1, 0) THEN -2 ELSE @c10 END,
		CASE WHEN /*SecondaryRecoveryLocation*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, '') = '' THEN 'ILB' ELSE @c11 END,
		CASE WHEN /*SecondaryHospitalApproach*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, -1) IN ( -1, 0) THEN -2 ELSE @c12 END,
		CASE WHEN /*SecondaryHospitalApproachedBy*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, -1) IN ( -1, 0) THEN -2 ELSE @c13 END,
		CASE WHEN /*SecondaryHospitalOutcome*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, -1) IN ( -1, 0) THEN -2 ELSE @c14 END,
		CASE WHEN /*SecondaryConsentMedSocPaperwork*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, -1) IN ( -1, 0) THEN -2 ELSE @c15 END,
		CASE WHEN /*SecondaryConsentMedSocObtainedBy*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, -1) IN ( -1, 0) THEN -2 ELSE @c16 END,
		CASE WHEN /*SecondaryConsentFuneralPlans*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND IsNull(@c17, -1) IN ( -1, 0) THEN -2 ELSE @c17 END,
		CASE WHEN /*SecondaryConsentFuneralPlansOther*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 AND IsNull(@c18, '') = '' THEN 'ILB' ELSE @c18 END,
		CASE WHEN /*SecondaryConsentLongSleeves*/ SUBSTRING(@bitmap, 3, 1) & 4 = 4 AND IsNull(@c19, -1) IN ( -1, 0) THEN -2 ELSE @c19 END,
		ISNULL(@c20, @LastStatEmployeeID),
		@auditLogTypeID,
		ISNULL(@c22, @lastModified)
	)

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

