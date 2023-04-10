/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_BloodProduct.sql  
**  Desc:   
**  
**  Date:    	Author:    			Description:  
**  --------   	--------   		-------------------------------------------  
**  06/20/2011  Steve Barron  	Insert Audit records for DBO.BloodProduct
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_BloodProduct]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_BloodProduct]
		PRINT 'Drop Sproc: spi_Audit_BloodProduct'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_BloodProduct'  
GO

create procedure "spi_Audit_BloodProduct"  
(   
@BloodProductId int  
,@BloodProductName varchar(50) 
,@BloodProductType varchar(50)  
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
--SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  
insert into DBO.BloodProduct  
(   
"BloodProductId" 
,"BloodProductName" 
,"BloodProductType"  
)  
VALUES   
(    
@BloodProductId  
,@BloodProductName  
,@BloodProductType   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO