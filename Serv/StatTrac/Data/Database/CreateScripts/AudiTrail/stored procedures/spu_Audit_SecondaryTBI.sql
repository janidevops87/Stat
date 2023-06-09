SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_SecondaryTBI]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	print 'drop procedure spu_Audit_SecondaryTBI' 
	drop procedure [dbo].[spu_Audit_SecondaryTBI]
END	
GO
print 'create procedure spu_Audit_SecondaryTBI' 
GO
create procedure "spu_Audit_SecondaryTBI" 
	@c1 int,
	@c2 varchar(25),
	@c3 int,
	@c4 varchar(10),
	@c5 smallint,
	@c6 int,
	@c7 int,
	@c8 varchar(250),
	@c9 smalldatetime,
	@c10 smalldatetime,
	@c11 int,
	@pkc1 int,
	@bitmap binary(2)
as

	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- SecondaryTBINumber
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SecondaryTBIIssuedStatEmployeeID
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryTBIPrefixDate
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryTBIAssignmentNotNeeded
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryTBIAssignmentNotNeededStatEmployeeID
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryTBIComment
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- CreateDate
		AND SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- LastModified
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- AuditLogTypeID

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c11, AuditLogTypeID)
	FROM
		SecondaryTBI
	WHERE 
		CallID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- SecondaryTBINumber
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SecondaryTBIIssuedStatEmployeeID
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryTBIPrefixDate
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryTBIAssignmentNotNeeded
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryTBIAssignmentNotNeededStatEmployeeID
	-- AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- LastStatEmployeeID
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryTBIComment
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- CreateDate
	AND SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- LastModified
	-- AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- AuditLogTypeID
	AND @auditLogTypeID = 3		
	)
BEGIN
	SET @auditLogTypeID = 2	-- Review
END


insert into 
	"SecondaryTBI"
	( 
		CallID,  --c1
		SecondaryTBINumber,  --c2
		SecondaryTBIIssuedStatEmployeeID,  --c3
		SecondaryTBIPrefixDate,  --c4
		SecondaryTBIAssignmentNotNeeded,  --c5
		SecondaryTBIAssignmentNotNeededStatEmployeeID,  --c6
		LastStatEmployeeID,  --c7
		SecondaryTBIComment,  --c8
		CreateDate,  --c9
		LastModified,  --c10
		AuditLogTypeID --c11
	)

values 
	( 
		@pkc1,
		CASE WHEN /*SecondaryTBINumber*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, '') = '' THEN 'ILB' ELSE @c2 END,
		CASE WHEN /*SecondaryTBIIssuedStatEmployeeID*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
		CASE WHEN /*SecondaryTBIPrefixDate*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN 'ILB' ELSE @c4 END,
		CASE WHEN /*SecondaryTBIAssignmentNotNeeded*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
		CASE WHEN /*SecondaryTBIAssignmentNotNeededStatEmployeeID*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
		ISNULL(@c7, @LastStatEmployeeID),
		CASE WHEN /*SecondaryTBIComment*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, '') = '' THEN 'ILB' ELSE @c8 END,
		@c9, /*CreateDate*/
		ISNULL(@c10, @lastModified),
		@auditLogTypeID
	)

END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

