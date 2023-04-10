   /****************************************************************************
**  
**  File:   
**  Name: spd_Audit_TcssListArginineVasopressin.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/21/2011  jim hawkins  	Delete Audit records for DBO.TcssListArginineVasopressin
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_TcssListArginineVasopressin]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_TcssListArginineVasopressin]
		PRINT 'Drop Sproc: spd_Audit_TcssListArginineVasopressin'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_TcssListArginineVasopressin'  
GO
create procedure "spd_Audit_TcssListArginineVasopressin" 
	@TcssListArginineVasopressinId int
as

INSERT INTO DBO.TcssListArginineVasopressin 
(
"TcssListArginineVasopressinId"
,"LastUpdateDate"
,"LastUpdateStatEmployeeId" 


)
VALUES
(
@TcssListArginineVasopressinId
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