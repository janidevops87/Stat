SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_DeleteArchiveStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_DeleteArchiveStatus]
GO

CREATE PROCEDURE spd_DeleteArchiveStatus AS

SET NOCOUNT ON

DECLARE	@COUNTER int,
	@RowCount int,
	@CurrentRowCount int,
	@TotalRowCount int, 
	@ErrorMessage varchar(50),
	@Delay varchar(10),
	@MaxArchiveStatusDate as smalldatetime

Set @Counter = 0 
Set @RowCount =50
Set @Delay = '000:00:20'
Select @MaxArchiveStatusDate = Max(TableDate) from ArchiveStatus
-- Delete data from the production Table based on the archive Status max tabledate
-- By Deleting Call records NoCall, Message, Referral, ReferralSecondaryData, CallCustomField, LogEvent
select 'deleting tables'

SET ROWCOUNT @RowCount


While (0=0)
BEGIN
	Select @Counter As 'Counter'		
	Select @Counter = @Counter+1
	DELETE
	FROM Call
	WHERE CallDateTime < DateAdd(d,1,@MaxArchiveStatusDate)

Select @CurrentRowCount = @@ROWCOUNT

select @TotalRowCount = @TotalRowCount + @CurrentRowCount
--Wait before deleting more
WAITFOR DELAY @Delay

--Record number of records copied 
SET @ErrorMessage = 'Information Message:> Deleted Call Records: ' + cast(@TotalRowCount AS VARCHAR)
RAISERROR (@ErrorMessage,1,1)with LOG

IF @CurrentRowCount = 0  
--and (select count(*) from Call where exists (select * from ArchiveCall where ArchiveCall.CallID = Call.CallID )) = 0
	BEGIN 

		BREAK
	END

END












GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

