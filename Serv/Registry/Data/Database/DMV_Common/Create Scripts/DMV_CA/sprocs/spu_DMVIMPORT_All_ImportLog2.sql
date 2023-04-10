if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_All_ImportLog2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_All_ImportLog2'
	drop procedure [dbo].[spu_DMVIMPORT_All_ImportLog2]
End
GO

	PRINT 'Creating spu_DMVIMPORT_All_ImportLog2'
GO

CREATE PROCEDURE spu_DMVIMPORT_All_ImportLog2 AS
/******************************************************************************
**		File: spu_DMVIMPORT_All_ImportLog2.sql
**		Name: spu_DMVIMPORT_All_ImportLog2
**		Desc: This sp checks the import type of the data load and determines how to calculate
**			record counts.
**			
**			Import data load types:
**			  1. Update calculate the updates
**			  2. Full reset the update counts
**
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
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/10/2007  ccarroll			initial
*******************************************************************************/
declare @@RecordsUpdated             int
declare @@RecordsAdded               int

if (SELECT RunType FROM DMVImportLog WHERE RunStatus = 'LOADING') = 'Update'

Begin
  /* This is an update. Count records which will be Added/Updated */

  select @@RecordsUpdated = count(DMVIMPORT.ID)
  from DMVIMPORT, DMV
  where DMVIMPORT.LICENSE = DMV.LICENSE

  select @@RecordsAdded = count(DMVIMPORT.ID)
  from DMVIMPORT
  where not exists(select DMVIMPORT.LICENSE
                   from DMV where DMVIMPORT.LICENSE = DMV.LICENSE)

End

ELSE

Begin
  /* This is a full data load. Reset updated record counts
     and get all records to be added                         */

  select @@RecordsUpdated = 0
  select @@RecordsAdded = (SELECT count(DMVIMPORT.ID) FROM DMVIMPORT)
End


update DMVIMPORTLOG
set RecordsUpdated            = @@RecordsUpdated,
    RecordsAdded              = @@RecordsAdded
where RunStatus = 'LOADING'



GO


