 /******************************************************************************
**		File: Remove Sproc RemoveUserFromRoleByName.sql
**		Desc: Removes RemoveUserFromRoleByName sproc. This sproc was create by Enterprise Library and is not necessary.
**
**		Auth: Bret Knoll
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------	
**		11/12/07	Bret Knoll			initial
**    
*******************************************************************************/ 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RemoveUserFromRoleByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'drop procedure [dbo].[RemoveUserFromRoleByName]'
	drop procedure [dbo].[RemoveUserFromRoleByName]
END
GO




 