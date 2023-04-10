 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisKidneyBiopsy.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisKidneyBiopsy**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
Set ANSI_NULLS ON     
go 
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisKidneyBiopsy]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisKidneyBiopsy]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisKidneyBiopsy'  
 END   
go 
PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisKidneyBiopsy'  
go  
create procedure "spi_Audit_TcssDonorDiagnosisKidneyBiopsy"  
(   @TcssDonorDiagnosisKidneyBiopsyId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@DateTime datetime  
,@Flow varchar(50) 
,@PressureSystolic varchar(50) 
,@PressureDiastolic varchar(50) 
,@Resistance varchar(50)  )  
AS  
Begin
  insert into DBO.TcssDonorDiagnosisKidneyBiopsy  
  (   "TcssDonorDiagnosisKidneyBiopsyId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"DateTime" 
,"Flow" 
,"PressureSystolic" 
,"PressureDiastolic" 
,"Resistance"  )  
VALUES   
(    @TcssDonorDiagnosisKidneyBiopsyId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListKidneyId  
,@DateTime  
,@Flow  
,@PressureSystolic  
,@PressureDiastolic  
,@Resistance   ) 
 END    
go 
SET QUOTED_IDENTIFIER OFF   
go 
SET ANSI_NULLS ON   
go