PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:3/13/2017 2:55:33 PM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST244ReferralAuditTrailBugFix\Serv\Registry\Data\Database\DMV_Common\Create Scripts\CommonRegistry\stored procedures\sps_GetRegistryData.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST244ReferralAuditTrailBugFix\Serv\Registry\Data\Database\DMV_Common\Create Scripts\CommonRegistry\stored procedures\sps_GetRegistryData.sql'
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_GetRegistryData]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping sps_GetRegistryData';
	DROP PROCEDURE [dbo].[sps_GetRegistryData];
END
GO
	PRINT 'Creating sps_GetRegistryData';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE sps_GetRegistryData (
	@DMVID	INTEGER = 0,
	@RegID	INTEGER = 0	
)

/******************************************************************************
**		File: sps_GetRegistryData.sql
**		Name: sps_GetRegistryData
**		Desc: Checks DLA donors used by registry searches.
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: Mike Berenson
**		Date: 12/5/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		12/05/2016  mberenson			initial
**		03/06/2017	mberenson			Added Source column to output
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;

	SELECT RegistryDlaResponseItemID AS RegistryID,
		ISNULL(FirstName, '') AS FirstName,
		ISNULL(MiddleName, '') AS MiddleName,
		ISNULL(LastName, '') AS LastName,
		DOB,
		ISNULL(Suffix, '') AS Suffix,
		ISNULL(Gender, '') AS Gender,
		CASE Donor 
		    	WHEN 0 Then 'N'
		    	WHEN 1 THEN 'Y'
			ELSE ''
    		END AS 'Donor',
		OnlineRegDate AS DonorFlagDate,
		ISNULL(RTRIM(LTRIM(Comment)), '') AS Restriction,
		RegistryDlaResponseItemID AS RegistryID,
		ISNULL(Addr1, '') AS ADDR1,
		ISNULL(Addr2, '') AS ADDR2,
		ISNULL(City, '') AS CITY,
		ISNULL([State], '') AS [STATE],
		ISNULL(Zip, '') AS ZIP,
		'Residential' AS AddrType,
		'' AS DonorYear,
		'DLA' AS 'Source'
	FROM dbo.RegistryDlaResponseItem
	WHERE RegistryDlaResponseItemID = @RegID;

GO



GO
