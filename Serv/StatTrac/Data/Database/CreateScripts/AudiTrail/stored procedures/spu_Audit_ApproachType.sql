/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_ApproachType.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/17/2011  Steve Barron  	Update Audit records for DBO.ApproachType
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_ApproachType]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spu_Audit_ApproachType]
		PRINT 'Drop Sproc: spu_Audit_ApproachType'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_ApproachType'  
GO

create procedure "spu_Audit_ApproachType"  
(   
@ApproachTypeID int  
,@ApproachTypeName varchar(50) 
,@Verified smallint  
,@Inactive smallint  
,@LastModified datetime  
,@UpdatedFlag smallint  
,@PKC1 int 
,@Bitmap binary(1)  
)  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --ApproachTypeName  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --Verified  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --Inactive  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --UpdatedFlag   
)   
BEGIN   

DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@ApproachTypeName AS VARCHAR(1)), '')
+ ISNULL(CAST(@Verified AS VARCHAR(1)), '')
+ ISNULL(CAST(@Inactive AS VARCHAR(1)), '')
+ ISNULL(CAST(@UpdatedFlag AS VARCHAR(1)), ''
)
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
	
insert into DBO.ApproachType  
(   
"ApproachTypeID" 
,"ApproachTypeName" 
,"Verified" 
,"Inactive" 
,"LastModified" 
,"UpdatedFlag"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@ApproachTypeName, '') = '' THEN 'ILB'  ELSE @ApproachTypeName END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@Verified, 0) = 0 THEN -2 ELSE @Verified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@Inactive, 0) = 0 THEN -2 ELSE @Inactive END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@UpdatedFlag, 0) = 0 THEN -2 ELSE @UpdatedFlag END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO