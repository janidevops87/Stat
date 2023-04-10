  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetWebVerification_select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetWebVerification_select]
	PRINT 'Dropping Procedure: GetWebVerification_select'
END
	PRINT 'Creating Procedure: GetWebVerification_select'
GO


CREATE PROCEDURE [dbo].[GetWebVerification_select]
	@SourceID int = NULL
AS
/******************************************************************************
**		File: GetWebVerification_select.sql
**		Name: GetWebVerification_select
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
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		04/02/2008		ccarroll				initial release
**		09/26/2009		ccarroll				fixed web.Limitations
**		02/05/2014		Moonray Schepart		Enable Drivers License or Registry ID as VerificationStateID value
**		01/03/2017		mmaitan					Added VerificationComment to fix verification form errors
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


SELECT
		RTRIM(IsNull(Web.FirstName, '')) + ' ' +
		CASE WHEN LEN(IsNull(Web.MiddleName, '')) > 0 THEN RTRIM(Web.MiddleName) + ' ' ELSE '' END + 
		RTRIM(IsNull(Web.LastName, '')) AS 'VerificationFullName',
		CONVERT(varchar, Web.DOB, 101) AS 'VerificationDOB',
		IsNull(WebAddr.Addr1, '')AS 'VerificationResidentialAddress',
		RTRIM(WebAddr.City) + ', ' +
		RTRIM(WebAddr.State) + ', ' +
		RTRIM(WebAddr.Zip) AS 'VerificationCityStateZip',
		RTRIM(Web.Limitations) AS 'VerificationLimitation',
		'Signature Date: ' + 
			CASE WHEN Web.SignatureDate Is Null
				 THEN CONVERT(varchar, Web.OnlineRegDate, 101)
				 ELSE CONVERT(varchar, Web.SignatureDate, 101)
			END AS 'VerificationSignatureDate',
		RegistryOwnerState.RegistryOwnerStateVerificationForm AS 'VerificationForm',
		CASE WHEN LEN(Web.License) > 0 
			 THEN 'License# ' + CONVERT(nvarchar(10), Web.License) 
		 	 ELSE
			  'Web Registry# ' + CONVERT(NVARCHAR(100), Web.RegistryID)
			 END AS 'VerificationStateID',
		NULL AS 'VerificationComment'


FROM	Registry AS Web
LEFT	JOIN RegistryAddr AS WebAddr ON WebAddr.RegistryID = Web.RegistryID AND (WebAddr.AddrTypeID = 1)	
LEFT	JOIN DMV_Common.dbo.RegistryOwnerStateConfig AS RegistryOwnerState ON RegistryOwnerState.RegistryOwnerStateAbbrv = WebAddr.State

WHERE
		Web.RegistryID = @SourceID


