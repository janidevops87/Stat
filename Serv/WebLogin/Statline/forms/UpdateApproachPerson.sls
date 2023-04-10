<%Option Explicit%>

<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>UpdateApproachPerson</title>
</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%	
Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData

Dim pvStartDate
Dim pvEndDate
Dim vUserID
Dim vUserName
Dim vUserOrgID
Dim vUserOrgName
Dim vCallID
Dim vReportGroupID
Dim vReferralOrgID

Dim vOldApproachPersonID
Dim vNewApproachPersonID

Dim ApproachUserOrgPersonList
Dim	ApproachReferralOrgPersonList

Dim vValue
Dim i
     

'Font Constants
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "3"

vUserID = Request.QueryString("UserID")
vUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
vCallID = Request.QueryString("CallID")
vReferralOrgID = Request.QueryString("OrgID")
vOldApproachPersonID = Request.QueryString("ApproachPersonID")

'Execute the main page generating routine
If AuthorizeMain Then

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	

	If vUserOrgID = 194 Then

		'Replace user org id with the owner of the selected report group
		If vReportGroupID <> 0 Then

			'Get number of rows
			vQuery = "SELECT OrgHierarchyParentID AS ParentID FROM WebReportGroup WHERE WebReportGroupID = " & vReportGroupID

			Set RS = Conn.Execute(vQuery)
			vUserOrgID = RS("ParentID")

			Set RS = Nothing
			
		End If

	End If

	'Get the user org name
	vQuery = "sps_OrganizationName " & vUserOrgID
	Set RS = Conn.Execute(vQuery)
	vUserOrgName = RS("OrganizationName")
	Set RS = Nothing

	'Get the user name
	vQuery = "sps_WebPerson " & vUserID
	Set RS = Conn.Execute(vQuery)
	vUserName = RS("PersonFirst") & " " & RS("PersonLast")
	Set RS = Nothing
%>


<!-- Pending Referrals Table -->
<form name="UpdateApproachPersonForm"
    action="<%=strHttpHeader & Request.ServerVariables("SERVER_NAME")%>/loginstatline/forms/ProcessApproachPerson.sls"
    method="POST">

<%'List the hidden fields%>   
<input type="hidden" name="DataSourceName" value=<%=DataSourceName%>>
<input type="hidden" name="CallID" value=<%=vCallID%>>
<input type="hidden" name="UserName" value="<%=vUserName%>">
<input type="hidden" name="UserOrgName" value="<%=vUserOrgName%>">
<input type="hidden" name="UserOrgID" value=<%=vUserOrgID%>>
<input type="hidden" name="UserID" value=<%=vUserID%>>
<input type="hidden" name="OldApproachPersonID" value=<%=vOldApproachPersonID%>>
<input type="hidden" name="NewApproachPersonID" value="-1">

<!-- Begin Header -->
<table  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<A	HREF="javascript:document.UpdateApproachPersonForm.submit();" NAME="Save">
				<IMG src="/loginstatline/images/submit2.gif"
				NAME="Save"
				BORDER="0">
			</A>			
		</td>
		<td>&nbsp;&nbsp;</td>
		<td>
			<A	HREF="javascript:self.close();">
				<IMG src="/loginstatline/images/cancel2.gif"
				NAME="Cancel"
				BORDER="0">
			</A>	
		</td>
	</tr>
</table>
<img src="/loginstatline/images/redline.gif" height="2" width="100%">
<!-- End Header -->

<!-- Get  Data -->
	
	<!-- Format Data -->
	<table border="0" cellpadding="0" cellspacing="2">	

		<%'Format Approach Person Field field%>
		<%
		
		'Response.Write ( vUserOrgID & "<BR>" & vReferralOrgID )
		'Get the User Org Approach Person data list
		'vQuery = "sps_Person " & vUserOrgID & ", null, " & 1
		'Set RS = Conn.Execute(vQuery)	
		'ApproachUserOrgPersonList = RS.GetRows
		'Set RS = Nothing
		
		'Get the Referral Org Approach Person data list
		vQuery = "sps_ApproachPerson " & vReferralOrgID & ", null, " & 1
		'Response.Write vQuery
		Set RS = Conn.Execute(vQuery)	
		'Do While NOT RS.EOF
		'	Response.Write (RS("PersonID") & "&nbsp" & RS("PersonFirst")& "&nbsp" & RS("PersonLast")& "<BR>")
		'RS.MoveNext
		'Loop
		ApproachReferralOrgPersonList = RS.GetRows
		Set RS = Nothing			
		%>
			
		<tr>
			<td ALIGN=LEFT VALIGN=TOP><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Approach Person</b></font></td>
		</tr>
		<tr>
			<TD ALIGN=LEFT VALIGN=TOP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<%vValue = CLng(vOldApproachPersonID)%>
				<select name="ApproachPerson" size="1">
					<%For i = 0 to Ubound(ApproachReferralOrgPersonList,2)%>
						Response.Write Ubound(ApproachReferralOrgPersonList,2)
						<%If vValue = ApproachReferralOrgPersonList(0,i) Then%>
							<option value="<%=ApproachReferralOrgPersonList(0,i)%>" selected><%=ApproachReferralOrgPersonList(1,i) & " " & ApproachReferralOrgPersonList(2,i)%></option>
						<%Else%>
							<option value="<%=ApproachReferralOrgPersonList(0,i)%>"><%=ApproachReferralOrgPersonList(1,i) & " " & ApproachReferralOrgPersonList(2,i)%></option>
						<%End If%>
					<%Next %> 						
				</select>
			</FONT>
			</TD>
		</tr>

		<tr>
			<td ALIGN=LEFT VALIGN=TOP><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Change Note</b></font></td>
		</tr>
		<tr>
			<td ALIGN=LEFT VALIGN=TOP><textarea rows="6" name="Comments" cols="30" wrap="virtual"></textarea></td>
		</tr>
	</table>

	<font face="arial" size="1">*A log event note will be automatically created if the approach person is changed.</font>

</form>

</BODY>
</HTML>

<%
End If

Set RS = Nothing
Set Conn = Nothing
%>
