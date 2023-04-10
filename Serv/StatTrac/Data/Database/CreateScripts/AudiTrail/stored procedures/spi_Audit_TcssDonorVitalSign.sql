 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorVitalSign.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorVitalSign**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorVitalSign]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorVitalSign]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorVitalSign'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorVitalSign'  
 GO
create procedure "spi_Audit_TcssDonorVitalSign"  
(   @TcssDonorVitalSignId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@FromDateTime smalldatetime  
,@ToDateTime smalldatetime   )  
AS  
 BEGIN
 insert into DBO.TcssDonorVitalSign  
 (   "TcssDonorVitalSignId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"FromDateTime" 
,"ToDateTime"  )  
VALUES   
(    @TcssDonorVitalSignId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@FromDateTime  
,@ToDateTime   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  