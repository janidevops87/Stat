/******************************************************************************
**		File: Remove Sproc ChangePasswordByName.sql
**		Desc: Removes ChangePasswordByName sproc. This sproc was create by Enterprise Library and is not necessary.
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ChangePasswordByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ChangePasswordByName]
GO


 