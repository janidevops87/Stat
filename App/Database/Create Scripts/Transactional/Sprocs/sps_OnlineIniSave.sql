SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineIniSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineIniSave]
GO




CREATE PROCEDURE sps_OnlineIniSave 

 AS

INSERT INTO Call (CallNumber, CallTypeID, CallDateTime, StatEmployeeID, CallTotalTime, CallSeconds, CallTemp, SourceCodeID, CallOpenByID, CallTempExclusive, CallTempSavedByID, CallExtension) VALUES (NULL,1,Current_TimeStamp,888,'00:00:00',0,0,14,-1,0,-1,233)
select  @@Identity



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

