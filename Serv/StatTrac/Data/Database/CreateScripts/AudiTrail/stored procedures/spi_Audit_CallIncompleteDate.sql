 /****************************************************************************
** 
** File:   
** Name: spi_Audit_CallIncompleteDate.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/21/2011  Jim Hawkins  Insert Audit records for DBO.CallIncompleteDate
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_CallIncompleteDate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
begin
 drop procedure [dbo].[spi_Audit_CallIncompleteDate]PRINT 'Drop Sproc: spi_Audit_CallIncompleteDate'  
END   
go
PRINT 'Create Sproc: spi_Audit_CallIncompleteDate'
go  
create procedure "spi_Audit_CallIncompleteDate"  
(@CallID int,  
@StatEmployeeID int,
@LastModified datetime   )  
AS  
begin
 --Legacy Tables do not have the Last Employee ID   --We are adding Legacy Data until the code and tables  --can be modified.  SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  
 insert into DBO.CallIncompleteDate  (   "CallID" 
,"StatEmployeeID" 
,"LastModified")  VALUES   (@CallID,  
@StatEmployeeID, 
@LastModified)  
END    
go
SET QUOTED_IDENTIFIER OFF   
go
SET ANSI_NULLS ON   
go
  