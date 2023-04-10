IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_AutoResponseCodeCleanUp')
	BEGIN
		PRINT 'Dropping Procedure sp_AutoResponseCodeCleanUp'
		DROP Procedure sp_AutoResponseCodeCleanUp
	END
GO

PRINT 'Creating Procedure sp_AutoResponseCodeCleanUp'
GO
CREATE Procedure sp_AutoResponseCodeCleanUp AS
/******************************************************************************
**	File: sp_AutoResponseCodeCleanUp.sql
**	Name: sp_AutoResponseCodeCleanUp
**	Desc: Removes Old AutoResponseCodeCleanUp
**	Auth: Bret Knoll
**	Date: 10/12/2019
**	Called By: SQL Job
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/12/2019		Bret Knoll				Initial Sproc Creation
*******************************************************************************/


while exists(
	select top(1000) LastModified,  AutoResponseCode.* from AutoResponseCode
	join call on AutoResponseCode.CallID = call.callid
	where LastModified < DATEADD(year, -1, GETDATE())
)
begin
	delete AutoResponseCode
	from AutoResponseCode
	join (
		select top(1000) AutoResponseCode.AutoResponseCodeId 
		from AutoResponseCode
		join call on AutoResponseCode.CallID = call.callid
		where LastModified < DATEADD(year, -1, GETDATE())
		order by AutoResponseCodeId desc ) delTable on AutoResponseCode.AutoResponseCodeID = delTable.AutoResponseCodeID

	WaitFor Delay '00:00:10'
end
