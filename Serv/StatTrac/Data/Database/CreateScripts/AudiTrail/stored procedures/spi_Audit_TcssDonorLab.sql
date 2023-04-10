 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorLab.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorLab**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorLab]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spi_Audit_TcssDonorLab]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorLab'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorLab'  
 go
    create procedure "spi_Audit_TcssDonorLab"  
	(   @TcssDonorLabId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListToxicologyScreenId int  
,@Results varchar(500) 
,@OtherLabs varchar(500) 
,@HbA1c decimal  
,@HbA1cDateTime smalldatetime   ) 
 AS  
 begin 
 insert into DBO.TcssDonorLab  
 (   "TcssDonorLabId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListToxicologyScreenId" 
,"Results" 
,"OtherLabs" 
,"HbA1c" 
,"HbA1cDateTime"  )  
VALUES   
(    @TcssDonorLabId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListToxicologyScreenId  
,@Results  
,@OtherLabs  
,@HbA1c  
,@HbA1cDateTime   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  