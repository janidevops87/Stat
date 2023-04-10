IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_IMPORT_All_ImportDonorFull]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping sps_IMPORT_All_ImportDonorFull';
	DROP PROCEDURE [dbo].[sps_IMPORT_All_ImportDonorFull];
END
GO

	PRINT 'Creating sps_IMPORT_All_ImportDonorFull';
GO

CREATE  PROCEDURE sps_IMPORT_All_ImportDonorFull AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonorFull.sql
**		Name: sps_IMPORT_All_ImportDonorFull
**		Desc: This sporc is used to add New (DMVImport) to the following tables:
**			1. DMVTempTable
**			2. DMVADDRTempTable
**			3. DMVOrganTempTable 	
**
**
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
**		Auth: Moonray Schepart
**		Date: 03/06/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------	--------				--------------------------------------
**		03/06/2014  Moonray Schepart		initial conversion to Sequence based insert
**		05/28/2014	Moonray Schepart		Include Branch Number and Enrollment Date fields
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
**		11/02/2016	Serge Hurko				42185 - Fix import SPs in all DMV DBs to calculate max DMV ID the way it is in DMV CO DB.
*******************************************************************************/

IF (object_id('tempdb..#TempIDTable') IS NOT NULL)
BEGIN
	DROP TABLE #TempIDTable;
END
CREATE Table #TempIDTable
	(	[IMPORTID] [int] NOT NULL,
		[ID] [int] NOT NULL		
	);
	
DECLARE @CurrentID int;
DECLARE @alterSequenceSQL NVARCHAR(200);
DECLARE @DMVIMPORTLOGID int;
DECLARE @maxIdDmv int; 
DECLARE @maxIdDmvArchive int;

select @maxIdDmv		= COALESCE(MAX(ID),5000) FROM DMV;
select @maxIdDmvArchive	= COALESCE(MAX(ID),5000) FROM DMVArchive;

					-- modified code grab max from either dmv or dmvarchive
SELECT @CurrentID = Case	when @maxIdDmv > @maxIdDmvArchive	
					then	@maxIdDmv	
					else	@maxIdDmvArchive	
					end;

SELECT @DMVIMPORTLOGID = ID
FROM IMPORTLOG
WHERE UPPER(RunStatus) = 'LOADING';

IF EXISTS(SELECT * FROM sys.sequences WHERE name = 'CountBy1') 
BEGIN
	DROP SEQUENCE CountBy1 ;	
END	
	CREATE SEQUENCE dbo.CountBy1
		START WITH 1
		INCREMENT BY 1 ;

   SET @alterSequenceSQL = 'ALTER SEQUENCE dbo.CountBy1 RESTART WITH ' + CONVERT(varchar(30),@CurrentID + 1);
   EXECUTE sp_executesql @alterSequenceSQL;

INSERT INTO #TempIDTable
SELECT  [ID],
		NEXT VALUE FOR dbo.CountBy1 
FROM IMPORT;

SET IDENTITY_INSERT DMVTempTable ON;


INSERT DMVTempTable ([ID],
					IMPORTLOGID,
					SSN,  
					License, 
					DOB, 
					FirstName, 
					MiddleName, 
					LastName, 
					Suffix, 
					Gender, 
					Donor, 
					RenewalDate, 
					DeceasedDate,  
					CSORState, 
					CSORLicense,
					LastModified, 
					CreateDate, 
					Fullname,
					TiffDir, 
					enrollmentdate, 
					branchnumber)
SELECT			
					T.ID,
					@DMVIMPORTLOGID,
					NULL,
					LICENSE,
					CASE ISDATE(DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,DOB) END,
					LEFT(FIRST,40),
					LEFT(MIDDLE,25),
					LEFT(LAST,40),
					SUFFIX,
					GENDER,
					CASE UPPER(DONOR)
                        WHEN 'Y' THEN 1
                        ELSE 0
                      END,
					CASE ISDATE(RENEWALDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,RENEWALDATE) END,
						CASE ISDATE(DECEASEDDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,DECEASEDDATE) END,
						CSORSTATE,
					CSORLICENSE,
					ISNULL(CREATEDATE,GETDATE()),
					ISNULL(CREATEDATE,GETDATE()),
					FullName,
					1 AS 'TiffDir', 
					enrollmentdate, 
					branchnumber
					FROM IMPORT
						INNER JOIN
							#TempIDTable T
						ON T.IMPORTID = IMPORT.[ID];

SET IDENTITY_INSERT DMVTempTable OFF;

INSERT DMVADDRTempTable (
						DMVID,
						ADDRTYPEID,
						Addr1,
						Addr2,
						City,
						State,
						Zip)
SELECT					
						T.ID,
						1,
						AADDR1,
						NULL,
						ACITY,
						ASTATE,
						AZIP
FROM IMPORT
INNER JOIN
		#TempIDTable T
	ON T.IMPORTID = IMPORT.[ID] 
WHERE COALESCE(AADDR1,'') + COALESCE(ACITY,'') + COALESCE(ASTATE,'') + COALESCE(AZIP,'') <> '';


INSERT DMVADDRTempTable (
						DMVID,
						ADDRTYPEID,
						Addr1,
						Addr2,
						City,
						State,
						Zip)
SELECT	
						T.ID,
						2,
						BADDR1,
						NULL,
						BCITY,
						BSTATE,
						BZIP
FROM IMPORT
INNER JOIN
		#TempIDTable T
	ON T.IMPORTID = IMPORT.[ID] 
WHERE COALESCE(BADDR1,'') + COALESCE(BCITY,'') + COALESCE(BSTATE,'') + COALESCE(BZIP,'') <> '';

INSERT DMVORGANTempTable (
						DMVID,
						ORGANTYPEID)
SELECT	
						T.ID,
						CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END
FROM IMPORT
	INNER JOIN
		#TempIDTable T
	ON T.IMPORTID = IMPORT.[ID]
WHERE COALESCE(DONOR,'') <> '';

IF (object_id('tempdb..#TempIDTable') IS NOT NULL)
BEGIN
	DROP TABLE #TempIDTable;
END