/****************************************************************************
**  
**  File:   
**  Name: spd_Audit_Alert.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Delete Audit records for DBO.Alert
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_Alert]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_Alert]
		PRINT 'Drop Sproc: spd_Audit_Alert'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_Alert'  
GO
create procedure "spd_Audit_Alert" 
	@AlertId int
as

INSERT INTO DBO.Alert 
(
"AlertId"
,"LastModified"
,"LastStatEmployeeID" 
,"AuditLogTypeID"

)
VALUES
(
@AlertId
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