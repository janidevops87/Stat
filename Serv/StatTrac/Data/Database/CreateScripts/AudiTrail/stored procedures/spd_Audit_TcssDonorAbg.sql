  /****************************************************************************
**  
**  File:   
**  Name: spd_Audit_TcssDonorAbg.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/21/2011  jim hawkins  	Delete Audit records for DBO.TcssDonorAbg
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_TcssDonorAbg]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_TcssDonorAbg]
		PRINT 'Drop Sproc: spd_Audit_TcssDonorAbg'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_TcssDonorAbg'  
GO
create procedure "spd_Audit_TcssDonorAbg" 
	@TcssDonorAbgId int
as

INSERT INTO DBO.TcssDonorAbg 
(
"TcssDonorAbgId"
,"LastUpdateDate"
,"LastUpdateStatEmployeeId" 


)
VALUES
(
@TcssDonorAbgId
,GETDATE()
--2241 is Legacy Data User
--Existing OLTP does not have last update user
--to be comliant with FDA we are adding this user
,2241


)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO