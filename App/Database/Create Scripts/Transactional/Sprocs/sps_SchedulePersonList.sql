SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SchedulePersonList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SchedulePersonList]
GO

-- sps_SchedulePersonList 7
Create Procedure sps_SchedulePersonList 

     @vScheduleGroupID     int      = null

AS


SELECT DISTINCT 
               --ScheduleGroupPerson.ScheduleGroupPersonID, 
               ScheduleGroupPerson.PersonID,
               PersonFirst + ' ' + PersonLast as Name, 
               PersonTypeName 
FROM           ScheduleGroupPerson 
JOIN           Person ON Person.PersonID = ScheduleGroupPerson.PersonID 
JOIN           PersonType ON PersonType.PersonTypeID = Person.PersonTypeID 
WHERE          ScheduleGroupPerson.ScheduleGroupID = @vScheduleGroupID 
ORDER BY       PersonFirst + ' ' + PersonLast ASC 

-- select * from ScheduleGroupPerson

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

