SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS OFF;
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_GetDonorSearchConfiguration]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_GetDonorSearchConfiguration];
GO

CREATE PROCEDURE sps_GetDonorSearchConfiguration
	@ServiceLevelID	INT =NULL

AS
/******************************************************************************
**		File: sps_GetDonorSearchConfiguration.sql
**		Name: sps_GetDonorSearchConfiguration.
**		Desc: 
**
**		Auth: Andrey Savin
**		Date: 4/29/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**     04/29/2020	Andrey Savin		Initial creation
*******************************************************************************/
SELECT DISTINCT COALESCE(StateAbbrv, 'DLA') AS StateAbbrv
FROM	DRDSN D
JOIN	ServiceLevelDRDSN SL ON SL.DRDSNID = D.DRDSNID
LEFT 
JOIN 	STATE ST ON ST.StateID = D.DRDSNStateID
WHERE	SL.ServiceLevelID = @ServiceLevelID

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

