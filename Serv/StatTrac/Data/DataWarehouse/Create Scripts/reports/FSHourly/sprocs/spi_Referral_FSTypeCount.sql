if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_FSHourlyCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_FSHourlyCount]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE spi_Referral_FSHourlyCount 
	@MonthID INT,
	@YearID  INT
	
AS

SET NOCOUNT ON

-- Create a variable table of hours in a day
DECLARE @LoopCount	INT,
	@LoopCount2	INT, 
	@MaxDay		INT,
	@DayID		INT,
	@sql1		VARCHAR(8000),
	@sql2		VARCHAR(8000),
	@sql3		VARCHAR(8000)
	
	
--- check for temp table and delete	
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id('tempdb..#_Temp_FSReferral_HourlyCount'))  DROP TABLE #_Temp_FSReferral_HourlyCount
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id('tempdb..#_Temp_FSReferral_TypeSelect')) DROP TABLE #_Temp_FSReferral_TypeSelect


-- fill #_Temp_FSReferral_TypeCount with shell data (YearID, MonthID, DayID, HourID, SourceCodeID, StatEmployeeID)
-- build template for a givenmonth containing YearID, MonthID, HourID
-- for each SourceCode and EmployeeID insert the template
--************************************************************************************************************
-- 
--	START OF SECTION TO FILL #_Temp_FSReferral_HourlyCount WITH SHELL DATA
--	
--************************************************************************************************************
-- Set Max days in a month
	SELECT @MaxDay = DATEPART(d , DATEADD(	d , -1 , ( DATEADD(  m , 1 , ( CONVERT( VARCHAR , @MonthID ) + '/1/' + CONVERT( VARCHAR , @YearID ) ) ) ) ) )


	DECLARE @HourTable TABLE
		(
			HourID INT
		)

	-- Create a variable table with YearID, MonthID, DayID, HourID. Fill the table with Year, month day and all hours for each month in a day.
	DECLARE @MonthTemplate TABLE
		(
			YearID	INT,
			MonthID	INT,
			DayID	INT,
			HourID  INT
		)

	-- create a variable table of Source Codes for a month include a ID in the table to loop with
	DECLARE @SourceCodes TABLE
		(
			ID		INT IDENTITY(1,1),
			SourceCodeID 	INT
		)

	-- create a variable table of all employees for a month include an ID in the table to loop with
	DECLARE @Employees TABLE
		(
			ID		INT IDENTITY(1,1),
			EmployeeID 	INT
		)

	CREATE TABLE #_Temp_FSReferral_HourlyCount 
		(
			[YearID] [int] NOT NULL ,
			[MonthID] [int] NOT NULL ,
			[DayID] [int] NOT NULL ,
			[HourID] [int] NOT NULL ,
			[SourceCodeID] [int] NOT NULL ,
			[StatEmployeeID] [int] NOT NULL ,
			[SecondaryScreeningCount] [int] NULL ,
			[FamilyApproachCount] [int] NULL ,
			[TotalApproachesCount] [int] NULL ,
			[FamilyUnavailableCount] [int] NULL ,
			[ConsentCount] [int] NULL ,
			[MedSocCount] [int] NULL 
		)

	-- fill the hour table
		-- set loop to 0 for hours 0 to 23
		SELECT @LoopCount = 0

		WHILE @LoopCount < 24
		BEGIN
			INSERT @HourTable
			VALUES(@LoopCount)

			SELECT @LoopCount = @LoopCount + 1
		END

	-- fill the month template table
		-- Set first day to 1
		Select @DayID = 1

	
		WHILE @DayID <= @MaxDay
		BEGIN
			INSERT @MonthTemplate
			SELECT @YearID, @MonthID, @DayID,  HourID FROM @HourTable

			SELECT @DayID = @DayID + 1
		END


	-- fill the source codes table
		INSERT @SourceCodes (SourceCodeID)
		SELECT DISTINCT c.SourceCodeID
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 
		ORDER BY c.SourceCodeID


	-- fill the employees table use a union to obtain a distinct list of all fields 
	-- used with statemployeid
		INSERT @Employees (EmployeeID)

		SELECT DISTINCT FSCaseBillSecondaryUserID
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 
		AND ISNULL(FSCaseBillSecondaryUserID , 0) > 0 

		UNION

		SELECT DISTINCT FSCaseBillApproachUserID
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 
		AND ISNULL(FSCaseBillApproachUserID , 0) > 0

		UNION

		SELECT DISTINCT FSCaseBillMedSocUserID
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 
		AND ISNULL(FSCaseBillMedSocUserID , 0) > 0

		UNION

		SELECT DISTINCT s.SecondaryApproachedBy
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		LEFT JOIN _ReferralProdReport.dbo.SecondaryApproach s ON s.CallID = c.CallID
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 
		AND ISNULL(s.SecondaryApproachedBy , 0) > 0

		UNION

		SELECT DISTINCT s.SecondaryConsentBy 
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		LEFT JOIN _ReferralProdReport.dbo.SecondaryApproach s ON s.CallID = c.CallID
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 
		AND ISNULL(s.SecondaryConsentBy , 0) > 0
		ORDER BY 1

		 -- SELECT * FROM @MonthTemplate
		 -- SELECT * FROM @Employees
		 -- SELECT * FROM @SourceCodes

	-- LOOP THROURH SOURCECODES AND THEN THROUGH EMPLOYEES 
	SELECT @LoopCount = 1
	SELECT @LoopCount2 = 1

	WHILE @LoopCount <= ( SELECT MAX(ID) FROM @SourceCodes )
	BEGIN

		WHILE @LoopCount2 <= ( SELECT MAX(ID) FROM @Employees )
		BEGIN
			INSERT #_Temp_FSReferral_HourlyCount
			(YearID , MonthID , DayID , HourID , SourceCodeID , StatEmployeeID)
			SELECT 
				YearID , 
				MonthID , 
				DayID , 
				HourID ,
				( SELECT SourceCodeID FROM @SourceCodes WHERE ID = @LoopCount ),
				( SELECT EmployeeID FROM @Employees WHERE ID = @LoopCount2 )

			FROM @MonthTemplate

			SELECT @LoopCount2 = @LoopCount2 + 1	
		END
		-- reset loop 2 for next loop
		SELECT @LoopCount2 = 1
		SELECT @LoopCount = @LoopCount + 1
	END

	-- SELECT * FROM #_Temp_FSReferral_HourlyCount

--************************************************************************************************************
-- 
-- 	END OF SECTION TO FILL #_Temp_FSReferral_HourlyCount WITH SHELL DATA
-- 	
--************************************************************************************************************

CREATE TABLE #_Temp_FSReferral_TypeSelect
	(
		[CallID] [INT] ,
		[SourceCodeID] [INT] ,
		[CallDateTime] [DATETIME] , 
		[FSCaseBillSecondaryUserID] [INT] NULL ,
		[FSCaseBillDateTime] [DATETIME] NULL ,
		[FSCaseBillApproachDateTime] [DATETIME] NULL ,
		[FSCaseBillApproachUserID] [INT] NULL ,
		[SumOfFSCaseBillApproachCount] [SMALLINT] NULL ,
		[FSCaseBillFamUnavailUserId] [INT] NULL , 
		[FSCaseBillFamUnavailDateTime] [DATETIME] NULL , 
		[FSCaseBillMedSocUserID] [INT] NULL ,
		[FSCaseBillMedSocDateTime] [DATETIME] NULL,
		[SecondaryApproached] [INT] NULL ,
		[SecondaryApproachReason] [INT] NULL ,
		[SecondaryApproachedBy] [INT] NULL ,		
		[SecondaryApproachOutcome] [INT] NULL ,
		[SecondaryConsentBy] [INT] NULL 
	)


	--- insert all values for a month in to temp table #_Temp_FSReferral_TypeSelect
	set @sql1 = ' INSERT #_Temp_FSReferral_TypeSelect
			(
				CallID , 
				SourceCodeID , 
				CallDateTime , 
				FSCaseBillSecondaryUserID , 
				FSCaseBillDateTime , 
				FSCaseBillApproachUserID , 
				FSCaseBillApproachDateTime , 
				SumOfFSCaseBillApproachCount , 
				FSCaseBillFamUnavailUserId , 
				FSCaseBillFamUnavailDateTime , 
				FSCaseBillMedSocUserID , 
				FSCaseBillMedSocDateTime , 
				SecondaryApproached , 
				SecondaryApproachReason , 
				SecondaryApproachedBy , 
				SecondaryApproachOutcome , 
				SecondaryConsentBy 
			)'							  
	set @sql2 = ' SELECT	
				c.CallID , 
				c.SourceCodeID , 
				c.CallDateTime , 
				fsc.FSCaseBillSecondaryUserID , 
				fsc.FSCaseBillDateTime , 
				fsc.FSCaseBillApproachUserID , 
				fsc.FSCaseBillApproachDateTime , 
				fsc.FSCaseBillApproachCount , 
				fsc.FSCaseBillFamUnavailUserId , 
				fsc.FSCaseBillFamUnavailDateTime , 
				fsc.FSCaseBillMedSocUserID , 
				fsc.FSCaseBillMedSocDateTime , 
				s.SecondaryApproached , 
				s.SecondaryApproachReason , 
				sea.StatEmployeeID , 
				s.SecondaryApproachOutcome , 
				sec.StatEmployeeID 

			FROM _ReferralProdReport.dbo.Call c 
			JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID 
			JOIN _ReferralProdReport.dbo.SecondaryApproach s ON  s.CallID = c.CallID 
			JOIN _ReferralProdReport.dbo.Referral r ON r.CallID = c.CallID 
			LEFT JOIN _ReferralProdReport.dbo.StatEmployee sea ON sea.personid = s.SecondaryApproachedBy
			LEFT JOIN _ReferralProdReport.dbo.StatEmployee sec ON sec.personid = s.SecondaryConsentBy'  

	set @sql3 = ' WHERE DATEPART(yyyy , c.CallDateTime) = '+ltrim(str(@YearID))
	set @sql3 = @sql3 + ' AND DATEPART(m , c.CallDateTime) = ' + ltrim(str(@MonthID))

	set @sql3 = @sql3 + ' ORDER BY s.CallID'
	-- SELECT @sql2+@sql3
 	EXEC(@sql1+@sql2+@sql3)

--***************************************************************************************************************************************************************************************	
-- 
-- 	[SecondaryScreeningCount]  
-- 
--  **************************************************************************--************************************************************************************************************
	UPDATE	#_Temp_FSReferral_HourlyCount
	SET	SecondaryScreeningCount = CountTable.ReferralCount
	FROM		
	(
	SELECT	SourceCodeID AS CallSourceCodeID,
		FSCaseBillSecondaryUserID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		DATEPART( YYYY , FSCaseBillDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseBillDateTime ) AS CallMonthID , 	-- MonthID different for every count
		DATEPART( D , FSCaseBillDateTime ) AS CallDayID  ,	-- DayID different for every count
		DATEPART( HH , FSCaseBillDateTime ) AS CallHourID ,	-- HourID different for every count
		Count(*) AS ReferralCount
	FROM	#_Temp_FSReferral_TypeSelect
	WHERE	ISNULL(FSCaseBillSecondaryUserID, 0) > 0 

	GROUP BY   DATEPART( YYYY , FSCaseBillDateTime ), DATEPART( M , FSCaseBillDateTime ), DATEPART( D , FSCaseBillDateTime ), DATEPART( HH , FSCaseBillDateTime ), SourceCodeID,  FSCaseBillSecondaryUserID 
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID
	AND	DayID = CountTable.CallDayID
	AND	HourID = CountTable.CallHourID

--***************************************************************************************************************************************************************************************	
-- 
-- 	[FamilyApproachCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	#_Temp_FSReferral_HourlyCount
	SET	FamilyApproachCount = CountTable.ReferralCount
	FROM		
	(
	SELECT	SourceCodeID AS CallSourceCodeID,
		SecondaryApproachedBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		DATEPART( YYYY , FSCaseBillApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseBillApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		DATEPART( D , FSCaseBillApproachDateTime ) AS CallDayID  ,	-- DayID different for every count
		DATEPART( HH , FSCaseBillApproachDateTime ) AS CallHourID ,	-- HourID different for every count
		Count(*) AS ReferralCount
	FROM	#_Temp_FSReferral_TypeSelect
	WHERE	ISNULL( SecondaryApproached , 0) = 1 

	GROUP BY   DATEPART( YYYY , FSCaseBillApproachDateTime ), DATEPART( M , FSCaseBillApproachDateTime ), DATEPART( D , FSCaseBillApproachDateTime ), DATEPART( HH , FSCaseBillApproachDateTime ), SourceCodeID,  SecondaryApproachedBy 
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID
	AND	DayID = CountTable.CallDayID
	AND	HourID = CountTable.CallHourID

--**************************************************************************************************************************************************************************************	
-- 
-- 	[TotalApproachesCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	#_Temp_FSReferral_HourlyCount
	SET	TotalApproachesCount = CountTable.ReferralCount
	FROM		
	(
	SELECT	SourceCodeID AS CallSourceCodeID,
		SecondaryApproachedBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		DATEPART( YYYY , FSCaseBillApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseBillApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		DATEPART( D , FSCaseBillApproachDateTime ) AS CallDayID  ,	-- DayID different for every count
		DATEPART( HH , FSCaseBillApproachDateTime ) AS CallHourID ,	-- HourID different for every count
		sum(SumOfFSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_FSReferral_TypeSelect
	WHERE	ISNULL(FSCaseBillApproachUserID , 0) > 0 

	GROUP BY   DATEPART( YYYY , FSCaseBillApproachDateTime ), DATEPART( M , FSCaseBillApproachDateTime ), DATEPART( D , FSCaseBillApproachDateTime ), DATEPART( HH , FSCaseBillApproachDateTime ), SourceCodeID,  SecondaryApproachedBy 
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID
	AND	DayID = CountTable.CallDayID
	AND	HourID = CountTable.CallHourID

--***************************************************************************************************************************************************************************************		
-- 
-- 	[FamilyUnavailableCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	#_Temp_FSReferral_HourlyCount
	SET	FamilyUnavailableCount = CountTable.ReferralCount
	FROM		
	(
	SELECT	SourceCodeID AS CallSourceCodeID,
		FSCaseBillFamUnavailUserId AS CallStatEmployeeID , 		-- StatEmployeeID different for every count
		DATEPART( YYYY , FSCaseBillFamUnavailDateTime ) AS CallYearID , -- YearID different for every count
		DATEPART( M , FSCaseBillFamUnavailDateTime ) AS CallMonthID , 	-- MonthID different for every count
		DATEPART( D , FSCaseBillFamUnavailDateTime ) AS CallDayID  ,	-- DayID different for every count
		DATEPART( HH , FSCaseBillFamUnavailDateTime ) AS CallHourID ,	-- HourID different for every count
		count(*) AS ReferralCount
	FROM	#_Temp_FSReferral_TypeSelect
	WHERE	ISNULL(SecondaryApproached , 0) = 2
	AND	ISNULL(SecondaryApproachReason , 0) = 3
	GROUP BY   DATEPART( YYYY , FSCaseBillFamUnavailDateTime ), DATEPART( M , FSCaseBillFamUnavailDateTime ), DATEPART( D , FSCaseBillFamUnavailDateTime ), DATEPART( HH , FSCaseBillFamUnavailDateTime ), SourceCodeID,  FSCaseBillFamUnavailUserId 
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID
	AND	DayID = CountTable.CallDayID
	AND	HourID = CountTable.CallHourID

--***************************************************************************************************************************************************************************************		
-- 
-- 	[ConsentCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	#_Temp_FSReferral_HourlyCount
	SET	ConsentCount = CountTable.ReferralCount
	FROM		
	(
	SELECT	SourceCodeID AS CallSourceCodeID,
		SecondaryConsentBy AS CallStatEmployeeID , 			-- StatEmployeeID different for every count
		DATEPART( YYYY , FSCaseBillApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseBillApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		DATEPART( D , FSCaseBillApproachDateTime ) AS CallDayID  ,	-- DayID different for every count
		DATEPART( HH , FSCaseBillApproachDateTime ) AS CallHourID ,	-- HourID different for every count
		count(*) AS ReferralCount
	FROM	#_Temp_FSReferral_TypeSelect
	WHERE	ISNULL(SecondaryApproached , 0) = 1
	AND	ISNULL(SecondaryApproachOutcome , 0) IN ( 1 , 2)
	GROUP BY   DATEPART( YYYY , FSCaseBillApproachDateTime ), DATEPART( M , FSCaseBillApproachDateTime ), DATEPART( D , FSCaseBillApproachDateTime ), DATEPART( HH , FSCaseBillApproachDateTime ), SourceCodeID,  SecondaryConsentBy 
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID
	AND	DayID = CountTable.CallDayID
	AND	HourID = CountTable.CallHourID

--***************************************************************************************************************************************************************************************		
-- 
-- 	[MedSocCount] 
-- 
-- **************************************************************************************************************************************************************************************
	UPDATE	#_Temp_FSReferral_HourlyCount
	SET	MedSocCount = CountTable.ReferralCount
	FROM		
	(
	SELECT	SourceCodeID AS CallSourceCodeID,
		FSCaseBillMedSocUserID AS CallStatEmployeeID , 		-- StatEmployeeID different for every count
		DATEPART( YYYY , FSCaseBillMedSocDateTime  ) AS CallYearID , -- YearID different for every count
		DATEPART( M , FSCaseBillMedSocDateTime  ) AS CallMonthID , 	-- MonthID different for every count
		DATEPART( D , FSCaseBillMedSocDateTime  ) AS CallDayID  ,	-- DayID different for every count
		DATEPART( HH , FSCaseBillMedSocDateTime ) AS CallHourID ,	-- HourID different for every count
		count(*) AS ReferralCount
	FROM	#_Temp_FSReferral_TypeSelect
	WHERE	ISNULL(FSCaseBillMedSocUserID  , 0) > 0
	GROUP BY   DATEPART( YYYY , FSCaseBillMedSocDateTime ), DATEPART( M , FSCaseBillMedSocDateTime ), DATEPART( D , FSCaseBillMedSocDateTime ), DATEPART( HH , FSCaseBillMedSocDateTime ), SourceCodeID,  FSCaseBillMedSocUserID 
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID
	AND	DayID = CountTable.CallDayID
	AND	HourID = CountTable.CallHourID

-- remove select after development
-- SELECT * FROM #_Temp_FSReferral_HourlyCount 
-- select * from #_Temp_FSReferral_TypeSelect

-- Delete any records for the given month and year
	DELETE 	Referral_FSHourlyCount                                                                       
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID

--Update the count statistics

	-- TEMPORARY FIX IS TO ONLY INSERT RECORDS WITH VALUES
	-- PERMENANENT FIX WILL NEED TO LIMIT THE SIZE OF THE ORIGINAL SIZE
	INSERT INTO Referral_FSHourlyCount 
	SELECT 
		YearID , 
		MonthID , 
		DayID , 
		HourID , 
		SourceCodeID , 
		StatEmployeeID , 
		ISNULL(SecondaryScreeningCount , 0) , 
		ISNULL(FamilyApproachCount , 0) , 
		ISNULL(TotalApproachesCount , 0) , 
		ISNULL(FamilyUnavailableCount , 0) , 
		ISNULL(ConsentCount , 0) , 
		ISNULL(MedSocCount , 0) 

	FROM #_Temp_FSReferral_HourlyCount 
	WHERE ISNULL(SecondaryScreeningCount , 0) <> 0 
	OR ISNULL(FamilyApproachCount , 0) <> 0 
	OR ISNULL(TotalApproachesCount , 0) <> 0 
	OR ISNULL(FamilyUnavailableCount , 0) <> 0 
	OR ISNULL(ConsentCount , 0) <> 0 
	OR ISNULL(MedSocCount , 0) <> 0
	
		
DROP TABLE #_Temp_FSReferral_HourlyCount
DROP TABLE #_Temp_FSReferral_TypeSelect



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

