if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_DropDMVADDRTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spf_DropDMVADDRTable'
	drop Procedure [dbo].[spf_DropDMVADDRTable]
End
GO

	PRINT 'Creating spf_DropDMVADDRTable'
GO


CREATE PROCEDURE spf_DropDMVADDRTable AS
/******************************************************************************
**		File: spf_DropDMVADDRTable.sql
**		Name: spf_DropDMVADDRTable
**		Desc: Used to drop DMVADDRTable
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVADDR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVADDR]


GO
