if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_A_DataCleanupInvalidFirstLast]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_A_DataCleanupInvalidFirstLast'
	drop procedure [dbo].[spu_DMVIMPORT_A_DataCleanupInvalidFirstLast]
End
GO

	PRINT 'Creating spu_DMVIMPORT_A_DataCleanupInvalidFirstLast'
GO


CREATE PROCEDURE spu_DMVIMPORT_A_DataCleanupInvalidFirstLast AS
/******************************************************************************
**		File: spu_DMVIMPORT_A_DataCleanupInvalidFirstLast.sql
**		Name: spu_DMVIMPORT_A_DataCleanupInvalidFirstLast
**		Desc: Looks for records with invalid First or Last and removes them to DMVSuspense_A
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
*******************************************************************************/declare @suspect varchar(255)
select @suspect = 'Invalid First or Last Name DMVIMPORT_A'
begin transaction DMVIMPORT_A
  insert DMVSUSPENSE_A
  select *, 0, @suspect from DMVIMPORT_A
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
  update DMVIMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from DMVIMPORT_A
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
commit transaction DMVIMPORT_A

CHECKPOINT 


GO


