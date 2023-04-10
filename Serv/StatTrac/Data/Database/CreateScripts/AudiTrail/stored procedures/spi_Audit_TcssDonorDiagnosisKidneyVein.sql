 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisKidneyVein.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisKidneyVein**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisKidneyVein]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisKidneyVein]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisKidneyVein'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisKidneyVein'  
 go
    create procedure "spi_Audit_TcssDonorDiagnosisKidneyVein"  
	(   @TcssDonorDiagnosisKidneyVeinId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@TcssListKidneyVeinId int  
,@Length float  
,@Diameter float  
,@Distance float  
,@VeinsOnVenaCava int   )  AS  
 begin 
 insert into DBO.TcssDonorDiagnosisKidneyVein  (   "TcssDonorDiagnosisKidneyVeinId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"TcssListKidneyVeinId" 
,"Length" 
,"Diameter" 
,"Distance" 
,"VeinsOnVenaCava"  )  
VALUES   (    @TcssDonorDiagnosisKidneyVeinId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListKidneyId  
,@TcssListKidneyVeinId  
,@Length  
,@Diameter  
,@Distance  
,@VeinsOnVenaCava   ) 
 END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  