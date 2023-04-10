

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AlertInsert')
	BEGIN
		PRINT 'Dropping Procedure AlertInsert'
		DROP Procedure AlertInsert
	END
GO

PRINT 'Creating Procedure AlertInsert'
GO
CREATE Procedure AlertInsert
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
**	File: AlertInsert.sql
**	Name: AlertInsert
**	Desc: Inserts Alert Based on Id field 
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

INSERT	Alert
	(
		AlertGroupName,
		AlertMessage1,
		AlertMessage2,
		LastModified,
		AlertTypeID,
		AlertLookupCode,
		AlertScheduleMessage,
		UpdatedFlag,
		AlertQAMessage1,
		AlertQAMessage2
	)
VALUES
	(
		@AlertGroupName,
		@AlertMessage1,
		@AlertMessage2,
		@LastModified,
		@AlertTypeID,
		@AlertLookupCode,
		@AlertScheduleMessage,
		@UpdatedFlag,
		@AlertQAMessage1,
		@AlertQAMessage2
	)

SET @AlertID = SCOPE_IDENTITY()

EXEC AlertSelect @AlertID

GO

GRANT EXEC ON AlertInsert TO PUBLIC
GO
