SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetSourceCodeName_ScheduleGroupID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetSourceCodeName_ScheduleGroupID]
GO


CREATE PROCEDURE sps_GetSourceCodeName_ScheduleGroupID
	@ScheduleGroupID INT =NULL
AS
	SELECT	DISTINCT SC.SourceCodeName 
	FROM 	SourceCode SC, ScheduleGroupSourceCode SSC

	WHERE 	SSC.SourceCodeID = SC.SourceCodeID
	AND	SSC.ScheduleGroupID = @ScheduleGroupID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

