 /****************************************************************************
** 
** File:   
** Name: spi_Audit_LogEventLock.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/21/2011  Jim Hawkins  Insert Audit records for DBO.LogEventLock
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
SET ANSI_NULLS ON     
go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_LogEventLock]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
begin
drop procedure [dbo].[spi_Audit_LogEventLock]PRINT 'Drop Sproc: spi_Audit_LogEventLock'  
END   
go
PRINT 'Create Sproc: spi_Audit_LogEventLock'  
go
create procedure "spi_Audit_LogEventLock"  (   @CallID int  ,@OrganizationID int  ,@LogEventOrg nvarchar(80) ,@StatEmployeeID int  ,@LastModified datetime  ,@LogEventID int   )  AS  
begin
 insert into DBO.LogEventLock  (   "CallID" 
,"OrganizationID" 
,"LogEventOrg" 
,"StatEmployeeID" 
,"LastModified" 
,"LogEventID"  )  VALUES   (    @CallID  ,@OrganizationID  ,@LogEventOrg  ,@StatEmployeeID  ,@LastModified  ,@LogEventID   )  
END    
go
SET QUOTED_IDENTIFIER OFF   
go
SET ANSI_NULLS ON   
go
  