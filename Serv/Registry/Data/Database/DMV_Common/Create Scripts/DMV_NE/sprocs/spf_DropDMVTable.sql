 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_DropDMVTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spf_DropDMVTable]
	PRINT 'Dropping Procedure: spf_DropDMVTable'
END
	PRINT 'Creating Procedure: spf_DropDMVTable'
GO

USE [DMV_NE]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spf_DropDMVTable] AS
/******************************************************************************
**		File: spf_DropDMVTable.sql
**		Name: spf_DropDMVTable
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMV]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMV]


GO
