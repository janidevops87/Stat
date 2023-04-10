<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 


'Declare variables
Dim ErrorReturn
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim vOrgList
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim pvReferralTypeID
Dim pvCallID
Dim pvOrderBy
Dim pvOptions
Dim pvNoName
Dim vReportGroupName
Dim vReportTitle
Dim vShowGroup1
Dim pvAnd

Dim pvDesignatedRequestorID

Dim Identify
Dim Org
Dim Children
Dim Referral
Dim vTZ
Dim i
Dim RHead(3)
Dim y
Dim x
Dim ResultArray
Dim TypeName
Dim RefDataArray
Dim Section2
Dim Section4
Dim LastOrganization
Dim CountCheck
Dim ErrorCatch

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog

'Declare format vaiables
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeHeadLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"
Dim vInsertBreaks
Dim vBreakValue
Dim vDRChecked
%>

<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Update Person</title>
<STYLE>
	H5 {page-break-before: always}
</STYLE>
</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->


<%
'Execute the main page generating routine
If AuthorizeMain Then
	Call ExecuteMain	
End If
Set Conn = Nothing
%>

</body>
</html>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

<%

Function ExecuteMain()

	'Create a connection object
	Set Conn = server.CreateObject("ADODB.Connection")
	Server.ScriptTimeout = 270
	Conn.CommandTimeout = 90
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the query variables
	pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
	pvDesignatedRequestorID = FormatNumber(Request.QueryString("DesignatedRequestorID"),0,,0,0)
	
	Dim vDRQuery
	Dim vPersonFirst
	Dim vPersonLast
	Dim vPersonTypeId
	Dim vPersonInactive
	Dim vPersonOrganizationId
	
	vDRQuery = "Select p.PersonFirst, p.PersonLast, p.PersonTypeId, p.Inactive, p.OrganizationId From Person p Where p.PersonId = " & pvDesignatedRequestorID & " And p.organizationid = " & pvOrgId
	Set RS = Conn.Execute(vDRQuery)

	If Not RS.EOF Then
		vPersonFirst = RS("PersonFirst")
		vPersonLast = StripDRSuffix(RS("PersonLast"))
		vPersonTypeId = RS("PersonTypeId")
		vPersonInactive = RS("Inactive")
		vPersonOrganizationId = RS("OrganizationId")
	Else
		vPersonFirst = ""
		vPersonLast = ""
		vPersonTypeId = 47	'Accts Payable
		vPersonInactive = 0
		vPersonOrganizationId = CLng(pvOrgId)
	End If

	vDRQuery = "Select pt.PersonTypeId, pt.PersonTypeName From PersonType pt order by PersonTypeName"
	Set RS = Conn.Execute(vDRQuery)

	Dim RSOrg
	Dim vOrgQuery
	vOrgQuery = "sps_ReportGroupOrgs " & pvReportGroupID
	Set RSOrg = Conn.Execute(vOrgQuery)
	'Print vOrgQuery
	
	%>
	<form name="UpdateDesignatedRequestor" 
		action="<%=strHttpHeader & Request.ServerVariables("SERVER_NAME")%>/loginstatline/forms/ProcessDesignatedRequestor.sls"
		method="POST">
	<input type=hidden name="DesignatedRequestorId" value="<%=pvDesignatedRequestorID%>">
	<input type=hidden name="OriginalOrgId" value="<%=pvOrgID%>">
	  <table>
	    <tr><td align=right><font face=<%=FontNameData%> size=<%=FontSizeData%>><b>First Name:</b></font></td><td><input type=text name="DRPersonFirst" value=<%=vPersonFirst%>></td></tr>
	    <tr><td align=right><font face=<%=FontNameData%> size=<%=FontSizeData%>><b>Last Name:</b></font></td><td><input type=text name="DRPersonLast" value=<%=vPersonLast%>></td></tr>
	    <tr><td align=right><font face=<%=FontNameData%> size=<%=FontSizeData%>><b>Title:</b></font></td><td><select name="DRPersonTypeId">
															<%Dim vSelectText
															  if Not RS.EOF Then
																Do While Not RS.EOF
																	if RS("PersonTypeId") = vPersonTypeId then
																		vSelectText = " selected"
																	else
																		vSelectText = ""
																	end if
																	%>
																	<option value=<%=RS("PersonTypeId")%><%=vSelectText%>><%=RS("PersonTypeName")%></option>
																	<%

																	RS.MoveNext
																Loop
															end if%>
	    </td></tr>
	    <tr><td align=right><font face=<%=FontNameData%> size=<%=FontSizeData%>><b>Organization:</b></font></td><td><select name="DROrganizationId">
																	<%if Not RSOrg.EOF Then
																		Do While Not RSOrg.EOF
																			if RSOrg("OrganizationId") = vPersonOrganizationId then
																				vSelectText = " selected"
																			else
																				vSelectText = ""
																			end if
																			%>
																			<option value=<%=RSOrg("OrganizationId")%><%=vSelectText%>><%=RSOrg("OrganizationName")%></option>
																			<%

																			RSOrg.MoveNext
																		Loop
																	end if%>
	    </td></tr>
	    <tr><td align=right><font face=<%=FontNameData%> size=<%=FontSizeData%>><b>Active</b></font></td><td><input type=checkbox name="DRPersonActive"<%if vPersonInactive=0 then response.write(" checked") end if%>></td></tr>
	    <tr><td align=right><font face=<%=FontNameData%> size=<%=FontSizeData%>><b>Designated Requestor</b></font></td><td><input type=checkbox name="DRPersonDesignated"<%=vDRChecked%>></td></tr>
	    <tr><td></td><td>
			<A	HREF="javascript:document.UpdateDesignatedRequestor.submit();" NAME="Save">
				<IMG src="/loginstatline/images/submit2.gif"
				NAME="Save"
				BORDER="0">
			</A>&nbsp;&nbsp;&nbsp;&nbsp;
			<A	HREF="javascript:self.close();">
				<IMG src="/loginstatline/images/cancel2.gif"
				NAME="Cancel"
				BORDER="0">
			</A></td></tr>
	  </table>
	</form>

<%
End Function



Sub FixQueryString(pvIn, pvOut)

	Dim j

	pvOut = ""

	For j=1 TO Len(pvIn)

		If Mid(pvIn,j,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,j,1)
		End If

	Next

End Sub

'This sub is used by DetailSection3 to format note fields
Sub OutputMemo(memo)

	Dim mx

	For mx=1 to Len(memo)

		If Asc(Mid(memo, mx, 1)) = 13 Then
			Response.Write("<BR>")
		Else
			Response.Write(Mid(memo,mx,1))
		End If
	Next
End Sub

Function StripDRSuffix(pvString)
	If right(pvString, 1) = "*" then
		StripDRSuffix = left(pvString, len(pvString)-1)
		vDRChecked = " checked"
	else
		StripDRSuffix = pvString
		vDRChecked = ""
	end if
End Function%>
