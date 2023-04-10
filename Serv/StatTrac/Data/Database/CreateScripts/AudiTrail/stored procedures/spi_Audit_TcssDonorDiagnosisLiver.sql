 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisLiver.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisLiver**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisLiver]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisLiver]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisLiver'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisLiver'  
 go
    create procedure "spi_Audit_TcssDonorDiagnosisLiver"  
	(   @TcssDonorDiagnosisLiverId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListLiverBiopsyId int  
,@Comment varchar(5000)  )  
AS  
 begin
  insert into DBO.TcssDonorDiagnosisLiver  (   "TcssDonorDiagnosisLiverId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListLiverBiopsyId" 
,"Comment"  )  
VALUES   
(    @TcssDonorDiagnosisLiverId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListLiverBiopsyId  
,@Comment   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  