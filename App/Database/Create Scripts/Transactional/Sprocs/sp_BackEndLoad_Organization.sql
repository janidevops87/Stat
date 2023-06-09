SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_BackEndLoad_Organization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_BackEndLoad_Organization]
GO


create  PROCEDURE sp_BackEndLoad_Organization AS

-- Procedure to add organizations to the appropriate tables

-- Declare variables needed for processing
DECLARE 	@phoneIDOrg int,
		@phoneIDPerson int,
		@orgID int,
		@personID int,
		@orgimportID varchar(5),
		@countyID int,
		@countyName varchar(25),
		@stateID int,
		@orgTypeID int,
		@webReportGroupID int,
		@sourceCode1 int,
		@sourceCode2 int,
		@sourceCode3 int,
		@webPersonID int,
		@reportID int,
		@userName varchar(30),
		@personTypeID int,
		@counter int,
		@phonetypeid int,
		@OrganizationID int


--SET @counter = 0
-- Set StateID

-- Declare cursor
DECLARE @curSource Cursor

-- Replace with appropriate items from the temp table you'll load from
-- Set cursor
SET @curSource = Cursor FOR
SELECT orgimportid
FROM OrgImport


-- Open the cursor
Open @curSource

-- Start processing each record; each should insert into the following tables:
-- Phone (with organization's phone number)
-- Phone (with contact's phone number)
-- Organization (with local coalition information)
-- Person (with contact name for organization)
-- PersonPhone (with the link between the person and the phone number for that person - @phoneIDPerson)
--select "statring while loop"
-- Get the first/next record
Fetch Next From @curSource 
Into @orgimportID

While @@fetch_status = 0
--While @counter < 52

Begin


-- reset variables
select	@countyID = 0,
	@phonetypeid = 0,
	@stateID = 0,
	@orgTypeID = 0,
	@phoneIDOrg = 0,
	@OrganizationID = null

	-- set stateid
	SELECT @stateID = StateID
	FROM STATE WHERE StateAbbrv = (SELECT State from orgimport where orgimportid = @orgimportID )
	-- SELECT * FROM STATE
	-- select * from organization
	--- I'll need to be moved into the cursor to get the county for each insert (and unhardcoded, obviously)
	SELECT @countyID = CountyID
	FROM County
	WHERE StateID = @stateID
	AND Upper(CountyName) = (select UPPER(countyname) from orgimport where orgimportID =@orgimportID ) --- SELECT COUNTY NAME )
	-- select * from county
	-- check if county id was set if not set it
	IF @countyID = 0
	BEGIN
		INSERT County (CountyName, StateID, Verified, Inactive)
		SELECT CountyName, @stateID, 0, 0 FROM orgimport where orgimportid = @orgimportID
		SELECT @countyID = @@identity
		--
	END

  	SELECT @OrganizationID =  OrganizationID FROM Organization 
	where OrganizationName like (SELECT OrganizationName FROM OrgImport WHERE orgimportid = @orgimportid) 
	and stateid = @stateID
	and countyid = @countyID
	and organizationcity like (select city FROM OrgImport WHERE orgimportid = @orgimportid) 

	--SELECT "organization id " , @OrganizationID
	IF isnull(@OrganizationID, 0) = 0 
	BEGIN
		select "importing", @orgimportID
		-- set phone type
		select @phonetypeid = 3
		
		---- Replace me with the correct OrganizationTypeName!!!
		SELECT @orgTypeID = OrganizationTypeID
		FROM OrganizationType
		WHERE UPPER(OrganizationTypeName) = UPPER('Funeral Home')
		
		-- SELECT * FROM OrganizationType
		
		
		
		-- set @counter = @counter + 1
		
		-- print @counter
		
		
		-- Phone for organization
		-- select * from phonetype
		INSERT Phone(PhoneTypeID, PhoneAreaCode, PhonePrefix, PhoneNumber) --, Unused)
		SELECT @phonetypeid, AreaCode, Prefix, DNIT --, ''
		--PhoneArea, PhonePrefix, PhoneNumber,  ''
		FROM  orgimport
		WHERE orgimportid = @orgimportID
		
		SELECT @phoneIDOrg = @@identity
		
		
		-- Organization
		INSERT Organization (OrganizationUserCode, OrganizationName, OrganizationAddress1, OrganizationAddress2, OrganizationCity, StateID, OrganizationZipCode, OrganizationTypeID,PhoneID,OrganizationTimeZone, CountyID, OrganizationNotes, Verified)
		SELECT "", OrganizationName , Address1,  Address2, City, @stateID, Zip, @orgTypeID, @phoneIDOrg, "CT", @countyID, "", '-1'
		FROM orgimport
		WHERE orgimportid = @orgimportID
	END
 -- Get the first/next record
 Fetch Next From @curSource 
 Into @orgimportID

end

-- Close and deallocate cursor
Close @curSource
Deallocate @curSource

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

