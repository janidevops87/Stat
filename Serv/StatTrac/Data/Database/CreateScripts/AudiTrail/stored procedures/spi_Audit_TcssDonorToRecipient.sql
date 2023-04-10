 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorToRecipient.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorToRecipient**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorToRecipient]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorToRecipient]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorToRecipient' 
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorToRecipient'  
 GO
    create procedure "spi_Audit_TcssDonorToRecipient"  
	(   @TcssDonorToRecipientId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssRecipientId int   )  
AS  
 BEGIN
 insert into DBO.TcssDonorToRecipient  
 (   "TcssDonorToRecipientId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssRecipientId"  )  
VALUES   
(    @TcssDonorToRecipientId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssRecipientId   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  