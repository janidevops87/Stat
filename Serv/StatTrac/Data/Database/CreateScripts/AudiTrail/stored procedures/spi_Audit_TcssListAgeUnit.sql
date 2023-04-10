 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssListAgeUnit.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/27/2011  Jim Hawkins  Insert Audit records for DBO.TcssListAgeUnit**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssListAgeUnit]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spi_Audit_TcssListAgeUnit]
 PRINT 'Drop Sproc: spi_Audit_TcssListAgeUnit'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssListAgeUnit'  
 GO
    create procedure "spi_Audit_TcssListAgeUnit"  
	(   @TcssListAgeUnitId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@SortOrder int  
,@IsActive bit  
,@FieldValue varchar(100) 
,@UnosValue varchar(100)  )  
AS  
 BEGIN
 insert into DBO.TcssListAgeUnit  
 (   "TcssListAgeUnitId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"SortOrder" 
,"IsActive" 
,"FieldValue" 
,"UnosValue"  )  
VALUES   
(    @TcssListAgeUnitId  
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
  