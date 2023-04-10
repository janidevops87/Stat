/****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_rpt_ConvertDateTime]    Script Date: 11/24/2008 10:37:21 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE name = 'AuditTrailfn_rpt_ConvertDateTime' AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION [dbo].[AuditTrailfn_rpt_ConvertDateTime]'
	DROP FUNCTION [dbo].[AuditTrailfn_rpt_ConvertDateTime]
END
	PRINT 'CREATE FUNCTION [dbo].[AuditTrailfn_rpt_ConvertDateTime]'
GO
/****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_rpt_ConvertDateTime]    Script Date: 11/24/2008 10:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[AuditTrailfn_rpt_ConvertDateTime] (
		@vOrgID int,						/* Referral Facility OrganizationID/UserOrgId */
		@vDateTime datetime,				/* DateTime to convert */
		@vDisplayMountainTime int = Null	/* Option
												0 = Display Referral Facility/UserOrg Time
												1 = Display Mountain Time - Statline Employee */
)

RETURNS datetime AS 

/******************************************************************************
**		File: AuditTrailfn_rpt_ConvertDateTime.sql
**		Name: AuditTrailfn_rpt_ConvertDateTime
**		Desc: Calls the produciton database function
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      11/13/2007	ccarroll			initial
**		08/24/2010	ccarroll			changed DB_NAME to @@SERVERNAME
*******************************************************************************/

BEGIN 
	DECLARE @RETURNDATETIME DATETIME
	IF(@@SERVERNAME like '%DEV%')
	BEGIN
		SELECT @RETURNDATETIME = ReferralTest2.dbo.fn_rpt_ConvertDateTime(@vOrgID, @vDateTime, @vDisplayMountainTime)
	END
	ELSE
	BEGIN
		SELECT @RETURNDATETIME = _ReferralProdReport.dbo.fn_rpt_ConvertDateTime(@vOrgID, @vDateTime, @vDisplayMountainTime)
	END
	
	RETURN @RETURNDATETIME
END


GO
