/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_OrganizationPhone.sql  
**  Desc:   
**  
**  Date:    Author:    Description:  
**  --------   --------   -------------------------------------------  
**  06/14/2011  Steve Barron  Insert Audit records for DBO.OrganizationPhone
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_OrganizationPhone]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
BEGIN 
	drop procedure [dbo].[spi_Audit_OrganizationPhone]
	PRINT 'Drop Sproc: spi_Audit_OrganizationPhone'  
END   
GO

PRINT 'Create Sproc: spi_Audit_OrganizationPhone'  
GO

create procedure "spi_Audit_OrganizationPhone"  
(   
@OrganizationPhoneID int  
,@OrganizationID int  
,@PhoneID int  
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int  
,@SubLocationID int  
,@SubLocationLevelID int  
,@Inactive smallint   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
SET @LastStatEmployeeID = 2241; 

insert into DBO.OrganizationPhone  
(   
"OrganizationPhoneID" 
,"OrganizationID" 
,"PhoneID" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId" 
,"SubLocationID" 
,"SubLocationLevelID" 
,"Inactive"  
)  
VALUES   
(    
@OrganizationPhoneID  
,@OrganizationID  
,@PhoneID  
,@LastModified  
,@LastStatEmployeeId  
,1  
,@SubLocationID  
,@SubLocationLevelID  
,@Inactive   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO