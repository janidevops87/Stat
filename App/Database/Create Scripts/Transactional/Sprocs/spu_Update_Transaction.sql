SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Update_Transaction]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_Update_Transaction]
GO



Create  PROCEDURE spu_Update_Transaction
(
	@vCallID as int,
	@vValues as int,
	@vUnlock as int)

AS

--DECLARE @vvalues INT
--DECLARE @vCallID INT

--set @vvalues = 683
--set @vcallid = 4816687

DECLARE  @intRetCode    int,
         @intRowcount   int,
         @intError      int

SELECT   @intRetCode = 0

BEGIN TRAN
  -- Lock Rows
  if @vUnlock = 1
     UPDATE Call SET Call.callopenbyid = @vValues	WHERE Call.CallID = @vCallID
  else
     UPDATE Call SET Call.callopenbyid = @vValues	WHERE Call.CallID = @vCallID and call.callopenbyid = -1
  --Transaction Error
  IF @@ERROR <> 0
    ROLLBACK TRANSACTION
	
  ELSE 
    COMMIT TRANSACTION
      

 SELECT @intRowCount = @@rowcount, @intError = @@error
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

RETURN @intRetCode


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

