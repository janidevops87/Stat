 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssListCauseOfDeath.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/27/2011  Jim Hawkins  Insert Audit records for DBO.TcssListCauseOfDeath**   
*******************************************************************************/SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssListCauseOfDeath]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spi_Audit_TcssListCauseOfDeath]
 PRINT 'Drop Sproc: spi_Audit_TcssListCauseOfDeath'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssListCauseOfDeath'  
 GO
    create procedure "spi_Audit_TcssListCauseOfDeath"  
	(   @TcssListCauseOfDeathId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@SortOrder int  
,@IsActive bit  
,@FieldValue varchar(100) 
,@UnosValue varchar(100)  )  
AS  
 BEGIN
insert into DBO.TcssListCauseOfDeath  
(   "TcssListCauseOfDeathId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"SortOrder" 
,"IsActive" 
,"FieldValue" 
,"UnosValue"  )  
VALUES   
(    @TcssListCauseOfDeathId  
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
  