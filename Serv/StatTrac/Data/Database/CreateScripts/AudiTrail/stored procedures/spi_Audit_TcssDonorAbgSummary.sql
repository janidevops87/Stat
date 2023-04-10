 /****************************************************************************
** 
** File:   
** Name: spi_Audit_TcssDonorAbgSummary.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorAbgSummary
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorAbgSummary]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN drop procedure [dbo].[spi_Audit_TcssDonorAbgSummary]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorAbgSummary'  
 END   
 go 
 PRINT 'Create Sproc: spi_Audit_TcssDonorAbgSummary'  
 go    
 create procedure "spi_Audit_TcssDonorAbgSummary"  
 (   @TcssDonorAbgSummaryId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@HowManyDaysVented int   )  AS  
BEGIN 
insert into DBO.TcssDonorAbgSummary  
(   "TcssDonorAbgSummaryId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"HowManyDaysVented"  )  VALUES   (    @TcssDonorAbgSummaryId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@HowManyDaysVented   )  
END    
 go 
 SET QUOTED_IDENTIFIER OFF   
 go 
 SET ANSI_NULLS ON   
 go  