 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryLabelsWeb_select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryLabelsWeb_select]
	PRINT 'Dropping Procedure: GetRegistryLabelsWeb_select'
END
	PRINT 'Creating Procedure: GetRegistryLabelsWeb_select'
GO


CREATE PROCEDURE [dbo].[GetRegistryLabelsWeb_select]
	@StartDateTime datetime = NULL,
	@EndDateTime datetime = NULL,
	@Source int = Null,
	@DonorStatus bit = Null,
	@RegistryOwnerID int = NULL
AS
/******************************************************************************
**		File: GetRegistryLabelsWeb_select.sql
**		Name: GetRegistryLabelsWeb_select
**		Desc: For release to: DMV_Common
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
**		Date: 01/18/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**		01/18/2011		ccarroll			Initial
*******************************************************************************/
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @DonorConfirmed bit = Null

IF IsNull(@Source, 0) = 1
BEGIN
/*  1 - Web Registry
	3 - Pending Registrants (Web)

	When Source is 'Web Registry' Set DonorConfirmed to DonorStatus as values work in tandom.
	If DonorStatus value is Null All records (N donors and Y donors) are returned.
*/
		IF @DonorStatus = 0
			BEGIN
			/*  0 - No donors
				1 - Yes donors

				When  looking for 'NO' donors the DonorConfirmed should be excluded from the search.
				and only the Donor flag should be evaluated 
			*/
				SET @DonorConfirmed = Null
			END
		ELSE
			BEGIN
					SET @DonorConfirmed = @DonorStatus
			END
END

IF IsNull(@Source, 0) = 3
BEGIN
/*  
	1 - Web Registry
	3 - Pending Registrants (Web)

	When Source is for 'Pending Registrants (Web)' get donors who have 
	registered and are not yet confirmed (Donorstatus = 1, DonorConfirmed = 0)
*/
	SET @DonorConfirmed = 0
	SET @DonorStatus = 1
END





SELECT DISTINCT
		IsNull(Registry.FirstName, '') AS RegistryLabelsReportFirstName,
		IsNull(Registry.MiddleName, '') AS RegistryLabelsReportMiddleName,
		IsNull(Registry.LastName, '') AS RegistryLabelsReportLastName,
		IsNull(Registry.Suffix, '') AS RegistryLabelsReportSuffix,
		IsNull(RegistryAddr.Addr1, '') AS RegistryLabelsReportAddr1,
		IsNull(RegistryAddr.Addr2, '') AS RegistryLabelsReportAddr2,
		IsNull(RegistryAddr.City, '') AS RegistryLabelsReportCity,
		IsNull(RegistryAddr.State, '') AS RegistryLabelsReportState,
		IsNull(RegistryAddr.Zip, '') AS RegistryLabelsReportZip,
		CONVERT(varchar, Registry.DOB, 101) AS RegistryLabelsReportDOB,
		CASE WHEN IsNull(Registry.Donor, 0) = 1 
			 THEN 'Y' 
				ELSE 'N' END AS RegistryLabelsReportDonor,
		CASE WHEN Registry.SignatureDate Is Null 
			 THEN CONVERT(varchar, Registry.CreateDate, 101) + ' ' + CAST(DatePart(HH, Registry.CreateDate) AS varchar) + ':'+ CAST(DatePart(MI, Registry.CreateDate) AS varchar)
				ELSE CONVERT(varchar, Registry.SignatureDate, 101)  + ' ' + CAST(DatePart(HH, Registry.SignatureDate) AS varchar) + ':'+ CAST(DatePart(MI, Registry.SignatureDate) AS varchar) END AS RegistryLabelsReportDatetime,
		IsNull(EventSubCategory.EventSubCategorySourceCode, '') AS RegistryLabelsReportSourceCode

FROM	Registry
LEFT	JOIN RegistryAddr ON RegistryAddr.RegistryID = Registry.RegistryID AND (RegistryAddr.AddrTypeID = 1)	
LEFT	JOIN EventRegistry ON EventRegistry.RegistryID = Registry.RegistryID
LEFT	JOIN EventSubCategory ON EventRegistry.EventSubCategoryID = EventSubCategory.EventSubCategoryID

WHERE
		ISNull(Registry.DeleteFlag, 0) <> 1 AND
		Registry.RegistryOwnerID = IsNull(@RegistryOwnerID, 0) AND
		Registry.OnlineRegDate BETWEEN @StartDateTime AND @EndDateTime AND
		IsNull(Registry.Donor, 0) = IsNull(@DonorStatus, IsNull(Registry.Donor, 0)) AND
		IsNull(Registry.DonorConfirmed, 0) = IsNull(@DonorConfirmed, IsNull(Registry.DonorConfirmed, 0))

GO