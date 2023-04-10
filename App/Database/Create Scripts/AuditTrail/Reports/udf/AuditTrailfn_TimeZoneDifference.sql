/****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_TimeZoneDifference]    Script Date: 11/24/2008 09:04:35 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE name = 'AuditTrailfn_TimeZoneDifference' AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION [dbo].[AuditTrailfn_TimeZoneDifference]'
	DROP FUNCTION [dbo].[AuditTrailfn_TimeZoneDifference]
END	
	PRINT 'CREATE FUNCTION [dbo].[AuditTrailfn_TimeZoneDifference]'
 
 
GO
/****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_TimeZoneDifference]    Script Date: 11/24/2008 09:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[AuditTrailfn_TimeZoneDifference]
	(
	@timeZone VARCHAR(2),
	@activityDate DATETIME
	)
RETURNS INT
AS
/******************************************************************************
**		File: AuditTrailfn_TimeZoneDifference.sql
**		Name: AuditTrailfn_TimeZoneDifference
**		Desc: 
**			Call fn_TimeZoneDifference from Report DB			
**
**              
**		Return values:
** 
**		Called by:   
**		AuditTrail Sprocs
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 11/19/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/19/08	Bret Knoll			buil during release
**		08/24/2010	ccarroll			changed DB_NAME to @@SERVERNAME
*******************************************************************************/

BEGIN
	DECLARE  @RETURNVALUE INT
	IF(@@SERVERNAME like '%DEV%')
	BEGIN
		SELECT @RETURNVALUE = ReferralTest2.dbo.fn_TimeZoneDifference(@timeZone,@activityDate)
	END
	ELSE
	BEGIN
		SELECT @RETURNVALUE = _ReferralProdReport.dbo.fn_TimeZoneDifference(@timeZone,@activityDate)
	END
	RETURN @RETURNVALUE 
END

GO