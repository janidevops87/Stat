 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssListArginineVasopressin.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/27/2011  Jim Hawkins  Insert Audit records for DBO.TcssListArginineVasopressin**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssListArginineVasopressin]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spi_Audit_TcssListArginineVasopressin]
 PRINT 'Drop Sproc: spi_Audit_TcssListArginineVasopressin'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssListArginineVasopressin'  
 GO
    create procedure "spi_Audit_TcssListArginineVasopressin"  
	(   @TcssListArginineVasopressinId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@SortOrder int  
,@IsActive bit  
,@FieldValue varchar(100) 
,@UnosValue varchar(100)  )  
AS  
 BEGIN
 insert into DBO.TcssListArginineVasopressin  
 (   "TcssListArginineVasopressinId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"SortOrder" 
,"IsActive" 
,"FieldValue" 
,"UnosValue"  )  
VALUES   
(    @TcssListArginineVasopressinId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@SortOrder  
,@IsActive  
,@FieldValue  
,@UnosValue   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  