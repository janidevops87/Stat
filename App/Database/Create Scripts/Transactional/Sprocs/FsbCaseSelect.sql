IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'FsbCaseSelect')
	BEGIN
		PRINT 'Dropping Procedure FsbCaseSelect'
		DROP Procedure FsbCaseSelect
	END
GO

PRINT 'Creating Procedure FsbCaseSelect'
GO

CREATE PROCEDURE dbo.FsbCaseSelect
(
	@CallId int
)
AS
/***************************************************************************************************
**	Name: FsbCaseSelect
**	Desc: Select Data from table FsbCaseStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT
c.CallId,
sc.SourceCodeName,
r.ReferralDonorFirstName AS PatientFirst,
r.ReferralDonorLastName AS PatientLast,
ISNULL(se.StatEmployeeFirstName + ' ','') + ISNULL(se.StatEmployeeLastName, '') AS CreatedUser,
--ISNULL(originalFcs.LastModified, getdate()) AS CreatedDate
ISNULL(originalFcs.LastModified, getdate()) AS LastModified
FROM dbo.Referral r
	INNER JOIN dbo.Call c ON r.CallId = c.CallId
	INNER JOIN dbo.SourceCode sc ON c.SourceCodeId = sc.SourceCodeId
	LEFT JOIN FsbCaseStatus originalFcs ON 
		(
			originalFcs.CallId = c.CallId
			AND originalFcs.LastModified = (Select Min(LastModified) From FsbCaseStatus Where CallId = c.CallId)
		)
	LEFT JOIN StatEmployee se ON originalFcs.LastStatEmployeeId = se.StatEmployeeId
WHERE
	c.CallId = @CallId
GO

GRANT EXEC ON FsbCaseSelect TO PUBLIC
GO
