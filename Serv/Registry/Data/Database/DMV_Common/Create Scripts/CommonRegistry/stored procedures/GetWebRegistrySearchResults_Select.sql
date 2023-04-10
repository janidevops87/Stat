IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetWebRegistrySearchResults_select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetWebRegistrySearchResults_select]
	PRINT 'Dropping Procedure: GetWebRegistrySearchResults_select'
END
	PRINT 'Creating Procedure: GetWebRegistrySearchResults_select'
GO


CREATE PROCEDURE [dbo].[GetWebRegistrySearchResults_select]
	@FirstName varchar(40) = NULL,
	@MiddleName varchar(40) = NULL,
	@LastName varchar(50) = NULL,
	@City varchar(40) = NULL,
	@State varchar(2) = NULL,
	@Zip varchar(40) = NULL,
	@WebRegistryID  int = NULL,/* May also be State ID */
	@DOB	datetime = NULL,
	@DisplayWebPendingSignature bit = Null,
	@RegistryOwnerID int = NULL,
	@DisplayNoDonors bit = Null,
	@License  nvarchar(20) = NULL /* May also be State ID */

AS
/******************************************************************************
**		File: GetWebRegistrySearchResults_select.sql
**		Name: GetWebRegistrySearchResults_select
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
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**		02/27/2008		ccarroll			initial release
**		05/12/2010		ccarroll			Added @RegistryOwnerID to search
**		01/04/2011		ccarroll			Bug Fix for wi-9231, HS-25889 (RegistrySearchResultSourceState)
**		07/19/2013		ccarroll			Added @DisplayNoDonors, @License
**		09/12/2013		Moonray Schepart	Excluded records marked for deletion
**		08/14/2014		Moonray Schepart	Increased license to 20 characters (CCRST196)
**		08/15/2014		Moonray Schepart	Strip Special Characters from name while searching (CCRST196)
**		01/14/2016		Andriy Mazur    	Refactor Zip filter to use widechar.
**		08/08/2016		Aykut Ucar			Added abiltity to search when name has accents on characters
**		09/09/2016		Bret Knoll			Changed previous fix to CI
*******************************************************************************/
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @DonorConfirmed bit,
		@DonorStatus int = Null;

IF coalesce(@DisplayWebPendingSignature, 0) = 0
BEGIN
	/* When @DisplayPendingSignature is turned off (0 or Null), only confirmed donors will show 
	   When @DonorConfirmed has a null value, both confirmed and non-confirmed donors are returned  */
	SET @DonorConfirmed = 1;
END

IF coalesce(@DisplayNoDonors, 0) = 0
BEGIN
	/*	if @DonorStatus is null then return both Yes and No donors 
		if @DonorStatus is 1 only display yes donors
		@DisplayNoDonors sets @DonorStatus value
	*/
	SET @DonorStatus = 1;
END

SELECT  DISTINCT
		'Web'AS 'RegistrySearchResultSourceName',
		RegistryAddr.State AS 'RegistrySearchResultSourceState',
		Registry.RegistryID AS 'RegistrySearchResultSourceID',
		Registry.FirstName AS 'RegistrySearchResultFirstName',
		Registry.MiddleName AS 'RegistrySearchResultMiddleName',
		Registry.LastName AS 'RegistrySearchResultLastName',
		''AS 'RegistrySearchResultVerificationForm', --RegistryOwnerState.RegistryOwnerStateVerificationForm AS 'RegistrySearchResultVerificationForm',
		CONVERT(varchar, Registry.DOB, 101) AS 'RegistrySearchResultDOB',
		coalesce(Registry.License, '') AS 'RegistrySearchResultSID',
		RegistryAddr.Addr1 AS 'RegistrySearchResultAddress',
		RegistryAddr.City AS 'RegistrySearchResultCity',
		RegistryAddr.State AS 'RegistrySearchResultState',
		RegistryAddr.Zip AS 'RegistrySearchResultZip',
		CASE WHEN Registry.SignatureDate Is Null 
			 THEN 'Enrollment Date: ' + CAST(Registry.CreateDate AS varchar) 
				ELSE 'Signature Date: ' + CONVERT(varchar, Registry.SignatureDate, 101) END AS 'RegistrySearchResultDonorDate',
		CASE WHEN Registry.SignatureDate Is Null 
			 THEN Registry.CreateDate 
				ELSE Registry.SignatureDate END AS 'RegistrySearchResultDonorActivityDate',

		CASE WHEN coalesce(Registry.Donor, 0) = 1 
			 THEN 'Y' 
				ELSE 'N' END AS 'RegistrySearchResultDonorStatus',
		CASE WHEN coalesce(Registry.DonorConfirmed, 0) = 1 
			 THEN 'Y' 
				ELSE 'N' END AS 'RegistrySearchResultDonorConfirmed'

FROM	Registry
LEFT	JOIN RegistryAddr ON RegistryAddr.RegistryID = Registry.RegistryID AND (RegistryAddr.AddrTypeID = 1)	
LEFT	JOIN RegistryOwnerStateConfig AS RegistryOwnerState ON RegistryOwnerState.RegistryOwnerStateAbbrv = RegistryAddr.State

WHERE
	(@RegistryOwnerID IS NULL OR Registry.RegistryOwnerID = @RegistryOwnerID) AND
	 Registry.DeleteFlag = 0 AND
	(@DonorStatus IS NULL OR coalesce(Registry.Donor, 0) = @DonorStatus)  AND
	(@DonorConfirmed IS NULL OR Registry.DonorConfirmed = @DonorConfirmed) AND -- Yes Donors
	(@DOB IS NULL OR Registry.DOB = @DOB) AND
	(@WebRegistryID IS NULL OR Registry.RegistryID = @WebRegistryID) AND
	(@State IS NULL OR RegistryAddr.State = @State) AND		
	(@FirstName IS NULL OR PATINDEX(@FirstName + '%' collate SQL_Latin1_General_Cp1251_CI_AS, dbo.FormatNameForStatTracSearch(Registry.FirstName collate SQL_Latin1_General_Cp1251_CI_AS)) > 0) AND
	(@MiddleName IS NULL OR PATINDEX(@MiddleName + '%' collate SQL_Latin1_General_Cp1251_CI_AS, dbo.FormatNameForStatTracSearch(Registry.MiddleName collate SQL_Latin1_General_Cp1251_CI_AS)) > 0) AND
	(@LastName IS NULL OR PATINDEX(@LastName + '%' collate SQL_Latin1_General_Cp1251_CI_AS, dbo.FormatNameForStatTracSearch(Registry.LastName collate SQL_Latin1_General_Cp1251_CI_AS)) > 0) AND
	(@City IS NULL OR PATINDEX(@City + '%', RegistryAddr.City) > 0) AND
	(@Zip IS NULL OR PATINDEX(@Zip + '%', RegistryAddr.Zip) > 0) AND
	(@License IS NULL OR PATINDEX(@License + '%', RTRIM(coalesce(Registry.License, ''))) > 0)		
GO