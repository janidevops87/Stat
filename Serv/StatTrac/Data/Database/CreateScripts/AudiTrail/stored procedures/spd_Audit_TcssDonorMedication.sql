   /****************************************************************************
**  
**  File:   
**  Name: spd_Audit_TcssDonorMedication.sql  
**  Desc:   
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/21/2011  jim hawkins  	Delete Audit records for DBO.TcssDonorMedication
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON     
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_TcssDonorMedication]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spd_Audit_TcssDonorMedication]
		PRINT 'Drop Sproc: spd_Audit_TcssDonorMedication'  
	END   
GO 

PRINT 'Create Sproc: spd_Audit_TcssDonorMedication'  
GO
create procedure "spd_Audit_TcssDonorMedication" 
	@TcssDonorMedicationId int
as

INSERT INTO DBO.TcssDonorMedication 
(
"TcssDonorMedicationId"
,"LastUpdateDate"
,"LastUpdateStatEmployeeId" 


)
VALUES
(
@TcssDonorMedicationId
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