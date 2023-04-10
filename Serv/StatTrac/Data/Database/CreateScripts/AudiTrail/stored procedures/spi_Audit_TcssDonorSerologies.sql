 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorSerologies.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorSerologies**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorSerologies]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorSerologies]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorSerologies'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorSerologies'  
 GO
 create procedure "spi_Audit_TcssDonorSerologies"  
(   @TcssDonorSerologiesId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListSerologyQuestionId int  
,@TcssListSerologyAnswerId int   )  
AS  
 BEGIN
 insert into DBO.TcssDonorSerologies  
 (   "TcssDonorSerologiesId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListSerologyQuestionId" 
,"TcssListSerologyAnswerId"  )  
VALUES  
 (   
 @TcssDonorSerologiesId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListSerologyQuestionId  
,@TcssListSerologyAnswerId   
)  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  