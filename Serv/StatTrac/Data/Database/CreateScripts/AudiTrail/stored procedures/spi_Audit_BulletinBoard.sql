/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_BulletinBoard.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/20/2011  Steve Barron  	Insert Audit records for DBO.BulletinBoard
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_BulletinBoard]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_BulletinBoard]
		PRINT 'Drop Sproc: spi_Audit_BulletinBoard'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_BulletinBoard'  
GO

create procedure "spi_Audit_BulletinBoard"  
(   
@BulletinBoardID int  
,@Organization nvarchar(80) 
,@Alert nvarchar(255) 
,@CreateDate datetime  
,@OrganizationID int  
,@LastModified datetime  
,@LastStatEmployeeID int  
,@AuditLogTypeID int   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
--SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241); 
 
insert into DBO.BulletinBoard  
(   
"BulletinBoardID" 
,"Organization" 
,"Alert" 
,"CreateDate" 
,"OrganizationID" 
,"LastModified" 
,"LastStatEmployeeID" 
,"AuditLogTypeID"  
)  
VALUES   
(    
@BulletinBoardID  
,@Organization  
,@Alert  
,@CreateDate  
,@OrganizationID  
,@LastModified  
,@LastStatEmployeeID  ,1   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO