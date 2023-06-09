SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_OnlineScheduleAccessList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_OnlineScheduleAccessList]
GO


Create Procedure spu_OnlineScheduleAccessList
     @vAccess      as int,
     @vPersonID    as int

AS

Update      Person
Set         AllowInternetScheduleAccess = @vAccess
Where       PersonID = @vPersonID  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

