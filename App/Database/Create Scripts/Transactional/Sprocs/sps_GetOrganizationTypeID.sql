SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetOrganizationTypeID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetOrganizationTypeID]
GO

CREATE PROCEDURE  SPS_GetOrganizationTypeID
                  @OrganizationTypeName                 VarChar(50)
AS
    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int
    SELECT   @intRetCode = 0
BEGIN
    SELECT OrganizationTypeID, OrganizationTypeName
    FROM          OrganizationType
    WHERE         OrganizationTypeName                 = @OrganizationTypeName
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

