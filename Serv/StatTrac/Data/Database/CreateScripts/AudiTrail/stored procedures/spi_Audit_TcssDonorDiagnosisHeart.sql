 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisHeart.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisHeart**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisHeart]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisHeart]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisHeart'  
 END   
 go 
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisHeart'  
 go    
 create procedure "spi_Audit_TcssDonorDiagnosisHeart"  
 (   @TcssDonorDiagnosisHeartId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@LvEjectionFraction decimal  
,@TcssListDiagnosisHeartMethodId int  
,@ShorteningFraction decimal  
,@SeptalWallThickness int  
,@LvPosteriorWallThickness int  
,@Comment varchar(5000)  )  
AS  
 begin 
 insert into DBO.TcssDonorDiagnosisHeart  
 (   
 "TcssDonorDiagnosisHeartId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"LvEjectionFraction" 
,"TcssListDiagnosisHeartMethodId" 
,"ShorteningFraction" 
,"SeptalWallThickness" 
,"LvPosteriorWallThickness" 
,"Comment"  )  
VALUES   
(    
@TcssDonorDiagnosisHeartId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@LvEjectionFraction  
,@TcssListDiagnosisHeartMethodId  
,@ShorteningFraction  
,@SeptalWallThickness  
,@LvPosteriorWallThickness  
,@Comment   
)  
END    
 go 
 SET QUOTED_IDENTIFIER OFF   
 go 
 SET ANSI_NULLS ON   
 go  