 /****************************************************************************** 

,"  File:  

,"  Name: spi_Audit_TcssDonorDiagnosisKidneyArtery.sql 

,"  Desc:  

," 

,"  Date:    Author:    Description: 

,"  --------   --------   ------------------------------------------- 

,"  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisKidneyArtery**   

,"*****************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
   SET ANSI_NULLS ON     
go
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisKidneyArtery]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisKidneyArtery]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisKidneyArtery'  
 END   
go
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisKidneyArtery'  
go
    create procedure "spi_Audit_TcssDonorDiagnosisKidneyArtery"  
	(   @TcssDonorDiagnosisKidneyArteryId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@TcssListKidneyArteryId int  
,@Length float  
,@Diameter float  
,@Distance float  
,@ArteriesOnCommonCuff int   )  
AS  
 begin 
 insert into DBO.TcssDonorDiagnosisKidneyArtery  
 (   "TcssDonorDiagnosisKidneyArteryId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"TcssListKidneyArteryId" 
,"Length" 
,"Diameter" 
,"Distance" 
,"ArteriesOnCommonCuff"  )  
VALUES   
(    @TcssDonorDiagnosisKidneyArteryId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListKidneyId  
,@TcssListKidneyArteryId  
,@Length  
,@Diameter  
,@Distance  
,@ArteriesOnCommonCuff   )  
END    
go
 SET QUOTED_IDENTIFIER OFF   
go
 SET ANSI_NULLS ON   
go
  