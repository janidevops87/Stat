IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertAutoResponseCode')
	BEGIN
		PRINT 'Dropping Procedure InsertAutoResponseCode'
		DROP  Procedure  InsertAutoResponseCode
	END

GO

PRINT 'Creating Procedure InsertAutoResponseCode'
GO
CREATE Procedure InsertAutoResponseCode
	@CallID int, 
	@AutoResponseCode int, 
	@LogeventID int 

AS

/******************************************************************************
**		File: InsertAutoResponseCode.sql
**		Name: InsertAutoResponseCode
**		Desc: Inserts a record into the AutoResponsCode table
**
**              
**		Return values:
**				new record
**		Called by:   
**			StatTrac.ModStatSave.SaveLogEvent
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 07/15/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		07/15/07	Bret Knoll			StatTrac 8.4.3.9
*******************************************************************************/
INSERT 
	AutoResponseCode 
	( 
		CallID,
		AutoResponseCode,
		LogeventID	
	) 
VALUES 
	( 		
		@CallID, 
		@AutoResponseCode, 
		@LogeventID	
	) 

SELECT 
	AutoResponseCodeID
	CallID,
	AutoResponseCode,
	LogeventID
FROM 
	AutoResponseCode
WHERE
	AutoResponseCodeID = SCOPE_IDENTITY()	


GO

GRANT EXEC ON InsertAutoResponseCode TO PUBLIC

GO
