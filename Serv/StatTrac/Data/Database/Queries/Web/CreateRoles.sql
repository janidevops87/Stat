DECLARE 
	@loopCount int, 
	@loopMax int,
	@RoleName varchar(250),
	@nothing varchar(50)

declare 
	
	@RoleDescription	nvarchar(250)
	,@LastStatEmployeeID	int
	,@AuditLogTypeID	int
	,@Inactive	int
	,@roleID int
DECLARE @RoleList TABLE
	(
		ID INT IDENTITY(1,1),
		RoleName varchar(250),
		nothing varchar(50)
		
	
	)
	
INSERT @RoleList
VALUES('Update Referral', '')
INSERT @RoleList
VALUES('Update Event Log', '')
INSERT @RoleList
VALUES('Update Schedule Shift', '')
INSERT @RoleList
VALUES('Create Schedule Shift', '')
INSERT @RoleList
VALUES('Delete Schedule Shift', '')
INSERT @RoleList
VALUES('Referral Facility Compliance', '')


DECLARE 
	@loopCount2 int, 
	@loopMax2 int,
	@webPersonID int,
	@webPersonName varchar(100)
DECLARE @webpersonList TABLE
	(
		ID INT IDENTITY(1,1),
		webPersonID int,
		webPersonName varchar(100)
		
	
	)
INSERT @webpersonList
VALUES(5012, 'lmdagostino')

INSERT @webpersonList
VALUES(6224, 'lmdagostino1')

INSERT @webpersonList
VALUES(3195, 'scwells')

INSERT @webpersonList
VALUES(296, 'bret')

INSERT @webpersonList
VALUES(296, 'bret')

INSERT @webpersonList
VALUES(5383, 'ccarroll')

INSERT @webpersonList
VALUES(7283, 'jhawkins')

SELECT @loopCount = MIN(ID), @loopMax = MAX(ID) FROM @RoleList

WHILE (@loopCount <= @loopMax)
BEGIN

	set @roleID = 0


	SELECT 
		@RoleName = RoleName,
		@nothing = nothing
	FROM 
		@RoleList
	WHERE
		ID = @loopCount

SET @RoleDescription = ''
SET @LastStatEmployeeID = 45 --- BRET
SET @AuditLogTypeID = 1
SET @Inactive = 0
-- if roles does not exist insert

select @roleID = RoleID from roles where RoleName = @RoleName
print @RoleName
print @roleID

if (isnull(@roleID, 0) < 1 )
begin
	print 'running insertroles'

	EXEC dbo.InsertRoles
		@Rolename
		,@RoleDescription
		,@LastStatEmployeeID
		,@AuditLogTypeID
		,@Inactive

	select @roleID = RoleID from roles where RoleName = @RoleName

	print 'RoleID'
	print @roleID
end
if(isnull(@RoleID, 0) > 0)
begin
	SELECT @loopCount2 = MIN(ID), @loopMax2 = MAX(ID) FROM @webpersonList

	WHILE (@loopCount2 <= @loopMax2)
	BEGIN

		SELECT 
			@webPersonID = webPersonID,
			@webPersonName = webPersonName
		FROM 
			@webpersonList
		WHERE
			ID = @loopCount2
		if not exists(select * from userroles where webPersonID = @webPersonID and RoleID = @roleID)
		begin
			exec dbo.InsertUserRoles
				@webPersonID
				, @roleID
				, @LastStatEmployeeID
				, @AuditLogTypeID
	
		end
		
		SET @loopCount2 = @loopCount2 + 1
	END
end
-- select * from userroles
-- SP_HELP InsertRoles
-- select * from roles
-- SELECT * FROM STATEMPLOYEE	WHERE STATEMPLOYEELASTNAME LIKE 'KNOLL'
	SET @loopCount = @loopCount + 1
END
