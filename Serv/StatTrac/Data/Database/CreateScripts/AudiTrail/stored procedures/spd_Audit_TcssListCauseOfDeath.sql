   /****************************************************************************
**  
**  File:   
**  Name: spd_Audit_TcssListCauseOfDeath.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/21/2011  jim hawkins  	Delete Audit records for DBO.TcssListCauseOfDeath
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_TcssListCauseOfDeath]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_TcssListCauseOfDeath]
		PRINT 'Drop Sproc: spd_Audit_TcssListCauseOfDeath'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_TcssListCauseOfDeath'  
GO
create procedure "spd_Audit_TcssListCauseOfDeath" 
	@TcssListCauseOfDeathId int
as

INSERT INTO DBO.TcssListCauseOfDeath 
(
"TcssListCauseOfDeathId"
,"LastUpdateDate"
,"LastUpdateStatEmployeeId" 


)
VALUES
(
@TcssListCauseOfDeathId
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