 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_DayLightStart]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_DayLightStart]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION dbo.fn_DayLightStart
	(
		@activityDate DATETIME 
	)
RETURNS DATETIME
AS
/******************************************************************************
**		File: fn_DayLightStart.sql
**		Name: fn_DayLightStart
**		Desc: 
**			Determines the startdate for daylight savings during the year specified by 
**			activitDateTime.  
**
**              
**		Return values:
** 
**		Called by:   
**		GetLogEventList
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 07/11/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		7/11/07		Bret Knoll			8.4.3.9 LogEventNumber
*******************************************************************************/
BEGIN

     DECLARE      
		@startDate varchar(20),
        @startMonth datetime
	 
		 -- SET THE BEGINING MONTH
		 SET
			@startMonth =	'3/1/' + CONVERT(
												VARCHAR(4),
												DATEPART(
															YYYY, 
															@activityDate
														)	
											)
									+ ' 02:00'		
         -- DETERMINE THE START DATE   
         SET
			@StartDate = DateAdd(
									d, -- add day
									(
										(case 
											when 
												-- start of month starts on first weekday
												DATEPART(
															dw, 
															@startMonth
														) = 1 
											THEN 
												1  
											ELSE  
												8 end 
										 ) - 
											DATEPART(
													dw, 
													@startMonth
													) + 7
									),  -- how many days
									@startMonth --- date to add to
								) 
           
         
	RETURN @StartDate
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

