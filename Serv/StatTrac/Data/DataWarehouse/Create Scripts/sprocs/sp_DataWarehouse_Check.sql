SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DataWarehouse_Check]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DataWarehouse_Check]
GO




CREATE PROCEDURE sp_DataWarehouse_Check
	@MonthID AS INT = 0,
	@YearID AS INT = 0
AS 
SET NOCOUNT ON

DECLARE @RowCount AS INT
																			 

SELECT @MonthID = CASE WHEN @MonthID = 0 OR @MonthID IS NULL THEN DATEPART(M,DATEADD(dd, - 1,GETDATE())) ELSE @MonthID END
SELECT @YearID  = CASE WHEN @YearID = 0 OR @YearID IS NULL THEN DATEPART(YYYY,DATEADD(dd, -1 ,GETDATE())) ELSE @YearID END

-- the following queries obtain a COUNT for each month FROM 1/2001 forward 

--CREATE TABLE #CheckTable
SELECT 0 AS 'StatCount', 'Empty String of Length 0000000000000000' AS 'TableName', 0 AS 'YearID', 0 AS 'MonthID' INTO #CheckTable WHERE 0<>0

INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_AgeDemoCount',YearID,  MonthID FROM Referral_AgeDemoCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID, MonthID  
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_ApproachCount',YearID,  MonthID FROM Referral_ApproachCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_ApproachPersonConsentCount',YearID,  MonthID FROM Referral_ApproachPersonConsentCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_ApproachPersonCount',YearID,  MonthID FROM Referral_ApproachPersonCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_ApproachPersonReasonCount',YearID,  MonthID FROM Referral_ApproachPersonReasonCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_ApproachReasonCount',YearID,  MonthID FROM Referral_ApproachReasonCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_AppropriateReasonCount',YearID,  MonthID FROM Referral_AppropriateReasonCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_AverageAgeCount',YearID,  MonthID FROM Referral_AverageAgeCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_CallerPersonCount',YearID,  MonthID FROM Referral_CallerPersonCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_ConsentReasonCount',YearID,  MonthID FROM Referral_ConsentReasonCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_ConversionReasonCount',YearID,  MonthID FROM Referral_ConversionReasonCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_HospitalReportTimeCount',YearID,  MonthID FROM Referral_HospitalReportTimeCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_RaceDemoCount',YearID,  MonthID FROM Referral_RaceDemoCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_TypeCount',YearID,  MonthID FROM Referral_TypeCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 
INSERT #CheckTable SELECT COUNT(*) AS 'StatCount', 'Referral_UnitSummaryCount',YearID,  MonthID FROM Referral_UnitSummaryCOUNT WHERE MonthID = @MonthID and YearID = @YearID GROUP BY YearID,  MonthID ORDER BY YearID,  MonthID 

SELECT * FROM #CheckTable WHERE StatCount < 1000 ORDER BY YearID, MonthID, TableName

IF @@ROWCOUNT > 0 
BEGIN
	RAISERROR  ('DataWarehouse data is incorrect run sp_DataWarehouse_Check to get list',11,1)with LOG
	DROP TABLE #CheckTable
	RETURN 1
END

DROP TABLE #CheckTable

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

