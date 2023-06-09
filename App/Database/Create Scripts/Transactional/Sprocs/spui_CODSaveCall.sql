SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_CODSaveCall]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_CODSaveCall]
GO


CREATE PROCEDURE spui_CODSaveCall 
	(@callId int = 0,
	@fName varchar(50) = NULL,
	@lName varchar(50) = NULL,
	@addr1 varchar(80) = NULL,
	@addr2 varchar(80) = NULL,
	@city varchar(30) = NULL,
	@stateId int = 0,
	@zip varchar(5) = NULL,
	@phone varchar(20) = NULL,
	@adMethod int = 0,
	@questions int = 0,
	@newQuestion varchar(255) = NULL,
	@VM smallint = 0)

/*
   Sproc to insert or update a CODCall record with all information collected by the 
   web page COD_Call_Track.sls.
   Created 3/31/05 by Scott Plummer
*/

AS

SET NOCOUNT ON

DECLARE @coalitionOrgId int,
	@exists int,
	@labelStatus int,
	@testState int,
	@sMsg varchar(1000),
	@sLocalCoalition varchar(1000)

SET @sMsg = ''  -- Initialize user info message

SET @labelStatus = 0  -- Initialize
-- Set @labelStatus to 1 if there is enough mailing info to send a label
IF Len(@fName) > 0 AND Len(@lName) > 0 AND Len(@addr1) > 0 AND Len(@city) > 0 AND @stateId > 0 AND Len(@zip) > 0
	BEGIN
		SET @labelStatus = 1
	END

-- Clean variables, inserting NULLs instead of zero-length strings to mimic behavior of StatTrac
IF Len(@fName) = 0 
	SET @fName = NULL;
IF Len(@lName) = 0
	SET @lName = NULL;
IF Len(@addr1) = 0
	SET @addr1 = NULL;
IF Len(@addr2) = 0
	SET @addr2  = NULL;
IF Len(@city) = 0
	SET @city = NULL;
IF @stateId = 0
	SET @stateId = -1;
IF Len(@zip) = 0
	SET @zip = NULL;
IF Len(@phone) = 0
	SET @phone = NULL;


-- Code borrowed from sps_COD_GetCoalition to get OrgId of nearest coalition
SET @coalitionOrgId = NULL  -- Initialize
SET @coalitionOrgId = (SELECT DISTINCT Organization.OrganizationID  
			FROM Zip
			LEFT JOIN CODMap ON CODMap.CountyFIPS = Zip.ZipCountyFIPS AND CODMap.StateID = Zip.StateID
			LEFT JOIN Organization ON Organization.OrganizationID = CODMap.OrganizationID
			LEFT JOIN State ON State.StateID = CODMap.StateID
			WHERE Zip.Zip = @zip);

-- Make sure correct state code is used, otherwise tell user
IF Len(@zip) > 0
	BEGIN
		SET @testState = 0
		SET @testState = (SELECT DISTINCT StateId FROM Zip WHERE Zip.Zip = @zip);
		IF @testState > 0 AND @testState <> @stateId 
			BEGIN
				-- Reset @stateId and give user message
				SET @stateId = @testState
				SET @sMsg = @sMsg + 'State corrected for zip ' + CAST(@zip AS VARCHAR) + '.<br>'
			END
	
		-- Now, get the local coalition
		DECLARE @personTypeID int

		SET @personTypeID = (SELECT PersonTypeID FROM PersonType WHERE PersonTypeName = 'Coalition Contact')

		-- We want a record returned if the zip code exists, but it doesn't have a mapping, therefore, we use LEFT joins
		-- This code pirated from sps_COD_GetCoalition, except it returns an HTML-formatted string.

		SET @sLocalCoalition = (SELECT DISTINCT '<b>(' + Phone.PhoneAreaCode + ') ' + Phone.PhonePrefix + '-' + Phone.PhoneNumber + '</b><br>' +
					Person.PersonFirst + ' ' + Person.PersonLast + '<br>' +
					Organization.OrganizationName + '<br>' +
					Zip.ZipCityUSPSPreferred + ', ' + State.StateName
				FROM Zip
				LEFT JOIN CODMap ON CODMap.CountyFIPS = Zip.ZipCountyFIPS AND CODMap.StateID = Zip.StateID
				LEFT JOIN Organization ON Organization.OrganizationID = CODMap.OrganizationID
				LEFT JOIN Person ON Person.OrganizationID = CODMap.OrganizationID and Person.PersonTypeID = @personTypeID
				LEFT JOIN PersonPhone ON PersonPhone.PersonID = Person.PersonID
				LEFT JOIN Phone ON Phone.PhoneID = PersonPhone.PhoneID
				LEFT JOIN State ON State.StateID = CODMap.StateID
				WHERE Zip.Zip = @zip);

	END

SET @exists = (SELECT Count(*) FROM CODCaller WHERE CallID = @callId);

-- If this is a new CallId, insert a new record in CODCaller
IF @exists = 0
	BEGIN
		INSERT INTO CODCaller (CallId, CODCallerFirst, CODCallerLast, 
			CODCallerAddress1, CODCallerAddress2, 
			CODCallerCity, StateID, CODCallerZip, OrganizationID, CODCallerPhone, 
			CODCallerLabelStatus, CODCallPassToCoalition, 
			CODAdMethod, CODQuestions, CODCallerVM, LastModified)
		VALUES  (@callId, @fName, @lName,
			@addr1, @addr2, 
			@city, @stateId, @zip, @coalitionOrgId, @phone,
			@labelStatus, NULL,
			@adMethod, @questions, @VM, GetDate());
	END
ELSE  -- It already exists, update it
	BEGIN
		UPDATE CODCaller 
			SET CODCallerFirst = @fName, 
			CODCallerLast = @lName, 
			CODCallerAddress1 = @addr1, 
			CODCallerAddress2 = @addr2, 
			CODCallerCity = @city, 
			StateID = @stateId, 
			CODCallerZip = @zip, 
			OrganizationID = @coalitionOrgId, 
			CODCallerPhone = @phone, 
			CODCallerLabelStatus = @labelStatus, 
			CODAdMethod = @adMethod, 
			CODQuestions = @questions, 
			CODCallerVM = @VM, 
			LastModified = GetDate()
		WHERE CallId = @callId;
	END

-- If a new question was entered, record it.  
-- This should only be recorded when the question is first passed, not updated with each call to sproc.
IF Len(@newQuestion) > 0 
	BEGIN
		INSERT INTO CODQuestionLog 
			(CallID, CODQuestionsID, CODQuestionLogQuestionText) 
		VALUES (@callId, 8, @newQuestion);
	END

-- Now, select the CODCall values for display availability

SELECT CC.CODCallerFirst, CC.CODCallerLast, CC.CODCallerAddress1, CC.CODCallerAddress2,
	CC.CODCallerCity, CC.StateID, CC.CODCallerZip, CC.OrganizationID,
	CC.CODCallerPhone, CC.CODCallerLabelStatus, CC.CODAdMethod, CC.CODQuestions,
	@sMsg AS Message, @sLocalCoalition AS LocalCoalition
FROM CODCaller CC 
WHERE CC.CallId = @callId;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

