if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_ServiceLevelDefault]')and TYPE ='FN')
	BEGIN
		PRINT 'Dropping Function fn_ServiceLevelDefault'
		DROP  function  dbo.fn_ServiceLevelDefault
	END
GO

	PRINT 'Creating function  dbo.fn_ServiceLevelDefault'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE  FUNCTION dbo.fn_ServiceLevelDefault (@strName varchar (255))
RETURNS varchar (10)
AS
/******************************************************************************
**		File: fn_ServiceLevelDefault.sql
**		Name: dbo.fn_ServiceLevelDefault
**		Desc: Provide default text when ServiceLevel is turned off 
**              
**		Return values: @StrName varchar(10)
** 
**		Called by: sps_rpt_ReferralDetail_Triage, ReferralDetail report   
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
**    
*******************************************************************************/

BEGIN
	SET @strName =  CASE ISNULL(@strName, '') WHEN '' THEN 'SL' ELSE @strName END
	RETURN(@strName)
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

