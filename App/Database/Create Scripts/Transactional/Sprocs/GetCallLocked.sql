IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetCallLocked')
	BEGIN
		PRINT 'Dropping Procedure GetCallLocked'
		DROP  Procedure  GetCallLocked
	END

GO

PRINT 'Creating Procedure GetCallLocked'
GO  
CREATE PROCEDURE GetCallLocked
	@CallID						int = Null,
	@CallOpenByID					int=Null,
	@returnVal int OUTPUT
	
	

AS
/******************************************************************************
**		File: GetCallLocked.sql
**		Name: GetCallLocked
**		Desc: 
**
**              
**		Return values:
** 
**		Called by: Referral Update.aspx
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: jth
**		Date: 10/2008
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**     10/2008      jth             initial
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
set @returnval = 0
declare @test int
declare @test1 int
SELECT  @test=DATEdiff(minute,LastModified,getdate()) ,  @test1=CallOpenByID FROM Call WHERE CallID = @CallID;
if (@test1 <> -1 and  @test < 10)
begin
	set @returnVal = 1
end
if (@test1 = @CallOpenByID)
begin
	set @returnVal = 0
end
RETURN @returnVal
GO