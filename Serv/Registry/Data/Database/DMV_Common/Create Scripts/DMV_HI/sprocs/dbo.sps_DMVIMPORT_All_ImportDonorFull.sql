IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_DMVIMPORT_All_ImportDonorFull')
	BEGIN
		PRINT 'Dropping Procedure sps_DMVIMPORT_All_ImportDonorFull'
		DROP PROCEDURE sps_DMVIMPORT_All_ImportDonorFull
	END;
GO

PRINT 'Creating Procedure sps_DMVIMPORT_All_ImportDonorFull';
GO

/****** Object:  StoredProcedure [dbo].[sps_DMVIMPORT_All_ImportDonorFull]    Script Date: 11/2/2016 8:15:54 PM ******/
SET ANSI_NULLS OFF;
GO

SET QUOTED_IDENTIFIER OFF;
GO

CREATE PROCEDURE [dbo].[sps_DMVIMPORT_All_ImportDonorFull] AS
/******************************************************************************
**		File: sps_DMVIMPORT_All_ImportDonorFull.sql
**		Name: sps_DMVIMPORT_All_ImportDonorFull
**		Desc: This sp uses a Sequence to transfer records to the DMVTempTable for import.
**			The temp tables allow access to donor records while records are added.
**			The active DMV tables are then dropped and the temp tables are renamed.
**			The LastModified date is the Last Recorded Drivers License or State ID
**				Issue date. 
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
**		Date: 03/10/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		03/10/2014  Moonray Schepart			initial
**		11/30/2015	mmaitan				Updated insert/updates to handle null LICENSE values
**		11/02/2016	Serge Hurko			42185 - Fix import SPs in all DMV DBs to calculate max DMV ID the way it is in DMV CO DB.
*******************************************************************************/

IF (object_id('tempdb..#TempIDTable') IS NOT NULL)
BEGIN
	DROP TABLE #TempIDTable;
END

CREATE Table #TempIDTable
	(	LICENSE NVARCHAR(25) Null,
		[FULLNAME] [varchar](255) NULL,
		[DOB] [varchar](255) NULL,
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
FROM DMVIMPORTLOG
WHERE UPPER(RunStatus) = 'LOADING';

IF EXISTS(SELECT * FROM sys.sequences WHERE name = 'CountBy1') 
BEGIN
	DROP SEQUENCE CountBy1;	
END	

CREATE SEQUENCE dbo.CountBy1
		START WITH 1
		INCREMENT BY 1;

SET @alterSequenceSQL = 'ALTER SEQUENCE dbo.CountBy1 RESTART WITH ' + CONVERT(varchar(30),@CurrentID + 1);
EXECUTE sp_executesql @alterSequenceSQL;

INSERT INTO #TempIDTable
SELECT  CASE WHEN LEN(LICENSE) > 0
			THEN LICENSE
			ELSE CSORLICENSE
			END,
			FULLNAME,
			DOB,
		NEXT VALUE FOR dbo.CountBy1 
FROM DMVIMPORT;

SET IDENTITY_INSERT DMVTempTable ON;

INSERT DMVTempTable ([ID],
			 DMVIMPORTLOGID,
			 STATEID,
			 SSN,
			 License,
			 DOB,
			 FirstName,
			 MiddleName,
			 LastName,
			 Suffix,
			 Gender,
			 Donor,
			 CountyCode,
			 Importdate,
			 DeceasedDate,
			 CSORState,
			 CSORLicense,
			 LastModified,
			 CreateDate,
			 FullName,
			 FirstName_Display,
			 MiddleName_Display,
			 LastName_Display)
SELECT		T.ID,
			@DMVIMPORTLOGID,
			CAST(STATEID AS INT),
			NULL,
			LEFT(DMVIMPORT.LICENSE,9),
			CASE ISDATE(DMVIMPORT.DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,DMVIMPORT.DOB) END,
			LEFT(FIRST,40),
			LEFT(MIDDLE,40),
			LEFT(LAST,50),
			SUFFIX,
			GENDER,
			CASE COALESCE(UPPER(DONOR), 'Y') WHEN 'Y' THEN 1 ELSE 0 END AS 'DONOR',
			COUNTYCODE,
			CASE ISDATE(IMPORTDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,IMPORTDATE) END,
			CASE ISDATE(DECEASEDDATE)WHEN 0 THEN NULL ELSE CONVERT(datetime,DECEASEDDATE) END,
			CAST(CSORSTATE AS varchar(2)),
			CAST(CSORLICENSE AS varchar(25)),
			CASE ISDATE(CREATEDATE) WHEN 1 THEN CREATEDATE ELSE GetDate() END,
			CASE ISDATE(CREATEDATE) WHEN 1 THEN CREATEDATE ELSE GetDate() END,
			DMVIMPORT.FULLNAME,
			DMVIMPORT.FIRST_Display,
			DMVIMPORT.MIDDLE_Display,
			DMVIMPORT.LAST_Display
    FROM DMVIMPORT
		INNER JOIN
			#TempIDTable T
		ON T.LICENSE = CASE WHEN LEN(DMVIMPORT.LICENSE) > 0
							THEN DMVIMPORT.LICENSE
							ELSE DMVIMPORT.CSORLICENSE
							END 
		AND T.LICENSE IS NOT NULL;

	--Insert records into DMVTempTable from DMVImport where License is null
    INSERT DMVTempTable ([ID],
			 DMVIMPORTLOGID,
			 STATEID,
			 SSN,
			 License,
			 DOB,
			 FirstName,
			 MiddleName,
			 LastName,
			 Suffix,
			 Gender,
			 Donor,
			 CountyCode,
			 Importdate,
			 DeceasedDate,
			 CSORState,
			 CSORLicense,
			 LastModified,
			 CreateDate,
			 FullName,
			 FirstName_Display,
			 MiddleName_Display,
			 LastName_Display)
    SELECT		T.ID,
			@DMVIMPORTLOGID,
			CAST(STATEID AS INT),
			NULL,
			LEFT(DMVIMPORT.LICENSE,9),
			CASE ISDATE(DMVIMPORT.DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,DMVIMPORT.DOB) END,
			LEFT(FIRST,40),
			LEFT(MIDDLE,40),
			LEFT(LAST,50),
			SUFFIX,
			GENDER,
			CASE COALESCE(UPPER(DONOR), 'Y') WHEN 'Y' THEN 1 ELSE 0 END AS 'DONOR',
			COUNTYCODE,
			CASE ISDATE(IMPORTDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,IMPORTDATE) END,
			CASE ISDATE(DECEASEDDATE)WHEN 0 THEN NULL ELSE CONVERT(datetime,DECEASEDDATE) END,
			CAST(CSORSTATE AS varchar(2)),
			CAST(CSORLICENSE AS varchar(25)),
			CASE ISDATE(CREATEDATE) WHEN 1 THEN CREATEDATE ELSE GetDate() END,
			CASE ISDATE(CREATEDATE) WHEN 1 THEN CREATEDATE ELSE GetDate() END,
			DMVIMPORT.FULLNAME,
			DMVIMPORT.FIRST_Display,
			DMVIMPORT.MIDDLE_Display,
			DMVIMPORT.LAST_Display
    FROM DMVIMPORT
		INNER JOIN
			#TempIDTable T
			ON T.FULLNAME = DMVIMPORT.FULLNAME
			AND T.DOB = DMVIMPORT.DOB
	WHERE T.LICENSE is null;

SET IDENTITY_INSERT DMVTempTable OFF;

	INSERT DMVADDRTempTable (
			DMVID,
			ADDRTYPEID,
			Addr1,
			Addr2,
			City,
			State,
			Zip)
    SELECT	T.ID,
			1,
			AADDR1,
			NULL,
			ACITY,
			ASTATE,
			AZIP
    FROM DMVIMPORT
	INNER JOIN
			#TempIDTable T
		ON T.LICENSE = CASE WHEN LEN(DMVIMPORT.LICENSE) > 0
							THEN DMVIMPORT.LICENSE
							ELSE DMVIMPORT.CSORLICENSE
							END 
		AND T.LICENSE IS NOT NULL
	WHERE COALESCE(AADDR1,'') + COALESCE(ACITY,'') + COALESCE(ASTATE,'') + COALESCE(AZIP,'') <> '';

	--Insert records into DMVTempTable from DMVImport where License is null
	INSERT DMVADDRTempTable (
			DMVID,
			ADDRTYPEID,
			Addr1,
			Addr2,
			City,
			State,
			Zip)
    SELECT	T.ID,
			1,
			AADDR1,
			NULL,
			ACITY,
			ASTATE,
			AZIP
    FROM DMVIMPORT
	INNER JOIN
			#TempIDTable T
			ON T.FULLNAME = DMVIMPORT.FULLNAME
			AND T.DOB = DMVIMPORT.DOB
	WHERE T.LICENSE is null
	AND COALESCE(AADDR1,'') + COALESCE(ACITY,'') + COALESCE(ASTATE,'') + COALESCE(AZIP,'') <> '';


	INSERT DMVADDRTempTable (
			DMVID,
			ADDRTYPEID,
			Addr1,
			Addr2,
			City,
			State,
			Zip)
    SELECT	T.ID,
			2,
			BADDR1,
			NULL,
			BCITY,
			BSTATE,
			BZIP
    FROM DMVIMPORT
	INNER JOIN
			#TempIDTable T
		ON T.LICENSE = CASE WHEN LEN(DMVIMPORT.LICENSE) > 0
							THEN DMVIMPORT.LICENSE
							ELSE DMVIMPORT.CSORLICENSE
							END 
		AND T.LICENSE IS NOT NULL
	WHERE COALESCE(BADDR1,'') + COALESCE(BCITY,'') + COALESCE(BSTATE,'') + COALESCE(BZIP,'') <> '';

	--Insert records into DMVTempTable from DMVImport where License is null
	INSERT DMVADDRTempTable (
			DMVID,
			ADDRTYPEID,
			Addr1,
			Addr2,
			City,
			State,
			Zip)
    SELECT	T.ID,
			2,
			BADDR1,
			NULL,
			BCITY,
			BSTATE,
			BZIP
    FROM DMVIMPORT
	INNER JOIN
			#TempIDTable T
			ON T.FULLNAME = DMVIMPORT.FULLNAME
			AND T.DOB = DMVIMPORT.DOB
	WHERE T.LICENSE is null
	AND COALESCE(BADDR1,'') + COALESCE(BCITY,'') + COALESCE(BSTATE,'') + COALESCE(BZIP,'') <> '';


--DMV ORGAN TABLE IS NOT USED BY HAWAII 
 --   INSERT DMVORGAN (
	--		DMVID,
	--		ORGANTYPEID)
 --   SELECT	T.ID,
	--		CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END
 --   FROM DMVIMPORT
	--	INNER JOIN
	--		#TempIDTable T
	--	ON T.LICENSE = CASE WHEN LEN(DMVIMPORT.LICENSE) > 0
	--						THEN DMVIMPORT.LICENSE
	--						ELSE DMVIMPORT.CSORLICENSE
	--						END 
	--WHERE COALESCE(DONOR,'') <> ''

IF (object_id('tempdb..#TempIDTable') IS NOT NULL)
BEGIN
	DROP TABLE #TempIDTable;
END;
GO
