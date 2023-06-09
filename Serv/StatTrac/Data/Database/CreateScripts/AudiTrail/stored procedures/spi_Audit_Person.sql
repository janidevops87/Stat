SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_Person]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_Person]
GO

create procedure "spi_Audit_Person" 
	@c1 int,
	@c2 varchar(50),
	@c3 varchar(1),
	@c4 varchar(50),
	@c5 int,
	@c6 int,
	@c7 varchar(255),
	@c8 smallint,
	@c9 smallint,
	@c10 smallint,
	@c11 datetime,
	@c12 smalldatetime,
	@c13 smallint,
	@c14 smalldatetime,
	@c15 varchar(255),
	@c16 varchar(30),
	@c17 smallint,
	@c18 smallint,
	@c19 int,
	@c20 smallint,
	@c21 int,
	@c22 int,
	@c23 int, -- GenderID
	@c24 int, -- RaceID	int
	@c25 varchar(25), -- Credential	varchar
	@c26 int -- TrainedRequestorID	int	


AS
BEGIN


insert into 
	"Person"
	( 
		"PersonID",
		"PersonFirst",
		"PersonMI",
		"PersonLast",
		"PersonTypeID",
		"OrganizationID",
		"PersonNotes",
		"PersonBusy",
		"Verified",
		"Inactive",
		"LastModified",
		"PersonBusyUntil",
		"PersonTempNoteActive",
		"PersonTempNoteExpires",
		"PersonTempNote",
		"Unused",
		"UpdatedFlag",
		"AllowInternetScheduleAccess",
		"PersonSecurity",
		"PersonArchive",
		"LastStatEmployeeID",
		"AuditLogTypeID",  --c22
		GenderID, --c23
		RaceID, --c24
		Credential, --c25
		TrainedRequestorID --c26
	)

values 
	( 
		@c1,
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
		@c20,
		@c21,
		@c22,
		@c23 , -- GenderID
		@c24 , -- RaceID	int
		@c25 , -- Credential	varchar
		@c26  -- TrainedRequestorID	int	
		
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

