 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorTest.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorTest**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorTest]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorTest]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorTest'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorTest'  
 GO
 create procedure "spi_Audit_TcssDonorTest"  
 (   @TcssDonorTestId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListTestTypeId int  
,@TestDateTime smalldatetime  
,@Interpretation varchar(5000)  ) 
AS  
BEGIN
insert into DBO.TcssDonorTest  
(   "TcssDonorTestId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListTestTypeId" 
,"TestDateTime" 
,"Interpretation"  )  VALUES  
 (    @TcssDonorTestId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListTestTypeId  
,@TestDateTime  
,@Interpretation   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  