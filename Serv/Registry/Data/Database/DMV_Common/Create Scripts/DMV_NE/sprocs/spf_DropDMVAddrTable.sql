 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_DropDMVAddrTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spf_DropDMVAddrTable]
	PRINT 'Dropping Procedure: spf_DropDMVAddrTable'
END
	PRINT 'Creating Procedure: spf_DropDMVAddrTable'
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spf_DropDMVAddrTable] AS
/******************************************************************************
**		File: spf_DropDMVAddrTable.sql
**		Name: spf_DropDMVAddrTable
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 10/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      10/28/2009		ccarroll			Initial release
*******************************************************************************/


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVADDR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVADDR]


GO


