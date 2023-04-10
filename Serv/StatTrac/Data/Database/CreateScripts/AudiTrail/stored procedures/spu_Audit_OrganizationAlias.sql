/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_OrganizationAlias.sql  
**  Desc:   
**  
**  Date:     Author:    Description:  
**  --------    --------   -------------------------------------------  
**  06/14/2011  Steve Barron  Update Audit records for DBO.OrganizationAlias
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_OrganizationAlias]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spu_Audit_OrganizationAlias]
		PRINT 'Drop Sproc: spu_Audit_OrganizationAlias'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_OrganizationAlias'  
GO

create procedure "spu_Audit_OrganizationAlias"  
(   
@OrganizationAliasId int  
,@OrganizationId int  
,@OrganizationAliasName nvarchar(80) 
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int  
,@PKC1 int 
,@Bitmap binary(1)  
)  
AS  
IF NOT (
SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --OrganizationAliasName  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --LastStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --AuditLogTypeId   
)   
BEGIN   
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@OrganizationId AS VARCHAR(1)), '')
+ ISNULL(CAST(@OrganizationAliasName AS VARCHAR(1)), '')

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
	
insert into DBO.OrganizationAlias  
(   
"OrganizationAliasId" 
,"OrganizationId" 
,"OrganizationAliasName" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationId, 0) = 0 THEN -2 ELSE @OrganizationId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@OrganizationAliasName, '') = '' THEN 'ILB'  ELSE @OrganizationAliasName END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@LastStatEmployeeId, 0) = 0 THEN -2 ELSE @LastStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@AuditLogTypeId, 0) = 0 THEN -2 ELSE @AuditLogTypeId END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO

  