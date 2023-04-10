/****************************************************************************
**  
**  File:   
**  Name: spd_Audit_BillTo.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/16/2011  Steve Barron  	Delete Audit records for DBO.BillTo
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_BillTo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_BillTo]
		PRINT 'Drop Sproc: spd_Audit_BillTo'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_BillTo'  
GO
create procedure "spd_Audit_BillTo" 
	@BillToIdId int
as

INSERT INTO DBO.BillTo 
(
"BillToId"
,"LastModified"
,"LastStatEmployeeID" 
,"AuditLogTypeID"

)
VALUES
(
@BillToIdId
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