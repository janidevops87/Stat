 /****************************************************************************
** 
** File:   
** Name: spu_Audit_LogEventLock.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/21/2011  jth     Update Audit records for DBO.LogEventLock
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
SET ANSI_NULLS ON     
go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_LogEventLock]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
begin
	drop procedure [dbo].[spu_Audit_LogEventLock]
	PRINT 'Drop Sproc: spu_Audit_LogEventLock'  
END   
go
PRINT 'Create Sproc: spu_Audit_LogEventLock'  
go
create procedure "spu_Audit_LogEventLock"  
(@CallID int  ,
@OrganizationID int  ,
@LogEventOrg nvarchar(80) ,
@StatEmployeeID int  ,
@LastModified datetime  ,
@LogEventID int  ,
@PKC1 int ,
@Bitmap binary(1)  )  

AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationID  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LogEventOrg  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --StatEmployeeID  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --LastModified  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --LogEventID   )   
)
begin
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@OrganizationID AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LogEventOrg AS VARCHAR(1)), '') 
+ ISNULL(CAST(@StatEmployeeID AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastModified AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LogEventID AS VARCHAR(1)), '')

insert into DBO.LogEventLock  ("CallID" ,"OrganizationID" ,"LogEventOrg" ,"StatEmployeeID" ,"LastModified" ,"LogEventID"  )  
VALUES   
(@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LogEventOrg, '') = '' THEN 'ILB'  ELSE @LogEventOrg END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@StatEmployeeID, 0) = 0 THEN -2 ELSE @StatEmployeeID END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@LogEventID, 0) = 0 THEN -2 ELSE @LogEventID END  )  
END    
go
SET QUOTED_IDENTIFIER OFF   
go
SET ANSI_NULLS ON   
go
