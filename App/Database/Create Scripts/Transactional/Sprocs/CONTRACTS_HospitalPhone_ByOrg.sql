SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_HospitalPhone_ByOrg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_HospitalPhone_ByOrg]
GO


CREATE PROCEDURE CONTRACTS_HospitalPhone_ByOrg @OrganizationID VARCHAR(255) AS
IF LTRIM(RTRIM(@OrganizationID)) = '*' SELECT @OrganizationID = '%'
SELECT DISTINCT o.OrganizationID, o.OrganizationName, ot.OrganizationTypeName,
                ('(' + ISNULL(p.PhoneAreaCode,'') + ') ' + ISNULL(p.PhonePrefix,'') + '-' + ISNULL(p.PhoneNumber,'') + '  ' + ISNULL(p.PhonePIN,'')) as MainNumber, 
                ('(' + ISNULL(Phone.PhoneAreaCode,'') + ') ' + ISNULL(Phone.PhonePrefix,'') + '-' + ISNULL(Phone.PhoneNumber,'') + '  ' + ISNULL(Phone.PhonePIN,'')) as PhoneNumber, 
                ISNULL(SubLocation.SubLocationName + ' ' + SubLocationLevel.SubLocationLevelName,'') as PhoneSub 
FROM Phone 
JOIN ((Referral LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID) LEFT JOIN SubLocationLevel ON Referral.ReferralCallerLevelID = SubLocationLevel.SubLocationLevelID) ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
JOIN Organization o ON o.OrganizationID = Referral.ReferralCallerOrganizationID
JOIN Phone p ON p.PhoneID = o.PhoneID
JOIN OrganizationType ot ON ot.OrganizationTypeID = o.OrganizationTypeID
WHERE o.OrganizationID LIKE @OrganizationID
ORDER BY o.OrganizationName, PhoneNumber, PhoneSub


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

