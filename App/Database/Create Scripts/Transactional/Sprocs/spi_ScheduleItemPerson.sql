SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_ScheduleItemPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_ScheduleItemPerson]
GO


CREATE PROCEDURE  spi_ScheduleItemPerson
	
	@vScheduleItemID		int	= null,
	@vPersonID                      int     = null,
        @vPriority                      int     = null

 AS

--INSERT INTO ScheduleLog (ScheduleGroupID, ScheduleLogDateTime, PersonID, ScheduleLogType, ScheduleLogShift, ScheduleLogChange) VALUES (14,'3/7/00 12:53:00 PM',47313,'Delete Person','03/18/00 06:00 Sat, 03/19/00 06:00 Sun','Deleted person #1, Calvin Brown')

     INSERT INTO ScheduleItemPerson 
     (ScheduleItemID, PersonID, Priority) 
     VALUES (@vScheduleItemID,@vPersonID,@vPriority)




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

