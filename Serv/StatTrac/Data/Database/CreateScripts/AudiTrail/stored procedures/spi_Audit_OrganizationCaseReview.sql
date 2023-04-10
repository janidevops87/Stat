/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_OrganizationCaseReview.sql  
**  Desc:   
**  
**  Date:    	Author:    		Description:  
**  --------   	--------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Insert Audit records for DBO.OrganizationCaseReview
**    
*******************************************************************************/

SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_OrganizationCaseReview]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
BEGIN 
	drop procedure [dbo].[spi_Audit_OrganizationCaseReview]
		PRINT 'Drop Sproc: spi_Audit_OrganizationCaseReview'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_OrganizationCaseReview'  
GO

create procedure "spi_Audit_OrganizationCaseReview"  
(   
@OrganizationCaseReviewId int  
,@OrganizationId int  
,@CaseTypeId int  
,@CaseReviewPercentage int  
,@LastModified datetime  
,@LastStatEmployeeId int  
,@AuditLogTypeId int   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID   
--We are adding Legacy Data until the code and tables  
--can be modified.  
SET @LastStatEmployeeID = 2241; 

insert into DBO.OrganizationCaseReview  
(   
"OrganizationCaseReviewId" 
,"OrganizationId" 
,"CaseTypeId" 
,"CaseReviewPercentage" 
,"LastModified" 
,"LastStatEmployeeId" 
,"AuditLogTypeId"  
)  
VALUES   
(    
@OrganizationCaseReviewId  
,@OrganizationId  
,@CaseTypeId  
,@CaseReviewPercentage  
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