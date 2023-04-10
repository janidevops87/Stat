

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AlertUpdate')
	BEGIN
		PRINT 'Dropping Procedure AlertUpdate'
		DROP Procedure AlertUpdate
	END
GO

PRINT 'Creating Procedure AlertUpdate'
GO
CREATE Procedure AlertUpdate
(
		@AlertID int = null output,
		@AlertGroupName varchar(80) = null,
		@AlertMessage1 ntext = null,
		@AlertMessage2 ntext = null,
		@LastModified datetime = null,
		@AlertTypeID int = null,
		@AlertLookupCode varchar(8) = null,
		@AlertScheduleMessage ntext = null,
		@UpdatedFlag smallint = null,
		@AlertQAMessage1 ntext = null,
		@AlertQAMessage2 ntext = null					
)
AS
/******************************************************************************
**	File: AlertUpdate.sql
**	Name: AlertUpdate
**	Desc: Updates Alert Based on Id field 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
*******************************************************************************/

UPDATE
	dbo.Alert 	
SET 
		AlertGroupName = @AlertGroupName,
		AlertMessage1 = @AlertMessage1,
		AlertMessage2 = @AlertMessage2,
		LastModified = GetDate(),
		AlertTypeID = @AlertTypeID,
		AlertLookupCode = @AlertLookupCode,
		AlertScheduleMessage = @AlertScheduleMessage,
		UpdatedFlag = @UpdatedFlag,
		AlertQAMessage1 = @AlertQAMessage1,
		AlertQAMessage2 = @AlertQAMessage2
WHERE 
	AlertID = @AlertID 				

GO

GRANT EXEC ON AlertUpdate TO PUBLIC
GO
