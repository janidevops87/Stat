/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_AppScreen.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/15/2011  Steve Barron  	Update Audit records for DBO.AppScreen
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_AppScreen]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spu_Audit_AppScreen]
		PRINT 'Drop Sproc: spu_Audit_AppScreen'  
	END   
GO

PRINT 'Create Sproc: spu_Audit_AppScreen'  
GO

create procedure "spu_Audit_AppScreen"  
(   
@AppScreenId int  
,@ParentId int  
,@ScreenName varchar(100) 
,@SortOrder int  
,@ShortCutKey varchar(10) 
,@PKC1 int 
,@Bitmap binary(1)  
) 
 AS  
 IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --ParentId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --ScreenName  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --SortOrder  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --ShortCutKey   
)   
BEGIN   

DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@ParentId AS VARCHAR(1)), '')
+ ISNULL(CAST(@ScreenName AS VARCHAR(1)), '')
+ ISNULL(CAST(@SortOrder AS VARCHAR(1)), '')
+ ISNULL(CAST(@ShortCutKey AS VARCHAR(1)), '')
--If the only chnage to the record is date time 
--it is a review not update. 
--IF @CheckForBlank IS NULL 
--	BEGIN 
--		SET @AuditLogTypeID = 2 
--	END

insert into DBO.AppScreen  
(   
"AppScreenId" 
,"ParentId" 
,"ScreenName" 
,"SortOrder" 
,"ShortCutKey"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@ParentId, 0) = 0 THEN -2 ELSE @ParentId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@ScreenName, '') = '' THEN 'ILB'  ELSE @ScreenName END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@SortOrder, 0) = 0 THEN -2 ELSE @SortOrder END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@ShortCutKey, '') = '' THEN 'ILB'  ELSE @ShortCutKey END  
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO

  