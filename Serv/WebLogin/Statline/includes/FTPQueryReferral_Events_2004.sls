<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<%

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
	   lvQueryString = ""
	   
		'Fields 1-11
		lvQueryString = "SELECT DISTINCT DATEADD(hour, " & lvTZ & ", LogEvent.LastModified) as LastModified,  "
		lvQueryString = lvQueryString & "LogEventID, ReferralID, CallNumber, LogEvent.LogEventTypeID, LogEventTypeName, "
		lvQueryString = lvQueryString & "DATEADD(hour, " & lvTZ & ", LogEventDateTime) as LogEventDateTime, LogEvent.PersonID, LogEventName, "
		lvQueryString = lvQueryString & "LogEventPhone, LogEvent.OrganizationID, LogEventOrg, "
		lvQueryString = lvQueryString & "REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',  "
		lvQueryString = lvQueryString & "StatEmployeeFirstName + ' ' + StatEmployeeLastName  AS LogEventCreatedBy, "
		
		'Fields 15-20 
		lvQueryString = lvQueryString & "ReferralEventAttnTo = CASE LogEvent.LogEventTypeID WHEN 18 THEN FaxQueueTo WHEN 19 THEN FaxQueueTo ELSE NULL END, "
		lvQueryString = lvQueryString & "DateDiff(n, LogEventDateTime,LogEventCalloutDateTime) AS ReferralEventCalloutMin, "
		lvQueryString = lvQueryString & "Cast(DatePart(hh,LogEventCalloutDateTime) AS Varchar) + ':' + Cast(DatePart(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter, "
		lvQueryString = lvQueryString & "CASE LogEventContactConfirmed WHEN 1 Then 'Y' ELSE 'N' END AS ReferralEventContactConfirm, "
		lvQueryString = lvQueryString & "ReferralEventFaxNbr = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFaxNo WHEN 19 THEN FaxQueueFaxNo ELSE NULL END, "
		lvQueryString = lvQueryString & "ReferralEventDocName = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFormName WHEN 19 THEN FaxQueueFormName ELSE NULL END "
	         
	
		lvQueryString = lvQueryString & "FROM LogEvent JOIN Call ON Call.CallID = LogEvent.CallID "
		lvQueryString = lvQueryString & "LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID "
		lvQueryString = lvQueryString & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
		lvQueryString = lvQueryString & "JOIN Referral ON Referral.CallID = LogEvent.CallID "
		lvQueryString = lvQueryString & "JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
		lvQueryString = lvQueryString & "LEFT JOIN FaxQueue ON FaxQueue.FaxQueueCallId = LogEvent.CallId "
		lvQueryString = lvQueryString & "AND FaxQueue.FaxQueueById = LogEvent.StatEmployeeID "
  
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
			lvQueryString = lvQueryString & "WHERE LogEvent.LogEventDateTime BETWEEN '"
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
	
	SET lvRS = nothing
	SET lvConn = nothing
	
End Function



%>
