
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetSourceCodeCount')
	BEGIN
		PRINT 'Dropping Procedure:  GetSourceCodeCount'
		DROP Procedure GetSourceCodeCount
	END
GO

PRINT 'Creating Procedure:  GetSourceCodeCount'
GO


CREATE Procedure GetSourceCodeCount
	@SourceCodeID INT,
	@SourceCodeName VARCHAR(15),
	@SourceCodeCallTypeID INT,
	@Count INT OUTPUT
AS

/******************************************************************************
**		File: GetSourceCodeCount.sql
**		Name:  GetSourceCodeCount
**		Desc: Returns the number of SourceCode with unique SourceCode call type 
**
**		Called by: SourceCodeSourceCodeControl.ascx  
**              
**
**		Auth: ccarroll	
**		Date: 2/16/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		2/16/2011	ccarroll			initial
**		4/14/2011	ccarroll			Added @SourceCodeID
*******************************************************************************/
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT @Count = (SELECT Count(SourceCodeName)
					FROM SourceCode
					WHERE SourceCodeName = @SourceCodeName AND
					SourceCodeCallTypeID = @SourceCodeCallTypeID AND
					SourceCodeID <> @SourceCodeID
				)


GO


