 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorHlaLiver.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorHlaLiver**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorHlaLiver]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spi_Audit_TcssDonorHlaLiver]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorHlaLiver'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorHlaLiver'  
 go
    create procedure "spi_Audit_TcssDonorHlaLiver"  (   @TcssDonorHlaLiverId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListPreliminaryCrossmatchId int  
,@PreAdmissionHistory varchar(500) 
,@TcssListHlaA1Id int  
,@TcssListHlaA2Id int  
,@TcssListHlaB1Id int  
,@TcssListHlaB2Id int  
,@TcssListHlaBw4Id int  
,@TcssListHlaBw6Id int  
,@TcssListHlaC1Id int  
,@TcssListHlaC2Id int  
,@TcssListHlaDr1Id int  
,@TcssListHlaDr2Id int  
,@TcssListHlaDr51Id int  
,@TcssListHlaDr52Id int  
,@TcssListHlaDr53Id int  
,@TcssListHlaDq1Id int  
,@TcssListHlaDq2Id int   )  
AS  
 begin 
 insert into DBO.TcssDonorHlaLiver 
 (   "TcssDonorHlaLiverId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListPreliminaryCrossmatchId" 
,"PreAdmissionHistory" 
,"TcssListHlaA1Id" 
,"TcssListHlaA2Id" 
,"TcssListHlaB1Id" 
,"TcssListHlaB2Id" 
,"TcssListHlaBw4Id" 
,"TcssListHlaBw6Id" 
,"TcssListHlaC1Id" 
,"TcssListHlaC2Id" 
,"TcssListHlaDr1Id" 
,"TcssListHlaDr2Id" 
,"TcssListHlaDr51Id" 
,"TcssListHlaDr52Id" 
,"TcssListHlaDr53Id" 
,"TcssListHlaDq1Id" 
,"TcssListHlaDq2Id"  )  
VALUES   
(    @TcssDonorHlaLiverId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListPreliminaryCrossmatchId  
,@PreAdmissionHistory  
,@TcssListHlaA1Id  
,@TcssListHlaA2Id  
,@TcssListHlaB1Id  
,@TcssListHlaB2Id  
,@TcssListHlaBw4Id  
,@TcssListHlaBw6Id  
,@TcssListHlaC1Id  
,@TcssListHlaC2Id  
,@TcssListHlaDr1Id  
,@TcssListHlaDr2Id  
,@TcssListHlaDr51Id  
,@TcssListHlaDr52Id  
,@TcssListHlaDr53Id  
,@TcssListHlaDq1Id  
,@TcssListHlaDq2Id   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  