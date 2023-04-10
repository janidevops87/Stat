 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spu_Update_DMV_PreviousDonorStatus')
	BEGIN
		PRINT 'Dropping Procedure spu_Update_DMV_PreviousDonorStatus'
		DROP  Procedure  spu_Update_DMV_PreviousDonorStatus
	END

GO

PRINT 'Creating Procedure spu_Update_DMV_PreviousDonorStatus'
GO
CREATE Procedure spu_Update_DMV_PreviousDonorStatus
		
AS
/******************************************************************************
**		File: spu_Update_DMV_PreviousDonorStatus.sql
**		Name: spu_Update_DMV_PreviousDonorStatus
**
**		Desc: This sproc updates DMV records as they are being imported. Records in the 
**		Registry are checked and If the donor exists, the previous donor status flag is
**      updated in the Import table provided the donor is confirmed and the Previous Donor
**		value differs from the DMV value.
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
**		Auth: ccarroll				
**		Date: 04/11/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     04/21/2007		ccarroll				Updated notes, changed logic to look at 
**												actual registry.Donor value
*******************************************************************************/

UPDATE Import SET Import.PreviousDonorState = Registry.Donor
FROM Registry, Import
WHERE Import.Last = Registry.LastName
AND   Import.First = Registry.FirstName
AND   Import.DOB = Registry.DOB
AND   (
		Import.PreviousDonorState <> Registry.Donor
	)
AND    IsNull(Registry.DonorConfirmed, 0) <> 0

GO
