/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_AlertSourceCode.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/16/2011  Steve Barron  	Insert Audit records for DBO.AlertSourceCode
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_AlertSourceCode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_AlertSourceCode]
		PRINT 'Drop Sproc: spi_Audit_AlertSourceCode'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_AlertSourceCode'  
GO

create procedure "spi_Audit_AlertSourceCode"  
(   
@AlertSourceCodeID int  
,@AlertID int  
,@SourceCodeID int  
,@LastModified smalldatetime  
,@UpdatedFlag smallint   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
--SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  

insert into DBO.AlertSourceCode  
(   
"AlertSourceCodeID" 
,"AlertID" 
,"SourceCodeID" 
,"LastModified" 
,"UpdatedFlag"  
)  
VALUES   
(    
@AlertSourceCodeID  
,@AlertID  
,@SourceCodeID  
,@LastModified  
,@UpdatedFlag   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO