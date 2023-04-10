<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 


'Dim Conn
'Dim DataSourceName
'Dim RS
'Dim vQuery

Dim CallID
Dim	UserName
Dim UserOrgName
'Dim	UserOrgID
'Dim	UserID
Dim CallerOrgID
Dim ConsentComments
Dim RecoveryComments

Dim TZ
Dim UpdateSuccess
Dim GeneralConsent
Dim ValidationMessage

Dim DebugMode
Dim DebugMessage
DebugMessage = "<BR>Debug:"

DebugMode = False

'11/13/02 drh
Dim vLogId
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%
'Validate and update information
If ValidateReferral Then

	Response.Cookies("ConsentComments") = ""
	Response.Cookies("RecoveryComments") = ""
	
	DebugMessage = DebugMessage & "<BR>Before Update"
	
	'drh 11/20/02 - Check if User has the call open
	If CheckIfOpen Then
		If UpdateReferral Then
			UpdateSuccess = True
			ValidationMessage = _
			"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
			"Update Successful." & _
			"</FONT>"
		
			'11/13/02 drh Save Audit Log Info
			'Call SaveAuditLogInfo()
		Else
			UpdateSuccess = False
			ValidationMessage = _
			"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
			"Update Failed." & _
			"</FONT>"
		End If
	Else
		UpdateSuccess = False
		ValidationMessage = _
		"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
		"The maximum amount of time a referral can be locked has expired." & _
		"<br>This referral is currently open and cannot be modified at this time." & _
		"<br>Please try again later." & _
		"</FONT>"
	End If
	
End If
%>


<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Process Update</title>
</head>

<%'drh 11/20/02 - Added onUnload event handler%>
<body bgcolor="#F5EBDD" onUnload="javascript:cancelReferral();">


	<%'Response.Write(ValidationMessage & "<BR>" & DebugMessage)%>
	<%Response.Write(ValidationMessage)%>

	<br></br>
	<%'Show a Back button if the update failed.
	If UpdateSuccess = False Then%>
		<A	HREF="javascript:callCancel=0; window.history.back();" NAME="Back">
			<IMG src="/loginstatline/images/back.gif"
			NAME="Back"
			BORDER="0">
		</A>	
	<%End If%>
	
	<A	HREF="javascript:self.close();" NAME="Close">
		<IMG src="/loginstatline/images/close2.gif"
		NAME="Close"
		BORDER="0">
	</A>	
	
<%
If DebugMode = True Then
    Response.Write "<!-- "
    Dim strItem
    Response.Write "<b>FORM VARS</b><br>"
    For Each strItem In Request.Form
        Response.Write "<br>" & strItem & " = " 
        Response.Write Request.Form(strItem) & vbCrLf
    Next
    Response.Write "<br><br>"
    Response.Write "<b>QUERYSTRING VARS</b><br>"
    For Each strItem In Request.QueryString
        Response.Write "<br>" & strItem & " = " 
        Response.Write Request.QueryString(strItem) & vbCrLf
    Next
    Response.Write " -->"    
End If	
%>

</body>
</html>

<%
'11/13/02 drh - Save Audit Log Info
Function SaveAuditLogInfo()
	vLogId = Request.Form("vLogId")
	
	'Build the Query
	vQuery = "spu_AuditReferralSave 3, " & CallId & ", " & UserId & ", " & vLogId & ", 1"
	Response.Write(vQuery)	
	'Set RS = Conn.Execute(vQuery)
End Function
%>

<%'drh 11/20/02
Function CheckIfOpen()
	CheckIfOpen = false
	DataSourceName = "ProductionTransaction"
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.CommandTimeout = 2000
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	
	vQuery = "sps_IncompleteReferralDetail1 " & Request.Form("TZ") & ", " & Request.Form("CallID")
	'Response.Write(vQuery)
	Set RS = Conn.Execute(vQuery)	
	'Response.write(RS("CallOpenByID") & ": " & Request("UserID"))
	
	If RS("CallOpenByID") = 0 and RS("CallOpenByWebPersonId") = CInt(Request("UserID")) Then
		CheckIfOpen = true
	End If
End Function
%>
	

<%
Function UpdateReferral()

	'DataSourceName = "ProductionTransaction"
	CallID = Request.Form("CallID")
	UserName = Request.Form("UserName")
	UserOrgName = Request.Form("UserOrgName")
	UserOrgID = Request.Form("UserOrgID")
	UserID = Request.Form("UserID") 
	TZ = Request.Form("TZ")
	CallerOrgID = Request.Form("CallerOrgID")
	
	'Establish a database connection
	'Set Conn = server.CreateObject("ADODB.Connection")
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.CommandTimeout = 2000
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	'Build the query
	vQuery = "EXEC UpdateReferralPending "

		'Approach type
		If Request.Form("ApproachType") <> "" Then
			vQuery = vQuery & "@ReferralApproachTypeID = " & Request.Form("ApproachType") & ", "
		End If
	
		'Approach person
		'03/04/03 drh - Added code to remove Approach person if Not Approached
		If Request.Form("ApproachType") = 1 And Request.Form("OldApproachPersonId") <> "-1" Then
			vQuery = vQuery & "@ReferralApproachedByPersonID = 0, "
		ElseIf Request.Form("ApproachPerson") <> "" Then
			vQuery = vQuery & "@ReferralApproachedByPersonID = " & Request.Form("ApproachPerson") & ", "
		End If
		
		'03/12/03 drh - Save General Consent selected in drop-down
		'General Consent
		If Request.Form("GeneralConsent") <> "" Then
			vQuery = vQuery & "@ReferralGeneralConsent = " & Request.Form("GeneralConsent") & ", "
		End If
				
		'****************************
		'Approach
		'****************************
		'Organ
		If Request.Form("ApproachOrgan") <> "" Then
			vQuery = vQuery & "@ReferralOrganApproachID = " & Request.Form("ApproachOrgan") & ", "
		End If
		'Bone
		If Request.Form("ApproachBone") <> "" Then
			vQuery = vQuery & "@ReferralBoneApproachID = " & Request.Form("ApproachBone") & ", "
		End If
		'Tissue
		If Request.Form("ApproachTissue") <> "" Then
			vQuery = vQuery & "@ReferralTissueApproachID = " & Request.Form("ApproachTissue") & ", "
		End If
		'Skin
		If Request.Form("ApproachSkin") <> "" Then
			vQuery = vQuery & "@ReferralSkinApproachID = " & Request.Form("ApproachSkin") & ", "
		End If
		'Valves
		If Request.Form("ApproachValves") <> "" Then
			vQuery = vQuery & "@ReferralValvesApproachID = " & Request.Form("ApproachValves") & ", "
		End If
		'Eyes
		If Request.Form("ApproachEyes") <> "" Then
			vQuery = vQuery & "@ReferralEyesTransApproachID = " & Request.Form("ApproachEyes") & ", "
		End If
		'Other
		If Request.Form("ApproachOther") <> "" Then
			vQuery = vQuery & "@ReferralEyesRschApproachID = " & Request.Form("ApproachOther") & ", "
		End If
														
		'****************************
		'Consent
		'****************************
		'Organ
		If Request.Form("ConsentOrgan") <> "" Then
			vQuery = vQuery & "@ReferralOrganConsentID = " & Request.Form("ConsentOrgan") & ", "
		End If
		'Bone
		If Request.Form("ConsentBone") <> "" Then
			vQuery = vQuery & "@ReferralBoneConsentID = " & Request.Form("ConsentBone") & ", "
		End If
		'Tissue
		If Request.Form("ConsentTissue") <> "" Then
			vQuery = vQuery & "@ReferralTissueConsentID = " & Request.Form("ConsentTissue") & ", "
		End If
		'Skin
		If Request.Form("ConsentSkin") <> "" Then
			vQuery = vQuery & "@ReferralSkinConsentID = " & Request.Form("ConsentSkin") & ", "
		End If
		'Valves
		If Request.Form("ConsentValves") <> "" Then
			vQuery = vQuery & "@ReferralValvesConsentID = " & Request.Form("ConsentValves") & ", "
		End If
		'Eyes
		If Request.Form("ConsentEyes") <> "" Then
			vQuery = vQuery & "@ReferralEyesTransConsentID = " & Request.Form("ConsentEyes") & ", "
		End If
		'Other
		If Request.Form("ConsentOther") <> "" Then
			vQuery = vQuery & "@ReferralEyesRschConsentID = " & Request.Form("ConsentOther") & ", "
		End If
					
		'****************************
		'Conversion
		'****************************
		'Organ
		If Request.Form("ConversionOrgan") <> "" Then
			vQuery = vQuery & "@ReferralOrganConversionID = " & Request.Form("ConversionOrgan") & ", "
		End If
		'Bone
		If Request.Form("ConversionBone") <> "" Then
			vQuery = vQuery & "@ReferralBoneConversionID = " & Request.Form("ConversionBone") & ", "
		End If
		'Tissue
		If Request.Form("ConversionTissue") <> "" Then
			vQuery = vQuery & "@ReferralTissueConversionID = " & Request.Form("ConversionTissue") & ", "
		End If
		'Skin
		If Request.Form("ConversionSkin") <> "" Then
			vQuery = vQuery & "@ReferralSkinConversionID = " & Request.Form("ConversionSkin") & ", "
		End If
		'Valves
		If Request.Form("ConversionValves") <> "" Then
			vQuery = vQuery & "@ReferralValvesConversionID = " & Request.Form("ConversionValves") & ", "
		End If
		'Eyes
		If Request.Form("ConversionEyes") <> "" Then
			vQuery = vQuery & "@ReferralEyesTransConversionID = " & Request.Form("ConversionEyes") & ", "
		End If
		'Other
		If Request.Form("ConversionOther") <> "" Then
			vQuery = vQuery & "@ReferralEyesRschConversionID = " & Request.Form("ConversionOther") & ", "
		End If
	
		vQuery = vQuery & "@LastStatEmployeeID = 77, " '77online user. Note the comma and space is stripped off
		
	'Strip the last ',' 
	vQuery = Left(vQuery, Len(vQuery) - 2)
	
	'Specify the call to update
	vQuery = vQuery & ", @CallID = " & CallID
	
	DebugMessage = DebugMessage & "<BR>Query: " & vQuery
	
	
	Call Conn.Execute(vQuery)
	
	'There was a db error
	If Conn.Errors.Count > 0 Then
	
		DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
		'Discontinue processing of the function
		UpdateReferral = False
		Exit Function
	
	Else
		'03/04/03 drh - If the referral was successfully updated, 
		'update the Approached Person field
		If Request.Form("ApproachType") = 1 And Request.Form("OldApproachPersonId") <> "0" And Request.Form("OldApproachPersonId") <> "-1" Then
			If InsertApproachPersonLogEvent = False Then
				'Discontinue processing of the function
				UpdateReferral = False
				Exit Function
			End If
		End If
	
	
		'Update the consent comments
		If Request.Form("ConsentVisible") = "True" Then
			If UpdateConsentComments = False Then
				'Discontinue processing of the function
				UpdateReferral = False
				Exit Function
			End If		
		End If
		
		'Update the recovery comments
		If Request.Form("RecoveryVisible") = "True" Then
			'Check if any of the recovery information was updated
			If (Request.Form("ConversionOrgan") = "" Or Request.Form("ConversionOrgan") = "-1") And _
			(Request.Form("ConversionBone") = "" Or Request.Form("ConversionBone") = "-1") And _
			(Request.Form("ConversionTissue") = "" Or Request.Form("ConversionTissue") = "-1") And _
			(Request.Form("ConversionSkin") = "" Or Request.Form("ConversionSkin") = "-1") And _
			(Request.Form("ConversionValves") = "" Or Request.Form("ConversionValves") = "-1") And _
			(Request.Form("ConversionEyes") = "" Or Request.Form("ConversionEyes") = "-1") And _
			(Request.Form("ConversionOther") = "" Or Request.Form("ConversionOther") = "-1") _
			Then
				'Do nothing
			Else
				If UpdateRecoveryComments = False Then
					'Discontinue processing of the function
					UpdateReferral = False
					Exit Function
				End If	
			End If			
		End If
		
	End If
		
	
	UpdateReferral = True
	
End Function

Function InsertApproachPersonLogEvent
'03/04/03 drh - Added function to insert note for modified approach person

	'Get the name of the old approach person
	vQuery = "sps_Person null, " & Request.Form("OldApproachPersonId")
	Set RS = Conn.Execute(vQuery)	
	'There was a db error
	If Conn.Errors.Count > 0 Then
		'Discontinue processing of the function
		InsertApproachPersonLogEvent = False
		Exit Function
	End If	
	
	Dim OldApproachPersonName
	Dim ChangeNote
	OldApproachPersonName = RS("PersonFirst") & " " & RS("PersonLast")
	Set RS = Nothing	

	'Log the change
	ChangeNote = "Removed approach person " & OldApproachPersonName & "."

	'Insert a consent outcome event	
	vQuery = "EXEC InsertLogEvent "
	vQuery = vQuery & "@CallID = " & CallID
	vQuery = vQuery & ", @LogEventTypeID = 1"	
	vQuery = vQuery & ", @LogEventName = '" & UserName & "'"
	vQuery = vQuery & ", @LogEventPhone = ''"
	vQuery = vQuery & ", @LogEventOrg = '" & UserOrgName & "'"
	vQuery = vQuery & ", @LogEventDesc = '" & ChangeNote & "'"
	vQuery = vQuery & ", @StatEmployeeID = 77 " '77 is Online User
	vQuery = vQuery & ", @LogEventDateTime = '" & Now() & "'"
	vQuery = vQuery & ", @LogEventCallbackPending = 0"
	vQuery = vQuery & ", @OrganizationID = " & UserOrgID
	vQuery = vQuery & ", @ScheduleGroupID = 0" 
	vQuery = vQuery & ", @PersonID  = " & UserID
	vQuery = vQuery & ", @PhoneID = 0"
	vQuery = vQuery & ", @LogEventContactConfirmed = 0"
	vQuery = vQuery & ", @LastStateEmployeeID = 77" '77 is Online User
	 			
	DebugMessage = DebugMessage & "<BR>Query: " & vQuery	 			
	Call Conn.Execute(vQuery)
			
	'There was a db error
	If Conn.Errors.Count > 0 Then
		'Discontinue processing of the function
		InsertApproachPersonLogEvent = False
	Else
		InsertApproachPersonLogEvent = True
	End If				
		
	Set RS = Nothing
	
End Function


Function UpdateConsentComments

	'Clean up any apostrophes
	ConsentComments = BuildString(ConsentComments)
	
	'Insert a consent outcome event	
	vQuery = "EXEC InsertLogEvent "
	vQuery = vQuery & "@CallID = " & CallID
	vQuery = vQuery & ", @LogEventTypeID = 7"
	vQuery = vQuery & ", @LogEventName = '" & UserName & "'"
	vQuery = vQuery & ", @LogEventPhone = ''"
	vQuery = vQuery & ", @LogEventOrg = '" & UserOrgName & "'"
	vQuery = vQuery & ", @LogEventDesc = '" & ConsentComments & "'"
	vQuery = vQuery & ", @StatEmployeeID = 77 " '77 is Online User
	vQuery = vQuery & ", @LogEventDateTime = '" & Now() & "'"
	vQuery = vQuery & ", @LogEventCallbackPending = 0"
	vQuery = vQuery & ", @OrganizationID = " & UserOrgID
	vQuery = vQuery & ", @ScheduleGroupID = 0" 
	vQuery = vQuery & ", @PersonID  = " & UserID
	vQuery = vQuery & ", @PhoneID = 0"
	vQuery = vQuery & ", @LogEventContactConfirmed = 0"	
	vQuery = vQuery & ", @LastStatEmployeeID = 77" '77 is Online User
	
	DebugMessage = DebugMessage & "<BR>Query: " & vQuery
	
	Call Conn.Execute(vQuery)
			
	'There was a db error
	If Conn.Errors.Count > 0 Then
		'Discontinue processing of the function
		UpdateConsentComments = False
	Else
		UpdateConsentComments = True
	End If	
	
	'Update the consent pending for the organization or for the hospital
	vQuery = "Exec UpdateLogEventPending "
	vQuery = vQuery & " @CallID = " & CallID 
	vQuery = vQuery & ", @LogEventTypeID = 4 "
	vQuery = vQuery & ", @UserOrgID = " & UserOrgID 
	vQuery = vQuery & ", @CallerOrgID = " & CallerOrgID 
	vQuery = vQuery & ", @LastStatEmployeeID = 77 " '77 is Online User
	
	Call Conn.Execute(vQuery)
			
	'There was a db error
	If Conn.Errors.Count > 0 Then
		'Discontinue processing of the function
		UpdateConsentComments = False
	Else
		UpdateConsentComments = True
	End If	
			
		
	Set RS = Nothing
	
End Function

Function UpdateRecoveryComments

	'Insert a recovery outcome event	
	vQuery = "EXEC InsertLogEvent "
	vQuery = vQuery & "@CallID = " & CallID
	vQuery = vQuery & ", @LogEventTypeID = 8"
	vQuery = vQuery & ", @LogEventName = '" & UserName & "'"
	vQuery = vQuery & ", @LogEventPhone = ''"
	vQuery = vQuery & ", @LogEventOrg = '" & UserOrgName & "'"
	vQuery = vQuery & ", @LogEventDesc = '" & RecoveryComments & "'"
	vQuery = vQuery & ", @StatEmployeeID = 77 " '77 is Online User
	vQuery = vQuery & ", @LogEventDateTime = '" & Now() & "'"
	vQuery = vQuery & ", @LogEventCallbackPending = 0"
	vQuery = vQuery & ", @OrganizationID = " & UserOrgID
	vQuery = vQuery & ", @ScheduleGroupID = 0" 
	vQuery = vQuery & ", @PersonID  = " & UserID
	vQuery = vQuery & ", @PhoneID = 0"
	vQuery = vQuery & ", @LogEventContactConfirmed = 0"	
	vQuery = vQuery & ", @LastStatEmployeeID = 77" '77 is Online User
	
	DebugMessage = DebugMessage & "<BR>Query: " & vQuery
	
	Call Conn.Execute(vQuery)
			
	'There was a db error
	If Conn.Errors.Count > 0 Then
		'Discontinue processing of the function
		UpdateRecoveryComments = False
	Else
		UpdateRecoveryComments = True
	End If	
		
	Set RS = Nothing
	
End Function


Function ValidateReferral
	
	ConsentComments = Request.Form("ConsentComments")
	RecoveryComments = Request.Form("RecoveryComments")
		
	'Assume validation is true
	ValidateReferral = True
	
	ValidationMessage = _
	"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
	"Validation Error!" & _
	"</FONT><BR></BR>"
	
	Response.Cookies("ConsentComments") = Request.Form("ConsentComments")	
	Response.Cookies("RecoveryComments") = Request.Form("RecoveryComments")	

	'Check for approach person with no approach type
	'03/04/03 drh - Commented this entire If stmt. since new code was added to remove the Approach Person if Not Approached
	'If Request.Form("ApproachType") = 1 And Request.Form("OldApproachPersonId") = "0" And Request.Form("ApproachPerson") <> "-1" Then
		'ValidationMessage = ValidationMessage & _
		'"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		'"Approach person with no approach method." & _
		'"</FONT><BR>"
		'ValidateReferral = False
	'End If
	
	'Check for approach type with no approach person
	If Request.Form("ApproachType") > 1 And Request.Form("ApproachPerson") = "-1" Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"Approach method with no approach person." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If
	
	'03/12/03 drh
	'Check for approach with no general consent
	If Request.Form("ApproachType") > 1 And Request.Form("GeneralConsent") = "-1" Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"Approach method with no General Consent." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If
	
	'Check for approach type with no approach
	If Request.Form("ApproachType") > 1 And _
	(Request.Form("ApproachOrgan") = "" Or Request.Form("ApproachOrgan") = "-1") And _
	(Request.Form("ApproachBone") = "" Or Request.Form("ApproachBone") = "-1") And _
	(Request.Form("ApproachTissue") = "" Or Request.Form("ApproachTissue") = "-1") And _
	(Request.Form("ApproachSkin") = "" Or Request.Form("ApproachSkin") = "-1") And _
	(Request.Form("ApproachValves") = "" Or Request.Form("ApproachValves") = "-1") And _
	(Request.Form("ApproachEyes") = "" Or Request.Form("ApproachEyes") = "-1") And _
	(Request.Form("ApproachOther") = "" Or Request.Form("ApproachOther") = "-1") _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"Approach method with no approach for the available options." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If
	
	'Check for no approach type with 'Yes' approach
	If Request.Form("ApproachType") = 1 And ( _
	Request.Form("ApproachOrgan") = "1" Or _
	Request.Form("ApproachBone") = "1" Or _
	Request.Form("ApproachTissue") = "1" Or _
	Request.Form("ApproachSkin") = "1" Or _
	Request.Form("ApproachValves") = "1" Or _
	Request.Form("ApproachEyes") = "1" Or _
	Request.Form("ApproachOther") = "1" ) _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"Approach method is 'Not Approached', yet an approach is specified." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If
	
	'03/12/03 drh - Changed option value checks from 1 (Yes) to -1 (Blank) and operaters (inner operand) from And to Or
	'Check "Yes" Approach Type with no "Yes" Option Approach
	If Request.Form("ApproachType") > 1 And _
	(Request.Form("ApproachOrgan") = "-1" Or _
	Request.Form("ApproachBone") = "-1" Or _
	Request.Form("ApproachTissue") = "-1" Or _
	Request.Form("ApproachSkin") = "-1" Or _
	Request.Form("ApproachValves") = "-1" Or _
	Request.Form("ApproachEyes") = "-1" Or _
	Request.Form("ApproachOther") = "-1") _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"Approach method is specified, yet an Option Approach is blank." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If
	
	'03/12/03 drh - Added
	'Check for "Yes" General Consent with no "Yes" Option Consent
	' Fixed first "ConsentOther" - set to <> "1" - there were two that were <> "7".  3/16/05 - SAP
	If (Request.Form("GeneralConsent") = 1 Or Request.Form("GeneralConsent") = 2) And  _
	Request.Form("ConsentOrgan") <> "1" And _
	Request.Form("ConsentBone") <> "1" And _
	Request.Form("ConsentTissue") <> "1" And _
	Request.Form("ConsentSkin") <> "1" And _
	Request.Form("ConsentValves") <> "1" And _
	Request.Form("ConsentEyes") <> "1" And _
	Request.Form("ConsentOther") <> "1" And _
	Request.Form("ConsentOrgan") <> "7" And _
	Request.Form("ConsentBone") <> "7" And _
	Request.Form("ConsentTissue") <> "7" And _
	Request.Form("ConsentSkin") <> "7" And _
	Request.Form("ConsentValves") <> "7" And _
	Request.Form("ConsentEyes") <> "7" And _
	Request.Form("ConsentOther") <> "7" And _
	Request.Form("ConsentOrgan") <> "8" And _
	Request.Form("ConsentBone") <> "8" And _
	Request.Form("ConsentTissue") <> "8" And _
	Request.Form("ConsentSkin") <> "8" And _
	Request.Form("ConsentValves") <> "8" And _
	Request.Form("ConsentEyes") <> "8" And _
	Request.Form("ConsentOther") <> "8" _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"General Consent is Yes, yet no Option Consent is Yes." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If
	
	'03/12/03 drh - Added
	'Check for "No" General Consent with a "Yes" Option Consent
	If Request.Form("GeneralConsent") = 3 And  _
	(Request.Form("ConsentOrgan") = "1" Or _
	Request.Form("ConsentBone") = "1" Or _
	Request.Form("ConsentTissue") = "1" Or _
	Request.Form("ConsentSkin") = "1" Or _
	Request.Form("ConsentValves") = "1" Or _
	Request.Form("ConsentEyes") = "1" Or _
	Request.Form("ConsentOther") = "1" Or _
	Request.Form("ConsentOrgan") = "7" Or _
	Request.Form("ConsentBone") = "7" Or _
	Request.Form("ConsentTissue") = "7" Or _
	Request.Form("ConsentSkin") = "7" Or _
	Request.Form("ConsentValves") = "7" Or _
	Request.Form("ConsentEyes") = "7" Or _
	Request.Form("ConsentOther") = "7" Or _
	Request.Form("ConsentOrgan") = "8" Or _
	Request.Form("ConsentBone") = "8" Or _
	Request.Form("ConsentTissue") = "8" Or _
	Request.Form("ConsentSkin") = "8" Or _
	Request.Form("ConsentValves") = "8" Or _
	Request.Form("ConsentEyes") = "8" Or _
	Request.Form("ConsentOther") = "8") _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"General Consent is No, yet an Option Consent is Yes." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If
			
	'Check for consent with no approach
	If _	
		((Request.Form("ApproachOrgan") <> "1" And Request.Form("ApproachOrgan") <> "12" And Request.Form("ApproachOrgan") <> "13") And Request.Form("ConsentOrgan") > "-1") Or _
		((Request.Form("ApproachBone") <> "1" And Request.Form("ApproachBone") <> "12" And Request.Form("ApproachBone") <> "13") And Request.Form("ConsentBone") > "-1") Or _
		((Request.Form("ApproachTissue") <> "1" And Request.Form("ApproachTissue") <> "12" And Request.Form("ApproachTissue") <> "13") And Request.Form("ConsentTissue") > "-1") Or _
		((Request.Form("ApproachSkin") <> "1" And Request.Form("ApproachSkin") <> "12" And Request.Form("ApproachSkin") <> "13") And Request.Form("ConsentSkin") > "-1") Or _
		((Request.Form("ApproachValves") <> "1" And Request.Form("ApproachValves") <> "12" And Request.Form("ApproachValves") <> "13") And Request.Form("ConsentValves") > "-1") Or _
		((Request.Form("ApproachEyes") <> "1" And Request.Form("ApproachEyes") <> "12" And Request.Form("ApproachEyes") <> "13") And Request.Form("ConsentEyes") > "-1") Or _
		((Request.Form("ApproachOther") <> "1" And Request.Form("ApproachOther") <> "12" And Request.Form("ApproachOther") <> "13") And Request.Form("ConsentOther") > "-1") _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"Consent specified with no approach." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If	
	
	'Check for 'Yes' approach with no consent
	If _
	((Request.Form("ApproachOrgan") = "1" Or Request.Form("ApproachOrgan") = "12" Or Request.Form("ApproachOrgan") = "13") And Request.Form("ConsentOrgan") = "-1") Or _
	((Request.Form("ApproachBone") = "1" Or Request.Form("ApproachBone") = "12" Or Request.Form("ApproachBone") = "13") And Request.Form("ConsentBone") = "-1") Or _
	((Request.Form("ApproachTissue") = "1" Or Request.Form("ApproachTissue") = "12" Or Request.Form("ApproachTissue") = "13") And Request.Form("ConsentTissue") = "-1") Or _
	((Request.Form("ApproachSkin") = "1" Or Request.Form("ApproachSkin") = "12" Or Request.Form("ApproachSkin") = "13") And Request.Form("ConsentSkin") = "-1") Or _
	((Request.Form("ApproachValves") = "1" Or Request.Form("ApproachValves") = "12" Or Request.Form("ApproachValves") = "13") And Request.Form("ConsentValves") = "-1") Or _
	((Request.Form("ApproachEyes") = "1" Or Request.Form("ApproachEyes") = "12" Or Request.Form("ApproachEyes") = "13") And Request.Form("ConsentEyes") = "-1") Or _
	((Request.Form("ApproachOther") = "1" Or Request.Form("ApproachOther") = "12" Or Request.Form("ApproachOther") = "13") And Request.Form("ConsentOther") = "-1") _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"Approach is specified as 'Yes', but there is no consent outcome." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If	
		
	'Check for recovery with no consent
	If _
	((Request.Form("ConsentOrgan") <> "1" And Request.Form("ConsentOrgan") <> "7" And Request.Form("ConsentOrgan") <> "8") And Request.Form("ConversionOrgan") > "-1") Or _
	((Request.Form("ConsentBone") > "1" And Request.Form("ConsentBone") <> "7" And Request.Form("ConsentBone") <> "8") And Request.Form("ConversionBone") > "-1") Or _
	((Request.Form("ConsentTissue") > "1" And Request.Form("ConsentTissue") <> "7" And Request.Form("ConsentTissue") <> "8") And Request.Form("ConversionTissue") > "-1") Or _
	((Request.Form("ConsentSkin") > "1" And Request.Form("ConsentSkin") <> "7" And Request.Form("ConsentSkin") <> "8") And Request.Form("ConversionSkin") > "-1") Or _
	((Request.Form("ConsentValves") > "1" And Request.Form("ConsentValves") <> "7" And Request.Form("ConsentValves") <> "8") And Request.Form("ConversionValves") > "-1") Or _
	((Request.Form("ConsentEyes") > "1" And Request.Form("ConsentEyes") <> "7" And Request.Form("ConsentEyes") <> "8") And Request.Form("ConversionEyes") > "-1") Or _
	((Request.Form("ConsentOther") > "1" And Request.Form("ConsentOther") <> "7" And Request.Form("ConsentOther") <> "8") And Request.Form("ConversionOther") > "-1") _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"Recovery specified with no consent." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If	
	
	'Check for no data updates
	'03/04/03 drh - Changed Request.Form("ApproachType") = 1 to Request.Form("ApproachType") = -1 since we allow Not Approached to be entered now
	If (Request.Form("ApproachType") = "" Or Request.Form("ApproachType") = -1) And _
	(Request.Form("ApproachPerson") = "" Or Request.Form("ApproachPerson") = "-1") And _
	(Request.Form("ApproachOrgan") = "" Or Request.Form("ApproachOrgan") = "-1") And _
	(Request.Form("ApproachBone") = "" Or Request.Form("ApproachBone") = "-1") And _
	(Request.Form("ApproachTissue") = "" Or Request.Form("ApproachTissue") = "-1") And _
	(Request.Form("ApproachSkin") = "" Or Request.Form("ApproachSkin") = "-1") And _
	(Request.Form("ApproachValves") = "" Or Request.Form("ApproachValves") = "-1") And _
	(Request.Form("ApproachEyes") = "" Or Request.Form("ApproachEyes") = "-1") And _
	(Request.Form("ApproachOther") = "" Or Request.Form("ApproachOther") = "-1") And _
	(Request.Form("ConsentOrgan") = "" Or Request.Form("ConsentOrgan") = "-1") And _
	(Request.Form("ConsentBone") = "" Or Request.Form("ConsentBone") = "-1") And _
	(Request.Form("ConsentTissue") = "" Or Request.Form("ConsentTissue") = "-1") And _
	(Request.Form("ConsentSkin") = "" Or Request.Form("ConsentSkin") = "-1") And _
	(Request.Form("ConsentValves") = "" Or Request.Form("ConsentValves") = "-1") And _
	(Request.Form("ConsentEyes") = "" Or Request.Form("ConsentEyes") = "-1") And _
	(Request.Form("ConsentOther") = "" Or Request.Form("ConsentOther") = "-1") And _	
	(Request.Form("ConversionOrgan") = "" Or Request.Form("ConversionOrgan") = "-1") And _
	(Request.Form("ConversionBone") = "" Or Request.Form("ConversionBone") = "-1") And _
	(Request.Form("ConversionTissue") = "" Or Request.Form("ConversionTissue") = "-1") And _
	(Request.Form("ConversionSkin") = "" Or Request.Form("ConversionSkin") = "-1") And _
	(Request.Form("ConversionValves") = "" Or Request.Form("ConversionValves") = "-1") And _
	(Request.Form("ConversionEyes") = "" Or Request.Form("ConversionEyes") = "-1") And _
	(Request.Form("ConversionOther") = "" Or Request.Form("ConversionOther") = "-1") _
	Then
		ValidationMessage = ValidationMessage & _
		"<img src=/loginstatline/images/bulletWithSpace1.gif><FONT SIZE=2 FACE=Arial>" & _
		"There are no changes to be updated." & _
		"</FONT><BR>"
		ValidateReferral = False
	End If
	
	'Check for no consent comments
	If Request.Form("ConsentComments") = "" And Request.Form("ConsentVisible") = "True" Then
		ConsentComments = "No comments."
	End If
		
	'Check for no recovery comments
	If Request.Form("RecoveryComments") = "" And Request.Form("ConsentVisible") = "" And Request.Form("RecoveryVisible") = "True" Then
		RecoveryComments = "No comments."
	End If
			
End Function


Function BuildString(pString)

    Dim i
    
    i = InStr(1, pString, "'", 0)
    
    While i > 0
        pString = Left(pString, i - 1) & "''" & Right(pString, Len(pString) - (i - 1 + Len("'")))
        
        i = InStr(i + Len("''"), pString, "'", 0)
    Wend

    BuildString = pString

End Function

%>

<%'drh 11/20/02%>
<script language="JavaScript">
	var callCancel = 1

	function cancelReferral()
	{
		if (callCancel==1)
		{
			window.open('CancelReferral.sls?CallID=<%=Request.Form("CallID")%>&UserID=<%=Request.Form("UserID")%>&UserOrgID=<%=Request.Form("UserOrgID")%>&TZ=<%=Request.Form("TZ")%>&LogId=<%=Request.Form("LogId")%>')
		}
	}
</script>


