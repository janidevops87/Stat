/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_BloodProduct.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/20/2011  Steve Barron  	Update Audit records for DBO.BloodProduct
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_BloodProduct]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
	drop procedure [dbo].[spu_Audit_BloodProduct]
	PRINT 'Drop Sproc: spu_Audit_BloodProduct'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_BloodProduct'  
GO

create procedure "spu_Audit_BloodProduct"  
(   
@BloodProductId int  
,@BloodProductName varchar(50) 
,@BloodProductType varchar(50) 
,@PKC1 int 
,@Bitmap binary(1)  
)  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --BloodProductName  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --BloodProductType   
)   
BEGIN

DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@BloodProductName AS VARCHAR(1)), '')
+ ISNULL(CAST(@BloodProductType AS VARCHAR(1)), '')
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
   
insert into DBO.BloodProduct  
(   
"BloodProductId" 
,"BloodProductName" 
,"BloodProductType"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@BloodProductName, '') = '' THEN 'ILB'  ELSE @BloodProductName END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@BloodProductType, '') = '' THEN 'ILB'  ELSE @BloodProductType END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO