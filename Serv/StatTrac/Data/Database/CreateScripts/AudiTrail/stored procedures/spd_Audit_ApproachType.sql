/****************************************************************************
**  
**  File:   
**  Name: spd_Audit_ApproachType.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Delete Audit records for DBO.ApproachType
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_ApproachType]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_ApproachType]
		PRINT 'Drop Sproc: spd_Audit_ApproachType'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_ApproachType'  
GO
create procedure "spd_Audit_ApproachType" 
	@ApproachTypeIdId int
as

INSERT INTO DBO.ApproachType 
(
"ApproachTypeId"
,"LastModified"
--,"LastStatEmployeeID" 
--,"AuditLogTypeID"

)
VALUES
(
@ApproachTypeIdId
,GETDATE()
--2241 is Legacy Data User
--Existing OLTP does not have last update user
--to be comliant with FDA we are adding this user
--,2241
--,4

)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO