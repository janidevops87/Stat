IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spu_Update_Registry_PreviousDonorStatus')
	BEGIN
		PRINT 'Dropping Procedure spu_Update_Registry_PreviousDonorStatus'
		DROP  Procedure  spu_Update_Registry_PreviousDonorStatus
	END

GO

PRINT 'Creating Procedure spu_Update_Registry_PreviousDonorStatus'
GO
CREATE Procedure spu_Update_Registry_PreviousDonorStatus
		@RegID		Int = Null,
		@FirstName	varchar(255) = Null,
		@LastName	varchar(255) = Null,
		@DOB		smalldatetime = Null

AS

/******************************************************************************
**		File: spu_Update_Registry_PreviousDonorStatus.sql
**		Name: spu_Update_Registry_PreviousDonorStatus
**		Desc: 
**
**		Desc: This sproc updates Registry records as a Donor is entered. Records in the 
**		DMV are checked and If the donor exists, the previous donor status flag is
**      updated from the DMV records.
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll
**		Date: 04/11/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    04/21/2008		ccarroll				Changed to use DMV.Donor for previous value
**	  04/25/2008		ccarroll				Added IF EXISTS to check for null PreviousDonorStateDonor
*******************************************************************************/
/* Only check DMV if Previous Donor Status is missing in Registry */ 
IF EXISTS (SELECT * FROM Registry WHERE Registry.ID = @RegID AND PreviousDonorStateDonor Is Null)
		
BEGIN

	UPDATE Registry
			SET	Registry.DMVDonor = DMV.Donor,
				Registry.PreviousDonorStateDonor = DMV.Donor,
				Registry.PreviousDonorStateDMVDonor = DMV.PreviousDonorState,
				Registry.PreviousDonorStateDonorConfirmed= DMV.Donor
	FROM  DMV, Registry
	WHERE
						DMV.LastName = IsNull(@LastName, '')
					  AND   DMV.FirstName = IsNull(@FirstName, '')
					  AND   DMV.DOB = IsNull(@DOB,'')
					  AND	Registry.LastName = DMV.LastName
					  AND	Registry.FirstName = DMV.FirstName
					  AND	Registry.DOB = DMV.DOB
					  AND   Registry.ID = @RegID
					  AND   isNull(Registry.DonorConfirmed, 0) = 1
END				  
				  
GO
