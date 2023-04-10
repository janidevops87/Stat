SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineSubLocation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineSubLocation]
GO




CREATE PROCEDURE sps_OnlineSubLocation
		@vSourcecodeID as int = null

AS

	SELECT DISTINCT SubLocation.SubLocationID, SubLocation.SubLocationName 
       FROM SubLocation




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

