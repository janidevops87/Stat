if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_A_DataCleanupInvalidDOB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_A_DataCleanupInvalidDOB'
	drop procedure [dbo].[spu_DMVIMPORT_A_DataCleanupInvalidDOB]
End
GO

	PRINT 'Creating spu_DMVIMPORT_A_DataCleanupInvalidDOB'
GO


CREATE PROCEDURE spu_DMVIMPORT_A_DataCleanupInvalidDOB AS
/******************************************************************************
**		File: spu_DMVIMPORT_A_DataCleanupInvalidDOB.sql
**		Name: spu_DMVIMPORT_A_DataCleanupInvalidDOB
**		Desc: Looks for records with invalid DOB and removes them to DMVSuspense_A
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
declare @suspect varchar(255)
select @suspect = 'Invalid Date of Birth IMPORT_A'
begin transaction DMVIMPORT_A
  insert DMVSUSPENSE_A
  select *, 0, @suspect from DMVIMPORT_A
  where isnull(DOB,'') = ''
  update DMVIMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from DMVIMPORT_A
  where isnull(DOB,'') = ''
commit transaction DMVIMPORT_A

CHECKPOINT 


GO


