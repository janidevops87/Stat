  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spf_Reseed_DMVTempTable')
	BEGIN
		PRINT 'Dropping Procedure spf_Reseed_DMVTempTable'
		DROP  Procedure  spf_Reseed_DMVTempTable
	END

GO

PRINT 'Creating Procedure spf_Reseed_DMVTempTable'
GO


CREATE Procedure spf_Reseed_DMVTempTable

AS

/******************************************************************************
**		File: spf_Reseed_DMVTempTable.sql
**		Name: spf_Reseed_DMVTempTable
**		Desc: This sproc is placed after CreateDMVTempTable task and before the 
**		Import task in the Full Import DTS package. This will cause the new DMV
**		data to receive IDs outside the scope of the old data. HS-10508
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		NA
**
**		Auth: ccarroll						01/09/2008
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     01/09/2008		ccarroll				Initial
*******************************************************************************/
DECLARE @OldSeed int
DECLARE @NewSeed int


SET @OldSeed = (select Max(id) from (
				select ISNULL((select max(coalesce(id, 0)) from DMV), 0) id
				union all 
				select ISNULL((select max(coalesce(id, 0)) from DMVARCHIVE), 0) id
				) ud);
SET @NewSeed = (@OldSeed + 1)


DBCC CHECKIDENT (DMVTempTable, RESEED, @NewSeed );


GO
