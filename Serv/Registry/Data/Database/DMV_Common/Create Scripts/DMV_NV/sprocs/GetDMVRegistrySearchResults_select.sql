IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetDMVRegistrySearchResults_select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetDMVRegistrySearchResults_select]
	PRINT 'Dropping Procedure: GetDMVRegistrySearchResults_select'
END
	PRINT 'Creating Procedure: GetDMVRegistrySearchResults_select'
GO

CREATE PROCEDURE [dbo].[GetDMVRegistrySearchResults_select]
	@FirstName varchar(40) = NULL,
	@MiddleName varchar(40) = NULL,
	@LastName varchar(40) = NULL,
	@City varchar(40) = NULL,
	@State varchar(2) = NULL,
	@Zip varchar(40) = NULL,
	@License  varchar(10) = NULL,/* May also be State ID */
	@DOB	datetime = NULL,
	@DisplayDMVDonorsYesOnly bit = Null
AS
/******************************************************************************
**		File: GetDMVRegistrySearchResults_select.sql
**		Name: GetDMVRegistrySearchResults_select
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
**		Date: 02/27/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		02/27/2009		ccarroll				initial release
**		09/25/2009		ccarroll				added LEFT statements for temp table limitations
**		01/11/2011		ccarroll				Bug Fix for wi-9231, HS-25889 added RegistrySearchResultSourceState
**		08/05/2013		ccarroll				Added RegistrySearchResultDonorActivityDate for sorting
**		03/05/2014		Moonray Schepart		Added filter for CSORLICENSE on License match.
**		08/07/2014		Moonray Schepart		Inclusion of Display Name fields (CCRST196)
**		01/14/2016		Andriy Mazur    		Refactor Zip filter to use widechar.
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

DECLARE @Donor bit;

IF coalesce(@DisplayDMVDonorsYesOnly, 0) = 1
BEGIN
	SET @Donor = 1
END

SELECT  DISTINCT
		'DMV'AS 'RegistrySearchResultSourceName',
		Null AS 'RegistrySearchResultSourceState',
		DMV.ID AS 'RegistrySearchResultSourceID',
		LEFT(COALESCE(DMV.FirstName_Display,DMV.FirstName), 20) AS 'RegistrySearchResultFirstName',
		LEFT(COALESCE(DMV.MiddleName_Display, DMV.MiddleName), 20) AS 'RegistrySearchResultMiddleName',
		LEFT(COALESCE(DMV.LastName_Display,DMV.LastName), 25) AS 'RegistrySearchResultLastName',
		''AS 'RegistrySearchResultVerificationForm', --RegistryOwnerState.RegistryOwnerStateVerificationForm AS 'RegistrySearchResultVerificationForm',
		Convert(varchar, DMV.DOB, 101) AS 'RegistrySearchResultDOB',
		LEFT(DMV.License, 10) AS 'RegistrySearchResultSID',
		LEFT(DMVAddr.Addr1, 40) AS 'RegistrySearchResultAddress',
		LEFT(DMVAddr.City, 25) AS 'RegistrySearchResultCity',
		LEFT(DMVAddr.State, 2) AS 'RegistrySearchResultState',
		LEFT(DMVAddr.Zip, 10) AS 'RegistrySearchResultZip',
		CASE WHEN DMV.RenewalDate Is Null 
			 THEN 'Original Date: ' + CONVERT(varchar, DMV.CreateDate, 101) 
				ELSE 'Renewal Date: ' + CONVERT(varchar, DMV.RenewalDate, 101) END AS 'RegistrySearchResultDonorDate',
		CASE WHEN DMV.RenewalDate Is Null 
			 THEN DMV.CreateDate
				ELSE DMV.RenewalDate END AS 'RegistrySearchResultDonorActivityDate',
		CASE WHEN coalesce(DMV.Donor, 0) = 1 
			 THEN 'Y' 
				ELSE 'N' END AS 'RegistrySearchResultDonorStatus',
		CASE WHEN coalesce(DMV.Donor, 0) = 1 
			 THEN 'Y' 
				ELSE 'N' END AS 'RegistrySearchResultDonorConfirmed'

FROM	DMV
LEFT	JOIN DMVAddr ON DMVAddr.DMVID = DMV.ID AND (DMVAddr.AddrTypeID = 1)	
LEFT	JOIN DMV_Common.dbo.RegistryOwnerStateConfig AS RegistryOwnerState ON RegistryOwnerState.RegistryOwnerStateAbbrv = LEFT(DMVAddr.State,2)

WHERE
	(@Donor IS NULL OR coalesce(DMV.Donor, 0)=@Donor ) AND
	(@DOB IS NULL OR DMV.DOB = @DOB) AND
	(@License IS NULL OR PATINDEX(@License+ '%',  RTRIM(COALESCE(DMV.License, DMV.CSORLICENSE, ''))) > 0) AND
	(@State IS NULL OR LEFT(DMVAddr.State,2) = @State) AND
	(@Zip IS NULL OR PATINDEX(@Zip, DMVAddr.Zip) > 0) AND
	(@FirstName IS NULL OR PATINDEX(@FirstName + '%', DMV.FirstName) > 0) AND
	(@MiddleName IS NULL OR PATINDEX(@MiddleName+ '%', COALESCE(MiddleName,''))  > 0)  AND
	(@LastName IS NULL OR PATINDEX(@LastName+ '%', DMV.LastName) > 0) AND
	(@City IS NULL OR PATINDEX(@City+ '%', DMVAddr.City) > 0)
GO


