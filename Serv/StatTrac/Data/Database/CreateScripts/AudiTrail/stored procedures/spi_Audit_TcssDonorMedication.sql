 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorMedication.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorMedication**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorMedication]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorMedication]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorMedication'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorMedication'  
 GO
    create procedure "spi_Audit_TcssDonorMedication"  
	(   @TcssDonorMedicationId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListMedicationId int  
,@StartDate smalldatetime  
,@StopDateTime smalldatetime  
,@Dose decimal  
,@TcssListMedicationDoseUnitId int  
,@Duration int   )  
AS  
 BEGIN
 insert into DBO.TcssDonorMedication  
 (   "TcssDonorMedicationId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListMedicationId" 
,"StartDate" 
,"StopDateTime" 
,"Dose" 
,"TcssListMedicationDoseUnitId" 
,"Duration"  )  
VALUES   
(    @TcssDonorMedicationId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListMedicationId  
,@StartDate  
,@StopDateTime  
,@Dose  
,@TcssListMedicationDoseUnitId  
,@Duration   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  