/******************************************************************************
**		File: IDX_LastModifiedForLogEvent.sql
**		Name: IDX_LastModified
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 7/12/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      7/12/07		Bret Knoll			8.4 
*******************************************************************************/

IF  NOT EXISTS  (SELECT * FROM sysindexes WHERE name like 'IDX_LastModified')
	BEGIN
		PRINT 'Creating Index IDX_LastModified'
		CREATE 
		INDEX 
				[IDX_LastModified] ON [dbo].[LogEvent] ([LastModified])
		WITH
			PAD_INDEX,
			FILLFACTOR = 80
		ON 
			[IDX]
		
	END
GO



