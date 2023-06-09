SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineUpdateCall]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineUpdateCall]
GO




CREATE PROCEDURE sps_OnlineUpdateCall
	@vCallID as varchar(10),
	@vCallIDNumber as varchar(10) = '555555',	
	@vPersonID as int = 000,
	@SourceCodeID as int =14
 AS

UPDATE Call SET CallNumber =@vCallIDNumber,CallTypeID = 1,CallDateTime = current_TimeStamp,StatEmployeeID = @vPersonID,
CallTotalTime = '00:00:00',CallSeconds = 000,CallTemp = 0,SourceCodeID = @SourceCodeID,CallOpenByID = -1,
CallTempExclusive = 0,CallTempSavedByID = -1 WHERE CallID = @vCallID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

