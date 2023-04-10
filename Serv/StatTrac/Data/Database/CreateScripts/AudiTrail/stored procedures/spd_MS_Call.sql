 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_MS_Call]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_MS_Call]
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure "spd_MS_Call" 
	@pkc1 int
as
INSERT  
	"Call"( 
		 "CallID",
		 "CallNumber",
		 "CallTypeID",
		 "CallDateTime",
		 "StatEmployeeID",
		 "CallTotalTime",
		 "CallTempExclusive",
		 "Inactive",
		 "CallSeconds",
		 "LastModified",
		 "CallTemp",
		 "SourceCodeID",
		 "CallOpenByID",
		 "CallTempSavedByID",
		 "CallExtension",
		 "UpdatedFlag",
		 "CallOpenByWebPersonId",
		 "RecycleNCFlag",
		 "CallActive",
		 "CallSaveLastByID"
	)

values 
	( 
		 @pkc1,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null,
		 null
 )


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO