 /****************************************************************************
** 
** File:   
** Name: spi_Audit_TcssDonorCompleteBloodCount.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorCompleteBloodCount
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorCompleteBloodCount]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spi_Audit_TcssDonorCompleteBloodCount]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorCompleteBloodCount'  
 END   
 go 
 PRINT 'Create Sproc: spi_Audit_TcssDonorCompleteBloodCount'  
 go    
 create procedure "spi_Audit_TcssDonorCompleteBloodCount"  
 (   @TcssDonorCompleteBloodCountId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@Wbc varchar(50) 
,@Rbc varchar(50) 
,@Hgb varchar(50) 
,@Hct varchar(50) 
,@Plt varchar(50) 
,@Bands decimal   ) 
 AS  
 begin 
 insert into DBO.TcssDonorCompleteBloodCount  
 (   "TcssDonorCompleteBloodCountId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime" 
,"Wbc" 
,"Rbc" 
,"Hgb" 
,"Hct" 
,"Plt" 
,"Bands"  )  VALUES   (    @TcssDonorCompleteBloodCountId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@SampleDateTime  
,@Wbc  
,@Rbc  
,@Hgb  
,@Hct  
,@Plt  
,@Bands   )  
END    
 go 
 SET QUOTED_IDENTIFIER OFF   
 go 
 SET ANSI_NULLS ON   
 go  