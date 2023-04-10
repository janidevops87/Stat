if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_IntentionallyLeftBlankDefault]')and TYPE ='FN')
BEGIN
		PRINT 'Dropping Function dbo.fn_IntentionallyLeftBlankDefault'
		DROP  Function  dbo.fn_IntentionallyLeftBlankDefault
END
go

PRINT 'Creating Function  dbo.fn_IntentionallyLeftBlankDefault'
GO



SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE  FUNCTION dbo.fn_IntentionallyLeftBlankDefault (@strName varchar (255))
RETURNS varchar (255)
AS
/******************************************************************************
**		File: fn_IntentionallyLeftBlankDefault.sql
**		Name: dbo.fn_IntentionallyLeftBlankDefault
**		Desc: Provide default text for null or intentionally left blank value 
**              
**		Return values: @StrName varchar(250)
** 
**		Called by: Reporting Services   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**		@StrName						@StrName  - Default text
**
**		Auth: christopher carroll  
**		Date: 03/12/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		6/20/2007		ccarroll				Initial release
*******************************************************************************/
BEGIN
	SET @strName =  CASE ISNULL(@strName, '') WHEN '' THEN 'ILB' ELSE @strName END
	RETURN(@strName)
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


