 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetSourceCodeName')
	BEGIN
		PRINT 'Dropping Procedure GetSourceCodeName'
		DROP Procedure GetSourceCodeName
	END
GO

PRINT 'Creating Procedure GetSourceCodeName'
GO
CREATE Procedure GetSourceCodeName
(
		@CallID int = null,
		@returnVal varchar(10) OUTPUT

)
AS
/******************************************************************************
**	File: GetSourceCodeName.sql
**	Name: GetSourceCodeName
**	Desc: Selects SourceCode Name Based on Id fields
**        Called from Web Update 
**	Auth: ccarroll
**	Date: 06/09/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	06/09/2011		ccarroll			Initial
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @SourceCodeName AS varchar(10)
	
	SET @returnVal = ''

	SELECT @SourceCodeName = IsNull(SourceCode.SourceCodeName, '') 
	FROM 
		[Call]
		LEFT JOIN SourceCode ON SourceCode.SourceCodeID = [Call].SourceCodeID

	WHERE 
		[Call].CallID = IsNull(@CallID, 0)
	
	SET @returnVal = '' + @SourceCodeName + ''
		

GO

GRANT EXEC ON GetSourceCodeName TO PUBLIC
GO
 