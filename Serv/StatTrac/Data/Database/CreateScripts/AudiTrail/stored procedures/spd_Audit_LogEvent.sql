SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_LogEvent]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
drop procedure [dbo].[spd_Audit_LogEvent]
GO

create procedure "spd_Audit_LogEvent" @pkc1 int
as


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

