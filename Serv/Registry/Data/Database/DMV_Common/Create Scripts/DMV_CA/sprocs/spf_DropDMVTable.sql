if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_DropDMVTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spf_DropDMVTable'
	drop procedure [dbo].[spf_DropDMVTable]
End
GO

	PRINT 'Creating spf_DropDMVTable'
GO


CREATE PROCEDURE spf_DropDMVTable AS
/******************************************************************************
**		File: spf_DropDMVTable.sql
**		Name: spf_DropDMVTable
**		Desc: Used to drop DMV table prior to renaming tempDMV
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMV]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMV]


GO


