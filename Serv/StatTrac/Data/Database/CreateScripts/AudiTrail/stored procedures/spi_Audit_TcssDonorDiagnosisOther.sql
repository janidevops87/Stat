 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisOther.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisOther**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisOther]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisOther]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisOther'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisOther'  
 go
    create procedure "spi_Audit_TcssDonorDiagnosisOther"  
	(   @TcssDonorDiagnosisOtherId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListOtherOrganId int  
,@Comment varchar(5000)  )  
AS  
 begin
 insert into DBO.TcssDonorDiagnosisOther  
 (   "TcssDonorDiagnosisOtherId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListOtherOrganId" 
,"Comment"  )  
VALUES   
(    @TcssDonorDiagnosisOtherId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListOtherOrganId  
,@Comment   ) 
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  