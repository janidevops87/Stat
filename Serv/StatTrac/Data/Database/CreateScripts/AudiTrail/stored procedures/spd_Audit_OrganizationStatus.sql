/****************************************************************************
**  
**  File:   
**  Name: spd_Audit_OrganizationStatus.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Delete Audit records for DBO.OrganizationStatus
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_OrganizationStatus]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_OrganizationStatus]
		PRINT 'Drop Sproc: spd_Audit_OrganizationStatus'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_OrganizationStatus'  
GO
create procedure "spd_Audit_OrganizationStatus" 
	@OrganizationStatusID int
as

INSERT INTO DBO.OrganizationStatus 
(
"OrganizationStatusID"
,"LastModified"
,"LastStatEmployeeID" 
,"AuditLogTypeID"

)
VALUES
(
@OrganizationStatusID
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