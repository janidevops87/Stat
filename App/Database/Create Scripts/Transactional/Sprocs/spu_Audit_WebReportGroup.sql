drop  procedure "spu_Audit_WebReportGroup" 
go
create procedure "spu_Audit_WebReportGroup" 
(
	@WebReportGroupID int	 
	,@WebReportGroupName varchar(80)	 
	,@OrgHeirarchyParentId int
	,@Verified smallint
	,@Inactive smallint
	,@WebReportGroupMaster int
	,@LastModified datetime	 	
	,@UpdatedFlag smallint
	,@BatchFlag smallint	 
	,@LastStatEmployeeID int
	,@AuditLogTypeID int
	,@pkc1 int
	,@bitmap binary(3) 
) 
AS 

SELECT TOP 1
	@LastModified = ISNULL(@LastModified, LastModified),
	@LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID),
	@auditLogTypeID = ISNULL(@AuditLogTypeID, AuditLogTypeID)	 	 
FROM
	WebReportGroup
WHERE 
	WebReportGroupID = @pkc1
ORDER BY
	LastModified DESC
	
IF NOT ( SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 -- WebReportGroupID
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 -- WebReportGroupName
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 -- OrgHeirarchyParentId
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 -- Verified
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 -- Inactive
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 -- WebReportGroupMaster
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 -- LastModified
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 -- UpdatedFlag
AND SUBSTRING(@Bitmap, 2,
 1) & 2 <> 2 -- BatchFlag
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 -- AuditLogTypeID 
) 
BEGIN 

insert into WebReportGroup
(
	[WebReportGroupID]
	,[WebReportGroupName]
	,[OrgHierarchyParentID]
	,[Verified]
	,[Inactive]
	,[WebReportGroupMaster]
	,[LastModified]
	,[UpdatedFlag]
	,[BatchFlag]	 
	,[LastStatEmployeeID]
	,[AuditLogTypeID]	
) 
Values 
(
@pkc1
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@WebReportGroupName, '') = '' THEN 'ILB' ELSE @WebReportGroupName END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@OrgHeirarchyParentId, 0) = 0 THEN -2 
ELSE @OrgHeirarchyParentId END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@Verified, 0) = 0 THEN -2 ELSE @Verified END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@Inactive, '') = '' THEN -2 ELSE @Inactive END
,CASE WHEN SUBSTRING
(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@WebReportGroupMaster, 0) = 0 THEN -2 ELSE @WebReportGroupMaster END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@LastModified, '') = '' THEN '01/01/1900' ELSE @LastModified END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@UpdatedFlag, '') = '' THEN -2 ELSE @UpdatedFlag END
,CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@BatchFlag, 0) = 0 THEN -2 ELSE @BatchFlag END
,CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END
,CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4  AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END 
) 
 END 


