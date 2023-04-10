IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_Import_All_ImportDonor')
	BEGIN
		PRINT 'Dropping Procedure sps_Import_All_ImportDonor'
		DROP  Procedure  sps_Import_All_ImportDonor
	END

GO

PRINT 'Creating Procedure sps_Import_All_ImportDonor'
GO


CREATE PROCEDURE sps_IMPORT_All_ImportDonor AS
/******************************************************************************
**		File: 
**		Name: sps_Import_All_ImportDonor
**		Desc: This sproc will import the donors into the dmv tables
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**		-----------						--------
**
**
**		Auth: unknown
**		Date: unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		09/05/2007  Thien Ta 			Added code for PreviousDonorStatus	 
**      07/31/2014	Moonray Schepart	conversion to Sequence based insert and inclusion of display name fields (CCRST196)
**		2/19/2015	Bret Knoll			modified code grab max from either dmv or dmvarchive
**		07/10/2015	Seth Buxton			reduced TOP() to 1000
**		07/14/2015	Seth Buxton			increase TOP() to 25000
*******************************************************************************/

DECLARE @CurrentID			int;
DECLARE @alterSequenceSQL	NVARCHAR(200);
DECLARE @IMPORTLOGID		int;
DECLARE @maxIdDmv			int; 
DECLARE @maxIdDmvArchive	int;

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

-- if dbo.DMVIdTable table has records, assume restart if records exist
if not exists (select top(1) 1 from dbo.DMVIdTable)
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

	INSERT INTO dbo.DMVIdTable
	SELECT [ID],
			NEXT VALUE FOR dbo.CountBy1 
	FROM IMPORT;
end
	WHILE EXISTS (SELECT TOP(1) 1 FROM dbo.DMVIdTable T WHERE NOT EXISTS ( SELECT 1 FROM DMV where T.ID = DMV.ID ))	
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
					 CreateDate,
					 PreviousDonorState,
					 FirstName_Display, 
					 MiddleName_Display, 
					 LastName_Display)
		SELECT TOP(25000) T.ID,
					@IMPORTLOGID, 
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
					ISNULL(CREATEDATE,GETDATE()),
					PreviousDonorState,
					FIRST_Display, 
					MIDDLE_Display, 
					LAST_Display
		 FROM		IMPORT 
		 INNER JOIN	dbo.DMVIdTable T ON T.IMPORTID = IMPORT.[ID]
		 WHERE NOT EXISTS ( SELECT 1 FROM DMV where t.ID = DMV.ID );	 		 

		SET IDENTITY_INSERT DMV OFF;
	END
	
	WHILE EXISTS (SELECT TOP(1) 1 FROM IMPORT 
								INNER JOIN
									dbo.DMVIdTable T
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
		SELECT top(25000) T.ID,  
						1,          
						AADDR1, 
						NULL,  
						ACITY, 
						ASTATE, 
						AZIP
		FROM IMPORT
		INNER JOIN
			dbo.DMVIdTable T
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
											dbo.DMVIdTable T
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
		SELECT top(25000) T.[ID],  
						2,          
						BADDR1, 
						NULL,  
						BCITY, 
						BSTATE, 
						BZIP
		FROM IMPORT
		INNER JOIN
				dbo.DMVIdTable T
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

	WHILE EXISTS (SELECT TOP(1) 1 FROM IMPORT
								INNER JOIN dbo.DMVIdTable T ON T.IMPORTID = IMPORT.[ID]
								WHERE	DONOR IS NOT NULL 
								AND		DONOR <> ''
								AND	NOT EXISTS ( SELECT top(1) 1 FROM DMVORGAN JOIN DMV ON DMVORGAN.DMVID = DMV.ID WHERE T.ID = DMV.ID ))
	BEGIN
		INSERT DMVORGAN (	DMVID, ORGANTYPEID)
		SELECT TOP(25000)	T.ID,
							CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END
		FROM IMPORT
		INNER JOIN dbo.DMVIdTable T ON T.IMPORTID = IMPORT.[ID]
		WHERE	DONOR IS NOT NULL 
		AND		DONOR <> ''
		AND	NOT EXISTS ( SELECT 1 FROM DMVORGAN JOIN DMV ON DMVORGAN.DMVID = DMV.ID WHERE T.ID = DMV.ID );

	END

--- the import is done clear dbo.DMVIdTable 
truncate table dbo.DMVIdTable;

GO

GRANT EXEC ON sps_Import_All_ImportDonor TO PUBLIC

GO
