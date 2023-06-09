SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_SaveServiceLevelWorking]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_SaveServiceLevelWorking]
GO

CREATE PROCEDURE SPU_SaveServiceLevelWorking
--T.T 12/20/2004 saves serviceLevel as working updated flag = 1
	@ServiceLevelID as int
	 AS

UPDATE ServiceLevel SET WorkingStatusUpdatedFlag = 1 WHERE ServiceLevelID = @ServiceLevelID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

