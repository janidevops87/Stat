SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_ScheduleLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_ScheduleLog]
GO


Create Procedure spi_ScheduleLog

     @vScheduleGroupID          int          =null,
     @vScheduleLogDateTime      dateTime     =null,
     @vPersonID                 int          =null,
     @vScheduleLogType          varchar(20)  =null, 
     @vScheduleLogShift         varchar(80)  =null, 
     @vScheduleLogChange        varchar(200) =null


AS

     INSERT INTO ScheduleLog 
     (ScheduleGroupID, ScheduleLogDateTime, PersonID, ScheduleLogType, ScheduleLogShift, ScheduleLogChange)
     VALUES (@vScheduleGroupID, @vScheduleLogDateTime, @vPersonID, @vScheduleLogType, @vScheduleLogShift, @vScheduleLogChange)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

