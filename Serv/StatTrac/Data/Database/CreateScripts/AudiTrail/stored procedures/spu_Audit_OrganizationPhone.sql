/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_OrganizationPhone.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/15/2011  Steve Barron  	Update Audit records for DBO.OrganizationPhone
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO


SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_OrganizationPhone]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN
		drop procedure [dbo].[spu_Audit_OrganizationPhone]
		PRINT 'Drop Sproc: spu_Audit_OrganizationPhone'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_OrganizationPhone'  
GO

create procedure "spu_Audit_OrganizationPhone"  
(   
@OrganizationPhoneID int  
,@OrganizationID int  
,@PhoneID int  
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int  
,@SubLocationID int  
,@SubLocationLevelID int  
,@Inactive smallint  
,@PKC1 int 
,@Bitmap binary(2)  
)  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationID  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --PhoneID  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --LastStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --AuditLogTypeId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --SubLocationID  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --SubLocationLevelID  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --Inactive   
)   
BEGIN   

DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@OrganizationID AS VARCHAR(1)), '')
+ ISNULL(CAST(@PhoneID AS VARCHAR(1)), '')
+ ISNULL(CAST(@SubLocationID AS VARCHAR(1)), '')
+ ISNULL(CAST(@SubLocationLevelID AS VARCHAR(1)), '')
+ ISNULL(CAST(@Inactive AS VARCHAR(1)), '')
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
	
insert into DBO.OrganizationPhone  
(   
"OrganizationPhoneID" 
,"OrganizationID" 
,"PhoneID" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId" 
,"SubLocationID" 
,"SubLocationLevelID" 
,"Inactive"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@PhoneID, 0) = 0 THEN -2 ELSE @PhoneID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@LastStatEmployeeId, 0) = 0 THEN -2 ELSE @LastStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@AuditLogTypeId, 0) = 0 THEN -2 ELSE @AuditLogTypeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@SubLocationID, 0) = 0 THEN -2 ELSE @SubLocationID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@SubLocationLevelID, 0) = 0 THEN -2 ELSE @SubLocationLevelID END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@Inactive, 0) = 0 THEN -2 ELSE @Inactive END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO