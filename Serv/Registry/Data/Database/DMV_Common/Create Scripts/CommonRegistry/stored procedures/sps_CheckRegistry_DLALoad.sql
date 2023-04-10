IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_CheckRegistry_DLALoad]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	PRINT 'Dropping Procedure: sps_CheckRegistry_DLALoad';
	DROP PROCEDURE [dbo].[sps_CheckRegistry_DLALoad];
END
	PRINT 'Creating Procedure: sps_CheckRegistry_DLALoad';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistry_DLALoad]
(
 	@DOB			SMALLDATETIME   = NULL,
	@LastName		VARCHAR(25) = NULL,
	@FirstName		VARCHAR(25) = NULL
)	
/******************************************************************************
**		File: sps_CheckRegistry_DLALoad.sql
**		Name: sps_CheckRegistry_DLALoad
**		Desc: This sp looks in the DLA search results using the FirstName, MiddleName, & LastName fields
**             
**		Return values: none
**
**		Called by:  FrmReferralDonorData.vb
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: mberenson
**		Date: 11/17/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    11/17/2016	mberenson			Initial creation
**		12/14/2016	mberenson			Changed population of SearchDate
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;

	--Start Select (intentionally uses a nested select because vb/ado.net throws an error when using a temp table)
	SELECT TOP 1 
		item.FirstName,
		item.MiddleName,
		item.LastName,
		item.License,
		item.Addr1,
		item.City,
		item.[State],
		item.Zip,
		item.OnlineRegDate AS 'SearchDate',
		item.RegistryDlaResponseItemID AS 'Loc',
		'DLA' AS [Source]
	FROM DMV_Common.dbo.RegistryDlaResponseItem item
		INNER JOIN DMV_Common.dbo.RegistryDlaResponse response ON item.RegistryDlaResponseID = response.RegistryDlaResponseID
	WHERE response.RequestFirstName = @FirstName
	AND response.RequestLastName = @LastName
	AND response.RequestDOB = @DOB
	AND response.ItemCount > 0
	ORDER BY response.ResponseDateTime DESC;

GO