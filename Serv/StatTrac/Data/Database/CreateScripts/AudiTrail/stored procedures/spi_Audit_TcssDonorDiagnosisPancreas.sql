 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisPancreas.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisPancreas**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisPancreas]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisPancreas]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisPancreas'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisPancreas'  
 go
    create procedure "spi_Audit_TcssDonorDiagnosisPancreas"  
	(   @TcssDonorDiagnosisPancreasId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@Comment varchar(5000)  )  
AS  
 begin
 insert into DBO.TcssDonorDiagnosisPancreas  
 (   "TcssDonorDiagnosisPancreasId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"Comment"  )  
VALUES   
(    @TcssDonorDiagnosisPancreasId  
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
  