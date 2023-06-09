SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_GetRegistryStatus]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_GetRegistryStatus]
GO


CREATE FUNCTION fn_GetRegistryStatus (@referralId Integer)

RETURNS Integer  

-- Takes a referralId and checks for a valid "Registered" RegistryStatus (1,2, or 4)
-- If found, returns the RegistryStatus, otherwise returns 0
-- 9/17/04 - SAP

AS  
BEGIN 

DECLARE @registryVal Integer,
	@callId Integer

-- Constants
DECLARE @REGISTRY_STATE Integer,
	@REGISTRY_WEB Integer,
	@REGISTRY_MANUAL Integer

SET @REGISTRY_STATE = 1
SET @REGISTRY_WEB = 2
SET @REGISTRY_MANUAL = 4

SET @registryVal = 0 -- Initialize

-- First, check for registry value in RegistryStatus table
SET @registryVal = (SELECT RegistryStatus
	FROM RegistryStatus RS(NOLOCK) 
	LEFT JOIN Referral RF(NOLOCK) ON RS.CallId = RF.CallId
	WHERE RF.ReferralId = @referralId AND RegistryStatus IN (@REGISTRY_STATE, @REGISTRY_WEB, @REGISTRY_MANUAL));

-- If none was found, set @registryVal to 0
IF @registryVal IS NULL
	BEGIN
		SET @registryVal = 0
	END
	
RETURN @registryVal;


END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

