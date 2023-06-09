SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineReferral]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineReferral]
GO





CREATE PROCEDURE  sps_OnlineReferral (@OnLinePermissionID int = NULL)
/*
   Sproc created to handle new PermissionType of Online Referral (= 5)
   on reporting site.  Used to handle permissions for access to Online Referral functionality.
   Called by PermissionAdmin.sls.
   Created 4/5/2005 by Scott Plummer
*/
AS

DECLARE  @intRetCode    int,
         @intRowcount   int,
         @intError      int

SELECT   @intRetCode = 0;

IF @OnLinePermissionID IS NOT NULL
	BEGIN
	    SELECT
                  OnlinePermissionId,
                  OnlinePermissionName,
                  OnlinePermissionString,
                  OnlinePermissionDescription
	    FROM OnlinePermission
	    WHERE OnlinePermissionId = @OnLinePermissionID;
	END
ELSE
	BEGIN
		SELECT * FROM OnlinePermission
		Order By OnlinePermissionName;
	END

SELECT @intRowCount = @@rowcount, @intError = @@error;

IF @intRowCount = 0 OR @intError <> 0
	BEGIN

--		Insert error handling
	        SELECT @intRetcode = 6
	        RETURN -(@intRetcode)
	END

RETURN @intRetCode



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

