/****************************************************************************
**  
**  File:   
**  Name: spd_Audit_OrganizationASPSetting.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Delete Audit records for DBO.OrganizationASPSetting
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_OrganizationASPSetting]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_OrganizationASPSetting]
		PRINT 'Drop Sproc: spd_Audit_OrganizationASPSetting'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_OrganizationASPSetting'  
GO
create procedure "spd_Audit_OrganizationASPSetting" 
	@OrganizationASPSettingId int
as

INSERT INTO DBO.OrganizationASPSetting 
(
"OrganizationASPSettingId"
,"LastModified"
,"LastStatEmployeeID" 
,"AuditLogTypeID"

)
VALUES
(
@OrganizationASPSettingId
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