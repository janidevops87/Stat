  if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_DayLightEnd]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_DayLightEnd]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION dbo.fn_DayLightEnd
	(
		@activityDate DATETIME
	)
RETURNS DATETIME
AS
/******************************************************************************
**		File: fn_DayLightEnd.sql
**		Name: fn_DayLightEnd
**		Desc: 
**			Determines the enddate for daylight savings during the year specified by 
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
		@endDate   varchar(20),
        @endMonth datetime	
	 
		 -- SET THE END MONTH
		SET											
            @endMonth	=	'11/1/' + CONVERT(
												VARCHAR(4),
												DATEPART(
															YYYY, 
															@activityDate
														)	
											)
									+ ' 02:00'	
         
         -- DETERMINE THE END DATE
         SET
			@endDate = DateAdd(
								d, -- add a day
								(
									(case 
										when 
											-- start of month starts on first weekday
											DATEPART(
														dw, 
														@endMonth
													) = 1 
										THEN	
											1 
										ELSE  
											8 end 
									 ) - 
										DATEPART(
													dw, 
													@endMonth
												 ) 
								), -- how many days
								@endMonth 
							  ) -- date to add
            
         
	RETURN @endDate
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

