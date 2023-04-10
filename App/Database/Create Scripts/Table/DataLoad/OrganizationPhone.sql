 /***************************************************************************************************
**	Name: OrganizationPhone
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation 
***************************************************************************************************/

IF(DB_NAME() NOT LIKE '%Archive%' AND DB_NAME() NOT LIKE '%AuditTrail%'  )
BEGIN

	--- INSERT OrganizationPhone from Organization Table. 
	INSERT 
		OrganizationPhone (OrganizationID, PhoneID, LastModified, LastStatEmployeeId, AuditLogTypeId, SubLocationID, SubLocationLevelID,	Inactive)
		SELECT OrganizationID, Organization.PhoneID, GETDATE(), 45, 1, 60, NULL,	0
		FROM Organization
		JOIN Phone on Organization.PhoneID = Phone.PhoneID
		WHERE NOT EXISTS(SELECT OrganizationID FROM OrganizationPhone existsTable WHERE existsTable.OrganizationID = Organization.OrganizationID AND existsTable.PhoneID = Organization.PhoneID and existsTable.SubLocationID = 60)
		AND Organization.PhoneID IS NOT NULL
		and Phone.PhoneAreaCode like '[0-9][0-9][0-9]'
		and Phone.PhonePrefix like '[0-9][0-9][0-9]'
		and Phone.PhoneNumber like '[0-9][0-9][0-9][0-9]'
		and Phone.PhoneAreaCode <> '000'
		and Phone.PhonePrefix <> '000' 
		and Phone.PhoneNumber <> '0000'


	DECLARE @callBackList TABLE
	(
		PhoneID int, 
		OrganizationID int
	)
	DECLARE
		@PhoneID INT, 
		@OrganizationID INT,
		@Phone VARCHAR(20)
		
	INSERT @callBackList 
	SELECT PhoneID, OrganizationID 
	FROM CallBack

	while exists (select * from @callBackList)
	begin
		SELECT TOP 1 
		@PhoneID		= cbl.PhoneID, 
		@OrganizationID = cbl.OrganizationID,
		@Phone = '(' + COALESCE(Phone.PhoneAreaCode, '' ) + ') ' + COALESCE(Phone.PhonePrefix, '') + ' - ' + COALESCE(Phone.PhoneNumber,  '')
		
		FROM @callBackList cbl
		JOIN Phone on cbl.phoneID = Phone.PhoneID
		
		if not exists(
		select * from OrganizationPhone
		join Phone on OrganizationPhone.PhoneID = Phone.PhoneID
		where Phone.PhoneTypeID = 12
		and OrganizationPhone.OrganizationID = @OrganizationID)
		BEGIN
			UPDATE Phone
			SET PhoneTypeID = 12
			WHERE PhoneID = @PhoneID
			
			EXEC OrganizationPhoneInsert
				@OrganizationPhoneID = null,
				@OrganizationID = @OrganizationID,
				@PhoneID = @PhoneID, 
				@Phone = @Phone,
				@PhoneTypeID = 12,
				@PhoneType = NULL,
				@LastModified = NULL,
				@LastStatEmployeeId = 45,
				@AuditLogTypeId = 1,
				@SubLocationID= NULL,
				@SubLocation = NULL,
				@SubLocationLevelID = NULL,
				@SubLocationLevel = NULL,
				@Inactive = 0
		
		END
		
		DELETE @callBackList
		WHERE 
		@PhoneID		= PhoneID
		and
		@OrganizationID = OrganizationID

	end
END

--select Phone.* from CallBack
--join Phone on CallBack.PhoneID = Phone.PhoneID

-- select TOP 100 * from Phone ORDER BY 1 DESC

 --select * from OrganizationPhone
	--join Phone on OrganizationPhone.PhoneID = Phone.PhoneID
	--where Phone.PhoneTypeID = 12 
	