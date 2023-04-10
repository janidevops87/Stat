IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_IMPORT_All_ImportDonorFull]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_IMPORT_All_ImportDonorFull]
	PRINT 'Dropping Procedure: sps_IMPORT_All_ImportDonorFull'
END
	PRINT 'Creating Procedure: sps_IMPORT_All_ImportDonorFull'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[sps_IMPORT_All_ImportDonorFull] AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonorFull.sql
**		Name: sps_IMPORT_All_ImportDonorFull
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 06/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		06/02/2009	ccarroll			initial
**		08/06/2014	Moonray Schepart	conversion to Sequence based insert and inclusion of display name fields (CCRST196)
**		11/02/2016	Serge Hurko			42185 - Fix import SPs in all DMV DBs to calculate max DMV ID the way it is in DMV CO DB.
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
SELECT  CASE WHEN LEN(LICENSE) > 0
			THEN LICENSE
			ELSE CSORLICENSE
			END,
		NEXT VALUE FOR dbo.CountBy1 
FROM IMPORT

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
					 PreviousDonorState,
					 FirstName_Display, 
					 MiddleName_Display, 
					 LastName_Display)
SELECT				T.ID,
					@DMVIMPORTLOGID, 
					NULL, 
					LEFT(IMPORT.LICENSE,10), 
					CASE ISDATE(LEFT(DOB,10)) WHEN 0 THEN NULL ELSE CONVERT(datetime, LEFT(DOB,10)) END,        
					LEFT(FIRST,20), 
					LEFT(MIDDLE,20), 
					LEFT(LAST,25),  
					LEFT(SUFFIX,4), 
					LEFT(GENDER,1), 
					CASE COALESCE(UPPER(DONOR), 'Y') WHEN 'Y' THEN 1 ELSE 0 END AS 'DONOR', 
					CASE ISDATE(LEFT(RENEWALDATE,10)) WHEN 0 THEN NULL ELSE CONVERT(datetime, LEFT(RENEWALDATE,10)) END,                         
					CASE ISDATE(LEFT(DECEASEDDATE,10)) WHEN 0 THEN NULL ELSE CONVERT(datetime, LEFT(DECEASEDDATE,10)) END,                               
					CSORSTATE, 
					CSORLICENSE, 
					GetDate(), 
					ISNULL(CREATEDATE,GETDATE()), 
					PreviousDonorState,
					FIRST_Display, 
					MIDDLE_Display, 
					LAST_Display
			FROM IMPORT
				INNER JOIN
					#TempIDTable T
				ON T.LICENSE = CASE WHEN LEN(IMPORT.LICENSE) > 0
									THEN IMPORT.LICENSE
									ELSE IMPORT.CSORLICENSE
									END 

SET IDENTITY_INSERT DMVTempTable OFF
    
	INSERT DMVADDRTempTable (DMVID,      
					ADDRTYPEID, 
					Addr1,  
					Addr2, 
					City,  
					State,  
					Zip)    
	SELECT          T.ID,  
					1,          
					AADDR1, 
					NULL,  
					ACITY, 
					ASTATE, 
					AZIP
    FROM IMPORT
    INNER JOIN
		#TempIDTable T
	ON T.LICENSE = CASE WHEN LEN(IMPORT.LICENSE) > 0
									THEN IMPORT.LICENSE
									ELSE IMPORT.CSORLICENSE
									END 
	WHERE COALESCE(AADDR1,'') + COALESCE(ACITY,'') + COALESCE(ASTATE,'') + COALESCE(AZIP,'') <> '';

   
    INSERT DMVADDRTempTable (DMVID,      
					ADDRTYPEID, 
					Addr1,  
					Addr2, 
					City,  
					State,  
					Zip)
    SELECT          T.[ID],  
					2,          
					BADDR1, 
					NULL,  
					BCITY, 
					BSTATE, 
					BZIP
    FROM IMPORT
    INNER JOIN
			#TempIDTable T
		ON T.LICENSE = CASE WHEN LEN(IMPORT.LICENSE) > 0
									THEN IMPORT.LICENSE
									ELSE IMPORT.CSORLICENSE
									END 
	WHERE COALESCE(BADDR1,'') + COALESCE(BCITY,'') + COALESCE(BSTATE,'') + COALESCE(BZIP,'') <> '';  
