SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineSubLocationLevel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineSubLocationLevel]
GO




CREATE PROCEDURE sps_OnlineSubLocationLevel
		

AS
SELECT DISTINCT SubLocationLevel.SubLocationLevelID, SubLocationLevel.SubLocationLevelName FROM SubLocationLevel order by SublocationLevelName;



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

