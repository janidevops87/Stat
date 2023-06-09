SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetDSN]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetDSN]
GO


CREATE PROCEDURE sps_GetDSN
	@ServiceLevelID	INT =NULL,
	@StateID varchar(2) =NULL

AS

SELECT 
	D.DRDSNID,
	DRDSNName,
	DRDSNODBC
FROM	DRDSN D
JOIN	ServiceLevelDRDSN SL ON SL.DRDSNID = D.DRDSNID
LEFT JOIN STATE ST ON ST.StateID = D.DRDSNStateID
WHERE	SL.ServiceLevelID = @ServiceLevelID	
AND 	(ST.StateAbbrv  = @StateID  or ISNULL(@StateID , '')= '')





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

