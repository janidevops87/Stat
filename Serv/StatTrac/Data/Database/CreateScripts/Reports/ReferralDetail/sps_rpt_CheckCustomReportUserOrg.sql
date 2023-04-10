if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_CheckCustomReportUserOrg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_CheckCustomReportUserOrg'
		DROP  Procedure  sps_rpt_CheckCustomReportUserOrg
	END

GO

PRINT 'Creating Procedure sps_rpt_CheckCustomReportUserOrg'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_CheckCustomReportUserOrg
     @UserOrgID int = null,
     @Results int OUTPUT
AS
/******************************************************************************
**		File: sps_rpt_CheckCustomReportUserOrg.sql
**		Name: sps_rpt_CheckCustomReportUserOrg
**		Desc: This sproc returns true(1) if the organization is GOLM. Custom
**			  features (image logos and text notes) are then displayed in the
**			  report(ReferralDetail) 
**              
**		Return values:
** 
**		Called by: sps_rpt_ReferralDetail_Triage  
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**		@UserOrgID int,					@Results int
**
**		Auth: christopher carroll  
**		Date: 05/11/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		06/20/2007		ccarroll				Initial release
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @Result Int
SET @Result = 0

/* Test to see if this is a GOLM Org = 1 */
SET @Result = 
	  (SELECT Count(*) FROM sourcecodeorganization
	  WHERE organizationid = @UserOrgID
	  AND organizationid IN
		(
		  SELECT so.organizationid
		  FROM sourcecodeorganization so
		  JOIN organization o ON so.organizationid = o.organizationid
		  WHERE so.sourcecodeid IN (251) -- GOLM
		)
	  )
    
/* GOLM CustomReportCode - When returned to the report RS, will cause custom images and 
   notes to be displayed */
	IF (@Result > 0)
	SET @Result = 1  

RETURN @Result

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

