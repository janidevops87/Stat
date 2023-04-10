IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_AdmitToReferral180')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_AdmitToReferral180';
	DROP PROCEDURE sps_rpt_AdmitToReferral180;
END
GO

PRINT 'Creating Procedure sps_rpt_AdmitToReferral180';
GO
CREATE PROCEDURE [dbo].[sps_rpt_AdmitToReferral180]
(
	@DaysBack		int = 7,
	@DayDif			int = 180,
	@SourceCodeName	varchar(10) = NULL
)
AS

/******************************************************************************
**		File: sps_rpt_AdmitToReferral180.sql
**		Name: sps_rpt_AdmitToReferral180
**		Desc: This sproc is used for QA review process
**
**		Return values:
** 
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			-------------------------------------------
**  07/01/2021		James Gerberich		Initial release
**	06/21/2022		James Gerberich		Allow for variable Source Code and Day Dif
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

DECLARE @StartDate	datetime = DATEADD(dd, -1 * @DaysBack, GETDATE());

With Referrals AS
(
	SELECT
		c.CallID AS ReferralNumber,
		r.ReferralDonorAdmitDate AS AdmitDate,
		c.CallDateTime AS ReferralDate,
		DATEDIFF(dd, r.ReferralDonorAdmitDate, CAST(c.CallDateTime AS date)) AS DayDif,
		sc.SourceCodeName AS SourceCode,
		refFac.OrganizationName AS ReferralFacility
	FROM
		[Call] c
		INNER JOIN Referral r ON c.CallID = r.CallID
		INNER JOIN SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
		INNER JOIN Organization refFac ON r.ReferralCallerOrganizationID = refFac.OrganizationID
	WHERE
		c.CallDateTime >= @StartDate
	AND	(
			@SourceCodeName IS NULL
		OR	sc.SourceCodeName = @SourceCodeName
		)
)

SELECT *
FROM Referrals
WHERE DayDif >= @DayDif;

GO

GRANT EXEC ON sps_rpt_AdmitToReferral180 TO PUBLIC;
GO