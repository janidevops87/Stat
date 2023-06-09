SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CallVolumeSC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CallVolumeSC]
GO






/****** Object:  Stored Procedure dbo.sps_CallVolumeSC    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_CallVolumeSC
	@vStartDate	smalldatetime	= null,
	@vEndDate	smalldatetime	= null,
	@vCallTypeID	int		= null,
	@vRollup	smallint		= 0

AS

DECLARE	
	@vStartWeek	smallint	


IF	@vCallTypeID = 1 

	BEGIN
	IF	@vRollup = 0 
		SELECT 	CONVERT(char(8), CallDateTime, 1) AS Date, 
				SourceCodeName, 
				Count(CallTypeID) AS CallCount
		FROM		Call 
		JOIN		Referral ON Referral.CallID = Call.CallID
		LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
		WHERE	CallTypeID = 1	
		AND		CallDateTime >= @vStartDate AND CallDateTime < @vEndDate
		GROUP BY	SourceCodeName, CONVERT(char(8), CallDateTime, 1)
		ORDER BY	CONVERT(char(8), CallDateTime, 1), SourceCodeName
	IF	@vRollup = 1
		SELECT 	CAST(Year(CallDateTime) AS varchar(4)) + '-' + CAST(Month(CallDateTime) AS varchar(2)) As Date, 
				SourceCodeName, 
				Count(CallTypeID) AS CallCount
		FROM		Call 
		JOIN		Referral ON Referral.CallID = Call.CallID
		LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
		WHERE	CallTypeID = 1
		AND		CallDateTime >= @vStartDate AND CallDateTime < @vEndDate
		GROUP BY	SourceCodeName, CAST(Year(CallDateTime) AS varchar(4)) + '-' + CAST(Month(CallDateTime) AS varchar(2))
		ORDER BY	CAST(Year(CallDateTime) AS varchar(4)) + '-' + CAST(Month(CallDateTime) AS varchar(2)), SourceCodeName
	IF	@vRollup = 2
		SELECT 	CAST(Year(CallDateTime) AS varchar(4)) + '-wk ' + CAST(DatePart(wk, CallDateTime) AS varchar(2)) As Date, 
				SourceCodeName, 
				Count(CallTypeID) AS CallCount
		FROM		Call 
		JOIN		Referral ON Referral.CallID = Call.CallID
		LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
		WHERE	CallTypeID = 1
		AND		CallDateTime >= @vStartDate AND CallDateTime < @vEndDate
		GROUP BY	SourceCodeName, CAST(Year(CallDateTime) AS varchar(4)) + '-wk ' + CAST(DatePart(wk, CallDateTime) AS varchar(2))
		ORDER BY	CAST(Year(CallDateTime) AS varchar(4)) + '-wk ' + CAST(DatePart(wk, CallDateTime) AS varchar(2)), SourceCodeName
	END

IF	@vCallTypeID = 2

	BEGIN
	IF	@vRollup = 0 
		SELECT 	CONVERT(char(8), CallDateTime, 1) AS Date, 
				SourceCodeName, 
				Count(CallTypeID) AS CallCount
		FROM		Call 
		JOIN		Message ON Message.CallID = Call.CallID
		LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
		WHERE	CallTypeID = 2
		AND		CallDateTime >= @vStartDate AND CallDateTime < @vEndDate
		GROUP BY	SourceCodeName, CONVERT(char(8), CallDateTime, 1)
		ORDER BY	CONVERT(char(8), CallDateTime, 1), SourceCodeName
	IF	@vRollup = 1
		SELECT 	CAST(Year(CallDateTime) AS varchar(4)) + '-' + CAST(Month(CallDateTime) AS varchar(2)) As Date, 
				SourceCodeName, 
				Count(CallTypeID) AS CallCount
		FROM		Call 
		JOIN		Message ON Message.CallID = Call.CallID
		LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
		WHERE	CallTypeID = 2
		AND		CallDateTime >= @vStartDate AND CallDateTime < @vEndDate
		GROUP BY	SourceCodeName, CAST(Year(CallDateTime) AS varchar(4)) + '-' + CAST(Month(CallDateTime) AS varchar(2))
		ORDER BY	CAST(Year(CallDateTime) AS varchar(4)) + '-' + CAST(Month(CallDateTime) AS varchar(2)), SourceCodeName
	IF	@vRollup = 2
		SELECT 	CAST(Year(CallDateTime) AS varchar(4)) + '-wk ' + CAST(DatePart(wk, CallDateTime) AS varchar(2)) As Date, 
				SourceCodeName, 
				Count(CallTypeID) AS CallCount
		FROM		Call 
		JOIN		Message ON Message.CallID = Call.CallID
		LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
		WHERE	CallTypeID = 2
		AND		CallDateTime >= @vStartDate AND CallDateTime < @vEndDate
		GROUP BY	SourceCodeName, CAST(Year(CallDateTime) AS varchar(4)) + '-wk ' + CAST(DatePart(wk, CallDateTime) AS varchar(2))
		ORDER BY	CAST(Year(CallDateTime) AS varchar(4)) + '-wk ' + CAST(DatePart(wk, CallDateTime) AS varchar(2)), SourceCodeName
	END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

