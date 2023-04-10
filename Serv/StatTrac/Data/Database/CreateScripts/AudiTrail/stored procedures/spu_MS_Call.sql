 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_MS_Call]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_MS_Call]
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure "spu_MS_Call" 
	@c1 int,
	@c2 varchar(15),
	@c3 int,
	@c4 smalldatetime,
	@c5 smallint,
	@c6 varchar(15),
	@c7 smallint,
	@c8 smallint,
	@c9 smallint,
	@c10 datetime,
	@c11 smallint,
	@c12 int,
	@c13 int,
	@c14 int,
	@c15 numeric(5, 0),
	@c16 smallint,
	@c17 int,
	@c18 smallint,
	@c19 smallint,
	@c20 int,
	@pkc1 int,
	@bitmap binary(3)
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
		 @c2,
		 @c3,
		 @c4,
		 @c5,
		 @c6,
		 @c7,
		 @c8,
		 @c9,
		 @c10,
		 @c11,
		 @c12,
		 @c13,
		 @c14,
		 @c15,
		 @c16,
		 @c17,
		 @c18,
		 @c19,
		 @c20
 )
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO