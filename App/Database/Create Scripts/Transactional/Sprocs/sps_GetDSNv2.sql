SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetDSNv2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetDSNv2]
GO



CREATE PROCEDURE sps_GetDSNv2
	@ServiceLevelID	INT =NULL,
	@StateID varchar(2) =NULL

AS

SELECT 
	D.DRDSNID,
	DRDSNName,
	DRDSNODBC,
	DRDSNStateID, -- BJK 06/26/03 ADDED v1
	DRDSNServerName,	 --T.T 09/01/2004 added for oledb
	DRDSNDBName	 --T.T 09/01/2004 added for oledb
FROM	DRDSN D
JOIN	ServiceLevelDRDSN SL ON SL.DRDSNID = D.DRDSNID
LEFT 
JOIN 	STATE ST ON ST.StateID = D.DRDSNStateID
WHERE	SL.ServiceLevelID = @ServiceLevelID	
AND 	(ST.StateAbbrv  = @StateID  or ISNULL(@StateID , '')= '')



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

