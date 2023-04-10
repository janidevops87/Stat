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

CREATE  PROCEDURE [dbo].[sps_IMPORT_All_ImportDonor] AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonor.sql
**		Name: sps_IMPORT_All_ImportDonor
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 07/08/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		07/08/2009	ccarroll	initial
**      08/05/2016	mmaitan		Reworked sproc so it doesn't use a cursor similar to what was done for DMV_CO
**		11/02/2016	Serge Hurko	42185 - Fix import SPs in all DMV DBs to calculate max DMV ID the way it is in DMV CO DB.
*******************************************************************************/
DECLARE @CurrentID			int;
DECLARE @alterSequenceSQL	NVARCHAR(200);
DECLARE @IMPORTLOGID		int;
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
FROM IMPORTLOG
WHERE UPPER(RunStatus) = 'LOADING';

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

WHILE EXISTS (SELECT TOP(1) 1 FROM dbo.#TmpDMVIdTable T WHERE NOT EXISTS ( SELECT 1 FROM DMV where T.ID = DMV.ID ))
BEGIN
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
					 PreviousDonorState)
		SELECT TOP(@recordUpdateCount)	T.ID,
					@IMPORTLOGID,
					NULL,
					LICENSE,
					CASE ISDATE(DOB)
                    WHEN 0 THEN NULL
                    ELSE CONVERT(datetime,DOB)
                    END,
					FIRST,
					MIDDLE,
					LAST,
					SUFFIX,
					LEFT(GENDER, 1),
					CASE UPPER(DONOR)
                        WHEN 'Y' THEN 1
                        ELSE 0
                      END AS DonorTF,
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
					GetDate(),
					ISNULL(CREATEDATE,GETDATE()),
					PreviousDonorState
		 FROM IMPORT I
		 INNER JOIN	#TmpDMVIdTable T ON T.IMPORTID = I.[ID]
		 WHERE NOT EXISTS ( SELECT 1 FROM DMV where t.ID = DMV.ID );
	

		SET IDENTITY_INSERT DMV OFF;
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
													FROM DMVADDR  JOIN DMV ON DMVADDR.DMVID = DMV.ID 
													WHERE AddrTypeID = 1 AND T.ID = DMV.ID ))
	BEGIN

		INSERT DMVADDR (DMVID,      
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
		AND NOT EXISTS ( SELECT 1 FROM DMVADDR  JOIN DMV ON DMVADDR.DMVID = DMV.ID WHERE AddrTypeID = 1 AND T.ID = DMV.ID );
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
									AND NOT EXISTS ( SELECT TOP(1) 1 FROM DMVADDR JOIN DMV ON DMVADDR.DMVID = DMV.ID 
														WHERE AddrTypeID = 2 AND T.ID = DMV.ID))
	BEGIN
		INSERT DMVADDR (DMVID,      
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
		AND NOT EXISTS ( SELECT 1 FROM DMVADDR JOIN DMV ON DMVADDR.DMVID = DMV.ID 
							WHERE AddrTypeID = 2 AND T.ID = DMV.ID);
	END

	DROP TABLE #TmpDMVIdTable;

	GO
