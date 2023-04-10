
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_GetDMVCreateDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_GetDMVCreateDate'
	drop procedure [dbo].[spu_DMVIMPORT_GetDMVCreateDate]
End
GO

	PRINT 'Creating spu_DMVIMPORT_GetDMVCreateDate'
GO


CREATE   PROCEDURE spu_DMVIMPORT_GetDMVCreateDate AS
/******************************************************************************
**		File: spu_DMVIMPORT_GetDMVCreateDate.sql
**		Name: spu_DMVIMPORT_GetDMVCreateDate
**		Desc: This sproc retains the original CreateDate of DMV records to be updated.
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

begin transaction DMVGetCreateDate

	UPDATE DMVIMPORT SET CreateDate = DMV.CreateDate
	FROM DMVIMPORT, DMV
	WHERE DMVIMPORT.License = DMV.License



commit transaction DMVGetCreateDate

CHECKPOINT 


GO


