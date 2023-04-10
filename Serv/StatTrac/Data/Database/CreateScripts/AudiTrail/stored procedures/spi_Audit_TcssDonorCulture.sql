 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorCulture.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorCulture**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorCulture]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spi_Audit_TcssDonorCulture]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorCulture'  
 END   
 go 
 PRINT 'Create Sproc: spi_Audit_TcssDonorCulture'  
 go    
 create procedure "spi_Audit_TcssDonorCulture"  
 (   
 @TcssDonorCultureId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@TcssListCultureTypeId int  
,@TcssListCultureResultId int  
,@Comment varchar(2500)  )  
AS  
 begin
 insert into DBO.TcssDonorCulture  
 ( 
 "TcssDonorCultureId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime" 
,"TcssListCultureTypeId" 
,"TcssListCultureResultId" 
,"Comment"  )  VALUES   (    @TcssDonorCultureId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@SampleDateTime  
,@TcssListCultureTypeId  
,@TcssListCultureResultId  
,@Comment   
)  
END    

 go 
 SET QUOTED_IDENTIFIER OFF   
 
 go 
 SET ANSI_NULLS ON   
 
 go  