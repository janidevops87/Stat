 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisLung.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisLung**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisLung]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisLung]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisLung'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisLung'  
 go
    create procedure "spi_Audit_TcssDonorDiagnosisLung"  (   @TcssDonorDiagnosisLungId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@DateIntubated datetime  
,@LengthOfRightLung decimal  
,@LengthOfLeftLung decimal  
,@AorticKnobWidth decimal  
,@DiaphragmWidth decimal  
,@DistanceRcpaToLcpa decimal  
,@ChestCircLandmark decimal  
,@TcssListDiagnosisLungChestXrayId int  
,@LeftLungComments varchar(500) 
,@RightLungComments varchar(5000) 
,@DonorPredictedTotalLungCapacity decimal   )  
AS  
 begin
 insert into DBO.TcssDonorDiagnosisLung  (   "TcssDonorDiagnosisLungId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"DateIntubated" 
,"LengthOfRightLung" 
,"LengthOfLeftLung" 
,"AorticKnobWidth" 
,"DiaphragmWidth" 
,"DistanceRcpaToLcpa" 
,"ChestCircLandmark" 
,"TcssListDiagnosisLungChestXrayId" 
,"LeftLungComments" 
,"RightLungComments" 
,"DonorPredictedTotalLungCapacity"  )  
VALUES   
(    @TcssDonorDiagnosisLungId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@DateIntubated  
,@LengthOfRightLung  
,@LengthOfLeftLung  
,@AorticKnobWidth  
,@DiaphragmWidth  
,@DistanceRcpaToLcpa  
,@ChestCircLandmark  
,@TcssListDiagnosisLungChestXrayId  
,@LeftLungComments  
,@RightLungComments  
,@DonorPredictedTotalLungCapacity   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  