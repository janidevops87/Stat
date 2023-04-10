/****************************************************************************
**  
**  File:   
**  Name: spu_Audit_Alert.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Update Audit records for DBO.Alert
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Alert]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spu_Audit_Alert]
		PRINT 'Drop Sproc: spu_Audit_Alert'  
	END   
GO 

PRINT 'Create Sproc: spu_Audit_Alert'  
GO   

create procedure "spu_Audit_Alert"  
(   
@AlertID int
,@AlertGroupName varchar(80) 
,@AlertMessage1 ntext
,@AlertMessage2 ntext
,@LastModified datetime
,@AlertTypeID int
,@AlertLookupCode varchar(8) 
,@AlertScheduleMessage ntext
,@UpdatedFlag smallint
,@AlertQAMessage1 ntext
,@AlertQAMessage2 ntext
,@LastStatEmployeeID int
,@AuditLogTypeID int
,@PKC1 int ,
@Bitmap binary(2)  
)  
AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --AlertGroupName  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --AlertMessage1  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --AlertMessage2  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --AlertTypeID  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --AlertLookupCode  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --AlertScheduleMessage  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --UpdatedFlag  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --AlertQAMessage1  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --AlertQAMessage2  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --LastStatEmployeeID  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --AuditLogTypeID   
)   
BEGIN   
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@AlertGroupName AS VARCHAR(1)), '')
+ ISNULL(CAST(@AlertMessage1 AS VARCHAR(1)), '')
+ ISNULL(CAST(@AlertMessage2 AS VARCHAR(1)), '')
+ ISNULL(CAST(@AlertTypeID AS VARCHAR(1)), '')
+ ISNULL(CAST(@AlertLookupCode AS VARCHAR(1)), '')
+ ISNULL(CAST(@AlertScheduleMessage AS VARCHAR(1)), '')
+ ISNULL(CAST(@UpdatedFlag AS VARCHAR(1)), '')
+ ISNULL(CAST(@AlertQAMessage1 AS VARCHAR(1)), '')
+ ISNULL(CAST(@AlertQAMessage2 AS VARCHAR(1)), '')
+ ISNULL(CAST(@AuditLogTypeID AS VARCHAR(1)), '')

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

insert into DBO.Alert  
(   
"AlertID" 
,"AlertGroupName" 
,"AlertMessage1" 
,"AlertMessage2" 
,"LastModified" 
,"AlertTypeID" 
,"AlertLookupCode" 
,"AlertScheduleMessage" 
,"UpdatedFlag" 
,"AlertQAMessage1" 
,"AlertQAMessage2" 
,"LastStatEmployeeID" 
,"AuditLogTypeID"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@AlertGroupName, '') = '' THEN 'ILB'  ELSE @AlertGroupName END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(CAST(@AlertMessage1 AS VARCHAR(1000)), '') = '' THEN 'ILB'  ELSE @AlertMessage1 END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(CAST(@AlertMessage2 AS VARCHAR(1000)), '') = '' THEN 'ILB'  ELSE @AlertMessage2 END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@AlertTypeID, 0) = 0 THEN -2 ELSE @AlertTypeID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@AlertLookupCode, '') = '' THEN 'ILB'  ELSE @AlertLookupCode END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(CAST(@AlertScheduleMessage AS VARCHAR(1000)), '') = '' THEN 'ILB'  ELSE @AlertScheduleMessage END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@UpdatedFlag, 0) = 0 THEN -2 ELSE @UpdatedFlag END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(CAST(@AlertQAMessage1 AS VARCHAR(1000)), '') = '' THEN 'ILB'  ELSE @AlertQAMessage1 END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(CAST(@AlertQAMessage2 AS VARCHAR(1000)), '') = '' THEN 'ILB'  ELSE @AlertQAMessage2 END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END  
)  
END    
GO  

SET QUOTED_IDENTIFIER OFF   
GO  

SET ANSI_NULLS ON   
GO  