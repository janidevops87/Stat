/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_Approach.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/17/2011  Steve Barron  	Insert Audit records for DBO.Approach
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_Approach]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_Approach]
		PRINT 'Drop Sproc: spi_Audit_Approach'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_Approach'  
GO

create procedure "spi_Audit_Approach"  
(   
@ApproachID int  
,@ApproachName varchar(50) 
,@ApproachReportName varchar(9) 
,@Verified smallint  
,@Inactive smallint  
,@ApproachReportDisplaySort1 int  
,@LastModified datetime  
,@ApproachReportCode varchar(3) 
,@UpdatedFlag smallint   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
--SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  

insert into DBO.Approach  
(   
"ApproachID" 
,"ApproachName" 
,"ApproachReportName" 
,"Verified" 
,"Inactive" 
,"ApproachReportDisplaySort1" 
,"LastModified" 
,"ApproachReportCode" 
,"UpdatedFlag" 
 )  
 VALUES   
 (    
 @ApproachID  
,@ApproachName  
,@ApproachReportName  
,@Verified  
,@Inactive  
,@ApproachReportDisplaySort1  
,@LastModified  
,@ApproachReportCode  
,@UpdatedFlag   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO