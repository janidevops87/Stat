if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_CreateDMVOrganTempTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spf_CreateDMVOrganTempTable'
	drop procedure [dbo].[spf_CreateDMVOrganTempTable]
End
GO

	PRINT 'Creating spf_CreateDMVOrganTempTable'
GO

CREATE  PROCEDURE spf_CreateDMVOrganTempTable AS
/******************************************************************************
**		File: spf_CreateDMVOrganTempTable.sql
**		Name: spf_CreateDMVOrganTempTable
**		Desc: Used to create DMVOrganTempTable
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVOrganTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVOrganTempTable]



CREATE TABLE [dbo].[DMVOrganTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[DMVID] [int] NULL ,
	[OrganTypeID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
) ON [PRIMARY]


GO
