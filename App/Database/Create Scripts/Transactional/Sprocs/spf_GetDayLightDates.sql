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

          --get StartDate BREAK
         
               Select @DayLightStartDate = dbo.fn_DayLightStart('1/1/' + @Year)
               
               Select @DayLightEndDate = dbo.fn_DayLightEnd('1/1/' + @Year)
               

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

