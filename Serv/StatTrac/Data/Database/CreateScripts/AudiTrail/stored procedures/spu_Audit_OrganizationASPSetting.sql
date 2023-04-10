/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_OrganizationASPSetting.sql  
**  Desc:   
**  
**  Date:     Author:    Description:  
**  --------    --------   -------------------------------------------  
**  06/15/2011  Steve Barron  Update Audit records for DBO.OrganizationASPSetting
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_OrganizationASPSetting]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spu_Audit_OrganizationASPSetting]
		PRINT 'Drop Sproc: spu_Audit_OrganizationASPSetting'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_OrganizationASPSetting'  
GO

create procedure "spu_Audit_OrganizationASPSetting"  
(   
@OrganizationASPSettingId int  
,@OrganizationId int  
,@AspSettingTypeId int  
,@LinkToStatlinePhoneSystem int  
,@AutoDisplaySourceCode int  
,@AutoDisplaySourceCodeId int  
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int  
,@PKC1 int 
,@Bitmap binary(2)  
)  
AS  
IF NOT (
SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --AspSettingTypeId  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --LinkToStatlinePhoneSystem  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --AutoDisplaySourceCode  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --AutoDisplaySourceCodeId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --LastStatEmployeeId  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --AuditLogTypeId   
)   
BEGIN   
DECLARE @CheckForBlank VARCHAR(250); 

SELECT @CheckForBlank = ISNULL(CAST(@OrganizationId AS VARCHAR(1)), '')
+ ISNULL(CAST(@AspSettingTypeId AS VARCHAR(1)), '')
+ ISNULL(CAST(@LinkToStatlinePhoneSystem AS VARCHAR(1)), '')
+ ISNULL(CAST(@AutoDisplaySourceCode AS VARCHAR(1)), '')
+ ISNULL(CAST(@AutoDisplaySourceCodeId AS VARCHAR(1)), '')


--If the only chnage to the record is date time 
--it is a review not update. 
IF @CheckForBlank IS NULL 
	BEGIN 
		SET @AuditLogTypeID = 2 
	END

  --For Tables the do not have LastStatEmployeeID  
  --we will hard code the ID to be a user named  
  --legacy data for the FDA audits.    
  SET @LastStatEmployeeID = 2241 	
	
insert into DBO.OrganizationASPSetting  
(   
"OrganizationASPSettingId" 
,"OrganizationId" 
,"AspSettingTypeId" 
,"LinkToStatlinePhoneSystem" 
,"AutoDisplaySourceCode" 
,"AutoDisplaySourceCodeId" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationId, 0) = 0 THEN -2 ELSE @OrganizationId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@AspSettingTypeId, 0) = 0 THEN -2 ELSE @AspSettingTypeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@LinkToStatlinePhoneSystem, 0) = 0 THEN -2 ELSE @LinkToStatlinePhoneSystem END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@AutoDisplaySourceCode, 0) = 0 THEN -2 ELSE @AutoDisplaySourceCode END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@AutoDisplaySourceCodeId, 0) = 0 THEN -2 ELSE @AutoDisplaySourceCodeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@LastStatEmployeeId, 0) = 0 THEN -2 ELSE @LastStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@AuditLogTypeId, 0) = 0 THEN -2 ELSE @AuditLogTypeId END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO