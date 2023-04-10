IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'FsbActiveCasesSelect')
	BEGIN
		PRINT 'Dropping Procedure FsbActiveCasesSelect'
		DROP Procedure FsbActiveCasesSelect
	END
GO

PRINT 'Creating Procedure FsbActiveCasesSelect'
GO

CREATE PROCEDURE dbo.FsbActiveCasesSelect
(
	@StatEmployeeId int,
	@CallId varchar(50) = null,
	@MostRecentStatus nvarchar(100) = null,
	@MinLastUpdatDate datetime = null,
	@MaxLastUpdatDate datetime = null,
	@SourceCodeName nvarchar(100) = null,
	@PatientFirst nvarchar(100) = null,
	@PatientLast nvarchar(100) = null,
	@CoordinatorFirst nvarchar(100) = null,
	@CoordinatorLast nvarchar(100) = null,
	@MostRecentComment nvarchar(100) = null,
	@PreviousCoordinatorFirst nvarchar(100) = null,
	@PreviousCoordinatorLast nvarchar(100) = null,
	@userOrganizationID INT
)
AS
/***************************************************************************************************
**	Name: FsbActiveCasesSelect
**	Desc: Update Data in table FsbCaseStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
**	4/11         jth			timer stuff and userorgid, remove selection of organizationid
**  6/11		jth				fixed to handle if asp and expiration minutes once
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
Declare @LeaseOrg int
Declare @expirationminutes int = 0
--Select @OrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeId)

IF( LEN(@CallId) = 7 AND PATINDEX('-', @CallId)=0 )
BEGIN
	SET @MinLastUpdatDate		= NULL
	SET @MaxLastUpdatDate		= NULL
	SET @MostRecentStatus			= NULL
	SET @SourceCodeName = NULL
	SET @PatientFirst = NULL
	SET @PatientLast = NULL
	SET @CoordinatorFirst = NULL
	SET @CoordinatorLast = NULL
	SET @MostRecentComment = NULL
	SET @PreviousCoordinatorFirst = NULL
	SET @PreviousCoordinatorLast = NULL
END
IF(@userOrganizationID=194 )
	BEGIN
		SET @LeaseOrg = NULL
	END
IF(@userOrganizationID<>194 )
	BEGIN
		SET @LeaseOrg = @userOrganizationID
	END
SELECT TOP 1 @expirationminutes = [expirationminutes]  FROM OrganizationDashBoardTimer where DashBoardWindowId=5 and DashBoardTimerTypeID = 5 and OrganizationID = @userOrganizationID 
SELECT
c.CallId,
recentFcs.LastModified,
sc.SourceCodeName,
r.ReferralDonorFirstName AS PatientFirst,
r.ReferralDonorLastName AS PatientLast,
seRecent.PersonFirst AS CoordinatorFirst,
seRecent.PersonLast AS CoordinatorLast,
FsbStatus.FieldValue AS MostRecentStatus,
recentFcs.Comment AS MostRecentComment,
sePrev.PersonFirst AS PreviousCoordinatorFirst,
sePrev.PersonLast AS PreviousCoordinatorLast,
FsbStatusColor.FieldValue AS Color,
--CallList.IsAspLeaseOrganization,
Person.OrganizationID,
@expirationminutes as expirationminutes
FROM dbo.Referral r
	INNER JOIN dbo.Call c ON r.CallId = c.CallId
	--INNER JOIN dbo.GetCallIdByOrganizationId(@userOrganizationID) CallList ON c.CallId = CallList.CallId
	INNER JOIN dbo.SourceCode sc ON c.SourceCodeId = sc.SourceCodeId
	INNER JOIN FsbCaseStatus recentFcs ON 
		(
			recentFcs.CallId = c.CallId
			AND recentFcs.LastModified = (Select Max(LastModified) From FsbCaseStatus Where CallId = c.CallId)
		)
	LEFT JOIN Person seRecent ON recentFcs.FamilyServicesCoordinatorId = seRecent.PersonId
	LEFT JOIN ListFsbStatus FsbStatus ON recentFcs.ListFsbStatusId = FsbStatus.ListFsbStatusId
	LEFT JOIN ListFsbStatusColor FsbStatusColor ON FsbStatus.ListFsbStatusColorId = FsbStatusColor.ListFsbStatusColorId

	-- Get the previous user ingormation	
	LEFT JOIN FsbCaseStatus recentFcsPrev ON 
		(
			recentFcsPrev.CallId = c.CallId
			AND recentFcsPrev.LastModified = 
				(
					Select Max(LastModified) 
					From FsbCaseStatus 
					Where CallId = c.CallId
						AND FsbCaseStatusId != recentFcs.FsbCaseStatusId
				)
		)
	LEFT JOIN Person sePrev ON recentFcsPrev.FamilyServicesCoordinatorId = sePrev.PersonId
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = C.StatEmployeeID 
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID 
WHERE
	((@MostRecentStatus IS NULL AND FsbStatus.FieldValue != 'Closed') OR FsbStatus.FieldValue LIKE @MostRecentStatus + '%')
	
	and (@CallId IS NULL OR c.CallId like @CallId + '%')
	AND (@MinLastUpdatDate IS NULL OR recentFcs.LastModified > @MinLastUpdatDate)
	AND (@MaxLastUpdatDate IS NULL OR recentFcs.LastModified < @MaxLastUpdatDate)
	AND ISNULL(PATINDEX(@SourceCodeName+ '%',ISNULL(sc.SourceCodeName, 0)), -1) <> 0
	AND ISNULL(PATINDEX(@PatientFirst+ '%',ISNULL(r.ReferralDonorFirstName, 0)), -1) <> 0
	AND ISNULL(PATINDEX(@PatientLast+ '%',ISNULL(r.ReferralDonorLastName, 0)), -1) <> 0
	AND ISNULL(PATINDEX(@CoordinatorFirst+ '%',ISNULL(seRecent.PersonFirst, 0)), -1) <> 0
	AND ISNULL(PATINDEX(@CoordinatorLast+ '%',ISNULL(seRecent.PersonLast, 0)), -1) <> 0
	AND ISNULL(PATINDEX(@MostRecentComment+ '%',ISNULL(recentFcs.Comment, 0)), -1) <> 0
	AND ISNULL(PATINDEX(@PreviousCoordinatorFirst+ '%',ISNULL(sePrev.PersonFirst, 0)), -1) <> 0
	AND ISNULL(PATINDEX(@PreviousCoordinatorLast+ '%',ISNULL(sePrev.PersonLast, 0)), -1) <> 0
	AND person.organizationid = ISNULL(@LeaseOrg, person.organizationid)
ORDER BY recentFcs.LastModified
GO

GRANT EXEC ON FsbActiveCasesSelect TO PUBLIC
GO
