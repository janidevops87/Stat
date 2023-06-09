SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_RotationRun]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_RotationRun]
GO








CREATE PROCEDURE SPI_RotationRun 
			@Runn as int

 AS
Declare 
	@RotationGroupID as int,
	@RotationID as int,
	@RotationName as varchar(255),
	@RotationGroupName as varchar(255),
	@ID as int,
	@TimeZone as int,
	@modTime as datetime,
	@MaxRotation as int,
	@MinRotation as int,
	@currentRotation as int,
	@NextRotation as int



--set @Runn = 1
	select @modTime = current_Timestamp
	 if @Runn = 3
		begin
			select @modTime = dateadd(mi ,125,current_Timestamp)		 
			print @modTime
		end
	if @Runn = 4
		Begin
			select @modTime = dateadd(mi ,125,current_Timestamp)
			print @modTime
		end
	Print @maxrotation
	Print @MinRotation
	Print @Currentrotation	
	Print @NextRotation
	--set @Runn = 1 --PT
declare bRef cursor for
	
	--current rotation
	Select  ID  from Rotation where RotationNextRun < @modTime and RotationRemediate = -1
	
	
	

	Open bRef
	fetch next from bRef into @ID
	while @@fetch_status = 0
		begin
			Select @RotationGroupID = rotationGroupID from rotation where ID = @ID
			--select RotationNextRun from Rotation where RotationNextRun <@modTime and currentRotation = -1
			select @MaxRotation = Max(RotationID) from rotation where rotationGroupID = @RotationGroupID
			select @Minrotation = Min(RotationID) from rotation where rotationgroupID = @RotationGroupID
			select @Currentrotation = RotationID from rotation where rotationremediate = -1 and rotationgroupid = @RotationGroupID
		
			--current rotation is first one in sequence
			if @currentRotation = @maxRotation	
				Begin
					set @NextRotation = @Minrotation
				end
			--current rotation is last one is sequence
			if @currentRotation <> @maxRotation
				begin
					set @Nextrotation = @CurrentRotation + 1
				end
		
			select @RotationGroupID = RotationGroupID, @RotationID = @Nextrotation , @RotationName = RotationName  from Rotation where  rotationGroupID = @RotationGroupID and RotationID = @Nextrotation
			select @RotationGroupName = RotationGroupName from RotationGroupName where RotationGroupID = @RotationGroupID
			select @TimeZone = RotationTimeZone from RotationGroupName where RotationGroupID = @RotationGroupID
		if @TimeZone = @Runn 
			Begin
				insert into RotationRun (RotationGroupID,RotationID,RotationName,RotationGroupName) values (@RotationGroupID,@Nextrotation,@RotationName,@RotationGroupName)
				insert into RotationRunArchive (RotationGroupID,RotationID,RotationName,RotationGroupName) values (@RotationGroupID,@RotationID,@RotationName,@RotationGroupName)
				print @RotationName
			end
		fetch next from bRef into @ID
		End
		close bRef
		deallocate bRef
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

