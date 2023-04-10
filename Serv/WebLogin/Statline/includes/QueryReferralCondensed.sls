<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<%

Function GetCondensedQuery()

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
	DIM lvResultArray
	DIM lvLoopCounter
	Dim lvAppropriateOrgan
	Dim lvApproachOrgan
	Dim lvConsentOrgan
	Dim lvRecoveryOrgan
	Dim lvAppropriateBone
	Dim lvApproachBone
	Dim lvConsentBone
	Dim lvRecoveryBone
	Dim lvAppropriateTissue
	Dim lvApproachTissue
	Dim lvConsentTissue
	Dim lvRecoveryTissue
	Dim lvAppropriateSkin
	Dim lvApproachSkin
	Dim lvConsentSkin
	Dim lvRecoverySkin
	Dim lvAppropriateValves
	Dim lvApproachValves
	Dim lvConsentValve
	Dim lvRecoveryValve
	Dim lvAppropriateEyes
	Dim lvApproachEyes
	Dim lvConsentEyes
	Dim lvRecoveryEyes
	
	
    Set lvConn = server.CreateObject("ADODB.Connection")
	lvConn.Open DataSourceName, DBUSER, DBPWD
 
	 
	
     'Adjust start and end times for time zone
    IF pvCallID = 0 Then
    
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
		IF pvUserOrgID = 194 Then
			lvQueryString = "SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode "
		ELSE
			lvQueryString = "SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode WHERE WebReportGroupID = " & pvReportGroupID
		END IF
			
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
			lvQueryString = "SELECT DISTINCT   SourceCodeID, AccessOrgans, AccessBone, AccessTissue, AccessSkin, AccessValves, AccessEyes, AccessResearch FROM WebReportGroupSourceCode "
		
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
		
			'SET lvRS = NOTHING
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
	   lvQueryString = lvQueryString & "Call.SourceCodeID, SourceCodeName, Referral.ReferralTypeID, ReferralTypeName, "
	   lvQueryString = lvQueryString & "ReferralDonorLastName, ReferralDonorFirstName, OrganizationName, "
	   lvQueryString = lvQueryString & "CallerPerson.PersonFirst AS CallPersonFirst, CallerPerson.PersonLast AS CallerPersonLast, CallPersonType.PersonTypeName AS CallerPersonTitle, "
	         
	   lvQueryString = lvQueryString & "SubLocationName, ReferralCallerSubLocationLevel, '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber , ReferralCallerExtension, "

	   lvQueryString = lvQueryString & "Case when ReferralDonorSSN is not null THEN ReferralDonorRecNumber + ' - ' + ReferralDonorSSN  ELSE ReferralDonorRecNumber  END AS ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorGender, ReferralDonorWeight, "
	   lvQueryString = lvQueryString & "ReferralDonorOnVentilator, convert(char(8),ReferralDonorAdmitDate,1), ReferralDonorAdmitTime, convert(char(8),ReferralDonorDeathDate,1), ReferralDonorDeathTime, "
	   lvQueryString = lvQueryString & "ReferralNotesCase, RaceName, CauseOfDeathName, "
	   'ApproachTypeName, ApproachPerson.PersonFirst AS ApproachPersonFirst, ApproachPerson.PersonLast AS ApproachPersonLast, "
	   'lvQueryString = lvQueryString & "ReferralApproachNOK, ReferralApproachRelation, ReferralNOKPhone, ReferralNOKAddress, ReferralCoronerName, ReferralCoronerOrganization, "
	   'lvQueryString = lvQueryString & "ReferralCoronerPhone, ReferralCoronerNote, Attending.PersonFirst AS AttendingFirst, Attending.PersonLast AS AttendingLast, "
	   'lvQueryString = lvQueryString & "Pronouncing.PersonFirst AS PronouncingFirst, Pronouncing.PersonLast AS PronouncingLast, "
	      
	   'Attending.PersonFirst AS AttendingFirst, Attending.PersonLast AS AttendingLast, "
	   'lvQueryString = lvQueryString & "Pronouncing.PersonFirst AS PronouncingFirst, Pronouncing.PersonLast AS PronouncingLast, "
	   
	   IF NOT lvRS.EOF Then
			lvResultArray = lvRS.GetRows
		END IF	
		
		lvAppropriateOrgan = lvAppropriateOrgan & " Case "  
		lvApproachOrgan = lvApproachOrgan & " Case "
		lvConsentOrgan = lvConsentOrgan & " Case "
		lvRecoveryOrgan = lvRecoveryOrgan & " Case "
		lvAppropriateBone = lvAppropriateBone & " Case "
		lvApproachBone = lvApproachBone & " Case "
		lvConsentBone = lvConsentBone & " Case "
		lvRecoveryBone	= lvRecoveryBone & " Case "
		lvAppropriateTissue = lvAppropriateTissue & " Case "
		lvApproachTissue = lvApproachTissue & " Case "
		lvConsentTissue = lvConsentTissue & " Case "
		lvRecoveryTissue = lvRecoveryTissue & " Case "
		lvAppropriateSkin = lvAppropriateSkin & " Case "
		lvApproachSkin = lvApproachSkin & " Case "
		lvConsentSkin = lvConsentSkin & " Case "
		lvRecoverySkin = lvRecoverySkin & " Case "
		lvAppropriateValves = lvAppropriateValves & " Case "
		lvApproachValves = lvApproachValves & " Case "
		lvConsentValve = lvConsentValve & " Case "
		lvRecoveryValve = lvRecoveryValve & " Case "
		lvAppropriateEyes = lvAppropriateEyes & " Case "
		lvApproachEyes = lvApproachEyes & " Case "
		lvConsentEyes = lvConsentEyes & " Case "
		lvRecoveryEyes = lvRecoveryEyes & " Case "

		
		For lvLoopCounter = 0 to Ubound(lvResultArray,2)
			lvAppropriateOrgan = lvAppropriateOrgan & " When Call.SourceCodeID = "
			lvAppropriateOrgan = lvAppropriateOrgan & lvResultArray(0,lvLoopCounter)
			lvAppropriateOrgan = lvAppropriateOrgan & " Then Case when "
			lvAppropriateOrgan = lvAppropriateOrgan & lvResultArray(1,lvLoopCounter)
			lvAppropriateOrgan = lvAppropriateOrgan & " = 1 Then AppropOrgan.AppropriateReportName "
			lvAppropriateOrgan = lvAppropriateOrgan & "else '' End "
			
			
			lvApproachOrgan = lvApproachOrgan & " When Call.SourceCodeID = "
			lvApproachOrgan = lvApproachOrgan & lvResultArray(0,lvLoopCounter)
			lvApproachOrgan = lvApproachOrgan & " Then Case when "
			lvApproachOrgan = lvApproachOrgan & lvResultArray(1,lvLoopCounter)
			lvApproachOrgan = lvApproachOrgan & " = 1 Then ApproaOrgan.ApproachReportName "
			lvApproachOrgan = lvApproachOrgan & "else '' End "
			
			
			lvConsentOrgan = lvConsentOrgan & " When Call.SourceCodeID = "
			lvConsentOrgan = lvConsentOrgan & lvResultArray(0,lvLoopCounter)
			lvConsentOrgan = lvConsentOrgan & " Then Case when "
			lvConsentOrgan = lvConsentOrgan & lvResultArray(1,lvLoopCounter)
			lvConsentOrgan = lvConsentOrgan & " = 1 Then ConsentOrgan.ConsentReportName "
			lvConsentOrgan = lvConsentOrgan & "else '' End "
			
			
			lvRecoveryOrgan = lvRecoveryOrgan & " When Call.SourceCodeID = " 
			lvRecoveryOrgan = lvRecoveryOrgan & lvResultArray(0,lvLoopCounter)
			lvRecoveryOrgan = lvRecoveryOrgan & " Then Case when "
			lvRecoveryOrgan = lvRecoveryOrgan & lvResultArray(1,lvLoopCounter)
			lvRecoveryOrgan = lvRecoveryOrgan & " = 1 Then RecoveryOrgan.ConversionReportName "
			lvRecoveryOrgan = lvRecoveryOrgan & "else '' End "
			
			lvAppropriateBone = lvAppropriateBone & " When Call.SourceCodeID = " 
			lvAppropriateBone = lvAppropriateBone & lvResultArray(0,lvLoopCounter)
			lvAppropriateBone = lvAppropriateBone & " Then Case when "
			lvAppropriateBone = lvAppropriateBone & lvResultArray(2,lvLoopCounter)
			lvAppropriateBone = lvAppropriateBone & " = 1 Then AppropBone.AppropriateReportName "
			lvAppropriateBone = lvAppropriateBone  & "else '' End "
			
			lvApproachBone = lvApproachBone & " When Call.SourceCodeID = " 
			lvApproachBone = lvApproachBone & lvResultArray(0,lvLoopCounter)
			lvApproachBone = lvApproachBone & " Then Case when "
			lvApproachBone = lvApproachBone & lvResultArray(2,lvLoopCounter)
			lvApproachBone = lvApproachBone & " = 1 Then ApproaBone.ApproachReportName "
			lvApproachBone = lvApproachBone & "else '' End "
			
			lvConsentBone = lvConsentBone & " When Call.SourceCodeID = " 
			lvConsentBone = lvConsentBone & lvResultArray(0,lvLoopCounter)
			lvConsentBone = lvConsentBone & " Then Case when "
			lvConsentBone = lvConsentBone & lvResultArray(2,lvLoopCounter)
			lvConsentBone = lvConsentBone & " = 1 Then ConsentBone.ConsentReportName "
			lvConsentBone = lvConsentBone & "else '' End "
			
			lvRecoveryBone	= lvRecoveryBone & " When Call.SourceCodeID = " 
			lvRecoveryBone	= lvRecoveryBone & lvResultArray(0,lvLoopCounter)
			lvRecoveryBone	= lvRecoveryBone & " Then Case when "
			lvRecoveryBone	= lvRecoveryBone & lvResultArray(2,lvLoopCounter)
			lvRecoveryBone	= lvRecoveryBone & " = 1 Then RecoveryBone.ConversionReportName "
			lvRecoveryBone	= lvRecoveryBone & "else '' End "
	       
	       	lvAppropriateTissue = lvAppropriateTissue & " When Call.SourceCodeID = " 
	       	lvAppropriateTissue = lvAppropriateTissue & lvResultArray(0,lvLoopCounter)
	       	lvAppropriateTissue = lvAppropriateTissue & " Then Case when "
	       	lvAppropriateTissue = lvAppropriateTissue & lvResultArray(3,lvLoopCounter)
	       	lvAppropriateTissue = lvAppropriateTissue & " = 1 Then AppropTissue.AppropriateReportName "
	       	lvAppropriateTissue = lvAppropriateTissue & "else '' End "
	       	
			lvApproachTissue = lvApproachTissue & " When Call.SourceCodeID = " 
			lvApproachTissue = lvApproachTissue & lvResultArray(0,lvLoopCounter)
			lvApproachTissue = lvApproachTissue & " Then Case when "
			lvApproachTissue = lvApproachTissue & lvResultArray(3,lvLoopCounter)
			lvApproachTissue = lvApproachTissue & " = 1 Then ApproaTissue.ApproachReportName "
			lvApproachTissue = lvApproachTissue & "else '' End "
			
			lvConsentTissue = lvConsentTissue & " When Call.SourceCodeID = " 
			lvConsentTissue = lvConsentTissue & lvResultArray(0,lvLoopCounter)
			lvConsentTissue = lvConsentTissue & " Then Case when "
			lvConsentTissue = lvConsentTissue & lvResultArray(3,lvLoopCounter)
			lvConsentTissue = lvConsentTissue & " = 1 Then ConsentTissue.ConsentReportName "
			lvConsentTissue = lvConsentTissue & "else '' End "
			
			lvRecoveryTissue = lvRecoveryTissue & " When Call.SourceCodeID = " 
			lvRecoveryTissue = lvRecoveryTissue & lvResultArray(0,lvLoopCounter)
			lvRecoveryTissue = lvRecoveryTissue & " Then Case when "
			lvRecoveryTissue = lvRecoveryTissue & lvResultArray(3,lvLoopCounter)
			lvRecoveryTissue = lvRecoveryTissue & " = 1 Then RecoveryTissue.ConversionReportName "
			lvRecoveryTissue = lvRecoveryTissue & "else '' End "

			lvAppropriateSkin = lvAppropriateSkin & " When Call.SourceCodeID = " 
			lvAppropriateSkin = lvAppropriateSkin & lvResultArray(0,lvLoopCounter)
			lvAppropriateSkin = lvAppropriateSkin & " Then Case when "
			lvAppropriateSkin = lvAppropriateSkin & lvResultArray(4,lvLoopCounter)
			lvAppropriateSkin = lvAppropriateSkin & " = 1 Then AppropSkin.AppropriateReportName "
			lvAppropriateSkin = lvAppropriateSkin & "else '' End "
						
			lvApproachSkin = lvApproachSkin & " When Call.SourceCodeID = " 
			lvApproachSkin = lvApproachSkin & lvResultArray(0,lvLoopCounter)
			lvApproachSkin = lvApproachSkin & " Then Case when "
			lvApproachSkin = lvApproachSkin & lvResultArray(4,lvLoopCounter)
			lvApproachSkin = lvApproachSkin & " = 1 Then ApproaSkin.ApproachReportName "
			lvApproachSkin = lvApproachSkin & "else '' End "
			
			lvConsentSkin = lvConsentSkin & " When Call.SourceCodeID = " 
			lvConsentSkin = lvConsentSkin & lvResultArray(0,lvLoopCounter)
			lvConsentSkin = lvConsentSkin & " Then Case when "
			lvConsentSkin = lvConsentSkin & lvResultArray(4,lvLoopCounter)
			lvConsentSkin = lvConsentSkin & " = 1 Then ConsentSkin.ConsentReportName "
			lvConsentSkin = lvConsentSkin & "else '' End "
			
			lvRecoverySkin = lvRecoverySkin & " When Call.SourceCodeID = " 
			lvRecoverySkin = lvRecoverySkin & lvResultArray(0,lvLoopCounter)
			lvRecoverySkin = lvRecoverySkin & " Then Case when "
			lvRecoverySkin = lvRecoverySkin & lvResultArray(4,lvLoopCounter)
			lvRecoverySkin = lvRecoverySkin & " = 1 Then RecoverySkin.ConversionReportName "
			lvRecoverySkin = lvRecoverySkin & "else '' End "

       		lvAppropriateValves = lvAppropriateValves & " When Call.SourceCodeID = " 
       		lvAppropriateValves = lvAppropriateValves & lvResultArray(0,lvLoopCounter) 
    		lvAppropriateValves = lvAppropriateValves & " Then Case when "        		 
    		lvAppropriateValves = lvAppropriateValves & lvResultArray(5,lvLoopCounter)        		 
    		lvAppropriateValves = lvAppropriateValves & " = 1 Then AppropValve.AppropriateReportName "         		 
    		lvAppropriateValves = lvAppropriateValves & "else '' End "   		 
    		
			lvApproachValves = lvApproachValves & " When Call.SourceCodeID = " 
			lvApproachValves = lvApproachValves & lvResultArray(0,lvLoopCounter)
			lvApproachValves = lvApproachValves & " Then Case when "
			lvApproachValves = lvApproachValves & lvResultArray(5,lvLoopCounter)        		 
			lvApproachValves = lvApproachValves & " = 1 Then ApproaValve.ApproachReportName "
			lvApproachValves = lvApproachValves & "else '' End "
			
			lvConsentValve = lvConsentValve & " When Call.SourceCodeID = " 
			lvConsentValve = lvConsentValve & lvResultArray(0,lvLoopCounter)
			lvConsentValve = lvConsentValve & " Then Case when "
			lvConsentValve = lvConsentValve & lvResultArray(5,lvLoopCounter)        		 
			lvConsentValve = lvConsentValve & " = 1 Then ConsentValve.ConsentReportName " 
			lvConsentValve = lvConsentValve & "else '' End "
			
			lvRecoveryValve = lvRecoveryValve & " When Call.SourceCodeID = " 
			lvRecoveryValve = lvRecoveryValve & lvResultArray(0,lvLoopCounter)
			lvRecoveryValve = lvRecoveryValve & " Then Case when "
			lvRecoveryValve = lvRecoveryValve & lvResultArray(5,lvLoopCounter)        		 
			lvRecoveryValve = lvRecoveryValve & " = 1 Then RecoveryValve.ConversionReportName "
			lvRecoveryValve = lvRecoveryValve & "else '' End "
	      
			lvAppropriateEyes = lvAppropriateEyes & " When Call.SourceCodeID = " 
			lvAppropriateEyes = lvAppropriateEyes & lvResultArray(0,lvLoopCounter)
			lvAppropriateEyes = lvAppropriateEyes & " Then Case when "
			lvAppropriateEyes = lvAppropriateEyes & lvResultArray(6,lvLoopCounter)        		 
			lvAppropriateEyes = lvAppropriateEyes & " = 1 Then AppropEyes.AppropriateReportName "
			lvAppropriateEyes = lvAppropriateEyes & "else '' End "

			
			lvApproachEyes = lvApproachEyes & " When Call.SourceCodeID = " 
			lvApproachEyes = lvApproachEyes & lvResultArray(0,lvLoopCounter)
			lvApproachEyes = lvApproachEyes & " Then Case when "
			lvApproachEyes = lvApproachEyes & lvResultArray(6,lvLoopCounter)        		 
			lvApproachEyes = lvApproachEyes & " = 1 Then ApproaEyes.ApproachReportName "
			lvApproachEyes = lvApproachEyes & "else '' End "
						
			lvConsentEyes = lvConsentEyes & " When Call.SourceCodeID = " 
			lvConsentEyes = lvConsentEyes & lvResultArray(0,lvLoopCounter)			
			lvConsentEyes = lvConsentEyes & " Then Case when "
			lvConsentEyes = lvConsentEyes & lvResultArray(6,lvLoopCounter)        		 			
			lvConsentEyes = lvConsentEyes & " = 1 Then ConsentEyes.ConsentReportName "
			lvConsentEyes = lvConsentEyes & "else '' End "		
			
			lvRecoveryEyes = lvRecoveryEyes & " When Call.SourceCodeID = " 
			lvRecoveryEyes = lvRecoveryEyes & lvResultArray(0,lvLoopCounter)			
			lvRecoveryEyes = lvRecoveryEyes & " Then Case when "
			lvRecoveryEyes = lvRecoveryEyes	& lvResultArray(6,lvLoopCounter)        		 		
			lvRecoveryEyes = lvRecoveryEyes & " = 1 Then RecoveryEyes.ConversionReportName "
			lvRecoveryEyes = lvRecoveryEyes & "else '' End "			
	     	      
		Next
		
		lvAppropriateOrgan = lvAppropriateOrgan & "End AS AppropriateOrgan,  "
		lvApproachOrgan = lvApproachOrgan & "End AS ApproachOrgan,  "
		lvConsentOrgan = lvConsentOrgan & "End AS ConsentOrgan,  "
		lvRecoveryOrgan = lvRecoveryOrgan & "End AS RecoveryOrgan,  "
		lvAppropriateBone = lvAppropriateBone & "End AS AppropriateBone,  "
		lvApproachBone = lvApproachBone & "End AS ApproachBone,  "
		lvConsentBone = lvConsentBone & "End AS ConsentBone,  "
		lvRecoveryBone	= lvRecoveryBone & "End AS RecoveryBone,  "
		lvAppropriateTissue = lvAppropriateTissue & "End AS AppropriateTissue,  "
		lvApproachTissue = lvApproachTissue & "End AS ApproachTissue,  "
		lvConsentTissue = lvConsentTissue & "End AS ConsentTissue,  "
		lvRecoveryTissue = lvRecoveryTissue & "End AS RecoveryTissue,  "
		lvAppropriateSkin = lvAppropriateSkin & "End AS AppropriateSkin,  "
		lvApproachSkin = lvApproachSkin & "End AS ApproachSkin,  "
		lvConsentSkin = lvConsentSkin & "End AS ConsentSkin,  "
		lvRecoverySkin = lvRecoverySkin & "End AS RecoverySkin,  "
		lvAppropriateValves = lvAppropriateValves & "End AS AppropriateValves,  "
		lvApproachValves = lvApproachValves & "End AS ApproachValves,  "
		lvConsentValve = lvConsentValve & "End AS ConsentValve,  "
		lvRecoveryValve = lvRecoveryValve & "End AS RecoveryValve,  "
		lvAppropriateEyes = lvAppropriateEyes & "End AS AppropriateEyes,  "
		lvApproachEyes = lvApproachEyes & "End AS ApproachEyes,  "
		lvConsentEyes = lvConsentEyes & "End AS ConsentEyes,  "
		lvRecoveryEyes = lvRecoveryEyes & "End AS RecoveryEyes,  "
		
		
		lvQueryString = lvQueryString & lvAppropriateOrgan
		lvQueryString = lvQueryString & lvApproachOrgan
		lvQueryString = lvQueryString & lvConsentOrgan
		lvQueryString = lvQueryString & lvRecoveryOrgan
		lvQueryString = lvQueryString & lvAppropriateBone
		lvQueryString = lvQueryString & lvApproachBone
		lvQueryString = lvQueryString & lvConsentBone
		lvQueryString = lvQueryString & lvRecoveryBone
		lvQueryString = lvQueryString & lvAppropriateTissue
		lvQueryString = lvQueryString & lvApproachTissue
		lvQueryString = lvQueryString & lvConsentTissue
		lvQueryString = lvQueryString & lvRecoveryTissue
		lvQueryString = lvQueryString & lvAppropriateSkin
		lvQueryString = lvQueryString & lvApproachSkin
		lvQueryString = lvQueryString & lvConsentSkin
		lvQueryString = lvQueryString & lvRecoverySkin
		lvQueryString = lvQueryString & lvAppropriateValves
		lvQueryString = lvQueryString & lvApproachValves
		lvQueryString = lvQueryString & lvConsentValve
		lvQueryString = lvQueryString & lvRecoveryValve
		lvQueryString = lvQueryString & lvAppropriateEyes
		lvQueryString = lvQueryString & lvApproachEyes
		lvQueryString = lvQueryString & lvConsentEyes
		lvQueryString = lvQueryString & lvRecoveryEyes
		
		
		
	     ' CHECK FOR ORGAN ACCESS
	     'IF lvAccessOrgans = 1 Then
	        'lvQueryString = lvQueryString & "AppropOrgan.AppropriateReportName AS AppropriateOrgan, ApproaOrgan.ApproachReportName AS ApproachOrgan, ConsentOrgan.ConsentReportName AS ConsentOrgan, RecoveryOrgan.ConversionReportName AS RecoveryOrgan, "
	     'ELSE
  
	        'lvQueryString = lvQueryString & "'' AS AppropriateOrgan, '' AS ApproachOrgan, '' AS ConsentOrgan , '' AS RecoveryOrgan, "
	     'END IF
	     ' Check for bone access
	     'IF lvAccessBone = 1 Then
	       ' lvQueryString = lvQueryString & "AppropBone.AppropriateReportName AS AppropriateBone, ApproaBone.ApproachReportName AS ApproachBone, ConsentBone.ConsentReportName AS ConsentBone, RecoveryBone.ConversionReportName AS RecoveryBone, " 
	     'ELSE
	        'lvQueryString = lvQueryString & " '' AS AppropriateBone, '' AS ApproachBone, '' AS ConsentBone, '' AS RecoveryBone, " 
	     'END IF
	     ' Check for Tissue access
	     'IF lvAccessTissue = 1 Then
	      '  lvQueryString = lvQueryString & "AppropTissue.AppropriateReportName AS AppropriateTissue, ApproaTissue.ApproachReportName AS ApproachTissue, ConsentTissue.ConsentReportName AS ConsentTissue, RecoveryTissue.ConversionReportName AS RecoveryTissue,"
	     'ELSE
	        'lvQueryString = lvQueryString & "'' AS AppropriateTissue, '' AS ApproachTissue, '' AS ConsentTissue, '' AS RecoveryTissue,"     
	     'END IF
	     ' Check for skin access
	     'IF lvAccessSkin = 1 Then
	        'lvQueryString = lvQueryString & "AppropSkin.AppropriateReportName AS AppropriateSkin, ApproaSkin.ApproachReportName AS ApproachSkin, ConsentSkin.ConsentReportName AS ConsentSkin, RecoverySkin.ConversionReportName AS RecoverySkin, "
	     'ELSE
	       ' lvQueryString = lvQueryString & "'' AS AppropriateSkin, '' AS ApproachSkin, '' AS ConsentSkin, '' AS RecoverySkin, "
	     'END IF
	     ' Check for valves access
	     'IF lvAccessValves = 1 Then
	      '  lvQueryString = lvQueryString & "AppropValve.AppropriateReportName AS AppropriateValves, ApproaValve.ApproachReportName AS ApproachValves, ConsentValve.ConsentReportName AS ConsentValve, RecoveryValve.ConversionReportName AS RecoveryValve, "
	     'ELSE
	      '  lvQueryString = lvQueryString & "'' AS AppropriateValves, '' AS ApproachValves, '' AS ConsentValve, '' AS RecoveryValve, "
	     'END IF
	     'Check for eyes access
	     'IF lvAccessEyes = 1 Then
	     '   lvQueryString = lvQueryString & "AppropEyes.AppropriateReportName AS AppropriateEyes, ApproaEyes.ApproachReportName AS ApproachEyes, ConsentEyes.ConsentReportName AS ConsentEyes, RecoveryEyes.ConversionReportName AS RecoveryEyes, "
	     'ELSE
	     
	     '   lvQueryString = lvQueryString & "'' AS AppropriateEyes, '' AS ApproachEyes, '' AS ConsentEyes, '' AS RecoveryEyes, "
	     'END IF

		lvQueryString = lvQueryString & "' Field 60',' Field 61',' Field 62',' Field 63', "

	   lvQueryString = lvQueryString & "ReferralCallerOrganizationID AS OrganizationID, ReferralGeneralConsent, ReferralApproachTime, ReferralConsentTime "
	   lvQueryString = lvQueryString & ""
	   lvQueryString = lvQueryString & "FROM Call LEFT JOIN Referral ON Referral.CallID = Call.CallID "
	   lvQueryString = lvQueryString & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
	   lvQueryString = lvQueryString & "LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
	   lvQueryString = lvQueryString & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD "
	   lvQueryString = lvQueryString & "LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD "
	   lvQueryString = lvQueryString & "LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID "
	   lvQueryString = lvQueryString & "LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID "
	   lvQueryString = lvQueryString & "LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID "
	   lvQueryString = lvQueryString & "LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID "
	   lvQueryString = lvQueryString & "LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID "

	IF pvCallID > 0 Then
		lvQueryString = lvQueryString & "WHERE Call.CALLID = " 
		lvQueryString = lvQueryString & pvCallID
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
		IF pvAnd <> empty Then
				'Response.write pvAnd
				lvQueryString = lvQueryString & " "
				lvQueryString = lvQueryString & pvAnd
		End if

		   lvQueryString = lvQueryString & " ORDER BY "
		   lvQueryString = lvQueryString & pvOrderBy     
		   
	END IF  ' end CallID Exists   

	GetCondensedQuery = lvQueryString
	
	SET lvRS = nothing
	SET lvConn = nothing
	
End Function



%>
