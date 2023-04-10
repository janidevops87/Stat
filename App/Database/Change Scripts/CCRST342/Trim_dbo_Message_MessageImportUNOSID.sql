/******************************************************************************
**		File: Trim_dbo_Message_MessageImportUNOSID.sql
**		Name: Trim dbo.Message.MessageImportUNOSID 
**		Desc: Trim leading and trailing spaces from dbo.Message.MessageImportUNOSID
**
**		Auth: Mike Berenson
**		Date: 04/27/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      04/27/2021	Mike Berenson		initial
*******************************************************************************/

-- Begin chunking with 5,000 records in each update
WHILE (SELECT COUNT(1) FROM Message WHERE MessageImportUNOSID LIKE '[ ]%' OR MessageImportUNOSID LIKE '%[ ]') > 0
BEGIN

	UPDATE TOP(5000) Message
	SET MessageImportUNOSID = TRIM(MessageImportUNOSID)
	WHERE MessageImportUNOSID LIKE '[ ]%'	-- leading spaces
		OR MessageImportUNOSID LIKE '%[ ]';	-- trailing spaces

END
GO