   /******************************************************************************
**		File: Remove Sproc DeleteRoleByName.sql.sql
**		Desc: Removes DeleteRoleByName sproc. This sproc was create by Enterprise Library and is not necessary.
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteRoleByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteRoleByName]
GO


