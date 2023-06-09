SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_CODFinishCall]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_CODFinishCall]
GO




CREATE  PROCEDURE spu_CODFinishCall (@callId int = 0, @LogNoCall int = 0)

/*
   Finishes a call to the Coalition on Donation Spanish Information line.
   Used by COD_Call_Track.sls.
   Created 3/31/05 by Scott Plummer
*/
AS

SET NOCOUNT ON

DECLARE @callSeconds SmallInt


-- Calculate the total number of seconds between initial logging of call and now, use that number to generate 
-- CallSeconds and CallTotalTime

SET @callSeconds = (SELECT DateDiff(s, CallDateTime, GetDate()) FROM Call WHERE CallId = @callId);

-- Format the CallTotalTime string (varchar(15)) to correspond to the number of seconds taken
DECLARE @secondPart varchar(3), @minutePart varchar(3), @hourPart varchar(3)
-- Format the hours:
IF @callSeconds > 3600
	BEGIN
		SET @hourPart = Right('0' + CAST(@callSeconds / 3600 AS VARCHAR),2);
	END
ELSE
	BEGIN
		SET @hourPart = '00';
	END

-- Format the minutes:
IF @callSeconds > 60
	BEGIN
		SET @minutePart = Right('0' + CAST(@callSeconds / 60 AS VARCHAR),2);
	END
ELSE
	BEGIN
		SET @minutePart = '00';
	END

-- Format the seconds:
SET @secondPart = Right('0' + CAST(@callSeconds % 60 AS VARCHAR),2);


-- Update the call record with times and CallNumber
UPDATE Call SET CallNumber = CAST(@callId AS VARCHAR) + '-' + CAST(StatEmployeeId AS VARCHAR),
	CallTotalTime = @hourPart + ':' + @minutePart + ':' + @secondPart,
	CallSeconds = @callSeconds,
	LastModified = GetDate()
WHERE Call.CallId = @callId;

-- If this is to be logged as No Call, a number other than zero will appear in @LogNoCall
IF @LogNoCall <> 0 
	BEGIN
		-- Change call type
		UPDATE Call SET CallTypeId = 3 WHERE CallId = @callId;
		-- Create a NoCall Record
		INSERT INTO NoCall (CallID, NoCallTypeID, NoCallDescription) VALUES (@callId, 7, 'DLASPAN Mediconnect No Call');
	END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

