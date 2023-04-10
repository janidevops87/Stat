<%
Option Explicit

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

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

%>

<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Person Change Log</title>
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
	
	vQuery = "Select p.PersonFirst, p.PersonLast, pt.PersonTypeName, p.Inactive, o.OrganizationName, p.LastModified From Person p Join PersonType pt on p.PersonTypeId = pt.PersonTypeId Join Organization o on p.OrganizationId = o.OrganizationId Where p.PersonId = " & pvDesignatedRequestorID & " And p.organizationid = " & pvOrgId
	vQuery = vQuery & " union "
	vQuery = vQuery & " Select p.PersonFirst, p.PersonLast, pt.PersonTypeName, p.Inactive, o.OrganizationName, p.LastModified From PersonLog p Join PersonType pt on p.PersonTypeId = pt.PersonTypeId Join Organization o on p.OrganizationId = o.OrganizationId Where p.PersonId = " & pvDesignatedRequestorID & " And p.organizationid = " & pvOrgId & " Order By p.LastModified desc"
	Set RS = Conn.Execute(vQuery)
	
	%>
	<form name="UpdateDesignatedRequestor" 
		action="<%=strHttpHeader & Request.ServerVariables("SERVER_NAME")%>/loginstatline/forms/ProcessDesignatedRequestor.sls"
		method="POST">
	<input type=hidden name="DesignatedRequestorId" value="<%=pvDesignatedRequestorID%>">
	<input type=hidden name="OriginalOrgId" value="<%=pvOrgID%>">
	  <table>
	    <tr>
	    	<td align=left width=30%><font face=<%=FontNameHead%> size=<%=FontSizeHead%>><u><b>Name</b></u></font></td>
	    	<td align=left width=30%><font face=<%=FontNameHead%> size=<%=FontSizeHead%>><u><b>Title</b></u></font></td>
	    	<td align=left width=15%><font face=<%=FontNameHead%> size=<%=FontSizeHead%>><u><b>Status</b></u></font></td>
	    	<td align=left width=25%><font face=<%=FontNameHead%> size=<%=FontSizeHead%>><u><b>Modified</b></u></font></td>
	    </tr>
	    
	    <%
	    If Not RS.EOF Then
	    	Do While Not RS.EOF%>
	    	      <tr>
	    		<td align=left><font face=<%=FontNameData%> size=<%=FontSizeData%>><%=RS("PersonLast")%>, <%=RS("PersonFirst")%></font></td>
	    		<td align=left><font face=<%=FontNameData%> size=<%=FontSizeData%>><%=RS("PersonTypeName")%></font></td>
	    		<td align=left><font face=<%=FontNameData%> size=<%=FontSizeData%><%if RS("Inactive")=1 then%> Color=red>Inactive<%else%>>Active<%end if%></font></td>
	    		<td align=left><font face=<%=FontNameData%> size=<%=FontSizeData%>><%=RS("LastModified")%></font></td>
	    	      </tr>
	    	
	    	<%    RS.MoveNext
	    	Loop
	    Else%>
	    	<tr>
	    	  <td align=right><font face=<%=FontNameData%> size=<%=FontSizeData%>>No Data Available</font></td>	
	    	</tr>
	    <%End If%>
	    
	    <tr>
	    	<td><br><br>
			<A	HREF="javascript:self.close();">
				<IMG src="/loginstatline/images/close.gif"
				NAME="Close"
				BORDER="0">
			</A>
		</td>
	    </tr>
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
