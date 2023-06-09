/****** Object:  StoredProcedure [dbo].[spi_Import_Adds_Full]    Script Date: 10/27/2016 6:56:37 PM ******/
SET ANSI_NULLS OFF;
GO
SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id (N'[dbo].[spi_Import_Adds_Full]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spi_Import_Adds_Full];
	PRINT 'Dropping Procedure: spi_Import_Adds_Full';
END
PRINT 'Creating Procedure: spi_Import_Adds_Full';
GO

CREATE PROCEDURE [dbo].[spi_Import_Adds_Full] AS
/******************************************************************************
**		File: spi_Import_Adds_Full.sql
**		Name: spi_Import_Adds_Full
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**  		----------						-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 10/14/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**     	10/14/2008		ccarroll			Changed import to temp tables
**		08/04/2016		mmaitan				Reworked sproc so it doesn't use a cursor 
**											similar to what was done for DMV_CO
**		11/28/2016		Serge Hurko			41505 - Update the database field size limits for an import file RIDONORFILE.gz
**		11/02/2016		Serge Hurko			42185 - Fix import SPs in all DMV DBs to calculate max DMV ID the way it is in DMV CO DB.
*******************************************************************************/
DECLARE @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)

DECLARE @IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit,
        @matchCount Integer
DECLARE @CurrentID			int;
DECLARE @alterSequenceSQL	NVARCHAR(200);
DECLARE @maxIdDmv			int; 
DECLARE @maxIdDmvArchive	int;
DECLARE @recordUpdateCount	int;

select @recordUpdateCount = 25000; --25000

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

-----------------------------------------------------------------------------------------------------------------------


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
	FROM Import_Adds;

	DROP SEQUENCE CountBy1;
end

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
					 SignupDate,
					 RenewalDate,
					 DeceasedDate,
					 CSORState,
					 CSORLicense,
					 CreateDate,
					 IssueDate,
					 LastModified)
		SELECT TOP(@recordUpdateCount)	T.ID,
					@IMPORTLOGID, NULL, LICENSE, 
				CASE ISDATE(DOB)
					WHEN 0 THEN NULL
             		ELSE CONVERT(datetime,DOB)
             		END,                 
				FIRST,  MIDDLE,  LAST, SUFFIX, GENDER, 1,   -- Force donor status YES
				CASE ISDATE(SIGNUPDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,SIGNUPDATE)
					END,                         
				CASE ISDATE(RENEWALDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,RENEWALDATE)
					END,                         
				CASE ISDATE(DECEASEDDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,DECEASEDDATE)
					END,                               
				CSORSTATE, CSORLICENSE, ISNULL(CREATEDATE,GETDATE()),
				CASE ISDATE(IssueDate)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime, IssueDate)
					END,
				GetDate()
		 FROM Import_Adds I
		 INNER JOIN	#TmpDMVIdTable T ON T.IMPORTID = I.[ID]
		 WHERE NOT EXISTS ( SELECT 1 FROM DMVTempTable where t.ID = DMVTempTable.ID );
	

		SET IDENTITY_INSERT DMVTempTable OFF;
	END

	WHILE EXISTS (SELECT TOP(1) 1 FROM Import_Adds 
								INNER JOIN
									#TmpDMVIdTable T
								ON T.IMPORTID = Import_Adds.[ID] 
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
		FROM Import_Adds
		INNER JOIN
			#TmpDMVIdTable T
		ON T.IMPORTID = Import_Adds.[ID] 
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

	WHILE EXISTS (SELECT TOP(1) 1 FROM Import_Adds
									INNER JOIN
											#TmpDMVIdTable T
										ON T.IMPORTID = Import_Adds.[ID] 
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
		FROM Import_Adds
		INNER JOIN
				#TmpDMVIdTable T
			ON T.IMPORTID = Import_Adds.[ID] 
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
