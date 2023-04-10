/****************************************************************************
**  
**  File:   
**  Name: spi_Audit_Alert.sql  
**  Desc:   
**  
**  Date:   	Author:    		Description:  
**  --------  	--------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Insert Audit records for DBO.Alert
**    
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO

SET ANSI_NULLS ON     
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_Alert]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		drop procedure [dbo].[spi_Audit_Alert]
		PRINT 'Drop Sproc: spi_Audit_Alert'  
	END   
GO

PRINT 'Create Sproc: spi_Audit_Alert'  
GO

create procedure "spi_Audit_Alert"  
(   
@AlertID int
,@AlertGroupName varchar(80) 
,@AlertMessage1 ntext
,@AlertMessage2 ntext
,@LastModified datetime
,@AlertTypeID int
,@AlertLookupCode varchar(8) 
,@AlertScheduleMessage ntext
,@UpdatedFlag smallint
,@AlertQAMessage1 ntext
,@AlertQAMessage2 ntext
,@LastStatEmployeeID int
,@AuditLogTypeID int   
)  
AS  
BEGIN 
--Legacy Tables do not have the Last Employee ID 
--We are adding Legacy Data until the code and tables
--can be modified.
SET @LastStatEmployeeID = 2241;  

insert into DBO.Alert  
(   
"AlertID" 
,"AlertGroupName" 
,"AlertMessage1" 
,"AlertMessage2" 
,"LastModified" 
,"AlertTypeID" 
,"AlertLookupCode" 
,"AlertScheduleMessage" 
,"UpdatedFlag" 
,"AlertQAMessage1" 
,"AlertQAMessage2" 
,"LastStatEmployeeID" 
,"AuditLogTypeID"  
)  
VALUES   
(    
@AlertID
,@AlertGroupName
,@AlertMessage1
,@AlertMessage2
,@LastModified
,@AlertTypeID
,@AlertLookupCode
,@AlertScheduleMessage
,@UpdatedFlag
,@AlertQAMessage1
,@AlertQAMessage2
,@LastStatEmployeeID  
,1   
)  
END    
GO

SET QUOTED_IDENTIFIER OFF   
GO

SET ANSI_NULLS ON   
GO

  