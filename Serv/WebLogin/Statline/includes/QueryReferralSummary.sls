<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<%

Function GetSummaryList()

     'pvReportGroupID     int          = null,
     'pvStartDate         datetime     = null,
     'pvEndDate           datetime     = null,
     'pvOrgID             int          = null,
     'pvTZ                 varchar(2)   = null,
     'pvReferralTypeID    int          = null,
     'pvOrderBy           varchar(60)  = null,
     'pvUserOrgID	  int	       = null,
     'pvCallID            int          = null



	DIM lvQueryString
	DIM lvReferralTypeStart
	DIM lvReferralTypeEnd
	DIM lvTZ
	DIM lvSourceCodeID
	DIM lvSCIList
	DIM lvAccessOrgans
	DIM lvAccessBone
	DIM lvAccessTissue
	DIM lvAccessSkin
	DIM lvAccessValves
	DIM lvAccessEyes
	DIM lvAccessResearch
	DIM lvConn
	DIM lvRS
	DIM lvStartDate
	DIM lvEndDate
	Dim pvJoin
	Call FixQueryString(Request.QueryString("JOIN"), pvJoin)


	'' replacing connection code with set code below
    ''Set lvConn = server.CreateObject("ADODB.Connection")
	''lvConn.Open DataSourceName, DBUSER, DBPWD
	''

	Set lvConn = conn


     'Adjust start and end times for time zone
    IF pvCallID <= 0 Then

		lvTZ = ZoneDifference(pvStartDate, vTZ)

		lvStartDate = DateAdd("h", -lvTZ, pvStartDate)
		lvEndDate = DateAdd("h", -lvTZ, pvEndDate)

	Else
		lvQueryString = "SELECT CallDateTime FROM CALL WHERE CallID = " & pvCALLID
		SET lvRS = lvConn.Execute(lvQueryString)
		lvTZ = ZoneDifference(lvRS("CallDateTime"), vTZ)

		SET lvRS = NOTHING
	END IF

     ' build sourcecode list
 	    lvSCIList = ""
		'drh 09/10/03 - Removed: IF pvUserOrgID = 194 Then
		'drh 09/10/03 - Removed: 	lvQueryString = "SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode "
		'drh 09/10/03 - Removed: ELSE
			lvQueryString = "SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode WHERE WebReportGroupID = " & pvReportGroupID
		'drh 09/10/03 - Removed: END IF

		SET lvRS = lvConn.Execute(lvQueryString)

		WHILE NOT lvRS.EOF

			'SourceCodeID
			lvSCIList = lvSCIList &  RTRIM(lvRS("SourceCodeID"))

			lvRS.MoveNext

			IF NOT lvRS.EOF Then
			   lvSCIList = lvSCIList & ", "
			END IF
		WEND

		SET lvRS = NOTHING
		
		'set option access variables.
		IF pvUserOrgID <> 194 Then
			lvQueryString = "SELECT DISTINCT   AccessOrgans, AccessBone, AccessTissue, AccessSkin, AccessValves, AccessEyes, AccessResearch FROM WebReportGroupSourceCode "

			IF pvCallID > 0 Then
				lvQueryString = lvQueryString & "JOIN CALL ON Call.SourceCodeID = WebReportGroupSourceCode.SourceCodeID JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID WHERE CALLID = " & pvCallid & " AND WebReportGroup.OrgHierarchyParentID = " & pvUserOrgID
			ELSE
				lvQueryString = lvQueryString & "WHERE WebReportGroupID = " & pvReportGroupID
				'Response.Write lvQueryString
			END IF

			'Response.Write lvQueryString
			'Response.Write (pvUserOrgID & " | " & pvOrganizationID & " | " & pvReportGroupID)

			SET lvRS = lvConn.Execute(lvQueryString)

			IF NOT lvRS.EOF Then

				lvAccessOrgans = lvRS("AccessOrgans")
				lvAccessBone = lvRS("AccessBone")
				lvAccessTissue = lvRS("AccessTissue")
				lvAccessSkin = lvRS("AccessSkin")
				lvAccessValves = lvRS("AccessValves")
				lvAccessEyes = lvRS("AccessEyes")
				lvAccessResearch = lvRS("AccessResearch")

			END IF

			SET lvRS = NOTHING
		ELSE
				lvAccessOrgans = 1
				lvAccessBone = 1
				lvAccessTissue = 1
				lvAccessSkin = 1
				lvAccessValves = 1
				lvAccessEyes = 1
				lvAccessResearch = 1

		END IF
	   'BUILD query to pull referall detail data
	   lvQueryString = ""
	   lvQueryString = "SELECT DISTINCT Referral.ReferralID, Call.CallID, CallNumber, DATEADD(hour, "
	   lvQueryString = lvQueryString & lvTZ
	   lvQueryString = lvQueryString & " , CallDateTime) AS CallDateTime, CONVERT(char(8), DATEADD(hour, "
	   lvQueryString = lvQueryString & lvTZ
	   lvQueryString = lvQueryString & " , CallDateTime), 1) AS CallDate, CONVERT(char(5), DATEADD(hour, "
	   lvQueryString = lvQueryString & lvTZ
	   lvQueryString = lvQueryString & " , CallDateTime), 8) AS CallTime, ' Field 6', ' Field 7', ' Field 8', "
	   lvQueryString = lvQueryString & "' Field 9',' Field 10', Referral.ReferralTypeID, ReferralTypeName, "
	   lvQueryString = lvQueryString & "ReferralDonorLastName, ReferralDonorFirstName, OrganizationName, "
	   lvQueryString = lvQueryString & "CallerPerson.PersonFirst AS CallPersonFirst, CallerPerson.PersonLast AS CallerPersonLast, ' Field 18', "

	   lvQueryString = lvQueryString & "SubLocationName, ReferralCallerSubLocationLevel, ' Field 21', ' Field 22', "

	   lvQueryString = lvQueryString & " ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorGender, ' Field 27', "
	   lvQueryString = lvQueryString & "' Field 28', ' Field 29', ' Field 30', convert(char(8),ReferralDonorDeathDate,1),ReferralDonorDeathTime, "
	   lvQueryString = lvQueryString & "' Field 33', RaceName, CauseOfDeathName, ApproachTypeName, ApproachPerson.PersonFirst AS ApproachPersonFirst, ApproachPerson.PersonLast AS ApproachPersonLast, "
	   lvQueryString = lvQueryString & "' Field 39', ' Field 40', ' Field 41',' Field 42',' Field 43',' Field 44',' Field 45',' Field 46', "

	   'Attending.PersonFirst AS AttendingFirst, Attending.PersonLast AS AttendingLast, "
	   'lvQueryString = lvQueryString & "Pronouncing.PersonFirst AS PronouncingFirst, Pronouncing.PersonLast AS PronouncingLast, "

	     ' CHECK FOR ORGAN ACCESS
	     IF lvAccessOrgans = 1 Then

	        lvQueryString = lvQueryString & "AppropOrgan.AppropriateReportName AS AppropriateOrgan, ApproaOrgan.ApproachReportName AS ApproachOrgan, ConsentOrgan.ConsentReportName AS ConsentOrgan, RecoveryOrgan.ConversionReportName AS RecoveryOrgan, "

	     ELSE

	        lvQueryString = lvQueryString & "'' AS AppropriateOrgan, '' AS ApproachOrgan, '' AS ConsentOrgan , '' AS RecoveryOrgan, "
	     END IF
	     ' Check for bone access
	     IF lvAccessBone = 1 Then

	        lvQueryString = lvQueryString & "AppropBone.AppropriateReportName AS AppropriateBone, ApproaBone.ApproachReportName AS ApproachBone, ConsentBone.ConsentReportName AS ConsentBone, RecoveryBone.ConversionReportName AS RecoveryBone, "

	     ELSE

	        lvQueryString = lvQueryString & " '' AS AppropriateBone, '' AS ApproachBone, '' AS ConsentBone, '' AS RecoveryBone, "
	     END IF
	     ' Check for Tissue access
	     IF lvAccessTissue = 1 Then

	        lvQueryString = lvQueryString & "AppropTissue.AppropriateReportName AS AppropriateTissue, ApproaTissue.ApproachReportName AS ApproachTissue, ConsentTissue.ConsentReportName AS ConsentTissue, RecoveryTissue.ConversionReportName AS RecoveryTissue,"

	     ELSE

	        lvQueryString = lvQueryString & "'' AS AppropriateTissue, '' AS ApproachTissue, '' AS ConsentTissue, '' AS RecoveryTissue,"
	     END IF
	     ' Check for skin access
	     IF lvAccessSkin = 1 Then

	        lvQueryString = lvQueryString & "AppropSkin.AppropriateReportName AS AppropriateSkin, ApproaSkin.ApproachReportName AS ApproachSkin, ConsentSkin.ConsentReportName AS ConsentSkin, RecoverySkin.ConversionReportName AS RecoverySkin, "

	     ELSE

	        lvQueryString = lvQueryString & "'' AS AppropriateSkin, '' AS ApproachSkin, '' AS ConsentSkin, '' AS RecoverySkin, "
	     END IF

	     ' Check for valves access
	     IF lvAccessValves = 1 Then

	        lvQueryString = lvQueryString & "AppropValve.AppropriateReportName AS AppropriateValves, ApproaValve.ApproachReportName AS ApproachValves, ConsentValve.ConsentReportName AS ConsentValve, RecoveryValve.ConversionReportName AS RecoveryValve, "

	     ELSE

	        lvQueryString = lvQueryString & "'' AS AppropriateValves, '' AS ApproachValves, '' AS ConsentValve, '' AS RecoveryValve, "
	     END IF

	     'Check for eyes access
	     IF lvAccessEyes = 1 Then

	        lvQueryString = lvQueryString & "AppropEyes.AppropriateReportName AS AppropriateEyes, ApproaEyes.ApproachReportName AS ApproachEyes, ConsentEyes.ConsentReportName AS ConsentEyes, RecoveryEyes.ConversionReportName AS RecoveryEyes, "

	     ELSE

	        lvQueryString = lvQueryString & "'' AS AppropriateEyes, '' AS ApproachEyes, '' AS ConsentEyes, '' AS RecoveryEyes, "
	     END IF

		lvQueryString = lvQueryString & "' Field 71',' Field 72',' Field 73',' Field 74', "

	   lvQueryString = lvQueryString & "' Field 75', ' Field 76', ' Field 77', ' Field 78', "
	   lvQueryString = lvQueryString & "Referral.ReferralApproachTypeId, "
	   lvQueryString = lvQueryString & "CASE ReferralGeneralConsent WHEN 1 THEN 'Yes - Written' WHEN 2 THEN 'Yes - Verbal' WHEN 3 THEN 'No' ELSE 'No Outcome' END "
	   lvQueryString = lvQueryString & ""
	   lvQueryString = lvQueryString & "FROM Call (nolock) LEFT JOIN Referral (nolock) ON Referral.CallID = Call.CallID "
	   lvQueryString = lvQueryString & "LEFT JOIN SourceCode (nolock) ON SourceCode.SourceCodeID = Call.SourceCodeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Organization (nolock) ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
	   lvQueryString = lvQueryString & "LEFT JOIN WebReportGroupOrg (nolock) ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
	   lvQueryString = lvQueryString & "LEFT JOIN StatEmployee (nolock) ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person StatPerson (nolock) ON StatPerson.PersonID = StatEmployee.PersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person (nolock) ON Person.PersonID = StatEmployee.PersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person CallerPerson (nolock) ON CallerPerson.PersonID = Referral.ReferralCallerPersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person ApproachPerson (nolock) ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person Attending (nolock) ON Attending.PersonID = Referral.ReferralAttendingMD "
	   lvQueryString = lvQueryString & "LEFT JOIN Person Pronouncing (nolock) ON Pronouncing.PersonID = Referral.ReferralPronouncingMD "
	   lvQueryString = lvQueryString & "LEFT JOIN PersonType (nolock) ON PersonType.PersonTypeID = Person.PersonTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN PersonType CallPersonType (nolock) ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN SubLocation (nolock) ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID "
	   lvQueryString = lvQueryString & "LEFT JOIN Phone (nolock) ON Phone.PhoneID = Referral.ReferralCallerPhoneID "
	   lvQueryString = lvQueryString & "LEFT JOIN ReferralType (nolock) ON ReferralType.ReferralTypeID = Referral.ReferralTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Race (nolock) ON Race.RaceID = Referral.ReferralDonorRaceID "
	   lvQueryString = lvQueryString & "LEFT JOIN CauseOfDeath (nolock) ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID "
	   lvQueryString = lvQueryString & "LEFT JOIN ApproachType (nolock) ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropOrgan (nolock) ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropBone (nolock) ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropTissue (nolock) ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropSkin (nolock) ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropValve (nolock) ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropEyes (nolock) ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaOrgan (nolock) ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaBone (nolock) ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaTissue (nolock) ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaSkin (nolock) ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaValve (nolock) ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaEyes (nolock) ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentOrgan (nolock) ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentBone (nolock) ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentTissue (nolock) ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentSkin (nolock) ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentValve (nolock) ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentEyes (nolock) ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID "	   
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryOrgan (nolock) ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryBone (nolock) ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryTissue (nolock) ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoverySkin (nolock) ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryValve (nolock) ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryEyes (nolock) ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN ReferralSecondaryData (nolock) ON ReferralSecondaryData.ReferralID = Referral.ReferralID "

	   '04/27/2005 C.Chaput - Added registry status to select. This corrects the links counts between reports and summary list. 
	   lvQueryString = lvQueryString & "LEFT JOIN RegistryStatus (nolock) ON RegistryStatus.CallID = Referral.CallID "
	   'debug
	   'Response.Write( "<BR><B>pvAnd:</B><BR>" & pvAnd & "<BR>" )
	IF pvCallID > 0 Then
		lvQueryString = lvQueryString & "WHERE Call.CALLID = "
		lvQueryString = lvQueryString & pvCallID
		
	ELSE	
		IF Len(pvJoin) >0 Then
			lvQueryString = lvQueryString & pvJoin & " "
		END IF			

		lvQueryString = lvQueryString & "WHERE CallDateTime BETWEEN '"
		lvQueryString = lvQueryString & lvStartDate
		lvQueryString = lvQueryString & "' AND '"
		lvQueryString = lvQueryString & lvEndDate
		lvQueryString = lvQueryString & "' "
		IF pvReportGroupID > 0 Then
		lvQueryString = lvQueryString & " AND WebReportGroupOrg.WebReportGroupID = "
		lvQueryString = lvQueryString & pvReportGroupID
		End If
		'drh 09/10/03 - Removed: IF pvUserOrgID <> 194 Then
		'drh 3/2/04 - Added If stmt to check if there's a report group
		If pvReportGroupId > 0 then
		lvQueryString = lvQueryString & " AND CALL.SourceCodeID IN ( "
		lvQueryString = lvQueryString & lvSCIList
		'lvQueryString = lvQueryString & convert(char(25), lvpvReportGroupID)
		lvQueryString = lvQueryString & " ) "
		End If	'drh 3/2/04 Added End If
		'drh 09/10/03 - Removed: END IF
		IF pvReferralTypeID > 0 Then
		lvQueryString = lvQueryString & "AND Referral.ReferralTypeID = "
		lvQueryString = lvQueryString & pvReferralTypeID
		END IF
		IF PvOrgID <> 0 THEN
		        lvQueryString = lvQueryString & " AND Referral.ReferralCallerOrganizationID = "
		        lvQueryString = lvQueryString & PvOrgID
		END IF
		IF pvAnd <> empty Then
				'Response.write pvAnd
				lvQueryString = lvQueryString & " "
				lvQueryString = lvQueryString & pvAnd
		End if

		   lvQueryString = lvQueryString & " ORDER BY "
		   lvQueryString = lvQueryString & pvOrderBy

	END IF  ' end CallID Exists

	GetSummaryList = lvQueryString
'Print GetSummaryList

	SET lvRS = nothing
	SET lvConn = nothing

End Function



%>
