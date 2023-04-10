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
Dim OriginalOrgID
Dim Comments
Dim ChangeNote
Dim OldApproachPersonID
Dim NewApproachPersonID
Dim DesignatedRequestorId
Dim DRPersonLast
Dim DRPersonFirst
Dim DRPersonTypeId
Dim DRPersonActive
Dim DROrganizationId

Dim OldApproachPersonName
Dim NewApproachPersonName

Dim UpdateSuccess
Dim ValidationMessage

Dim DebugMessage
%>


<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Process Update</title>
</head>

<body bgcolor="#F5EBDD" onUnload="javascript:window.opener.location.reload();">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
Call UpdateDesignatedRequestor
%>

<%=DebugMessage%>

<BR><BR>
<%If InStr(DebugMessage, "Successful") = 0 Then%>
	<A	HREF="javascript:callCancel=0; window.history.back();" NAME="Back">
		<IMG src="/loginstatline/images/back.gif"
		NAME="Back"
		BORDER="0">
	</A>
<%End If%>


<A	HREF="javascript:self.close();">
	<IMG src="/loginstatline/images/close2.gif"
	NAME="Cancel"
	BORDER="0">
</A>


</body>
</html>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

<%
Function UpdateDesignatedRequestor()

	If Request.Form("DRPersonFirst") = "" Then
		DebugMessage = "<FONT COLOR=red><B>Please enter a First Name.</B></FONT>"
		UpdateDesignatedRequestor = False
		Exit Function
	End If
	
	If Request.Form("DRPersonLast") = "" Then
		DebugMessage = "<FONT COLOR=red><B>Please enter a Last Name.</B></FONT>"
		UpdateDesignatedRequestor = False
		Exit Function
	End If

	DataSourceName = "ProductionTransaction"
	UserOrgID = Request.Form("UserOrgID")
	UserID = Request.Form("UserID")
	OriginalOrgID = Request.Form("OriginalOrgID")
	DesignatedRequestorID = Request.Form("DesignatedRequestorID")
	DRPersonLast = AddDRSuffix(Request.Form("DRPersonLast"), Request.Form("DRPersonDesignated"))
	DRPersonFirst = Request.Form("DRPersonFirst")
	DRPersonTypeId = Request.Form("DRPersonTypeId")
	DRPersonActive = ConvertCheckbox(Request.Form("DRPersonActive"))
	DROrganizationId = Request.Form("DROrganizationId")
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	

	'Check if a person with the same name already exists for this org
	vQuery = "SELECT PersonId FROM Person WHERE (PersonLast = '" & BuildString(Request.Form("DRPersonLast")) & "' OR PersonLast = '" & BuildString(Request.Form("DRPersonLast")) & "*') AND PersonFirst = '" & BuildString(Request.Form("DRPersonFirst")) & "' AND OrganizationId = " & Request.Form("DROrganizationID")
	'response.write(vQuery)
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.CommandTimeout = 2000
	Conn.Open DataSourceName, DBUSER, DBPWD
	Set RS = Conn.Execute(vQuery)
	
	If Not RS.EOF Then
		If RS("PersonId") <> Clng(DesignatedRequestorId) Then
			DebugMessage = "<FONT COLOR=red><B>A person with the same name already exists for this organization.</B></FONT>"
			UpdateDesignatedRequestor = False
			Exit Function
		End If
	End If
	
	
	'Insert/Update the Person
	vQuery = "spu_OrganizationPerson " & DesignatedRequestorId & ", '" & BuildString(DRPersonLast) & "', '" & BuildString(DRPersonFirst) & "', " & DRPersonTypeId & ", " & DROrganizationId & ", " & DRPersonActive & ", " & OriginalOrgId
	'response.write(vQuery)
	Call Conn.Execute(vQuery)

	If Conn.Errors.Count > 0 Then

		DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
		'Discontinue processing of the function
		UpdateDesignatedRequestor = False
		Exit Function

	Else
		'If the Person was successfully updated
		DebugMessage = "<B>Update Successful!</B>"	

	End If

	UpdateDesignatedRequestor = True
	
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

Function AddDRSuffix(pvString, pvDRChecked)
	AddDRSuffix = pvString

	'Strip all ending asterix
	do while right(AddDRSuffix, 1) = "*"
		AddDRSuffix = left(AddDRSuffix, len(AddDRSuffix)-1)
	loop
	
	'Add suffix
	if pvDRChecked = "on" then
		AddDRSuffix = AddDRSuffix & "*"
	end if
End Function

Function ConvertCheckbox(pvDRChecked)
	ConvertCheckbox = 0

	if pvDRChecked = "on" then
		ConvertCheckbox = 1
	end if
End Function

%>


