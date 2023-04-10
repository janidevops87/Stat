 
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetSourceCodeDefaultCount')
	BEGIN
		PRINT 'Dropping Procedure:  GetSourceCodeDefaultCount'
		DROP Procedure GetSourceCodeDefaultCount
	END
GO

PRINT 'Creating Procedure:  GetSourceCodeDefaultCount'
GO


CREATE Procedure GetSourceCodeDefaultCount
	@SourceCodeID INT,
	@SourceCodeName VARCHAR(15),
	@Count INT OUTPUT
AS

/******************************************************************************
**		File: GetSourceCodeDefaultCount.sql
**		Name:  GetSourceCodeCount
**		Desc: Returns the number of Default SourceCodes  
**
**		Called by: SourceCodeSourceCodeControl.ascx  
**              
**
**		Auth: ccarroll	
**		Date: 3/9/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		3/9/2011	ccarroll			initial
**		4/14/2011	ccarroll			Added @SourceCodeID
*******************************************************************************/
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT @Count = (SELECT Count(SourceCodeName)
					FROM SourceCode
					WHERE SourceCodeName = IsNull(@SourceCodeName,'') AND
					IsNull(SourceCodeDefault, 0) = 1 AND
					SourceCodeID <> @SourceCodeID
				)


GO


