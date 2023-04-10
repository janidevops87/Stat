/****************************************************************************
**  
**  File:   
**  Name: spd_Audit_OrganizationDashBoardTimer.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Delete Audit records for DBO.OrganizationDashBoardTimer
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_OrganizationDashBoardTimer]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_OrganizationDashBoardTimer]
		PRINT 'Drop Sproc: spd_Audit_OrganizationDashBoardTimer'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_OrganizationDashBoardTimer'  
GO
create procedure "spd_Audit_OrganizationDashBoardTimer" 
	@OrganizationDashBoardTimerId int
as

INSERT INTO DBO.OrganizationDashBoardTimer 
(
"OrganizationDashBoardTimerId"
,"LastModified"
,"LastStatEmployeeID" 
,"AuditLogTypeID"

)
VALUES
(
@OrganizationDashBoardTimerId
,GETDATE()
--2241 is Legacy Data User
--Existing OLTP does not have last update user
--to be comliant with FDA we are adding this user
,2241
,4

)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO