 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorVitalSignDetail.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorVitalSignDetail**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorVitalSignDetail]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorVitalSignDetail]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorVitalSignDetail'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorVitalSignDetail'  
 GO
    create procedure "spi_Audit_TcssDonorVitalSignDetail"  
	(   @TcssDonorVitalSignDetailId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssDonorVitalSignId int  
,@TcssListVitalSignId int  
,@Answer varchar(200)  )  
AS  
 BEGIN
 insert into DBO.TcssDonorVitalSignDetail  
 (   "TcssDonorVitalSignDetailId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssDonorVitalSignId" 
,"TcssListVitalSignId" 
,"Answer"  )  
VALUES   
(    @TcssDonorVitalSignDetailId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssDonorVitalSignId  
,@TcssListVitalSignId  
,@Answer   ) 
 END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  