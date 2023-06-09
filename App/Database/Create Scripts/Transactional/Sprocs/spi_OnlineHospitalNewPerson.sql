SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_OnlineHospitalNewPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_OnlineHospitalNewPerson]
GO

CREATE PROCEDURE spi_OnlineHospitalNewPerson 
			@PersonFirst as varchar(50),
			@PersonMI as varchar(50)= NULL,
			@PersonLast as varchar(50),
			@PersonTypeID as int,
			@OrganizationID as int


AS

INSERT INTO Person (PersonFirst, PersonMI, PersonLast, PersonTypeID, OrganizationID, PersonNotes, PersonBusy, Verified, PersonBusyUntil, 
PersonTempNoteActive, PersonTempNoteExpires, PersonTempNote, Inactive)
 VALUES (@PersonFirst,NULL,@PersonLast,@PersonTypeID,@OrganizationID,NULL,0,0,NULL,0,NULL,NULL,0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

