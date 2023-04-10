/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_AppScreen.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/15/2011  Steve Barron  	Insert Audit records for DBO.AppScreen
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_AppScreen]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_AppScreen]
		PRINT 'Drop Sproc: spi_Audit_AppScreen'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_AppScreen'  
GO

create procedure "spi_Audit_AppScreen"  (   
@AppScreenId int  
,@ParentId int  
,@ScreenName varchar(100) 
,@SortOrder int  
,@ShortCutKey varchar(10)  
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
--SET @LastStatEmployeeID = 2241; 
insert into DBO.AppScreen  
(   
"AppScreenId" 
,"ParentId" 
,"ScreenName" 
,"SortOrder" 
,"ShortCutKey"  
)  
VALUES   
(    
@AppScreenId  
,@ParentId  
,@ScreenName  
,@SortOrder  
,@ShortCutKey   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO