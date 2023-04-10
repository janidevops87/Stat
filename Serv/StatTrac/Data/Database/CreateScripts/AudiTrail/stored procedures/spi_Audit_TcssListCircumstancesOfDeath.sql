 /****************************************************************************
** 
** File:   
** Name: spi_Audit_TcssListCircumstancesOfDeath.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/27/2011  Jim Hawkins  Insert Audit records for DBO.TcssListCircumstancesOfDeath
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssListCircumstancesOfDeath]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssListCircumstancesOfDeath]
	 PRINT 'Drop Sproc: spi_Audit_TcssListCircumstancesOfDeath'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssListCircumstancesOfDeath'  
 GO
    create procedure "spi_Audit_TcssListCircumstancesOfDeath"  
	(   @TcssListCircumstancesOfDeathId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@SortOrder int  
,@IsActive bit  
,@FieldValue varchar(100) 
,@UnosValue varchar(100)  )  
AS  
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); 
 SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SortOrder AS VARCHAR(1)), '') 
+ ISNULL(CAST(@IsActive AS VARCHAR(1)), '') 
+ ISNULL(CAST(@FieldValue AS VARCHAR(1)), '') 
+ ISNULL(CAST(@UnosValue AS VARCHAR(1)), '')
  insert into DBO.TcssListCircumstancesOfDeath 
  (   "TcssListCircumstancesOfDeathId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"SortOrder" 
,"IsActive" 
,"FieldValue" 
,"UnosValue"  )  
VALUES   
(    @TcssListCircumstancesOfDeathId  
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
  