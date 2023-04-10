/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_OrganizationDashBoardTimer.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Insert Audit records for DBO.OrganizationDashBoardTimer
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_OrganizationDashBoardTimer]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_OrganizationDashBoardTimer]
			PRINT 'Drop Sproc: spi_Audit_OrganizationDashBoardTimer'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_OrganizationDashBoardTimer'  
GO

create procedure "spi_Audit_OrganizationDashBoardTimer"  		
(   
@OrganizationDashBoardTimerId int  
,@OrganizationId int  
,@DashBoardWindowId int  
,@DashBoardTimerTypeId int  
,@ExpirationMinutes int  
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
SET @LastStatEmployeeID = 2241; 

insert into DBO.OrganizationDashBoardTimer  
(   
"OrganizationDashBoardTimerId" 
,"OrganizationId" 
,"DashBoardWindowId" 
,"DashBoardTimerTypeId" 
,"ExpirationMinutes" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  
)  
VALUES   
(    
@OrganizationDashBoardTimerId  
,@OrganizationId  
,@DashBoardWindowId  
,@DashBoardTimerTypeId  
,@ExpirationMinutes  
,@LastModified  
,@LastStatEmployeeId  
,1   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO

   