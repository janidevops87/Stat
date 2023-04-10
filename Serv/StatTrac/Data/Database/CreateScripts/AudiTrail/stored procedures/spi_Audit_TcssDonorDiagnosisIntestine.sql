 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisIntestine.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisIntestine**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisIntestine]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisIntestine]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisIntestine'  
 END   
 go 
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisIntestine'  
 go    
 create procedure "spi_Audit_TcssDonorDiagnosisIntestine"  
 (   @TcssDonorDiagnosisIntestineId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@Comment varchar(5000))
AS  
BEGIN 
insert into DBO.TcssDonorDiagnosisIntestine  
(   "TcssDonorDiagnosisIntestineId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"Comment"  )  
VALUES   
(    @TcssDonorDiagnosisIntestineId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@Comment   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go  