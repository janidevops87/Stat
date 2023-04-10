 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_MS_Message]') and OBJECTPROPERTY(id,
 N'IsProcedure') = 1)
drop procedure [dbo].[spu_MS_Message]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure "spu_MS_Message" 
	@c1 int,
	@c2 int,
	@c3 varchar(80),
	@c4 varchar(20),
	@c5 varchar(80),
	@c6 int,
	@c7 int,
	@c8 int,
	@c9 smallint,
	@c10 varchar(255),
	@c11 smallint,
	@c12 datetime,
	@c13 numeric(5,0),
	@c14 varchar(50),
	@c15 varchar(20),
	@c16 varchar(5),
	@c17 smallint,
	@pkc1 int,
	@bitmap binary(3)
as
INSERT  
	"Message"( 
		"MessageID",
		"CallID",
		"MessageCallerName",
		"MessageCallerPhone",
		"MessageCallerOrganization",
		"OrganizationID",
		"PersonID",
		"MessageTypeID",
		"MessageUrgent",
		"MessageDescription",
		"Inactive",
		"LastModified",
		"MessageExtension",
		"MessageImportPatient",
		"MessageImportUNOSID",
		"MessageImportCenter",
		"UpdatedFlag"
 )

values ( 
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
	@c17
 )

/*
update "Message" 
set
"MessageID" = case substring(@bitmap, 1, 1) & 1 when 1 then @c1 else "MessageID" end,
"CallID" = case substring(@bitmap, 1, 1) & 2 when 2 then @c2 else "CallID" end,
"MessageCallerName" = case substring(@bitmap, 1, 1) & 4 when 4 then @c3 else "MessageCallerName" end,
"MessageCallerPhone" = case substring(@bitmap, 1, 1) & 8 when 8 then @c4 else "MessageCallerPhone" end,
"MessageCallerOrganization" = case substring(@bitmap, 1, 1) & 16 when 16 then @c5 else "MessageCallerOrganization" end,
"OrganizationID" = case substring(@bitmap,
1,
1) & 32 when 32 then @c6 else "OrganizationID" end
,
"PersonID" = case substring(@bitmap,
1,
1) & 64 when 64 then @c7 else "PersonID" end
,
"MessageTypeID" = case substring(@bitmap,
1,
1) & 128 when 128 then @c8 else "MessageTypeID" end
,
"MessageUrgent" = case substring(@bitmap,
2,
1) & 1 when 1 then @c9 else "MessageUrgent" end
,
"MessageDescription" = case substring(@bitmap,
2,
1) & 2 when 2 then @c10 else "MessageDescription" end
,
"Inactive" = case substring(@bitmap,
2,
1) & 4 when 4 then @c11 else "Inactive" end
,
"LastModified" = case substring(@bitmap,
2,
1) & 8 when 8 then @c12 else "LastModified" end
,
"MessageExtension" = case substring(@bitmap,
2,
1) & 16 when 16 then @c13 else "MessageExtension" end
,
"MessageImportPatient" = case substring(@bitmap,
2,
1) & 32 when 32 then @c14 else "MessageImportPatient" end
,
"MessageImportUNOSID" = case substring(@bitmap,
2,
1) & 64 when 64 then @c15 else "MessageImportUNOSID" end
,
"MessageImportCenter" = case substring(@bitmap,
2,
1) & 128 when 128 then @c16 else "MessageImportCenter" end
,
"UpdatedFlag" = case substring(@bitmap,
3,
1) & 1 when 1 then @c17 else "UpdatedFlag" end
where "MessageID" = @pkc1
if @@rowcount = 0
	if @@microsoftversion>0x07320000
		exec sp_MSreplraiserror 20598
end
else
begin
update "Message" set
"CallID" = case substring(@bitmap,
1,
1) & 2 when 2 then @c2 else "CallID" end
,
"MessageCallerName" = case substring(@bitmap,
1,
1) & 4 when 4 then @c3 else "MessageCallerName" end
,
"MessageCallerPhone" = case substring(@bitmap,
1,
1) & 8 when 8 then @c4 else "MessageCallerPhone" end
,
"MessageCallerOrganization" = case substring(@bitmap,
1,
1) & 16 when 16 then @c5 else "MessageCallerOrganization" end
,
"OrganizationID" = case substring(@bitmap,
1,
1) & 32 when 32 then @c6 else "OrganizationID" end
,
"PersonID" = case substring(@bitmap,
1,
1) & 64 when 64 then @c7 else "PersonID" end
,
"MessageTypeID" = case substring(@bitmap,
1,
1) & 128 when 128 then @c8 else "MessageTypeID" end
,
"MessageUrgent" = case substring(@bitmap,
2,
1) & 1 when 1 then @c9 else "MessageUrgent" end
,
"MessageDescription" = case substring(@bitmap,
2,
1) & 2 when 2 then @c10 else "MessageDescription" end
,
"Inactive" = case substring(@bitmap,
2,
1) & 4 when 4 then @c11 else "Inactive" end
,
"LastModified" = case substring(@bitmap,
2,
1) & 8 when 8 then @c12 else "LastModified" end
,
"MessageExtension" = case substring(@bitmap,
2,
1) & 16 when 16 then @c13 else "MessageExtension" end
,
"MessageImportPatient" = case substring(@bitmap,
2,
1) & 32 when 32 then @c14 else "MessageImportPatient" end
,
"MessageImportUNOSID" = case substring(@bitmap,
2,
1) & 64 when 64 then @c15 else "MessageImportUNOSID" end
,
"MessageImportCenter" = case substring(@bitmap,
2,
1) & 128 when 128 then @c16 else "MessageImportCenter" end
,
"UpdatedFlag" = case substring(@bitmap,
3,
1) & 1 when 1 then @c17 else "UpdatedFlag" end
where "MessageID" = @pkc1
*/
if @@rowcount = 0
	if @@microsoftversion>0x07320000
		exec sp_MSreplraiserror 20598


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

