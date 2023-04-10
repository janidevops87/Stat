<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<%
'ccarroll 10/27/2006 - Removed Limitations to ReferralNotesCase field
'ccarroll 10/06/2006 - Added granularity check for ServiceLevel of Referral by adding 
			'CASE statments - StatTrac 8.0, Iteration 2 release

Function GetDetailList()

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
	DIM lvStartDate, lvEndDate
	DIM gdlDSN

    Set lvConn = GetConnection(DBUSER, DBPWD,DataSourceName )
 
     'Adjust start and end times for time zone
    IF pvCallID = 0 Then
    
		lvTZ = ZoneDifference(pvStartDate, vTZ)		    
		
		lvStartDate = DateAdd("h", -lvTZ, pvStartDate)
		lvEndDate = DateAdd("h", -lvTZ, pvEndDate)     
	
	Else
		lvQueryString = "SELECT CallDateTime FROM CALL WHERE CallID = " & pvCALLID
		SET lvRS = lvConn.Execute(lvQueryString)
		
		If lvRS.EOF Then
			gdlDSN=ARCHIVEDSN
			Set lvConn = GetConnection(DBUSER, DBPWD,gdlDSN )
			SET lvRS = lvConn.Execute(lvQueryString)			
			IF not lvRS.EOF Then
			  DataSourceName = gdlDSN
			else
			  Set lvConn = GetConnection(DBUSER, DBPWD,DataSourceName )
			End if
		End If	
		lvTZ = ZoneDifference(lvRS("CallDateTime"), vTZ)		
		
		
		SET lvRS = NOTHING
		'lvStartDAte = DateAdd("h", -lvTZ, pvStartDate)
	END IF	

     ' build sourcecode list
 	    
		IF pvUserOrgID <> 194 Then
		
			lvSCIList = ""
			
			lvQueryString = "SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode JOIN WebReportGroup ON WebReportGroup.WeBReportGroupID = WebReportGroupSourceCode.WebReportGroupID WHERE WebReportGroupMaster = 1 AND OrgHierarchyParentID =  " & pvUserOrgID

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
		END IF

		'set option access variables.
		IF pvUserOrgID <> 194 Then	  
			lvQueryString = "SELECT DISTINCT   AccessOrgans, AccessBone, AccessTissue, AccessSkin, AccessValves, AccessEyes, AccessResearch FROM WebReportGroupSourceCode "
		
			IF pvCallID > 0 Then
				lvQueryString = lvQueryString & "JOIN CALL ON Call.SourceCodeID = WebReportGroupSourceCode.SourceCodeID JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID WHERE CALLID = " & pvCallid & " AND WebReportGroup.OrgHierarchyParentID = " & pvUserOrgID		
			ELSE		
				lvQueryString = lvQueryString & "WHERE WebReportGroupID = " & pvReportGroupID
			END IF
			'Print lvQueryString
			'Response.Write lvQueryString
			'Response.write (lvConn)
			'Response.write(pvCallID)
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
				
			ELSE
				response.write("<font color=red>Please verify that this Report Group has a Source Code assigned to it.</font>")
				GetDetailList = NULL
				Exit Function
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
	   lvQueryString = lvQueryString & " , CallDateTime), 8) AS CallTime, StatPerson.PersonFirst AS StatPersonFirstName, StatPerson.PersonLast AS StatPersonLastName, ReferralDonorGender + ' ' + ReferralDonorAge + ' ' + ReferralDonorAgeUnit, "
	   lvQueryString = lvQueryString & "Call.SourceCodeID, SourceCodeName, Referral.ReferralTypeID, ReferralType.ReferralTypeName, "
	   lvQueryString = lvQueryString & "ReferralDonorLastName, ReferralDonorFirstName, OrganizationName, "
	   lvQueryString = lvQueryString & "CallerPerson.PersonFirst AS CallPersonFirst, CallerPerson.PersonLast AS CallerPersonLast, CallPersonType.PersonTypeName AS CallerPersonTitle, "
	         
	   lvQueryString = lvQueryString & "SubLocationName, ReferralCallerSubLocationLevel, '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber , ReferralCallerExtension, "

	   lvQueryString = lvQueryString & "ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorGender, ReferralDonorWeight, "
	   lvQueryString = lvQueryString & "ReferralDonorOnVentilator, convert(char(8),ReferralDonorAdmitDate,1), ReferralDonorAdmitTime, convert(char(8),ReferralDonorDeathDate,1), ReferralDonorDeathTime, "

	   'ccarroll 08/10/2006 - Removed limitation for ReferralNotesCase. 8.0 length is 400
	   
	   lvQueryString = lvQueryString & "ReferralNotesCase, RaceName, CauseOfDeathName, ApproachType.ApproachTypeName, ApproachPerson.PersonFirst AS ApproachPersonFirst, ApproachPerson.PersonLast AS ApproachPersonLast, "

	   'ccarroll 06/29/06 added check for new or existing NOK data
	   lvQueryString = lvQueryString & "Case When ReferralNOKID > 0 THEN LEFT(REPLACE(REPLACE(NOK.NOKFirstName + ' ' + NOK.NOKLastName,CHAR(10), CHAR(32)), CHAR(13), ''),50) ELSE ReferralApproachNOK END AS ReferralApproachNOK, "
	   lvQueryString = lvQueryString & "Case When ReferralNOKID > 0 THEN NOK.NOKApproachRelation ELSE ReferralApproachRelation END AS ReferralApproachRelation, "
	   lvQueryString = lvQueryString & "Case When ReferralNOKID > 0 THEN NOK.NOKPhone ELSE ReferralNOKPhone END AS ReferralNOKPhone, "
	   lvQueryString = lvQueryString & "Case When ReferralNOKID > 0 THEN LEFT(REPLACE(REPLACE(Referral.ReferralNOKAddress + ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, CHAR(10), CHAR(32)), CHAR(13), ''), 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS ReferralNOKAddress, "

	   lvQueryString = lvQueryString & "ReferralCoronerName, ReferralCoronerOrganization, "
	   lvQueryString = lvQueryString & "ReferralCoronerPhone, ReferralCoronerNote, Attending.PersonFirst AS AttendingFirst, Attending.PersonLast AS AttendingLast, "
	   lvQueryString = lvQueryString & "Pronouncing.PersonFirst AS PronouncingFirst, Pronouncing.PersonLast AS PronouncingLast, "

	   IF pvUserOrgID = 194 Then	   
		lvQueryString = lvQueryString & "AppropOrgan.AppropriateReportName AS AppropriateOrgan, ApproaOrgan.ApproachReportName AS ApproachOrgan, ConsentOrgan.ConsentReportName AS ConsentOrgan, RecoveryOrgan.ConversionReportName AS RecoveryOrgan, "
		lvQueryString = lvQueryString & "AppropBone.AppropriateReportName AS AppropriateBone, ApproaBone.ApproachReportName AS ApproachBone, ConsentBone.ConsentReportName AS ConsentBone, RecoveryBone.ConversionReportName AS RecoveryBone, " 
		lvQueryString = lvQueryString & "AppropTissue.AppropriateReportName AS AppropriateTissue, ApproaTissue.ApproachReportName AS ApproachTissue, ConsentTissue.ConsentReportName AS ConsentTissue, RecoveryTissue.ConversionReportName AS RecoveryTissue,"
		lvQueryString = lvQueryString & "AppropSkin.AppropriateReportName AS AppropriateSkin, ApproaSkin.ApproachReportName AS ApproachSkin, ConsentSkin.ConsentReportName AS ConsentSkin, RecoverySkin.ConversionReportName AS RecoverySkin, "
		lvQueryString = lvQueryString & "AppropValve.AppropriateReportName AS AppropriateValves, ApproaValve.ApproachReportName AS ApproachValves, ConsentValve.ConsentReportName AS ConsentValve, RecoveryValve.ConversionReportName AS RecoveryValve, "
		lvQueryString = lvQueryString & "AppropEyes.AppropriateReportName AS AppropriateEyes, ApproaEyes.ApproachReportName AS ApproachEyes, ConsentEyes.ConsentReportName AS ConsentEyes, RecoveryEyes.ConversionReportName AS RecoveryEyes, "

	   ELSE
	        'ccarroll 10/06/2006 - Added granularity check for ServiceLevel of Referral by adding 
	        'CASE statments - StatTrac 8.0, Iteration 2 release

		'CHECK FOR ORGAN ACCESS
	     IF lvAccessOrgans = 1 Then
	        lvQueryString = lvQueryString & "AppropOrgan.AppropriateReportName AS AppropriateOrgan, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE '' END AS ApproachOrgan, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE '' END AS ConsentOrgan, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE '' END AS RecoveryOrgan, "

	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateOrgan, '' AS ApproachOrgan, '' AS ConsentOrgan , '' AS RecoveryOrgan, "
	     END IF

	        'CHECK FOR BONE ACCESS
	     IF lvAccessBone = 1 Then
	        lvQueryString = lvQueryString & "AppropBone.AppropriateReportName AS AppropriateBone, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE '' END AS ApproachBone, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE '' END AS ConsentBone, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE '' END AS RecoveryBone, "

	     ELSE
	        lvQueryString = lvQueryString & " '' AS AppropriateBone, '' AS ApproachBone, '' AS ConsentBone, '' AS RecoveryBone, " 
	     END IF

	        'CHECK FOR TISSUE ACCESS
	     IF lvAccessTissue = 1 Then
	        lvQueryString = lvQueryString & "AppropTissue.AppropriateReportName AS AppropriateTissue, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE '' END AS ApproachTissue, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE '' END AS ConsentTissue, " 
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE '' END AS RecoveryTissue,	"
	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateTissue, '' AS ApproachTissue, '' AS ConsentTissue, '' AS RecoveryTissue,"     
	     END IF
	        'CHECK FOR SKIN ACCESS
	     IF lvAccessSkin = 1 Then
	        lvQueryString = lvQueryString & "AppropSkin.AppropriateReportName AS AppropriateSkin, " 
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE '' END AS ApproachSkin, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE '' END AS ConsentSkin, " 
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE '' END AS RecoverySkin, "
	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateSkin, '' AS ApproachSkin, '' AS ConsentSkin, '' AS RecoverySkin, "
	     END IF

	        'CHECK FOR VALVES ACCESS
	     IF lvAccessValves = 1 Then
	        lvQueryString = lvQueryString & "AppropValve.AppropriateReportName AS AppropriateValves, " 
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE '' END AS ApproachValves, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE '' END AS ConsentValve, " 
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE '' END AS RecoveryValve, "
	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateValves, '' AS ApproachValves, '' AS ConsentValve, '' AS RecoveryValve, "
	     END IF
	          
	     'CHECK FOR EYES ACCESS
	     IF lvAccessEyes = 1 Then
	        lvQueryString = lvQueryString & "AppropEyes.AppropriateReportName AS AppropriateEyes, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE '' END AS ApproachEyes, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE '' END AS ConsentEyes, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE '' END AS RecoveryEyes, "
	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateEyes, '' AS ApproachEyes, '' AS ConsentEyes, '' AS RecoveryEyes, "
	     END IF
	   End IF 'End IF for check for disposition access
	   
		lvQueryString = lvQueryString & "'','','','', "

	   lvQueryString = lvQueryString & "ReferralCallerOrganizationID AS OrganizationID, ReferralGeneralConsent, ReferralApproachTime, ReferralConsentTime, ReferralSecondaryHistory, "
	   lvQueryString = lvQueryString & "ReferralExtubated, "
	   'Add Other category to select
	   IF pvUserOrgID = 194 Then	   
		lvQueryString = lvQueryString & "AppropRsch.AppropriateReportName AS AppropriateOther, ApproaRsch.ApproachReportName AS ApproachOther, ConsentRsch.ConsentReportName AS ConsentOther, RecoveryRsch.ConversionReportName AS RecoveryOther, "
	    
	   Else
		' CHECK FOR ORGAN ACCESS
	    IF lvAccessResearch = 1 Then
			lvQueryString = lvQueryString & "AppropRsch.AppropriateReportName AS AppropriateOther, ApproaRsch.ApproachReportName AS ApproachOther, ConsentRsch.ConsentReportName AS ConsentOther, RecoveryRsch.ConversionReportName AS RecoveryOther, "
	     Else
			lvQueryString = lvQueryString & "'' AS AppropriateOther, '' AS ApproachOther, '' AS ConsentOther, '' AS RecoveryOther, "
	     End If
	   End If 

	'Added lines for custom fields
	lvQueryString = lvQueryString & "Referral.ReferralApproachTypeId, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField1 as customField_1, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField2 as customField_2, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField3 as customField_3, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField4 as customField_4, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField5 as customField_5, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField6 as customField_6, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField7 as customField_7, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField8 as customField_8, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField9 as customField_9, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField10 as customField_10, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField11 as customField_11, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField12 as customField_12, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField13 as customField_13, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField14 as customField_14, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField15 as customField_15, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField16 as customField_16, "
	'Added lines for custom field labels
	'lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomTextAlert AS ServiceLevelCustomTextAlert, " 
	'lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomListAlert AS ServiceLevelCustomListAlert, " 
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16, "
	
	'02/14/03 drh - Additional Referral Field
	lvQueryString = lvQueryString & "ReferralDOB, "
	
	'drh 06/23/03 - Commented Heartbeat out until we're ready to go live
	'lvQueryString = lvQueryString & "CASE ReferralDonorHeartBeat WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE '' END AS 'ReferralDonorHeartBeat', "
	
	lvQueryString = lvQueryString & "ReferralDonorSSN, " 
	
	'drh 08/25/03 - Added fields for Hospital Approach
	lvQueryString = lvQueryString & "ISNULL(SecondaryApproach.CallID, -1), "
	lvQueryString = lvQueryString & "HospitalApproachType.ApproachTypeName, " 
	lvQueryString = lvQueryString & "HospitalApproachPerson.PersonFirst AS HospitalApproachPersonFirst, HospitalApproachPerson.PersonLast AS HospitalApproachPersonLast, " 
	lvQueryString = lvQueryString & "SecondaryHospitalOutcome, " 
	lvQueryString = lvQueryString & "SecondaryApproached, "
	
	'T.T added heartbeat field 3/22/2004
	lvQueryString = lvQueryString & " CASE ReferralDonorHeartBeat WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE '' END AS 'ReferralDonorHeartBeat', "
	lvQueryString = lvQueryString & " ISNULL(RegistryStatusType.RegistryType, 'Not on Registry') AS RegistryStatus, "
	lvQueryString = lvQueryString & " dbo.fn_OrgAddressHtml(Organization.OrganizationId) AS OrganizationAddress, "
	
	'03/21/06 ccarroll- added new fields for StatTrac 8.0 per Requirements document
	lvQueryString = lvQueryString & "Referral.ReferralDonorSpecificCOD, "
	lvQueryString = lvQueryString & "Referral.ReferralDonorBrainDeathDate, "
	lvQueryString = lvQueryString & "Referral.ReferralDonorBrainDeathTime, "
	lvQueryString = lvQueryString & "Referral.ReferralPronouncingMDPhone, "
	lvQueryString = lvQueryString & "Referral.ReferralAttendingMDPhone, "
	lvQueryString = lvQueryString & "CurrentRefType.ReferralTypeName AS CurrentRef, "
	lvQueryString = lvQueryString & "Referral.ReferralDonorNameMI "
	
   
	   'lvQueryString = lvQueryString & "FROM Call LEFT JOIN Referral ON Referral.CallID = Call.CallID "
	   lvQueryString = lvQueryString & "FROM Call (nolock) JOIN Referral (nolock) ON Referral.CallID = Call.CallID "
	   lvQueryString = lvQueryString & "LEFT JOIN NOK  (nolock) ON NOK.NOKID = Referral.ReferralNOKID "
	   lvQueryString = lvQueryString & "LEFT JOIN State st (nolock) ON st.StateID = NOK.NOKStateID "
	   lvQueryString = lvQueryString & "LEFT JOIN SourceCode  (nolock) ON SourceCode.SourceCodeID = Call.SourceCodeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Organization (nolock) ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
	   lvQueryString = lvQueryString & "LEFT JOIN WebReportGroupOrg (nolock) ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
	   lvQueryString = lvQueryString & "LEFT JOIN WebReportGroup (nolock) ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID "
	   lvQueryString = lvQueryString & "LEFT JOIN StatEmployee (nolock) ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person StatPerson (nolock) ON StatPerson.PersonID = StatEmployee.PersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person (nolock) ON Person.PersonID = StatEmployee.PersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person CallerPerson (nolock) ON CallerPerson.PersonID = Referral.ReferralCallerPersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person ApproachPerson (nolock) ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID "
	   
	   'drh 08/25/03 - Added joins for Hospital Approach
	   lvQueryString = lvQueryString & "LEFT JOIN SecondaryApproach (nolock) ON Call.CallID = SecondaryApproach.CallID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person HospitalApproachPerson (nolock)ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy "
	   lvQueryString = lvQueryString & "LEFT JOIN ApproachType HospitalApproachType (nolock)ON HospitalApproachType.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach "
	   
	   lvQueryString = lvQueryString & "LEFT JOIN Person Attending (nolock) ON Attending.PersonID = Referral.ReferralAttendingMD "
	   lvQueryString = lvQueryString & "LEFT JOIN Person Pronouncing (nolock) ON Pronouncing.PersonID = Referral.ReferralPronouncingMD "
	   lvQueryString = lvQueryString & "LEFT JOIN PersonType (nolock) ON PersonType.PersonTypeID = Person.PersonTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN PersonType CallPersonType (nolock) ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN SubLocation (nolock) ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID "
	   lvQueryString = lvQueryString & "LEFT JOIN Phone (nolock) ON Phone.PhoneID = Referral.ReferralCallerPhoneID "
	   lvQueryString = lvQueryString & "LEFT JOIN ReferralType (nolock) ON ReferralType.ReferralTypeID = Referral.ReferralTypeID "
	   
	   '05/20/2006 ccarroll added Current Referral Type
	   lvQueryString = lvQueryString & "LEFT JOIN ReferralType AS CurrentRefType (nolock) ON CurrentRefType.ReferralTypeID = Referral.CurrentReferralTypeID "	   
	   
	   lvQueryString = lvQueryString & "LEFT JOIN Race (nolock) ON Race.RaceID = Referral.ReferralDonorRaceID "
	   lvQueryString = lvQueryString & "LEFT JOIN CauseOfDeath (nolock) ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID "
	   lvQueryString = lvQueryString & "LEFT JOIN ApproachType (nolock) ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropOrgan (nolock) ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropBone (nolock) ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropTissue (nolock) ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropSkin (nolock) ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropValve (nolock) ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropEyes (nolock) ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropRsch (nolock) ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID "
	   
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaOrgan (nolock) ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaBone (nolock) ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaTissue (nolock) ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaSkin (nolock) ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaValve (nolock) ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaEyes (nolock) ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaRsch (nolock) ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID "
	   	   
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentOrgan (nolock) ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentBone (nolock) ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentTissue (nolock) ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentSkin (nolock) ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentValve (nolock) ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentEyes (nolock) ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentRsch (nolock) ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID "
	   
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryOrgan (nolock) ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryBone (nolock) ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryTissue (nolock) ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoverySkin (nolock) ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryValve (nolock) ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryEyes (nolock) ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryRsch (nolock) ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID "
	   	    
	   lvQueryString = lvQueryString & "LEFT JOIN ReferralSecondaryData (nolock) ON ReferralSecondaryData.ReferralID = Referral.ReferralID "

	   'Added custom fields 00.0928 - ttw
	   lvQueryString = lvQueryString & "LEFT JOIN CallCustomField (nolock) on CallCustomField.CallID = Referral.CallID "
           'Added RegistryStatus for v.7.7.1.  9/22/04 - SAP
           lvQueryString = lvQueryString & "LEFT JOIN RegistryStatus (nolock) ON RegistryStatus.CallId = Call.CallId "
           lvQueryString = lvQueryString & "LEFT JOIN RegistryStatusType (nolock) ON RegistryStatus.RegistryStatus = RegistryStatusType.ID "
	
	
	   '02/13/03 bjk need to change join statments based on when the referral exists
	   	' if the referral is pre Family Services Module (8/14/2002 ) use old join to obtain ServiceLevelID
	   'callid 2673141 8/13/02 07:57
	   	  'evaluate by callid if callid > 0
	   	   if pvCallid > 0 Then	   
	   
			   If pvCallID < 2673141  Then
				   'Added Custom field labels 01.0518
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
				   lvQueryString = lvQueryString & "JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID "
				   lvQueryString = lvQueryString & "and ServiceLevelStatus = 0 "	   				   
				   lvQueryString = lvQueryString & "JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID "
				   lvQueryString = lvQueryString & "AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID "
				   lvQueryString = lvQueryString & "JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID "

		   ' if the referral is post Family Services Module (8/14/2002 ) use new join to CallCriteria to obtain ServiceLevel
			   Else 
				   'Added Custom field labels 01.0518
				   '02/12/03 bjk modifed relation to ServiceLevel
				   lvQueryString = lvQueryString & "LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID "
				   lvQueryString = lvQueryString & "AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID "
			   End if 
		   'evaluate by date if call id = 0
		   else 'lvStartDate < "8/13/02")
			   If cdate(lvStartDate) < cdate("8/13/02 07:57")  Then
				   'Added Custom field labels 01.0518
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
				   lvQueryString = lvQueryString & "JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID "
				   lvQueryString = lvQueryString & "and ServiceLevelStatus = 0 "	   				   
				   lvQueryString = lvQueryString & "JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID "
				   lvQueryString = lvQueryString & "AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID "
				   lvQueryString = lvQueryString & "JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID "

		   ' if the referral is post Family Services Module (8/14/2002 ) use new join to CallCriteria to obtain ServiceLevel
			   Else 
				   'Added Custom field labels 01.0518
				   '02/12/03 bjk modifed relation to ServiceLevel
				   lvQueryString = lvQueryString & "LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID "
				   lvQueryString = lvQueryString & "AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID "
			   End if 
		   
		   
		   
		   End If
		   
 
	IF pvCallID > 0 Then
		lvQueryString = lvQueryString & "WHERE Call.CALLID = " 
		lvQueryString = lvQueryString & pvCallID
		'lvQueryString = lvQueryString & " AND CallTypeID = 1 "
		IF pvUserOrgID <> 194 Then
		lvQueryString = lvQueryString & " AND CALL.SourceCodeID IN ( "
		lvQueryString = lvQueryString & lvSCIList
		'lvQueryString = lvQueryString & convert(char(25), lvpvReportGroupID)
		lvQueryString = lvQueryString & " ) "
		lvQueryString = lvQueryString & " AND WebReportGroup.OrgHierarchyParentID = "
		lvQueryString = lvQueryString & pvUserOrgID		
		END IF 		
	ELSE
		lvQueryString = lvQueryString & "WHERE CallDateTime BETWEEN '"
		lvQueryString = lvQueryString & lvStartDate
		lvQueryString = lvQueryString & "' AND '"
		lvQueryString = lvQueryString & lvEndDate
		lvQueryString = lvQueryString & "' AND WebReportGroupOrg.WebReportGroupID = "
		lvQueryString = lvQueryString & pvReportGroupID
		IF pvUserOrgID <> 194 Then
		lvQueryString = lvQueryString & " AND CALL.SourceCodeID IN ( "
		lvQueryString = lvQueryString & lvSCIList
		'lvQueryString = lvQueryString & convert(char(25), lvpvReportGroupID)
		lvQueryString = lvQueryString & " ) "
		END IF 
		IF pvReferralTypeID > 0 Then
		lvQueryString = lvQueryString & "AND Referral.ReferralTypeID = "
		lvQueryString = lvQueryString & pvReferralTypeID
		END IF
		IF PvOrgID <> 0 THEN
		        lvQueryString = lvQueryString & " AND Referral.ReferralCallerOrganizationID = " 
		        lvQueryString = lvQueryString & PvOrgID
		END IF

		   lvQueryString = lvQueryString & " ORDER BY "
		   lvQueryString = lvQueryString & pvOrderBy     
	END IF  ' end CallID Exists 
	
	GetDetailList = lvQueryString
	 'response.write(lvQueryString)
 	 'response.end
	SET lvRS = nothing
	SET lvConn = nothing
	
End Function



%>
