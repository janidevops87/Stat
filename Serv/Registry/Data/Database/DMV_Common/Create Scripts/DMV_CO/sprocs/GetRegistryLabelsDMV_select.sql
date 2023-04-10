  if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetRegistryLabelsDMV_select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: GetRegistryLabelsDMV_select'
	drop procedure [dbo].[GetRegistryLabelsDMV_select]
END
GO

PRINT 'Creating Procedure: GetRegistryLabelsDMV_select'
GO

CREATE PROCEDURE GetRegistryLabelsDMV_select
	@StartDatetime datetime = Null,
	@EndDatetime datetime = Null,
	@Source				int = NULL,
	@DonorStatus		int = NULL
AS
/******************************************************************************
**		File: GetRegistryLabelsDMV_select.sql
**		Name: GetRegistryLabelsDMV_select
**		Desc: For release to ALL DMVs Execpt DMV_NE
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: ccarroll
**		Date: 03/09/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      03/09/2011		ccarroll				initial
*******************************************************************************/
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


SELECT 
		IsNull(DMV.FirstName, '') AS RegistryLabelsReportFirstName,
		IsNull(DMV.MiddleName, '') AS RegistryLabelsReportMiddleName,
		IsNull(DMV.LastName, '') AS RegistryLabelsReportLastName,
		IsNull(DMV.Suffix, '') AS RegistryLabelsReportSuffix,
		IsNull(DMVAddr.Addr1, '') AS RegistryLabelsReportAddr1,
		IsNull(DMVAddr.Addr2, '') AS RegistryLabelsReportAddr2,
		IsNull(DMVAddr.City, '') AS RegistryLabelsReportCity,
		IsNull(DMVAddr.State, '') AS RegistryLabelsReportState,
		IsNull(DMVAddr.Zip, '') AS RegistryLabelsReportZip,
		CONVERT(varchar, DMV.DOB, 101) AS RegistryLabelsReportDOB,
		CASE WHEN IsNull(DMV.Donor, 0) = 1 
			 THEN 'Y' 
				ELSE 'N' END AS RegistryLabelsReportDonor,
		CASE WHEN DMV.RenewalDate Is Null 
			 THEN CONVERT(varchar, DMV.CreateDate, 101) + ' ' + CAST(DatePart(HH, DMV.CreateDate) AS varchar) + ':'+ CAST(DatePart(MI, DMV.CreateDate) AS varchar)
				ELSE CONVERT(varchar, DMV.RenewalDate, 101)  + ' ' + CAST(DatePart(HH, DMV.RenewalDate) AS varchar) + ':'+ CAST(DatePart(MI, DMV.RenewalDate) AS varchar) END AS RegistryLabelsReportDatetime,
		'' AS RegistryLabelsReportSourceCode
FROM DMV 
LEFT JOIN DMVAddr ON DMVAddr.DMVID = DMV.ID AND DMVAddr.AddrTypeID = 1
WHERE
		DMV.CreateDate BETWEEN @StartDateTime AND @EndDateTime AND
		IsNull(DMV.Donor, 0) = IsNull(@DonorStatus, IsNull(DMV.Donor, 0))


GO