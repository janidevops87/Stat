SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS OFF;
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_GetDSNv3]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_GetDSNv3];
GO





CREATE PROCEDURE sps_GetDSNv3
	@ServiceLevelID	INT =NULL,
	@StateID VARCHAR(3) =NULL

AS
/******************************************************************************
**		File: sps_GetDSNv3.sql
**		Name: sps_GetDSNv3.
**		Desc: 
**
**		Auth: Unknown
**		Date: Created Prior to 06/26/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      08/07/2014	Moonray Schepart	Added Distinct filter 
**		12/01/2016	Mike Berenson		Added logic for stateid as DLA
*******************************************************************************/
SELECT DISTINCT
	D.DRDSNID,
	DRDSNName,
	DRDSNODBC,
	DRDSNStateID, -- BJK 06/26/03 ADDED v1
	DRDSNServerName,	 --T.T 09/01/2004 added for oledb
	DRDSNDBName,	 --T.T 09/01/2004 added for oledb
	WebServiceEnable,	--T.T 09/20/2005 addeed for Webservice 
	WebServiceOrder
FROM	DRDSN D
JOIN	ServiceLevelDRDSN SL ON SL.DRDSNID = D.DRDSNID
LEFT 
JOIN 	STATE ST ON ST.StateID = D.DRDSNStateID
WHERE	SL.ServiceLevelID = @ServiceLevelID	
AND 	(ST.StateAbbrv = @StateID OR ISNULL(@StateID, '') = ''
	OR (@StateID = 'DLA' AND D.DRDSNStateID IS NULL))

ORDER BY WebServiceEnable DESC, WebServiceOrder ASC;
GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

