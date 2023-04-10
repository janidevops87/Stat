if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_DropDMVOrganTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spf_DropDMVOrganTable'
	drop procedure [dbo].[spf_DropDMVOrganTable]
End
GO

	PRINT 'Creating spf_DropDMVOrganTable'
GO

CREATE PROCEDURE spf_DropDMVOrganTable AS
/******************************************************************************
**		File: spf_DropDMVOrganTable.sql
**		Name: spf_DropDMVOrganTable
**		Desc: Used to drop DMVOrgan table
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: christopher carroll
**		Date: 10/09/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/09/2007  ccarroll			initial
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVOrgan]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVOrgan]

GO


