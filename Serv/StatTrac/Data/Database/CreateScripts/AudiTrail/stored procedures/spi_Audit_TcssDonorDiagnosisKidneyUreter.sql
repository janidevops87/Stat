 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisKidneyUreter.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisKidneyUreter**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
   SET ANSI_NULLS ON     
go
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisKidneyUreter]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisKidneyUreter]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisKidneyUreter'  
 END   
go
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisKidneyUreter'  
go
    create procedure "spi_Audit_TcssDonorDiagnosisKidneyUreter"  (   @TcssDonorDiagnosisKidneyUreterId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@TcssListKidneyUreterId int  
,@Length float  
,@TcssListKidneyUreterTissueQualityId int   )  
AS  
 begin 
 insert into DBO.TcssDonorDiagnosisKidneyUreter  (   "TcssDonorDiagnosisKidneyUreterId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"TcssListKidneyUreterId" 
,"Length" 
,"TcssListKidneyUreterTissueQualityId"  )  VALUES   (    @TcssDonorDiagnosisKidneyUreterId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListKidneyId  
,@TcssListKidneyUreterId  
,@Length  
,@TcssListKidneyUreterTissueQualityId   )  
END    
go
 SET QUOTED_IDENTIFIER OFF   
go
 SET ANSI_NULLS ON   
go
  