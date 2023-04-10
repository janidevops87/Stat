if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_A_DataCleanupInvalidLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_A_DataCleanupInvalidLicense'
	drop procedure [dbo].[spu_DMVIMPORT_A_DataCleanupInvalidLicense]
End
GO

	PRINT 'Creating spu_DMVIMPORT_A_DataCleanupInvalidLicense'
GO


CREATE PROCEDURE spu_DMVIMPORT_A_DataCleanupInvalidLicense AS
/******************************************************************************
**		File: spu_DMVIMPORT_A_DataCleanupInvalidLicense.sql
**		Name: spu_DMVIMPORT_A_DataCleanupInvalidLicense
**		Desc: Looks for records with an invalid license. If found, removes them to DMVSuspense_A
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
select @suspect = 'Invalid DMV License Number DMVIMPORT_A'
begin transaction DMVIMPORT_A
  insert DMVSUSPENSE_A
  select *, 0, @suspect from DMVIMPORT_A
  where isnull(LICENSE,'') = ''
  update DMVIMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from DMVIMPORT_A
  where isnull(LICENSE,'') = ''
commit transaction DMVIMPORT_A

CHECKPOINT 


GO


