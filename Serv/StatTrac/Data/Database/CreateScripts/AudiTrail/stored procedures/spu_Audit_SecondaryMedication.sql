SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_SecondaryMedication]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spu_Audit_SecondaryMedication]
GO

create procedure "spu_Audit_SecondaryMedication" 
	@c1 int,
	@c2 int,
	@c3 int,
	@c4 int,
	@c5 smalldatetime,
	@pkc1 int,
	@pkc2 int,
	@bitmap binary(1)
as

	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallId
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- MedicationId
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- AuditLogTypeID
		AND SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- LastModified
	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c4, AuditLogTypeID)
	FROM
		SecondaryMedication
	WHERE 
		CallID = @pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallId
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- MedicationId
	--AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- LastStatEmployeeID
	--AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- AuditLogTypeID
	AND SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- LastModified
	AND @auditLogTypeID = 3	

	)
BEGIN
	SET @auditLogTypeID = 2	-- Review
END


insert into 
	"SecondaryMedication"
	( 
		CallId,  --c1
		MedicationId,  --c2
		LastStatEmployeeID,  --c3
		AuditLogTypeID,  --c4
		LastModified  --c5
	)
values 
	( 
		@pkc1,
		@pkc2,
		ISNULL(@c3, @LastStatEmployeeID),
		@auditLogTypeID,
		ISNULL(@c5, @lastModified)
	)

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

