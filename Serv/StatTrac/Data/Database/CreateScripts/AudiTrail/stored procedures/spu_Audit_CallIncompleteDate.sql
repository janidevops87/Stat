 /****************************************************************************
** 
** File:   
** Name: spu_Audit_CallIncompleteDate.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/21/2011  Jim Hawkins  Update Audit records for DBO.CallIncompleteDate
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
SET ANSI_NULLS ON    
go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_CallIncompleteDate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
begin
 drop procedure [dbo].[spu_Audit_CallIncompleteDate]PRINT 'Drop Sproc: spu_Audit_CallIncompleteDate'  
END   
go
PRINT 'Create Sproc: spu_Audit_CallIncompleteDate'  
go

create procedure "spu_Audit_CallIncompleteDate"  (   @CallID int  
,@StatEmployeeID int  
,@LastModified datetime  
,@PKC1 int 
,@Bitmap binary(1)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --StatEmployeeID  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4) --LastModified   )  
begin
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@StatEmployeeID AS VARCHAR(1)), '') + ISNULL(CAST(@LastModified AS VARCHAR(1)), '')--If the only chnage to the record is date time --it is a review not update. 
END
Begin
insert into DBO.CallIncompleteDate  (   "CallID" 
,"StatEmployeeID" 
,"LastModified"  )  VALUES   (   @PKC1, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@StatEmployeeID, 0) = 0 THEN -2 ELSE @StatEmployeeID END, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END  )  
END    
go
SET QUOTED_IDENTIFIER OFF   
go
SET ANSI_NULLS ON   
go
  