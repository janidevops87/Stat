 SET NOCOUNT ON
DECLARE
	@StartDateTime		datetime,
	@EndDateTime		datetime,
	@ReportGroupID		int, 
	@OrganizationID		int,
	@SourceCodeName		varchar (10),
	@ApproachPersonID	int,
	@SourceCodeLoopCount 	int,
	@SourceCodeLoopMax	int,
	@MonthLoop		datetime,
	@MonthMax		datetime,
	@MonthStart 		datetime

SELECT
	@StartDateTime		= '1/1/06' ,
	@EndDateTime		= '1/31/06 23:59',
	@ReportGroupID		= 37 , 
	@OrganizationID		= NULL	 ,
	@SourceCodeName		= NULL,
	@ApproachPersonID	= NULL,
	@MonthStart		= '1/1/06',
	@MonthMax		= '7/1/07'

DECLARE
	@Numbers Table
	(
		MonthID       INT,
		YearID	      INT,
		SourceCodeName VARCHAR(50),
		TotalReferrals INT,
		TotalSecondarys INT,
		Approached  	INT,
		Consented   	INT,
		Recovered   	INT,
		NotRecovered 	INT,
		UnknownRecovery INT

	)
DECLARE
	@SourceCodeList TABLE
	(
		ID INT IDENTITY(1,1),
		SourceCodeName  VARCHAR(50)
	)
INSERT @SourceCodeList
SELECT DISTINCT
	SourceCodeName
FROM 	
	Call c
JOIN 
	SourceCode sc ON sc.SourceCodeID = c.SourceCodeID
JOIN	
	FSCASE fsc ON fsc.CallID = c.CallID
WHERE
	CallDateTime between '1/1/06' and '8/1/06'
AND	
	SourceCodeName IN ('NORS', 'CAOL', 'MN', 'HIOP', 'CTLC', 'NYRC', 'NYSC')


-- SELECT * FROM @SourceCodeList
IF EXISTS (SELECT * FROM tempdb..SYSOBJECTS WHERE NAME LIKE '#FS%')
BEGIN
	DROP TABLE #FSConversionRateAll
END
CREATE TABLE #FSConversionRateAll
	(
		ID          INT,
		FormatCode  INT,
		Category        VARCHAR(50),     
		TotalReferrals INT,
		Approached  INT,
		Consented   INT,
		Recovered   INT,
		NotRecovered INT,
		UnknownRecovery INT

	)
SELECT @SourceCodeLoopMax = MAX(ID), 
       @SourceCodeLoopCount = 1
FROM 
	@SourceCodeList
WHILE @SourceCodeLoopCount <= @SourceCodeLoopMax
BEGIN
	SELECT @MonthLoop = @MonthStart
	WHILE @MonthLoop <= @MonthMax
	BEGIN

		
	
		SELECT @StartDateTime = @MonthLoop
		SELECT @EndDateTime   = DATEADD(n, -1, DATEADD(M, 1, @StartDateTime))
		SELECT @SourceCodeName = SourceCodeName FROM @SourceCodeList WHERE ID = @SourceCodeLoopCount
		PRINT @SourceCodeName
		PRINT @StartDateTime
		PRINT @EndDateTime
		INSERT #FSConversionRateAll
		EXEC sps_rpt_FSConversionRateAll
	
		@StartDateTime		,
		@EndDateTime		,
		@ReportGroupID		, 
		@OrganizationID		,
		@SourceCodeName		,
		@ApproachPersonID	
	
		INSERT @Numbers			
		SELECT 
			DATEPART(M, @StartDateTime), 
			DATEPART(YYYY, @StartDateTime),
			@SourceCodeName,
			(SELECT COUNT(*) FROM CALL WHERE CallDateTime BETWEEN @StartDateTime AND @EndDateTime AND CallTypeID = 1 AND CallActive <> 0 AND SourceCodeID IN (SELECT SourceCodeID FROM SourceCode WHERE SourceCodename = @SourceCodeName)),
			TotalReferrals ,
			Approached  	,
			Consented   	,
			Recovered   	,
			NotRecovered 	,
			UnknownRecovery
		FROM 
			#FSConversionRateAll 
		WHERE 
			Category = 'Total Referrals'
		TRUNCATE TABLE 
			#FSConversionRateAll
		SELECT 
			@MonthLoop = DATEADD(M, 1, @MonthLoop)
		
		
	END	

	SELECT @SourceCodeLoopCount = @SourceCodeLoopCount + 1
END

SELECT * FROM @Numbers 
ORDER BY 
	YearID,
	MonthID,
	SourceCodeName