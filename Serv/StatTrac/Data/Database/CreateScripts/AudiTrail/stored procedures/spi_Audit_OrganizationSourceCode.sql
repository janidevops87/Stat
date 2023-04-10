/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_OrganizationSourceCode.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Insert Audit records for DBO.OrganizationSourceCode
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_OrganizationSourceCode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_OrganizationSourceCode]
		PRINT 'Drop Sproc: spi_Audit_OrganizationSourceCode'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_OrganizationSourceCode'  
GO

 create procedure "spi_Audit_OrganizationSourceCode"  
 (   
 @OrganizationID int  
,@SourceCodeList nvarchar(1000) 
,@LastModified smalldatetime  
,@LastStatEmployeeID int  
,@AuditLogTypeID int   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
SET @LastStatEmployeeID = 2241; 

insert into DBO.OrganizationSourceCode  
(   
"OrganizationID" 
,"SourceCodeList" 
,"LastModified" 
,"LastStatEmployeeID" 
,"AuditLogTypeID"  
)  
VALUES   
(    
@OrganizationID  
,@SourceCodeList  
,@LastModified  
,@LastStatEmployeeID  
,1   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO