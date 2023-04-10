
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_ImportLog1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_ImportLog1'
	drop procedure [dbo].[spu_DMVIMPORT_ImportLog1]
End
GO

	PRINT 'Creating spu_DMVIMPORT_ImportLog1'
GO


CREATE PROCEDURE spu_DMVIMPORT_ImportLog1
	@RunType varchar(10) = Null
AS
/******************************************************************************
**		File: spu_DMVIMPORT_ImportLog1.sql
**		Name: spu_DMVIMPORT_ImportLog1
**		Desc:This procedure updates the DMVImportLog table. The RunType value is set by passing
**			a parameter to the sproc. This import process value is used later to provide accurate
**			record counts to DMVImportLog.
**
**		Usage:
**			spu_DMVIMPORT_ImportLog1 'Full'	-- Full data imports
**			spu_DMVIMPORT_ImportLog1  	-- updates  
**
**
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@RunType varchar(10) = Null
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

declare @@RecordsTotal               int

select @@RecordsTotal = count(DMVIMPORT_A.ID)
from DMVIMPORT_A
update DMVIMPORTLOG
set RecordsTotal = @@RecordsTotal,
    RunType = ISNULL(@RunType,'Update')

where RunStatus = 'LOADING'



GO


