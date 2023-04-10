<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<%
    	'03/22/06 ccarroll Added the following fields per StatTrac 8.0 Desgin Specification documentation:
	'- 4.2.5 ReferralDOB_ILB
	'- 4.3.6 ReferralDonorSpecificCOD
	'- 4.6.4 ReferralDonorBrainDeath Date/Time
	'- 4.7.2.4 ReferralDonorPronounce/Attending MDPhone
	'- 4.8.6 ReferralTypeName
	
	'12/12/06 ccarroll Added changes for StatTrac 8.0 Iteration 2, fixed errors

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
			DataSourceName = ARCHIVEDSN
			Set lvConn = GetConnection(DBUSER, DBPWD,DataSourceName )
			SET lvRS = lvConn.Execute(lvQueryString)
		End If	
		lvTZ = ZoneDifference(lvRS("CallDateTime"), vTZ)		
		
		
		SET lvRS = NOTHING
		'lvStartDAte = DateAdd("h", -lvTZ, pvStartDate)
	END IF	

     ' build sourcecode list
 	    
		IF pvUserOrgID <> 194 Then
		
			lvSCIList = ""
			
			lvQueryString = "SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode JOIN WebReportGroup ON WebReportGroup.WeBReportGroupID = WebReportGroupSourceCode.WebReportGroupID WHERE WebReportGroupMaster = 1 AND OrgHierarchyParentID =  " & pvUserOrgID
			'Print lvQueryString
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
				'Response.Write lvQueryString
			END IF
			'Print lvQueryString
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
	   lvQueryString = "exec sps_rpt_ReferralDetail_Extended_2006_Select "
	   lvQueryString = lvQueryString & "@TimeZoneOffset = " & lvTZ
	       
	IF pvCallID > 0 Then
		lvQueryString = lvQueryString & ", @CallID = " & pvCallID
		IF pvUserOrgID <> 194 Then
			lvQueryString = lvQueryString & ", @OrganizationIDParent = " & pvUserOrgID	
			lvQueryString = lvQueryString & ", @SourceCodeIDList = '" & lvSCIList & "';"	
		END IF 		
	ELSE
		lvQueryString = lvQueryString & ", @CallDateTimeStart = '" & lvStartDate & "'"
		lvQueryString = lvQueryString & ", @CallDateTimeEnd = '" & lvEndDate & "'"
		lvQueryString = lvQueryString & ", @WebReportGroupID = " & pvReportGroupID

		IF pvUserOrgID <> 194 Then
			lvQueryString = lvQueryString & ", @SourceCodeIDList = '" & lvSCIList & "'"	
		END IF 
		IF pvReferralTypeID > 0 Then
			lvQueryString = lvQueryString & ", @ReferralTypeID = " & pvReferralTypeID
		END IF
		IF PvOrgID <> 0 THEN
		    lvQueryString = lvQueryString & ", @OrganizationIDCaller = " & PvOrgID
		END IF
		lvQueryString = lvQueryString & ", @OrderBy = '" & pvOrderBy & "';"
	END IF  

	GetDetailList = lvQueryString
	
	SET lvRS = nothing
	SET lvConn = nothing
	
End Function



%>
