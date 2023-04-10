

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_GetWebPersonByUserName')
	BEGIN
		PRINT 'Dropping Procedure sps_GetWebPersonByUserName'
		DROP Procedure sps_GetWebPersonByUserName
	END
GO

PRINT 'Creating Procedure sps_GetWebPersonByUserName'
GO




CREATE PROCEDURE dbo.sps_GetWebPersonByUserName
	@UserName nvarchar(25)
AS

/******************************************************************************
**	File: sps_GetWebPersonByUserName.sql
**	Name: sps_GetWebPersonByUserName
**	Desc: Pulls webperson data by username.
**	Auth: Pam Scheichenost
**	Date: 10/30/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	10/30/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/
DECLARE
	@UserOrganizationId int,
	@ScheduleEditRoleId int = 18,
	@AdminRoleId int = 2;

DECLARE @UserData TABLE
(
	WebPersonId int,
	WebPersonUserName varchar(15),
	PersonID int,
	WebPersonPassword varchar(20),
	UnusedField1 int,
	LastModified datetime,
	WebPersonSessionCounter int,
	UnusedField2 int,
	WebPersonLastSessionAccess smalldatetime,
	WebPersonEmail varchar(100),
	UpdatedFlag smallint,
	WebPersonUserAgent varchar(100),
	Access int,
	LastStatEmployeeID int,
	AuditLogTypeID int,
	SaltValue varchar(100),
	HashedPassword varchar(50),
	InternalSessionID uniqueidentifier,
	PasswordExpiration datetime,
	PersonFirst varchar(50), 
	PersonLast varchar(50), 
	Email varchar(100),
	UserOrganizationId int,
	DefaultReportGroupId int,
	TimeZone varchar(3),
	CanSchedule int,
	StatEmployeeID int
)
INSERT INTO @UserData
(
	WebPersonId,
	WebPersonUserName,
	PersonID,
	WebPersonPassword,
	UnusedField1,
	LastModified,
	WebPersonSessionCounter,
	UnusedField2,
	WebPersonLastSessionAccess,
	WebPersonEmail,
	UpdatedFlag,
	WebPersonUserAgent,
	Access,
	LastStatEmployeeID,
	AuditLogTypeID,
	SaltValue,
	HashedPassword,
	InternalSessionID,
	PasswordExpiration,
	PersonFirst, 
	PersonLast, 
	Email,
	UserOrganizationId,
	TimeZone,
	CanSchedule,
	StatEmployeeID
)
SELECT TOP(1) w.WebPersonId,
	w.WebPersonUserName,
	w.PersonID,
	w.WebPersonPassword,
	w.UnusedField1,
	w.LastModified,
	w.WebPersonSessionCounter,
	w.UnusedField2,
	w.WebPersonLastSessionAccess,
	w.WebPersonEmail,
	w.UpdatedFlag,
	w.WebPersonUserAgent,
	w.Access,
	w.LastStatEmployeeID,
	w.AuditLogTypeID,
	w.SaltValue,
	w.HashedPassword,
	w.InternalSessionID,
	w.PasswordExpiration,
	p.PersonFirst, 
	p.PersonLast, 
	pp.PhoneAlphaPagerEmail AS Email,
	p.OrganizationId AS UserOrganizationId,
	t.TimeZoneAbbreviation As TimeZone,
	CASE WHEN ur.WebPersonID IS NULL THEN 0 ELSE 1 END AS CanSchedule,
	s.StatEmployeeID

FROM dbo.WebPerson w
INNER JOIN dbo.Person p ON p.PersonId = w.PersonId and p.Inactive = 0
INNER JOIN dbo.Organization o ON o.OrganizationID = p.OrganizationID
LEFT JOIN dbo.TimeZone t ON t.TimeZoneId = o.TimeZoneId
LEFT JOIN dbo.StatEmployee s ON s.PersonID = p.PersonID
LEFT JOIN dbo.UserRoles ur ON ur.WebPersonId = w.WebPersonId and ur.RoleID IN (@ScheduleEditRoleId, @AdminRoleId)
LEFT JOIN PersonPhone pp
	INNER JOIN Phone ph ON pp.PhoneID = ph.PhoneID AND ph.PhoneTypeID = 11
ON p.PersonID = pp.PersonID
WHERE w.WebPersonUserName=@UserName
ORDER BY pp.PersonPhoneID DESC;

SELECT
	@UserOrganizationId = UserOrganizationId
FROM @UserData;

declare @PersonId int;
declare @StatEmployeeID int;
SELECT TOP(1) @PersonId = PersonId
FROM @UserData;

IF (NOT EXISTS(SELECT * FROM @UserData WHERE StatEmployeeID IS NOT NULL))
BEGIN
EXEC dbo.StatEmployeeInsert @PersonId = @PersonId, @StatEmployeeID = @StatEmployeeID OUTPUT;
UPDATE @UserData SET StatEmployeeID = @StatEmployeeID;
END

--Get default report group
IF	@UserOrganizationId = 194
BEGIN
	UPDATE @UserData
	SET DefaultReportGroupId =	WebReportGroupID 
	FROM		WebReportGroup
	WHERE 	OrgHierarchyParentID = @UserOrganizationId
	AND WebReportGroupName = 'Statline- All Referrals (Triage & FS)';
END
	
ELSE
BEGIN
	UPDATE @UserData
	SET	DefaultReportGroupId = WebReportGroupID
	FROM		WebReportGroup
	WHERE 	OrgHierarchyParentID = @UserOrganizationId
	AND WebReportGroupname = 'All Referrals';
	--there are a few clients where they are messages only
	IF ((SELECT DefaultReportGroupId FROM @UserData) IS NULL)
	BEGIN
		UPDATE @UserData
		SET	DefaultReportGroupId = WebReportGroupID
		FROM		WebReportGroup
		WHERE 	OrgHierarchyParentID = @UserOrganizationId
		AND WebReportGroupname = 'All Messages';
	END
END

SELECT
	WebPersonId,
	WebPersonUserName,
	PersonID,
	WebPersonPassword,
	UnusedField1,
	LastModified,
	WebPersonSessionCounter,
	UnusedField2,
	WebPersonLastSessionAccess,
	WebPersonEmail,
	UpdatedFlag,
	WebPersonUserAgent,
	Access,
	LastStatEmployeeID,
	AuditLogTypeID,
	SaltValue,
	HashedPassword ,
	InternalSessionID ,
	PasswordExpiration ,
	PersonFirst, 
	PersonLast , 
	Email ,
	UserOrganizationId ,
	DefaultReportGroupId,
	TimeZone,
	CanSchedule,
	StatEmployeeID
FROM @UserData;

GO

GRANT EXEC ON sps_GetWebPersonByUserName TO PUBLIC
GO

