SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_faxqueuecheck]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_faxqueuecheck]
GO


CREATE  PROCEDURE spf_faxqueuecheck AS

DECLARE		@5_Min_Count AS INTEGER,
		@IsNull_Count AS INTEGER,
		@Return AS INTEGER,
		@MAXCOUNT AS INTEGER, -- NUMBER OF FAXES IN QUEUE
		@MAXTIME AS INTEGER   -- MINUTES IN QUEUE
		
SELECT	@MAXCOUNT = 6, 
		@MAXTIME = 10

SET NOCOUNT ON 

SELECT	@5_Min_Count = (SELECT COUNT(*) FROM FaxQueue WHERE FaxQueueSentDate IS NULL AND ABS(DATEDIFF(N,GETDATE(),FaxQueueSubmitDate)) > @MAXTIME) , 
	@IsNull_Count = (SELECT COUNT(*) FROM FaxQueue WHERE FaxQueueSentDate is null)

IF @5_Min_Count > 0
 BEGIN
	SELECT @Return = @5_Min_Count
 END
ELSE IF @IsNull_Count > @MAXCOUNT 
 BEGIN
	SELECT @Return = @IsNull_Count
 END

SELECT @Return AS 'RETURN'
RETURN @Return






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

