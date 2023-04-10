/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_BillTo.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/16/2011  Steve Barron  	Update Audit records for DBO.BillTo
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_BillTo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
	BEGIN 
		drop procedure [dbo].[spu_Audit_BillTo]
		PRINT 'Drop Sproc: spu_Audit_BillTo'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_BillTo'  
GO

create procedure "spu_Audit_BillTo"  
(   
@BillToID int  
,@OrganizationID int  
,@Name nvarchar(100) 
,@Address1 nvarchar(80) 
,@Address2 nvarchar(80) 
,@City nvarchar(30) 
,@StateID int  
,@PostalCode nvarchar(10) 
,@CountryID int  
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int  
,@PKC1 int 
,@Bitmap binary(2)  
)  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationID  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --Name  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --Address1  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --Address2  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --City  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --StateID  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --PostalCode  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --CountryID  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --LastModified  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --LastStatEmployeeId  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --AuditLogTypeId   
)   
BEGIN   
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@OrganizationID AS VARCHAR(1)), '')
+ ISNULL(CAST(@Name AS VARCHAR(1)), '')
+ ISNULL(CAST(@Address1 AS VARCHAR(1)), '')
+ ISNULL(CAST(@Address2 AS VARCHAR(1)), '')
+ ISNULL(CAST(@City AS VARCHAR(1)), '')
+ ISNULL(CAST(@StateID AS VARCHAR(1)), '')
+ ISNULL(CAST(@PostalCode AS VARCHAR(1)), '')
+ ISNULL(CAST(@CountryID AS VARCHAR(1)), '')
--If the only chnage to the record is date time 
--it is a review not update. 
IF @CheckForBlank IS NULL 
	BEGIN 
		SET @AuditLogTypeID = 2 
	END

  --For Tables the do not have LastStatEmployeeID  
  --we will hard code the ID to be a user named  
  --legacy data for the FDA audits.    
  SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  	
	
insert into DBO.BillTo  
(   
"BillToID" 
,"OrganizationID" 
,"Name" 
,"Address1" 
,"Address2" 
,"City" 
,"StateID" 
,"PostalCode" 
,"CountryID" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@Name, '') = '' THEN 'ILB'  ELSE @Name END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@Address1, '') = '' THEN 'ILB'  ELSE @Address1 END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@Address2, '') = '' THEN 'ILB'  ELSE @Address2 END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@City, '') = '' THEN 'ILB'  ELSE @City END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@StateID, 0) = 0 THEN -2 ELSE @StateID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@PostalCode, '') = '' THEN 'ILB'  ELSE @PostalCode END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@CountryID, 0) = 0 THEN -2 ELSE @CountryID END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@LastStatEmployeeId, 0) = 0 THEN -2 ELSE @LastStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@AuditLogTypeId, 0) = 0 THEN -2 ELSE @AuditLogTypeId END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO