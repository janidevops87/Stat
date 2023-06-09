SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracReferralFSMedications]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_DonorTracReferralFSMedications]'
	drop procedure [dbo].[sps_DonorTracReferralFSMedications]
END
PRINT 'Creating procedure [sps_DonorTracReferralFSMedications]'

GO

CREATE PROCEDURE sps_DonorTracReferralFSMedications   

		@vUserName as varchar(50),
		@vPassWord as varchar(50),
		@CallID as int
AS
/******************************************************************************
**		File: sps_DonorTracReferralFSMedications.sql
**		Name: sps_DonorTracReferralFSMedications
**		Desc: Provides the detail information for a FS Referral 
**
**              
**		Return values: returns the inserted record
**		
** 
**		Called by:   Statline.StatInfo
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Thien Ta
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		05/01/05	Thien Ta			initial
**		03/18/09	Bret Knoll			Modified what report group dtmtf uses
**		07/20/18	Ilya Osipov			Added HashedPassword code
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*********************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	declare
		@SourcecodeID as varchar(10),
		@WebReportID as varchar(10),
		@vOrgID as int,
		@vSourceCode as int,
		@vReportGroupID as int,
		@vSourceCodeName as varchar(10),
		@vSourceCodeIDRef as int,
		@webReportGroupName varchar(100),
		@TargetHashedPassword VARCHAR(100);

	SELECT @TargetHashedPassword =  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassWord+ CONVERT(VARCHAR(100),[SaltValue])), 2)
		FROM [dbo].[WebPerson]
		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
		WHERE [WebPersonUserName] = @vUserName 
		AND 	Person.Inactive <> 1;

/* 6/30/08 

	for any client where a sourcecode should not be pulled have clients services create a 
	"DTStatTrac Imports" web report group.
	
	Add an IF statement to check for the @vUserName and add the DTClient user to the in statement
*/
	IF (@vUserName IN( 'DTMTF'))
	BEGIN
		SET @webReportGroupName = 'DTStatTrac Imports'
	END
	ELSE
	BEGIN
		SET @webReportGroupName = 'All Referrals'
	END
	
/* End 6/30/08 Section */
--AS
 
--set @PreviousDay = '12/31/2004'
--set @CurrentDay = '01/01/2005'

--set @vUserName = 'Testdo'
--set @vPassWord = 'Testdo'

--Get OrganizationID
SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	HashedPassword = @TargetHashedPassword
Print @vOrgID

--Get SourceCode
--select   @vSourceCode = Sourcecode.SourceCodeID from sourcecodeorganization JOIN SourceCode 
--ON SourceCode.SourceCodeID = SourceCodeORganization.SourceCodeID where organizationID = @vOrgID
select   @vSourceCode = SourcecodeID from sourceCodeOrganization where OrganizationID = @vOrgID
Print @vSourceCode

-- Get SourceCode Name
select @vSourceCodeName = SourcecodeName from Sourcecode where SourcecodeID = @vSourceCode

Print @vSourceCodeName

-- Get sourcecodeType
select  @vSourceCodeIDRef = SourcecodeID from sourcecode where sourcecodeName = @vSourceCodeName and sourcecodeType = 1

Print @vSourceCodeIDRef

--Retrieve WebReportGroup
Select @vReportGroupID = wrg.WebReportGroupID  From 
WebReportGroup wrg join webreportgroupsourcecode wrgsc on wrg.webReportGroupID = wrgsc.webReportGroupID
left join organization o on o.organizationid = wrg.OrgHierarchyParentid
where 
	WebReportGroupName = @webReportGroupName
--and wrgsc.sourceCodeID  = @vSourceCodeIDRef
and o.OrganizationID = @vOrgID

Print @vReportGroupID



SELECT DISTINCT 
MedName.MedicationName AS MedicationName, MedicationTypeUse As MedicationType, 
'' As Dose, '' As StartDate, '' As EndDate
FROM Call JOIN Referral ON Referral.CallID = Call.CallID 
LEFT JOIN SecondaryMedication on SecondaryMedication.callID = Call.CallID
LEFT JOIN Medication AS MedName ON MedName.MedicationID = secondarymedication.MedicationID 
WHERE call.CallID =  @CallID



UNION


SELECT DISTINCT SecondaryMedicationOtherName As MedicationName, 
SecondaryMedicationOtherTypeUse As MedicationType, 
SecondaryMedicationOtherDose As Dose, 
CONVERT(VARCHAR, SecondaryMedicationOtherStartDate, 101) As StartDate,
CONVERT(VARCHAR, SecondaryMedicationOtherEndDate, 101) As EndDate
FROM Call JOIN Referral ON Referral.CallID = Call.CallID 
LEFT JOIN SecondaryMedication on SecondaryMedication.callID = Call.CallID
LEFT JOIN SecondaryMedicationOther on SecondaryMedicationOther.CallID = Call.CallID 
WHERE call.CallID =  @CallID



/*

SELECT     SecondaryMedicationOther.*
FROM         Secondary INNER JOIN
                      SecondaryMedicationOther ON Secondary.CallID = SecondaryMedicationOther.CallId where Secondary.CallID = @CallID
*/



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

