IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_CheckRegistry_DLA]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping sps_CheckRegistry_DLA';
	DROP PROCEDURE [dbo].[sps_CheckRegistry_DLA];
END
	PRINT 'Creating sps_CheckRegistry_DLA';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE sps_CheckRegistry_DLA
(
	@DOB				DATETIME = NULL,
	@LastName			VARCHAR(25) = NULL,
	@FirstName			VARCHAR(25) = NULL,
	@DLAID				INT OUTPUT,
	@DLADonor			BIT OUTPUT,
	@DLADate			DATETIME OUTPUT,
	@RecordsReturned	INT OUTPUT 
)
/******************************************************************************
**		File: sps_CheckRegistry_DLA.sql
**		Name: sps_CheckRegistry_DLA
**		Desc: This sp searches for qualified donor in the DLA Web Service Results
**             
**		Called by:  sps_CheckRegistry.sql
**             
**		Parameters:
**		Input							Output
**     ----------						-----------
**		@DOB							@DLAID
**		@LastName						@DLADonor
**		@FirstName						@DLADate
**										@RecordsReturned
**
**		Auth: Mike Berenson
**		Date: 10/17/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/17/2016  mberenson			Initial Stored Procedure Creation
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;

	--Get Values From Last Matching Record
	SELECT TOP (1)
		@DLAID = item.RegistryDlaResponseItemID,
		@DLADonor = 1,
		@DLADate = item.OnlineRegDate,
		@RecordsReturned = response.ItemCount
	FROM DMV_Common.dbo.RegistryDlaResponseItem item
		INNER JOIN DMV_Common.dbo.RegistryDlaResponse response ON item.RegistryDlaResponseID = response.RegistryDlaResponseID
	WHERE response.RequestFirstName = @FirstName
	AND response.RequestLastName = @LastName
	AND response.RequestDOB = @DOB
	AND response.ItemCount > 0
	ORDER BY response.ResponseDateTime DESC;

GO


