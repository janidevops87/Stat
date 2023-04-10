/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_OrganizationAlias.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Insert Audit records for DBO.OrganizationAlias
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

   SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_OrganizationAlias]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_OrganizationAlias]
		PRINT 'Drop Sproc: spi_Audit_OrganizationAlias'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_OrganizationAlias'  
GO

create procedure "spi_Audit_OrganizationAlias"  
(   
@OrganizationAliasId int  
,@OrganizationId int  
,@OrganizationAliasName nvarchar(80) 
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
SET @LastStatEmployeeID = 2241; 

insert into DBO.OrganizationAlias  
(   
"OrganizationAliasId" 
,"OrganizationId" 
,"OrganizationAliasName" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  )  
VALUES   
(    
@OrganizationAliasId  
,@OrganizationId  
,@OrganizationAliasName  
,@LastModified  
,@LastStatEmployeeId  
,1   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO

  