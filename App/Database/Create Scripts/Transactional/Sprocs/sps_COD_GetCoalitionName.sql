SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_COD_GetCoalitionName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_COD_GetCoalitionName]
GO


CREATE PROCEDURE sps_COD_GetCoalitionName
			@vOrgID	int	=null

AS

SET NOCOUNT ON

SELECT OrganizationName
FROM Organization
WHERE OrganizationID = @vOrgID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

