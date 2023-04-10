if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateRoleById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'drop procedure [dbo].[UpdateRoleById]'
	drop procedure [dbo].[UpdateRoleById]
END
GO
 