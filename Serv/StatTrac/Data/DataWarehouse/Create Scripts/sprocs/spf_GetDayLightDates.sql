SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_GetDayLightDates]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_GetDayLightDates]
GO



Create Procedure spf_GetDayLightDates
        @Year           varchar(4),
        @DayLightStartDate  datetime OUTPUT,
        @DayLightEndDate    datetime OUTPUT

AS
     SET NOCount ON
     Declare 
		@LoopCount	int,
		@weekCount	int	

          --get StartDate BREAK
          Select @LoopCount = 1
          SET @weekCount = 0
          WHILE @LoopCount < 32
          BEGIN
               Select @DayLightStartDate = '3/' + convert(varchar(2),@LoopCount) + '/' + @Year + ' 02:00:00'

               IF ISDATE(@DayLightStartDate) = 1
               BEGIN
					--if the @DayLightStartDate is equal to the first day of the week add to the weekcount
					IF DATEPART(dw, @DayLightStartDate) = 1
					BEGIN
						SET @weekCount = @weekCount + 1
						print 'set @weekcount'
					END
		    
					-- if the date is a sunday and the weekCount is 2 for the second week
					IF (DATEPART(dw, @DayLightStartDate) = 1 AND @weekCount = 2)
					BEGIN
						Break
					END     
					PRINT '@weekCount' + convert(varchar, isnull(@weekCount, 0) )
				END
               SELECT @LoopCount = @LoopCount + 1
          END
          

          --get enddate
          Select @LoopCount = 1
          WHILE @LoopCount < 32
          BEGIN
               Select @DayLightEndDate = '11/' + convert(varchar(2),@LoopCount) + '/' + @Year + ' 02:00:00'
               IF ISDATE(@DayLightEndDate) = 1
               BEGIN
                    IF DATEPART(dw, @DayLightEndDate) = 1
                    BEGIN
                         Break
                    END     
               END
               SELECT @LoopCount = @LoopCount + 1 
          END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

