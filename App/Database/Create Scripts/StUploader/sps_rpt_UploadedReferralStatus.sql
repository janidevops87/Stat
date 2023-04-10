IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_UploadedReferralStatus')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_UploadedReferralStatus';
	DROP PROCEDURE sps_rpt_UploadedReferralStatus;
END
GO

PRINT 'Creating Procedure sps_rpt_UploadedReferralStatus';
GO
CREATE PROCEDURE [dbo].sps_rpt_UploadedReferralStatus
(
	@StartDate	datetime,
	@EndDate	datetime,
	@StatusId	int,
	@SourceCode	varchar(10),
	@LastName	varchar(80),
	@SexId		int,
	@FileName	varchar(max)
)
AS

/******************************************************************************
**		File: sps_rpt_UploadedReferralStatus.sql
**		Name: sps_rpt_UploadedReferralStatus
**
**		Auth: James Gerberich
**		Date: 04/05/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-----------------------------------
**      04/05/2021		James Gerberich		Initial release
**		08/23/2021		Mike Berenson		Added cast of AddedToSystemOn to DateTime before comparing
******************************************************************************/

DROP TABLE IF EXISTS #ConvertedUploads;

--Create Adjusted Start/End DateTimes
DECLARE	
	@AdjustedStartDateTime	SMALLDATETIME	= DATEADD(D, -1, @StartDate),
	@AdjustedEndDateTime	SMALLDATETIME	= DATEADD(D, +1, @EndDate);

--Build reference tables
DECLARE @ProcessingStatus TABLE
(
	Id			int,
	[Status]	varchar(10)
);
INSERT @ProcessingStatus
	SELECT 0, 'Pending' UNION
	SELECT 1, 'Success' UNION
	SELECT 2, 'Failure';
--------------------------------

DECLARE @Gender TABLE
(
	Id		int,
	Gender	varchar(10)
);
INSERT @Gender
	SELECT 1, 'Male' UNION
	SELECT 2, 'Female';
----------------------------------------------------------------

--Load #ConvertedUploads with data including converted AddedToSystemOnDate
SELECT
    upld.Id,
    upld.SourceFileName,
    upld.ProcessingStatus_Status AS StatusId, -- 0=Pending, 1=Success, 2=Failure
	prcSts.[Status] AS ProcessingStatus,
    upld.ProcessingStatus_ErrorMessage AS ErrorMessage,
    upld.AddedToSystemOn,
	CAST(upld.AddedToSystemOn AS DATETIME) AS 'AddedToSystemOnDateTime' ,
    upld.Referral_CallerSourceCode AS SourceCode,
    upld.Referral_CallReceivedOn AS CallReceivedOn,
    upld.Referral_DonorPerson_DateOfBirth AS DateOfBirth,
    upld.Referral_DonorPerson_Gender AS GenderId, -- 1=Male, 2=Female
	sex.Gender AS Sex,
    upld.Referral_DonorPerson_Name_FirstName AS FirstName,
    upld.Referral_DonorPerson_Name_LastName AS LastName,
    upld.Referral_ReferralNumer AS ReferralNumber
INTO #ConvertedUploads
FROM
	ReferralUploads upld
	LEFT JOIN @ProcessingStatus prcSts ON upld.ProcessingStatus_Status = prcSts.Id
	LEFT JOIN @Gender sex ON upld.Referral_DonorPerson_Gender = sex.Id
WHERE
	(
		upld.AddedToSystemOn >= @AdjustedStartDateTime
	AND	upld.AddedToSystemOn <= @AdjustedEndDateTime
	)
AND	(
		@StatusId IS NULL
	OR	upld.ProcessingStatus_Status = @StatusId
	)
AND	(
		@SourceCode IS NULL
	OR	upld.Referral_CallerSourceCode = @SourceCode
	)
AND	(
		@SexId IS NULL
	OR	upld.Referral_DonorPerson_Gender = @SexId
	)
AND	(
		@LastName IS NULL
	OR	PATINDEX('%' + @LastName + '%', upld.Referral_DonorPerson_Name_LastName) > 0
	)
AND	(
		@FileName IS NULL
	OR	PATINDEX('%' + @FileName + '%', upld.SourceFileName) > 0
	);

SELECT *
FROM #ConvertedUploads
WHERE 
		AddedToSystemOnDateTime >= @StartDate
	AND	AddedToSystemOnDateTime <= @EndDate;

DROP TABLE IF EXISTS #ConvertedUploads;

