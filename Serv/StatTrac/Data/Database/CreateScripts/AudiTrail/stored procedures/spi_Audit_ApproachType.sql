/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_ApproachType.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/17/2011  Steve Barron  	Insert Audit records for DBO.ApproachType
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_ApproachType]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_ApproachType]
		PRINT 'Drop Sproc: spi_Audit_ApproachType'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_ApproachType'  
GO

create procedure "spi_Audit_ApproachType"  
(   
@ApproachTypeID int  
,@ApproachTypeName varchar(50) 
,@Verified smallint  
,@Inactive smallint  
,@LastModified datetime  
,@UpdatedFlag smallint   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
--SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  

insert into DBO.ApproachType  
(   
"ApproachTypeID" 
,"ApproachTypeName" 
,"Verified" 
,"Inactive" 
,"LastModified" 
,"UpdatedFlag"  
)  
VALUES   
(    
@ApproachTypeID  
,@ApproachTypeName  
,@Verified  
,@Inactive  
,@LastModified  
,@UpdatedFlag   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO