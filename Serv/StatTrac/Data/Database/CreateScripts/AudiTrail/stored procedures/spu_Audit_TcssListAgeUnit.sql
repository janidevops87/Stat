 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssListAgeUnit.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/27/2011  jim hawkins   Update Audit records for DBO.TcssListAgeUnit**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssListAgeUnit]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spu_Audit_TcssListAgeUnit]
 PRINT 'Drop Sproc: spu_Audit_TcssListAgeUnit'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssListAgeUnit'  
 GO
   create procedure "spu_Audit_TcssListAgeUnit"  
   (   @TcssListAgeUnitId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@SortOrder int  
,@IsActive bit  
,@FieldValue varchar(100) 
,@UnosValue varchar(100) 
,@PKC1 int 
,@Bitmap binary(2)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --SortOrder  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --IsActive  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --FieldValue  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --UnosValue   
)   
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); 
 SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SortOrder AS VARCHAR(1)), '') 
+ ISNULL(Cast(@IsActive AS VARCHAR(1)), '') 
+ ISNULL(CAST(@FieldValue AS VARCHAR(1)), '') 
+ ISNULL(CAST(@UnosValue AS VARCHAR(1)), '')
   insert into DBO.TcssListAgeUnit  
   (   "TcssListAgeUnitId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"SortOrder" 
,"IsActive" 
,"FieldValue" 
,"UnosValue"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@SortOrder, 0) = 0 THEN -2 ELSE @SortOrder END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@IsActive, 0) = 0 THEN 0 ELSE @IsActive END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@FieldValue, '') = '' THEN 'ILB'  ELSE @FieldValue END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@UnosValue, '') = '' THEN 'ILB'  ELSE @UnosValue END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  