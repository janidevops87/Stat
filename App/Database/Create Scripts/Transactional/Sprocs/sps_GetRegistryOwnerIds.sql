SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS OFF;
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_GetRegistryOwnerIds]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_GetRegistryOwnerIds];
GO

CREATE PROCEDURE sps_GetRegistryOwnerIds
	@ServiceLevelID	INT = NULL

AS
/******************************************************************************
**		File: sps_GetRegistryOwnerIds.sql
**		Name: sps_GetRegistryOwnerIds.
**		Desc: Gets the list of Registry Owner IDs for a given service level.
**
**		Auth: Andrey Savin
**		Date: 6/16/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**     6/16/2020	Andrey Savin		Initial creation
*******************************************************************************/

SELECT DISTINCT RO.RegistryOwnerId FROM DRDSN
JOIN DRDSNRegistryOwner RO ON RO.DRDSNID = DRDSN.DRDSNID
JOIN ServiceLevelDRDSN SL ON SL.DRDSNID = DRDSN.DRDSNID
WHERE SL.ServiceLevelID = @ServiceLevelID;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

