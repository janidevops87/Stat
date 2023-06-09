SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_OrganizationPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_OrganizationPerson]
GO


CREATE PROCEDURE spu_OrganizationPerson
	@PersonId int,
	@PersonLast varchar(20),
	@PersonFirst varchar(20),
	@PersonTypeId int,
	@PersonOrganizationId int,
	@PersonActive smallint,
	@OriginalOrganizationId int = 0

AS

IF @PersonId = 0
--IT'S AN INSERT
BEGIN
		--Reverse the Active/Inactive flag
		SET @PersonActive =  CASE @PersonActive
					WHEN 0 THEN 1
					WHEN 1 THEN 0
				END

		Insert Person(PersonLast, PersonFirst, PersonTypeId, OrganizationId, Inactive, LastModified)
		Values(@PersonLast, @PersonFirst, @PersonTypeId, @PersonOrganizationId,  @PersonActive, getdate())
END
ELSE
--IT'S AN UPDATE
BEGIN
	IF @PersonOrganizationId = @OriginalOrganizationId
	--The org is not changing
	BEGIN
		--Insert a record in the change log
		Insert PersonLog(PersonID, PersonFirst, PersonMI, PersonLast, PersonTypeID, OrganizationID, Inactive, LastModified)
			Select PersonID, PersonFirst, PersonMI, PersonLast, PersonTypeID, OrganizationID, Inactive, LastModified From Person Where PersonID = @PersonId

		Update Person 
		Set PersonLast = @PersonLast, 
			PersonFirst = @PersonFirst, 
			PersonTypeId = @PersonTypeId,
			OrganizationId = @PersonOrganizationId,
			Inactive =  CASE @PersonActive
					WHEN 0 THEN 1
					WHEN 1 THEN 0
				END,
			LastModified = getdate()
		Where PersonId = @PersonId
	END
	ELSE
	--We're changing the org
	BEGIN
		--Insert a record in the change log
		Insert PersonLog(PersonID, PersonFirst, PersonMI, PersonLast, PersonTypeID, OrganizationID, Inactive, LastModified)
			Select PersonID, PersonFirst, PersonMI, PersonLast, PersonTypeID, OrganizationID, Inactive, LastModified From Person Where PersonID = @PersonId

		--Deactivate the person in the current org
		Update Person 
		Set Inactive =  1,
		LastModified = getdate()
		Where PersonId = @PersonId

		--Reverse the Active/Inactive flag
		SET @PersonActive =  CASE @PersonActive
					WHEN 0 THEN 1
					WHEN 1 THEN 0
				END
		
		--Insert a new person in the new org
		Insert Person(PersonLast, PersonFirst, PersonTypeId, OrganizationId, Inactive, LastModified)
		Values(@PersonLast, @PersonFirst, @PersonTypeId, @PersonOrganizationId,  @PersonActive, getdate())
	END
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

