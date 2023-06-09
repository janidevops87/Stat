SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_AdvanceRotationDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_AdvanceRotationDate]
GO







CREATE PROCEDURE SPS_AdvanceRotationDate 
--T.T 12/22/2004 This stored proc advances the next Run of a Rotation
		@RotationGroupID as int

 AS
--select * from rotation
declare
	@RotationFrequency as int,
	@RotationLastRun as datetime,
	@RotationFutureRun as datetime,
	@RotationAccessDate as datetime

--Get rotation Frequency
select @RotationFrequency = RotationFrequency from RotationGroupName where RotationGroupID = @RotationGroupID
--assign LastRun 
select @RotationLastRun = RotationNextRun from Rotation where  RotationGroupID = @RotationGroupID
--print @RotationLastRun

if @RotationFrequency = 1
	Begin
		SELECT  @RotationFutureRun =  DATEADD(wk,1,@RotationLastRun);
		SELECT @RotationAccessDate = DATEADD(wk,1,@RotationFutureRun);
	End
if @RotationFrequency = 3 	
	Begin
		SELECT  @RotationFutureRun =  DATEADD(mm,6,@RotationLastRun);
		Select 	   @RotationAccessDate = DateAdd(mm,6,@RotationFutureRun);
	End
If @RotationFrequency = 2 
	Begin 
		SELECT  @RotationFutureRun =  DATEADD(mm,1,@RotationLastRun);
		Select 	   @RotationAccessDate = DateAdd(mm,1,@RotationFutureRun);
	End
if @RotationFrequency = 4 
	Begin
		SELECT  @RotationFutureRun =  DATEADD(yy,1,@RotationLastRun);
		Select 	   @RotationAccessDate = DateAdd(yy,1,@RotationFutureRun);
	End

--Update last Run
Update Rotation
set RotationLastRun = @RotationLastRun
where  RotationGroupID = @RotationGroupID

--Update Next Run
Update Rotation 
set RotationNextRun = @RotationFutureRun
where  RotationGroupID = @RotationGroupID

--Update AccessDate
Update Rotation
set RotationReportAccessDate = @RotationAccessDate
where RotationGroupID = RotationGroupID


--select * from Rotation where currentRotation = -1 and RotationID = 2 and RotationGroupID = 2




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

