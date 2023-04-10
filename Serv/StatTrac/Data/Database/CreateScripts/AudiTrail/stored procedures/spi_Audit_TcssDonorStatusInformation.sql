 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorStatusInformation.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorStatusInformation**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorStatusInformation]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorStatusInformation]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorStatusInformation'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorStatusInformation'  
 GO
    create procedure "spi_Audit_TcssDonorStatusInformation" 
	(   @TcssDonorStatusInformationId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@DateTime smalldatetime  
,@StatEmployeeId int  
,@TcssListStatusId int  
,@Comment varchar(200)  ) 
 AS  
 BEGIN
 
 insert into DBO.TcssDonorStatusInformation  
 (   "TcssDonorStatusInformationId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"DateTime" 
,"StatEmployeeId" 
,"TcssListStatusId" 
,"Comment"  )  
VALUES   
(    @TcssDonorStatusInformationId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@DateTime  
,@StatEmployeeId  
,@TcssListStatusId  
,@Comment   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  