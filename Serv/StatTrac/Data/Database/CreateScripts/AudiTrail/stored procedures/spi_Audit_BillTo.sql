/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_BillTo.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/16/2011  Steve Barron  	Insert Audit records for DBO.BillTo
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_BillTo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_BillTo]
		PRINT 'Drop Sproc: spi_Audit_BillTo'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_BillTo'  
GO

create procedure "spi_Audit_BillTo"  
(   
@BillToID int  
,@OrganizationID int  
,@Name nvarchar(100) 
,@Address1 nvarchar(80) 
,@Address2 nvarchar(80) 
,@City nvarchar(30) 
,@StateID int  
,@PostalCode nvarchar(10) 
,@CountryID int  
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241); 

insert into DBO.BillTo  
(   
"BillToID" 
,"OrganizationID" 
,"Name" 
,"Address1" 
,"Address2" 
,"City" 
,"StateID" 
,"PostalCode" 
,"CountryID" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  
)  
VALUES   
(    
@BillToID  
,@OrganizationID  
,@Name  
,@Address1  
,@Address2  
,@City  
,@StateID  
,@PostalCode  
,@CountryID  
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