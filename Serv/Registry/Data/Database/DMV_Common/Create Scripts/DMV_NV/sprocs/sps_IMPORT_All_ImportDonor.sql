 if exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_IMPORT_All_ImportDonor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_IMPORT_All_ImportDonor'
	drop procedure [dbo].[sps_IMPORT_All_ImportDonor]
END
	PRINT 'Creating Procedure: sps_IMPORT_All_ImportDonor'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[sps_IMPORT_All_ImportDonor] AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonor.sql
**		Name: sps_IMPORT_All_ImportDonor
**		Desc: Loads data into temp table FROM the Import table using T-Cursor
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		NA
**
**		Auth: unknown						01/2003
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**     08/26/2010	ccarroll			Added Lastmodified Date for reporting (HS: 24904)
**	   10/01/2013	Moonray Schepart	Changed lastmodified date to default to the last day 
**										of the last month instead of the current date.
**	   03/03/2014	Moonray Schepart	Modified lastmodified date to calulcate last day at midnight
**	   08/07/2014	Moonray Schepart	Inclusion of Display Name fields (CCRST196)
**     08/10/2016	Michael Maitan		Reworked sproc so it doesn't use a cursor similar to what was done for DMV_CO
**	   11/02/2016	Serge Hurko			42185 - Fix import SPs in all DMV DBs to calculate max DMV ID the way it is in DMV CO DB.
*******************************************************************************/
DECLARE @ID       int; 
DECLARE @IDENTITY int;
DECLARE @IMPORTLOGID int;
DECLARE @CurrentID			int;
DECLARE @alterSequenceSQL	NVARCHAR(200);
DECLARE @maxIdDmv			int; 
DECLARE @maxIdDmvArchive	int;
DECLARE @recordUpdateCount	int;
DECLARE @LastDayOfLastMonth	datetime;

select @recordUpdateCount = 25000; --25000

SET @LastDayOfLastMonth = CONVERT(datetime, SUBSTRING(CONVERT(nvarchar(20), Dateadd(d, -DATEPART(d, getdate()), GETDATE())),1,11));

select @maxIdDmv		= COALESCE(MAX(ID),5000) FROM DMV;
select @maxIdDmvArchive	= COALESCE(MAX(ID),5000) FROM DMVArchive;

					-- modified code grab max from either dmv or dmvarchive
SELECT @CurrentID = Case	when @maxIdDmv > @maxIdDmvArchive	
					then	@maxIdDmv	
					else	@maxIdDmvArchive	
					end;

SELECT @IMPORTLOGID = ID
	FROM ImportLog
	WHERE Upper(RunStatus) = 'LOADING';

IF OBJECT_ID('tempdb..#TmpDMVIdTable') IS NOT NULL
BEGIN
	DROP TABLE #TmpDMVIdTable;
END

CREATE TABLE #TmpDMVIdTable
(
	[IMPORTID] [int] NOT NULL,
	[ID] [int] NOT NULL
);

if not exists (select top(1) 1 from #TmpDMVIdTable)
begin
	IF EXISTS(SELECT * FROM sys.sequences WHERE name = 'CountBy1') 
	BEGIN
		DROP SEQUENCE CountBy1 ;	
	END	
		CREATE SEQUENCE dbo.CountBy1
			START WITH 1
			INCREMENT BY 1 ;

	   SET @alterSequenceSQL = 'ALTER SEQUENCE dbo.CountBy1 RESTART WITH ' + CONVERT(varchar(30),@CurrentID + 1);
	   EXECUTE sp_executesql @alterSequenceSQL;

	INSERT INTO #TmpDMVIdTable
	SELECT [ID],
			NEXT VALUE FOR dbo.CountBy1 
	FROM IMPORT;

	DROP SEQUENCE CountBy1;
end

-----------------------------------------------------------------------------------------------------------------------
WHILE EXISTS (SELECT TOP(1) 1 FROM dbo.#TmpDMVIdTable T WHERE NOT EXISTS ( SELECT 1 FROM DMVTempTable where T.ID = DMVTempTable.ID ))
BEGIN
		SET IDENTITY_INSERT DMVTempTable ON;
		INSERT DMVTempTable ( T.[ID],
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
					 FirstName_Display,
					 MiddleName_Display,
					 LastName_Display)
		SELECT TOP(@recordUpdateCount)	T.ID,
				   @IMPORTLOGID,
				   NULL,
				   RTRIM(LICENSE),
				   CASE ISDATE(DOB)
				   WHEN 0 THEN NULL
				   ELSE CONVERT(datetime,DOB)
				   END,
				   LEFT(FIRST,20),
				   LEFT(MIDDLE,20),
				   LEFT(LAST,25),
				   SUFFIX,
				   GENDER,
				   CASE upper(DONOR)
						WHEN 'Y' THEN 1
						ELSE 0
                   END,
				   CASE ISDATE(RENEWALDATE)
						WHEN 0 THEN NULL
						ELSE CONVERT(datetime,RENEWALDATE)
				   END,
				   CASE ISDATE(DECEASEDDATE)
						WHEN 0 THEN NULL
						ELSE CONVERT(datetime,DECEASEDDATE)
				   END,
				   CSORSTATE,
				   CSORLICENSE,
				   @LastDayOfLastMonth,
				   ISNULL(CREATEDATE,GETDATE()),
				   First_Display,
				   Middle_Display,
				   Last_Display
		 FROM IMPORT I
		 INNER JOIN	#TmpDMVIdTable T ON T.IMPORTID = I.[ID]
		 WHERE NOT EXISTS ( SELECT 1 FROM DMVTempTable where t.ID = DMVTempTable.ID );
	

		SET IDENTITY_INSERT DMVTempTable OFF;
	END

	WHILE EXISTS (SELECT TOP(1) 1 FROM IMPORT 
								INNER JOIN
									#TmpDMVIdTable T
								ON T.IMPORTID = IMPORT.[ID] 
								WHERE	(AADDR1 is not null 
								and		ACITY is not null 
								and		 ASTATE is not null  
								and		AZIP is not null )
								and		(AADDR1 <> '' 
								and		 ACITY <> '' 
								and		ASTATE <> '' 
								and		AZIP <> '0' )							
								AND  NOT EXISTS ( SELECT TOP(1) 1	
													FROM DMVADDRTempTable  JOIN DMVTempTable ON DMVADDRTempTable.DMVID = DMVTempTable.ID 
													WHERE AddrTypeID = 1 AND T.ID = DMVTempTable.ID ))

	BEGIN

		INSERT DMVADDRTempTable (DMVID,      
						ADDRTYPEID, 
						Addr1,  
						Addr2, 
						City,  
						State,  
						Zip)    
		SELECT top(@recordUpdateCount) T.ID,  
						1,          
						AADDR1, 
						NULL,  
						ACITY, 
						ASTATE, 
						AZIP
		FROM IMPORT
		INNER JOIN
			#TmpDMVIdTable T
		ON T.IMPORTID = IMPORT.[ID] 
		WHERE (AADDR1 is not null 
		and		ACITY is not null 
		and		ASTATE is not null  
		and		AZIP is not null )
		and		(AADDR1 <> '' 
		and		ACITY <> '' 
		and		ASTATE <> '' 
		and		AZIP <> '0' )							
		AND NOT EXISTS ( SELECT 1 FROM DMVADDRTempTable  JOIN DMVTempTable ON DMVADDRTempTable.DMVID = DMVTempTable.ID WHERE AddrTypeID = 1 AND T.ID = DMVTempTable.ID );
	END

	WHILE EXISTS (SELECT TOP(1) 1 FROM IMPORT
									INNER JOIN
											#TmpDMVIdTable T
										ON T.IMPORTID = IMPORT.[ID] 
									WHERE	(BADDR1 is not null 
									and		BCITY is not null 
									and		BSTATE is not null  
									and		BZIP is not null 
									and		BADDR1 <> '' 
									and		BCITY <> '' 
									and		BSTATE <> '' 
									and		BZIP <> '0' )
									AND NOT EXISTS ( SELECT TOP(1) 1 FROM DMVADDRTempTable JOIN DMVTempTable ON DMVADDRTempTable.DMVID = DMVTempTable.ID 
														WHERE AddrTypeID = 2 AND T.ID = DMVTempTable.ID))
	BEGIN
		INSERT DMVADDRTempTable (DMVID,      
						ADDRTYPEID, 
						Addr1,  
						Addr2, 
						City,  
						State,  
						Zip)
		SELECT top(@recordUpdateCount) T.[ID],  
						2,          
						BADDR1, 
						NULL,  
						BCITY, 
						BSTATE, 
						BZIP
		FROM IMPORT
		INNER JOIN
				#TmpDMVIdTable T
			ON T.IMPORTID = IMPORT.[ID] 
		WHERE	(BADDR1 is not null 
		and		BCITY is not null 
		and		BSTATE is not null  
		and		BZIP is not null 
		and		BADDR1 <> '' 
		and		BCITY <> '' 
		and		BSTATE <> '' 
		and		BZIP <> '0' )
		AND NOT EXISTS ( SELECT 1 FROM DMVADDRTempTable JOIN DMVTempTable ON DMVADDRTempTable.DMVID = DMVTempTable.ID 
							WHERE AddrTypeID = 2 AND T.ID = DMVTempTable.ID);
	END

GO
	--Redundant:
	--IF isnull(@Donor,'') <> ''
	--BEGIN
	--	INSERT DMVORGAN (DMVID, ORGANTYPEID)
	--	SELECT           @IDENTITY, case ltrim(rtrim(DONOR))
	--				  when 'Y' then 1                   
	--		   else 0
	--								end
	--	FROM IMPORT
	--	WHERE IMPORT.ID = @ID;   
	--END


