/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_Approach.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/17/2011  Steve Barron  	Update Audit records for DBO.Approach
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Approach]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spu_Audit_Approach]
		PRINT 'Drop Sproc: spu_Audit_Approach'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_Approach'  
GO

 create procedure "spu_Audit_Approach"  
 (   
 @ApproachID int  
,@ApproachName varchar(50) 
,@ApproachReportName varchar(9) 
,@Verified smallint  
,@Inactive smallint  
,@ApproachReportDisplaySort1 int  
,@LastModified datetime  
,@ApproachReportCode varchar(3) 
,@UpdatedFlag smallint  
,@PKC1 int 
,@Bitmap binary(2)  
)  
AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --ApproachName  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --ApproachReportName  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --Verified  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --Inactive  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --ApproachReportDisplaySort1  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --ApproachReportCode  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --UpdatedFlag   
)   
BEGIN   

DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@ApproachName AS VARCHAR(1)), '')
+ ISNULL(CAST(@ApproachReportName AS VARCHAR(1)), '')
+ ISNULL(CAST(@Verified AS VARCHAR(1)), '')
+ ISNULL(CAST(@Inactive AS VARCHAR(1)), '')
+ ISNULL(CAST(@ApproachReportDisplaySort1 AS VARCHAR(1)), '')
+ ISNULL(CAST(@ApproachReportCode AS VARCHAR(1)), '')
+ ISNULL(CAST(@UpdatedFlag AS VARCHAR(1)), '')
--If the only chnage to the record is date time 
--it is a review not update. 
--IF @CheckForBlank IS NULL 
--	BEGIN 
--		SET @AuditLogTypeID = 2 
--	END

--For Tables the do not have LastStatEmployeeID  
--we will hard code the ID to be a user named  
--legacy data for the FDA audits.    
--SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  	

insert into DBO.Approach  
(   
"ApproachID" 
,"ApproachName" 
,"ApproachReportName" 
,"Verified" 
,"Inactive" 
,"ApproachReportDisplaySort1" 
,"LastModified" 
,"ApproachReportCode" 
,"UpdatedFlag"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@ApproachName, '') = '' THEN 'ILB'  ELSE @ApproachName END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@ApproachReportName, '') = '' THEN 'ILB'  ELSE @ApproachReportName END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@Verified, 0) = 0 THEN -2 ELSE @Verified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@Inactive, 0) = 0 THEN -2 ELSE @Inactive END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@ApproachReportDisplaySort1, 0) = 0 THEN -2 ELSE @ApproachReportDisplaySort1 END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@ApproachReportCode, '') = '' THEN 'ILB'  ELSE @ApproachReportCode END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@UpdatedFlag, 0) = 0 THEN -2 ELSE @UpdatedFlag END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO