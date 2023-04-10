 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_DORDataHour')
	BEGIN
		PRINT 'Dropping Procedure sps_DORDataHour'
		DROP  Procedure  sps_DORDataHour
	END

GO

PRINT 'Creating Procedure sps_DORDataHour'
GO
CREATE Procedure sps_DORDataHour
	@StartDate SMALLDATETIME,
 	@EndDate SMALLDATETIME =null,
	@MedSocOffSet INT = 1 --- USE THIS TO DETERMINE HOW MANY HOURS MEDSOC IS OFFSET BY
						-- the event that triggers medsoc happen after completetion	
AS

/******************************************************************************
**		File: 
**		Name: sps_DORDataHour
**		Desc: 
**
**              
**		Return values:
**		All values are based on the shift for that day
**		See Requirements
**
**		Called by:   DOR Data Report
**              
**
**		Auth: Bret Knoll
**		Date: 05/08/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		05/08/08	Bret Knoll			Initial
******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

CREATE TABLE #sps_DORDataHalfHour
(
	ActivityDateTime DATETIME,       
	SecondaryScreening INT,
	FamilyApproaches INT,
	MedSoc INT
)

INSERT #sps_DORDataHalfHour 
EXEC sps_DORDataHalfHour @StartDate, @EndDate, @MedSocOffSet


SELECT 
	CONVERT(SMALLDATETIME, CONVERT(VARCHAR(2), DATEPART(MM, ActivityDateTime)) + '/' + CONVERT(VARCHAR(2), DATEPART(DD, ActivityDateTime)) + '/' + CONVERT(VARCHAR(4), DATEPART(YYYY, ActivityDateTime)) + ' ' + CONVERT(VARCHAR(2), DATEPART(HH, ActivityDateTime)) + ':00:00') ActivityDateTime,	
	SUM(SecondaryScreening) SecondaryScreening, 
	SUM(FamilyApproaches) FamilyApproaches, 
	SUM(MedSoc) MedSoc
FROM
	#sps_DORDataHalfHour
GROUP BY 
	CONVERT(SMALLDATETIME, CONVERT(VARCHAR(2), DATEPART(MM, ActivityDateTime)) + '/' + CONVERT(VARCHAR(2), DATEPART(DD, ActivityDateTime)) + '/' + CONVERT(VARCHAR(4), DATEPART(YYYY, ActivityDateTime)) + ' ' + CONVERT(VARCHAR(2), DATEPART(HH, ActivityDateTime)) + ':00:00')
ORDER BY
	CONVERT(SMALLDATETIME, CONVERT(VARCHAR(2), DATEPART(MM, ActivityDateTime)) + '/' + CONVERT(VARCHAR(2), DATEPART(DD, ActivityDateTime)) + '/' + CONVERT(VARCHAR(4), DATEPART(YYYY, ActivityDateTime)) + ' ' + CONVERT(VARCHAR(2), DATEPART(HH, ActivityDateTime)) + ':00:00')


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





GO

GRANT EXEC ON sps_DORDataHour TO PUBLIC

GO
