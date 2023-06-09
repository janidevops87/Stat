SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_SecondaryDisposition]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spu_Audit_SecondaryDisposition]
GO

create procedure "spu_Audit_SecondaryDisposition" 
	@c1 int,
	@c2 int,
	@c3 int,
	@c4 smallint,
	@c5 smallint,
	@c6 smallint,
	@c7 smallint,
	@c8 smallint,
	@c9 int,
	@c10 int,
	@c11 smalldatetime,
	@pkc1 int,
	@bitmap binary(2)
As

	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int,
		@callID int,
		@subCriteriaID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- SecondaryDispositionID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SubCriteriaID
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryDispositionAppropriate
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryDispositionApproach
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryDispositionConsent
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryDispositionConversion
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryDispositionCRO
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
		@subCriteriaID = ISNULL(SubCriteriaID, 0)
	FROM
		SecondaryDisposition
	WHERE 
		SecondaryDispositionID = @pkc1
	ORDER BY
		LastModified DESC	


	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- SecondaryDispositionID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SubCriteriaID
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryDispositionAppropriate
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryDispositionApproach
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryDispositionConsent
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryDispositionConversion
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryDispositionCRO
	--AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- LastStatEmployeeID
	--AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- AuditLogTypeID
	AND SUBSTRING(@bitmap, 2, 1) & 4 = 4 -- LastModified
	AND @auditLogTypeID = 3	

	)
BEGIN
	SET @auditLogTypeID = 2	-- Review
END


insert into 
	"SecondaryDisposition"
	( 
		SecondaryDispositionID,  --c1
		CallID,  --c2
		SubCriteriaID,  --c3
		SecondaryDispositionAppropriate,  --c4
		SecondaryDispositionApproach,  --c5
		SecondaryDispositionConsent,  --c6
		SecondaryDispositionConversion,  --c7
		SecondaryDispositionCRO,  --c8
		LastStatEmployeeID,  --c9
		AuditLogTypeID,  --c10
		LastModified  --c11
	)

values 
	( 
		@pkc1,
		@callID,
		CASE WHEN /*SubCriteriaID*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
		CASE WHEN /*SecondaryDispositionAppropriate*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, -1) IN ( -1, 0) THEN -2 ELSE @c4 END,
		CASE WHEN /*SecondaryDispositionApproach*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
		CASE WHEN /*SecondaryDispositionConsent*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
		CASE WHEN /*SecondaryDispositionConversion*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, -1) IN ( -1, 0) THEN -2 ELSE @c7 END,
		CASE WHEN /*SecondaryDispositionCRO*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, -1) IN ( -1, 0) THEN -2 ELSE @c8 END,
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

