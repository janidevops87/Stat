/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_AlertOrganization.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/16/2011  Steve Barron  	Insert Audit records for DBO.AlertOrganization
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_AlertOrganization]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_AlertOrganization]
		PRINT 'Drop Sproc: spi_Audit_AlertOrganization'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_AlertOrganization'  
GO

create procedure "spi_Audit_AlertOrganization"  
(   
@AlertOrganizationID int  
,@AlertID int  
,@OrganizationID int  
,@LastModified datetime  
,@UpdatedFlag smallint   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
--SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  
insert 
into DBO.AlertOrganization  
(   
"AlertOrganizationID" 
,"AlertID" 
,"OrganizationID" 
,"LastModified" 
,"UpdatedFlag"  
)  
VALUES   
(    
@AlertOrganizationID  
,@AlertID  
,@OrganizationID  
,@LastModified  
,@UpdatedFlag  
 )  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO