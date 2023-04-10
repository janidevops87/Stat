
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVIMPORT_ImportInitialize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_DMVIMPORT_ImportInitialize'
	drop procedure [dbo].[sps_DMVIMPORT_ImportInitialize]
End
GO

	PRINT 'Creating sps_DMVIMPORT_ImportInitialize'
GO


CREATE PROCEDURE sps_DMVIMPORT_ImportInitialize AS
/******************************************************************************
**		File: sps_DMVIMPORT_ImportInitialize.sql
**		Name: sps_DMVIMPORT_ImportInitialize
**		Desc: This procedure is used to insert an import log record and then
**				return the identity value to the DTS.
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


/* Cancel ImportLog if still Loading */
UPDATE DMVIMPORTLOG
	SET RunStatus = 'Canceled',
		LastModified = GetDate()
WHERE RunStatus = 'LOADING'

/* Initialize Total Record count */
insert DMVIMPORTLOG(RecordsTotal) values(0)
return @@IDENTITY


GO


