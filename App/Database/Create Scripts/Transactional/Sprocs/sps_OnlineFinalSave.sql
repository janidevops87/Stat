SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineFinalSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineFinalSave]
GO




CREATE PROCEDURE sps_OnlineFinalSave

 AS

UPDATE Call SET CallNumber = '4413575-574',
CallTypeID = 1,
CallDateTime = '3/15/2005 6:09:00 PM',
StatEmployeeID = 574,
CallTotalTime = '00:14:02',
CallSeconds = 842,
CallTemp = 0,
SourceCodeID = 14,
CallOpenByID = -1,
CallTempExclusive = 0,
CallTempSavedByID = -1 
WHERE CallID = 4413575



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

