SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_OrganizationPhone]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_OrganizationPhone]
GO

create procedure [dbo].[spi_Audit_OrganizationPhone]  
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
,@SubLocationLevel varchar(5)
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
,SubLocationLevel
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
,@SubLocationLevel
)  
END    

GO

