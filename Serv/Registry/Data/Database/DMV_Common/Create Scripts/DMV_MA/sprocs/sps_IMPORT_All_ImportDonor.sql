IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_IMPORT_All_ImportDonor]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_IMPORT_All_ImportDonor]
	PRINT 'Dropping Procedure: sps_IMPORT_All_ImportDonor'
END
	PRINT 'Creating Procedure: sps_IMPORT_All_ImportDonor'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sps_IMPORT_All_ImportDonor]
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonor.SQL
**		Name: sps_IMPORT_All_ImportDonor
**		Desc:
**
** 
**		Called by:   
**			DMV DTS Import 
**              
**
**		Auth: ccarroll	
**		Date: 06/12/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		06/12/2009	ccarroll			Initial - PreviousDonorState
**      07/31/2014	Moonray Schepart	conversion to Sequence based insert and inclusion of display name fields (CCRST196)
**		11/02/2016	Serge Hurko			42185 - Fix import SPs in all DMV DBs to calculate max DMV ID the way it is in DMV CO DB.
*******************************************************************************/
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

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

SET IDENTITY_INSERT DMV ON;

    INSERT DMV ( [ID],
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
    SELECT      T.ID,
				@DMVIMPORTLOGID, 
				NULL, 
				LICENSE, 
				CASE ISDATE(DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,DOB) END,                 
				FIRST,     
				MIDDLE,     
				LAST,     
				SUFFIX, 
				GENDER, 
				CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END, 
				CASE ISDATE(RENEWALDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,RENEWALDATE) END,                        
				CASE ISDATE(DECEASEDDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,DECEASEDDATE) END,                               
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
		ON T.IMPORTID = IMPORT.[ID];

SET IDENTITY_INSERT DMV OFF;

    INSERT DMVADDR (DMVID,      
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
	ON T.IMPORTID = IMPORT.[ID] 
	WHERE COALESCE(AADDR1,'') + COALESCE(ACITY,'') + COALESCE(ASTATE,'') + COALESCE(AZIP,'') <> '';

   
    INSERT DMVADDR (DMVID,      
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
		ON T.IMPORTID = IMPORT.[ID] 
	WHERE COALESCE(BADDR1,'') + COALESCE(BCITY,'') + COALESCE(BSTATE,'') + COALESCE(BZIP,'') <> '';  

    INSERT DMVORGAN (DMVID,
					ORGANTYPEID)
	SELECT			T.ID,
					CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END
	FROM IMPORT
		INNER JOIN
			#TempIDTable T
		ON T.IMPORTID = IMPORT.[ID]
	WHERE COALESCE(DONOR,'') <> '';
