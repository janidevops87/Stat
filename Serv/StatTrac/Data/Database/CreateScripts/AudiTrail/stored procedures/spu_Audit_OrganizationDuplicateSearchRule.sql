/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_OrganizationDuplicateSearchRule.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/15/2011  Steve Barron  	Update Audit records for DBO.OrganizationDuplicateSearchRule
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_OrganizationDuplicateSearchRule]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spu_Audit_OrganizationDuplicateSearchRule]
		PRINT 'Drop Sproc: spu_Audit_OrganizationDuplicateSearchRule'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_OrganizationDuplicateSearchRule'  
GO

create procedure "spu_Audit_OrganizationDuplicateSearchRule"  
(   
@OrganizationDuplicateSearchRuleId int  
,@OrganizationId int  
,@DuplicateSearchRuleId int  
,@CallTypeID int  
,@NumberOfDaysToSearch int  
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int  
,@PKC1 int 
,@Bitmap binary(2)  
)  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --DuplicateSearchRuleId  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --CallTypeID  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --NumberOfDaysToSearch  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --LastStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --AuditLogTypeId   
)   
BEGIN   
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@OrganizationId AS VARCHAR(1)), '')
+ ISNULL(CAST(@DuplicateSearchRuleId AS VARCHAR(1)), '')
+ ISNULL(CAST(@CallTypeID AS VARCHAR(1)), '')
+ ISNULL(CAST(@NumberOfDaysToSearch AS VARCHAR(1)), '')

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
  
  
insert into DBO.OrganizationDuplicateSearchRule  
(   
"OrganizationDuplicateSearchRuleId" 
,"OrganizationId" 
,"DuplicateSearchRuleId" 
,"CallTypeID" 
,"NumberOfDaysToSearch" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationId, 0) = 0 THEN -2 ELSE @OrganizationId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@DuplicateSearchRuleId, 0) = 0 THEN -2 ELSE @DuplicateSearchRuleId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@CallTypeID, 0) = 0 THEN -2 ELSE @CallTypeID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@NumberOfDaysToSearch, 0) = 0 THEN -2 ELSE @NumberOfDaysToSearch END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@LastStatEmployeeId, 0) = 0 THEN -2 ELSE @LastStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@AuditLogTypeId, 0) = 0 THEN -2 ELSE @AuditLogTypeId END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO