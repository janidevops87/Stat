 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetFormElectronicSignature]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetFormElectronicSignature]
	PRINT 'Dropping Procedure: GetFormElectronicSignature'
END
	PRINT 'Creating Procedure: GetFormElectronicSignature'
GO

CREATE PROCEDURE [dbo].GetFormElectronicSignature
(
	@RegistryID int = NULL
)
/******************************************************************************
**		File: GetFormElectronicSignature.sql
**		Name: GetFormElectronicSignature
**		Desc:  Common Registry: NEOB
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 03/16/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/16/2008	ccarroll	initial
**		03/16/2012	ccarroll	removed comma between State and zipcode
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
			IsNull(Registry.FirstName, '') + ' ' +
			IsNull(Registry.MiddleName, '') + ' ' +
			IsNull(Registry.LastName, '') AS 'ElectronicSignatureName',
			
			IsNull(RegistryAddr.Addr1, '') + ', ' +
			IsNull(RegistryAddr.Addr2, '') + CASE WHEN IsNull(RegistryAddr.Addr2, '') = '' THEN '' ELSE ', ' END +
			IsNull(RegistryAddr.City, '') + ', ' +
			IsNull(RegistryAddr.State, '') + '  ' +
			IsNull(RegistryAddr.Zip, '')  AS 'ElectronicSignatureAddress',
			IsNull(Registry.Email, '') AS 'ElectronicSignatureEmail',
			Convert(varchar, Registry.DOB, 101) AS 'ElectronicSignatureDOB'
	FROM
		Registry
		
	LEFT JOIN
		RegistryAddr ON Registry.RegistryID = RegistryAddr.RegistryID AND(RegistryAddr.AddrTypeID = 1)
	WHERE 
		Registry.RegistryID = IsNull(@RegistryID, Registry.RegistryID)


	RETURN @@Error
GO 