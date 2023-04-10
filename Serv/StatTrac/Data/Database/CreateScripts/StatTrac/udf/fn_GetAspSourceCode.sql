 IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'fn_GetAspSourceCode')
Begin
	PRINT 'DROP FUNCTION fn_GetAspSourceCode'

	DROP FUNCTION fn_GetAspSourceCode
End
PRINT 'CREATE FUNCTION fn_GetAspSourceCode'
GO
CREATE FUNCTION fn_GetAspSourceCode(@sourceCodeID int)
	RETURNS @table Table
(	[SourceCodeID] int ,
	[AspSourceCodeID] int 
	) 
AS  
/******************************************************************************
**		File: fn_GetAspSourceCode.sql
**		Name: fn_GetAspSourceCode
**		Desc: Returns table of ASP source codes
**
**		Called by:  GetDuplicateReferrals sproc
**              
**		Author:		jth
**		Create date: 12/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/08		jth					Initial
*******************************************************************************/

BEGIN 

INSERT @table
	SELECT @sourceCodeID,@sourceCodeID
union
	select SourceCodeID,AspSourceCodeID
		from AspSourceCodeMap where sourcecodeid = @sourceCodeID
RETURN 
END
GO