IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_DMVIMPORT_All_ImportDonor')
	BEGIN
		PRINT 'Dropping Procedure sps_DMVIMPORT_All_ImportDonor'
		DROP PROCEDURE sps_DMVIMPORT_All_ImportDonor
	END;
GO

PRINT 'Creating Procedure sps_DMVIMPORT_All_ImportDonor';
GO

/****** Object:  StoredProcedure [dbo].[sps_DMVIMPORT_All_ImportDonor]    Script Date: 11/2/2016 9:40:35 PM ******/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER OFF;
GO

CREATE PROCEDURE [dbo].[sps_DMVIMPORT_All_ImportDonor] AS
/******************************************************************************
**		File: sps_DMVIMPORT_All_ImportDonor.sql
**		Name: sps_DMVIMPORT_All_ImportDonor
**		Desc: This sporc is used to add deltas (DMVImport) to the following tables:
**			1. DMV
**			2. DMVADDR
**			3. DMVOrgan 	
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
**		Date: 10/03/2013
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------	--------				--------------------------------------
**		01/31/2014  Moonray Schepart		initial
**		11/02/2016	Serge Hurko				42185 - Fix import SPs in all DMV DBs to calculate max DMV ID the way it is in DMV CO DB.
*******************************************************************************/

IF (object_id('tempdb..#TempIDTable') IS NOT NULL)
BEGIN
	DROP TABLE #TempIDTable;
END
CREATE Table #TempIDTable
	(	LICENSE NVARCHAR(25) NOT Null,
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
SELECT  LICENSE,		
		NEXT VALUE FOR dbo.CountBy1 
FROM DMVIMPORT;

SET IDENTITY_INSERT DMV ON;

INSERT DMV ([ID],
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
			CASE ISDATE(DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,DOB) END,
			LEFT(FIRST,20),
			LEFT(MIDDLE,20),
			LEFT(LAST,25),
			SUFFIX,
			GENDER,
			CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END AS 'DONOR',
			COUNTYCODE,
			CASE ISDATE(IMPORTDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,IMPORTDATE) END,
			CASE ISDATE(DECEASEDDATE)WHEN 0 THEN NULL ELSE CONVERT(datetime,DECEASEDDATE) END,
			CAST(CSORSTATE AS varchar(2)),
			CAST(CSORLICENSE AS varchar(25)),
			CASE ISDATE(IMPORTDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,IMPORTDATE) END,
			ISNULL(CREATEDATE,GetDate()), 
			FULLNAME,
			FIRST_Display, 
			MIDDLE_Display, 
			LAST_Display
    FROM DMVIMPORT
		INNER JOIN
			#TempIDTable T
		ON T.LICENSE = DMVIMPORT.LICENSE;
						

SET IDENTITY_INSERT DMV OFF

	INSERT DMVADDR (
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
		ON T.LICENSE = DMVIMPORT.LICENSE
	WHERE COALESCE(AADDR1,'') + COALESCE(ACITY,'') + COALESCE(ASTATE,'') + COALESCE(AZIP,'') <> '';


	INSERT DMVADDR (
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
		ON T.LICENSE = DMVIMPORT.LICENSE
	WHERE COALESCE(BADDR1,'') + COALESCE(BCITY,'') + COALESCE(BSTATE,'') + COALESCE(BZIP,'') <> '';


    INSERT DMVORGAN (
			DMVID,
			ORGANTYPEID)
    SELECT	T.ID,
			CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END
    FROM DMVIMPORT
		INNER JOIN
			#TempIDTable T
		ON T.LICENSE = DMVIMPORT.LICENSE
	WHERE COALESCE(DONOR,'') <> '';

	UPDATE TX_LimitationsMap
	SET ORGANLIMITATIONS = DMV.ORGANLIMITATIONS,
		TISSUELIMITATIONS = DMV.TISSUELIMITATIONS,
		[SOURCE] = DMV.[SOURCE]
	FROM TX_LimitationsMap TX, 
		( SELECT DMV.ID	, ORGANLIMITATIONS, TISSUELIMITATIONS, [SOURCE]
			FROM DMV, DMVIMPORT_A 
			WHERE DMV.License = DMVIMPORT_A.LICENSE
		) DMV
	WHERE TX.DMVID = DMV.ID;

	INSERT INTO TX_LimitationsMap(DMVID, ORGANLIMITATIONS, TISSUELIMITATIONS, [SOURCE])
	SELECT ID, ORGANLIMITATIONS, TISSUELIMITATIONS, [SOURCE]
	FROM ( SELECT T.ID, ORGANLIMITATIONS, TISSUELIMITATIONS, [SOURCE]
			FROM DMVIMPORT_A
			INNER JOIN
				#TempIDTable T
			ON T.LICENSE = DMVIMPORT_A.LICENSE

	 ) DMVIMPORT_A
	WHERE DMVIMPORT_A.ID NOT IN (SELECT DMVID		
									FROM TX_LimitationsMap
									WHERE COALESCE(DMVID,-1) > 0
									);

IF (object_id('tempdb..#TempIDTable') IS NOT NULL)
BEGIN
	DROP TABLE #TempIDTable;
END;
GO
