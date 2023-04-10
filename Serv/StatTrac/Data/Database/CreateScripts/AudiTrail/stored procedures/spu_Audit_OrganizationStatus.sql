﻿/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_OrganizationStatus.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/15/2011  Steve Barron  	Update Audit records for DBO.OrganizationStatus
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_OrganizationStatus]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spu_Audit_OrganizationStatus]
		PRINT 'Drop Sproc: spu_Audit_OrganizationStatus'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_OrganizationStatus'  
GO

create procedure "spu_Audit_OrganizationStatus"  
(   
@OrganizationStatusID int  
,@OrganizationStatusName nvarchar(25) 
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int  
,@PKC1 int 
,@Bitmap binary(1)  
)  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationStatusName  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --LastStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --AuditLogTypeId   
)   
BEGIN 

DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@OrganizationStatusName AS VARCHAR(1)), '')
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

  
insert into DBO.OrganizationStatus  
(   
"OrganizationStatusID" 
,"OrganizationStatusName" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  )  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationStatusName, '') = '' THEN 'ILB'  ELSE @OrganizationStatusName END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@LastStatEmployeeId, 0) = 0 THEN -2 ELSE @LastStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@AuditLogTypeId, 0) = 0 THEN -2 ELSE @AuditLogTypeId END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO