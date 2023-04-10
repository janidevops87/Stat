  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetDMVVerification_select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetDMVVerification_select]
	PRINT 'Dropping Procedure: GetDMVVerification_select'
END
	PRINT 'Creating Procedure: GetDMVVerification_select'
GO


CREATE PROCEDURE [dbo].[GetDMVVerification_select]
	@SourceID int = NULL
AS
/******************************************************************************
**		File: GetDMVVerification_select.sql
**		Name: GetDMVVerification_select
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll	
**		Date: 04/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		04/02/2009		ccarroll				initial release
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


SELECT
		RTRIM(IsNull(DMV.FirstName, '')) + ' ' +
		CASE WHEN LEN(IsNull(DMV.MiddleName, '')) > 0 THEN RTRIM(DMV.MiddleName) + ' ' ELSE '' END + 
		RTRIM(IsNull(DMV.LastName, '')) AS 'VerificationFullName',
		CONVERT(varchar, DMV.DOB, 101) AS 'VerificationDOB',
		IsNull(DMVAddr.Addr1, '')AS 'VerificationResidentialAddress',
		RTRIM(DMVAddr.City) + ', ' +
		RTRIM(DMVAddr.State) + ', ' +
		RTRIM(DMVAddr.Zip) AS 'VerificationCityStateZip',
		'' AS 'VerificationLimitation',
		CASE WHEN DMV.RenewalDate Is Null 
			 THEN 'Date of Registry activity: ' + CONVERT(varchar, DMV.CreateDate, 101) + ' ' + CONVERT(varchar, DMV.CreateDate, 108) 
			 ELSE 'Renewal Date: ' + CONVERT(varchar, DMV.RenewalDate, 101) + ' ' + CONVERT(varchar, DMV.RenewalDate, 108) END AS 'VerificationSignatureDate',
		RegistryOwnerState.RegistryOwnerStateVerificationForm AS 'VerificationForm',
		CASE WHEN LEN(IsNull(DMV.License, '')) > 0 
		THEN RTRIM(DMV.License) 
		ELSE CAST(DMV.ID AS varchar)
		END AS 'VerificationStateID'


FROM	DMV
LEFT	JOIN DMVAddr ON DMVAddr.DMVID = DMV.ID AND (DMVAddr.AddrTypeID = 1)	
LEFT	JOIN DMV_Common.dbo.RegistryOwnerStateConfig AS RegistryOwnerState ON RegistryOwnerState.RegistryOwnerStateAbbrv = DMVAddr.State

WHERE
		DMV.ID = @SourceID


GO