SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckForOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckForOrganization]
GO

CREATE PROCEDURE  SPS_CheckForOrganization
             @OrganizationName                 	VarChar(80),
	@Address1			VarChar(80),
	@City				VarChar(30),
	@StateID			int
AS

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0
BEGIN
    SELECT
                  OrganizationName, OrganizationID
    FROM          Organization
    WHERE         OrganizationName                 = @OrganizationName
    AND 		OrganizationAddress1	= @Address1
    AND		OrganizationCity		= @City
    AND		StateID			= @StateID
END
    SELECT @intRowCount = @@rowcount, @intError = @@error
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN

--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

RETURN @intRetCode
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

