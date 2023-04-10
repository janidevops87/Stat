if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_MS_Message]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_MS_Message]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure "spd_MS_Message" 
	@pkc1 int
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
 values(
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
	null )

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 