SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_SecondaryMedicationOther]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spu_Audit_SecondaryMedicationOther]
GO

create procedure "spu_Audit_SecondaryMedicationOther" 
	@c1 int,
	@c2 int,
	@c3 int,
	@c4 varchar(100),
	@c5 varchar(100),
	@c6 varchar(100),
	@c7 smalldatetime,
	@c8 smalldatetime,
	@c9 int,
	@c10 int,
	@c11 smalldatetime,
	@pkc1 int,
	@bitmap binary(2)
as

	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int,
		@callID int,
		@MedicationOtherID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- SecondaryMedicationOtherId
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallId
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- MedicationId
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryMedicationOtherTypeUse
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryMedicationOtherName
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryMedicationOtherDose
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryMedicationOtherStartDate
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryMedicationOtherEndDate
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- AuditLogTypeID
		AND SUBSTRING(@bitmap, 2, 1) & 4 = 4 -- LastModified

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c10, AuditLogTypeID),
		@callID = CallID,
		@MedicationOtherID = SecondaryMedicationOtherId
	FROM
		SecondaryMedicationOther
	WHERE 
		SecondaryMedicationOtherId = 	@pkc1
	ORDER BY
		LastModified DESC	


	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- SecondaryMedicationOtherId
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallId
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- MedicationId
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryMedicationOtherTypeUse
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryMedicationOtherName
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryMedicationOtherDose
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryMedicationOtherStartDate
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryMedicationOtherEndDate
	--AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- LastStatEmployeeID
	--AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- AuditLogTypeID
	AND SUBSTRING(@bitmap, 2, 1) & 4 = 4 -- LastModified
	AND @auditLogTypeID = 3
	)
BEGIN
		SET @auditLogTypeID = 2	-- Review
END


insert into 
	"SecondaryMedicationOther"
	( 
		SecondaryMedicationOtherId,  --c1
		CallId,  --c2
		MedicationId,  --c3
		SecondaryMedicationOtherTypeUse,  --c4
		SecondaryMedicationOtherName,  --c5
		SecondaryMedicationOtherDose,  --c6
		SecondaryMedicationOtherStartDate,  --c7
		SecondaryMedicationOtherEndDate,  --c8
		LastStatEmployeeID,  --c9
		AuditLogTypeID,  --c10
		LastModified  --c11
	)

values 
	( 
		@pkc1,
		@callID,
		CASE WHEN /*MedicationId*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
		CASE WHEN /*SecondaryMedicationOtherTypeUse*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN 'ILB' ELSE @c4 END,
		CASE WHEN /*SecondaryMedicationOtherName*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, '') = '' THEN 'ILB' ELSE @c5 END,
		CASE WHEN /*SecondaryMedicationOtherDose*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, '') = '' THEN 'ILB' ELSE @c6 END,
		CASE WHEN /*SecondaryMedicationOtherStartDate*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, '') = '' THEN '01/01/1900' ELSE @c7 END,
		CASE WHEN /*SecondaryMedicationOtherEndDate*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, '') = '' THEN '01/01/1900' ELSE @c8 END,
		ISNULL(@c9, @LastStatEmployeeID),
		@auditLogTypeID,
		ISNULL(@c11, @lastModified)
	)


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

