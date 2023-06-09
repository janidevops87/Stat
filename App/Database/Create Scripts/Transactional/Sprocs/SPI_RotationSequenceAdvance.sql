SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_RotationSequenceAdvance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_RotationSequenceAdvance]
GO









CREATE PROCEDURE SPI_RotationSequenceAdvance
		@RotationGroupID as int

 AS
Declare
	@RotationMax as int,
	@RotationMIn as int,
	@RotationCurrent as int,
	@RotationCurrentSequence as int

select @RotationMin = min (rotationsequence)  from rotation where rotationgroupid = @RotationGroupID
select @RotationMax = max(rotationsequence) from rotation where rotationgroupid = @RotationGroupID
select @RotationCurrent = rotationID, @RotationCurrentSequence = rotationsequence from rotation where rotationgroupid = @RotationgroupID and RotationRemediate = -1

--set entire rotation off
Update rotation
set CurrentRotation = -1
where  RotationGroupID = @RotationGroupID

--set entire rotation off
Update rotation
set RotationRemediate = 0 
where RotationGroupID = @rotationGroupID

if @RotationCurrentSequence = @RotationMax
	Begin
		Update rotation	
		set RotationRemediate = -1
		where Rotationsequence = @RotationMin and RotationGroupID = @RotationGroupID
	
		Update rotation
		set currentRotation = 0
		where Rotationsequence = (@RotationMin) and RotationGroupID = @RotationGroupID

	end

if @RotationCurrentSequence <> @RotationMax
	Begin
		Update rotation
		set CurrentRotation = 0
		where Rotationsequence = (@RotationCurrentSequence + 1) and RotationGroupID = @RotationGroupID
	
		Update rotation
		set RotationRemediate = -1
		where Rotationsequence = (@RotationCurrentSequence + 1) and RotationGroupID = @RotationGroupID
	end

--Update rotatio to be remediated
	--Update rotation	
	--set RotationRemediate = -1
	--where Rotationsequence = @RotationCurrentsequence and RotationGroupID = @RotationGroupID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

