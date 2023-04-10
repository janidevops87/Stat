
<%
Option Explicit

Dim DataWarehouseConn
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrg
Dim pvOrgID
Dim pvReportGroupID
Dim vReportTitle
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn
Dim vReportName
Dim vCurrentColor

Dim vTotals(2)
Dim i
Dim x

Dim FontNameHead
Dim FontNameData

FontNameHead = "Arial"
FontNameData = "Times New Roman"

vReportName = "Update Referral Compliance"

%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Referral Compliance</title>
</head>
<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%
Call Process

Function Process

'Execute the main page generating routine
If AuthorizeMain Then

	
	Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrg = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)

	'Verify the requesting organization if it not Statline
	If pvUserOrg <> 194 then
		
		vQuery = "sps_OrganizationName " & pvUserOrg
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)		
		End If
		
		Set RS = Nothing
	
	Else
	
		'If the user org = 194 and a report group has been selected,
		'the replace the user org id with the org owner of the 
		'selected report group.
		If pvReportGroupID <> 0 Then
			vQuery = "sps_ReportGroupOrgParentID " & pvReportGroupID & " "
			Set RS = Conn.Execute(vQuery)
			If RS.EOF <> True Then
				pvUserOrg = RS("OrgHierarchyParentID")
				vReportTitle = RS("OrganizationName") & " - "
			End If
			Set RS = Nothing
		End If		

	End If

	If pvReportGroupID <> 0 AND pvOrgID = 0 Then
		
		'If a report group has been selected, get the report group name
		'and set the report title to the name of the report group
		vQuery = "sps_ReportGroupName " & pvReportGroupID & " "
		Set RS = Conn.Execute(vQuery)

		If Conn.Errors.Count > 0 Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
		End If
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The selected report group is no longer valid. Please select another group.<BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			
		Else
			vReportTitle = vReportTitle & RS("WebReportGroupName")		
		End If
		
		Set RS = Nothing
		
	ElseIf pvOrgID <> 0  Then

		'Else if a single organization has been selected, get the organization data 
		'and set the report title to the name of the selected organization

		'Get the organization information
		vQuery = "sps_OrganizationName " & pvOrgID
		
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization selected for this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Else
			vReportTitle = RS("OrganizationName")			
		End If
		
		Set RS = Nothing
		
	ElseIf pvOrgID = 0 AND pvReportGroupID = 0 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, UnitSummary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)

	Else

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Unexpected Error. <BR> "
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, UnitSummary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)

	End if

	vQuery = "sps_OrganizationTimeZone " & pvUserOrg & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing
	
%>
<!-- drh 10/02/03 - Added ReportGroupID param -->
<form name="UpdateForm"
    action="<%=strHttpHeader & Request.ServerVariables("SERVER_NAME")%>/loginstatline/forms/ProcessReferralComp.sls?ReportGroupID=<%=pvReportGroupID%>"
    method="POST"
    onSubmit="return confirmSubmit();">
    
	<input type="hidden" name="OrgID" value=<%=pvOrgID%>>
    <input type="hidden" name="submitValue" value="true">
    
<!-- Begin Header -->

	<table border="0" cellpadding="0" cellspacing="0">
	<TR><TD WIDTH=75><IMG SRC="/loginstatline/images/logo1.gif" WIDTH=60 HEIGHT=60></TD>
		<TD ALIGN=LEFT width="425" valign="CENTER">
			<table  border="0" cellpadding="0" cellspacing="0">
				<TR><TD><FONT SIZE="4" FACE="<%=FontNameHead%>"><B><%=vReportName%></B></TD></TR>
				<TR><TD><FONT SIZE="4" FACE="<%=FontNameHead%>"><B><%=vReportTitle%></B></TD></TR>
			</TABLE>
		</TD>

		<td ALIGN=LEFT ><input type="image" src="/loginstatline/images/submit2.gif" name="save" onclick="setSubmit(true);" language="JavaScript" border=0></td>
		<td>&nbsp;&nbsp;</td>
		<td ALIGN=LEFT ><input type="image" src="/loginstatline/images/cancel2.gif" name="close" onclick="setSubmit(false);" language="JavaScript" border=0></td>
	</TR>
	</TABLE>

<!-- End Header -->

    <br>
	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

	<TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

	<TR>
		<%If pvOrgID <> 0 Then%>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Year / Month</B></TD>
		<%Else%>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referral Facility</B></TD>
		<%End If%>
		
		<TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		<TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		<TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>%</B></TD>
		
	<TR><TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp;</B></TD>
		<TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
		<TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Deaths</B></TD>
		<TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Compliance</B></TD>
		
	<TR><TD COLSPAN=5><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

<%
	vCurrentColor = "bgcolor=#FFFFFF"
	vTotals(0) = 0
	i = 1
	
	'A report group has been selected so get the list of organizations
	'to be processed
	vQuery = "sps_ReferralCompliance4 " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
	
	Set RS = DataWarehouseConn.Execute(vQuery)

	Do While Not RS.EOF
%>
		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">
				<input type="hidden" name="Row<%=i%>" value=<%=i%>>
				<%
				If pvOrgID <> 0 Then
					Response.Write(RS("MonthYear"))
				%>
					<input type="hidden" name="YearID<%=i%>" value=<%=RS("YearID")%>>
					<input type="hidden" name="MonthID<%=i%>" value=<%=RS("MonthID")%>>
				<%
				Else
					Response.Write(RS("OrganizationName"))
				End If	
				%>	
			</TD>
			
			<%
			vTotals(1) = vTotals(1) + RS("AllTypes")
			%>			
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AllTypes")%></FONT></TD>
						
			<%If IsNull(RS("TotalDeaths")) Then%>
				<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">
				<input type="text" onfocus="this.select();" onblur="if !(isInteger(this.value)){alert('Please enter digits only');this.select();}" size="7" name="totalDeaths<%=i%>" maxlength="5" value="0"></FONT></TD>
			<%Else%>
				<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">
				
				<!-- 07/12/2004 - CAB - Added If statement to check for -1 (default value). If -1,
				     insert a 0, if not -1, insert value from recordset -->
				<%If RS("TotalDeaths")=-1 then%>
				
					<input type="text" onfocus="this.select();" onblur="if (!isInteger(this.value)){alert('Please enter digits only');this.select();}" size="7" name="totalDeaths<%=i%>" maxlength="5" value="0"></FONT></TD>
				<%Else%>
				
					<input type="text" onfocus="this.select();" onblur="if (!isInteger(this.value)){alert('Please enter digits only');this.select();}" size="7" name="totalDeaths<%=i%>" maxlength="5" value="<%=RS("TotalDeaths")%>"></FONT></TD>
				<%End If%>
			<%End If%>
			
			<%
			If IsNull(RS("TotalDeaths")) Or RS("TotalDeaths")= -1 Then
				vTotals(0) = vTotals(0) + 0
			Else
				vTotals(0) = vTotals(0) + RS("TotalDeaths")
			End If
			%>

			<%If RS("TotalDeaths") = 0 Or IsNull(RS("TotalDeaths")) Or RS("TotalDeaths")= -1 Then%>
				<TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("AllTypes")/RS("TotalDeaths"))*100,0)%>%</FONT></I></TD>
			<%End If%>
	
		</TR>
			
	<%
		If vCurrentColor = "bgcolor=#FFFFFF" Then
			vCurrentColor = "bgcolor=#F5EBDD"
		Else
			vCurrentColor = "bgcolor=#FFFFFF"
		End If
			
		RS.MoveNext
		i = i + 1
	Loop
	%>

	<!-- Process Totals -->
	<TR><TD COLSPAN=5><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

	<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
		
		<!-- 07/12/2004 - CAB - Added if statement to check for -1. Totals should reflect 0 when
		     Organization has not reported any deaths, instead of default value of -1 -->		
		<%If vTotals(0)=-1 then%>
			<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0</B></FONT></TD>
		<%Else%>			
			<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
		<%End If%>
		
		<%If vTotals(0) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(1)/vTotals(0))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
	</TR>

	</TABLE>
<%
End If

Set RS = Nothing
Set Conn = Nothing
Set DataWarehouseConn = Nothing

End Function
%>

</form>
</body>
</html>


<%
Function DateLiteral(pvDate)

	Select Case Month(pvDate)
	
		Case 1
			DateLiteral = "Jan "
		Case 2
			DateLiteral = "Feb "
		Case 3
			DateLiteral = "March "
		Case 4
			DateLiteral = "April "
		Case 5
			DateLiteral = "May "
		Case 6
			DateLiteral = "June "
		Case 7
			DateLiteral = "July "
		Case 8
			DateLiteral = "Aug "
		Case 9
			DateLiteral = "Sept "
		Case 10
			DateLiteral = "Oct "
		Case 11
			DateLiteral = "Nov "
		Case 12
			DateLiteral = "Dec "
	End Select
	
	DateLiteral = DateLiteral & Year(pvDate)
	
End Function

Sub FixQueryString(pvIn, pvOut)
	pvOut = ""
	For x=1 TO Len(pvIn)
		If Mid(pvIn,x,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,x,1)
		End If
	Next
End Sub
%>

<script language="JavaScript">

	function setSubmit(submitValue)
	{
		if (submitValue == true)
			{
			document.UpdateForm.submitValue.value = "true"
			}
			
		
		if (submitValue == false)
			{
			document.UpdateForm.submitValue.value = "false"
			}
			
		return
	}
	
	function confirmSubmit()
	{
		if (document.UpdateForm.submitValue.value == "true")
			{
			return true
			}
			
		if (document.UpdateForm.submitValue.value == "false")
			{
			
			window.top.close();
			return false
			}
	}
	
function isInteger (s)

{   var i;

    if (isEmpty(s)) 
       if (isInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isInteger.arguments[1] == true);

    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);

        if (!isDigit(c)) return false;
    }

    // All characters are numbers.
    return true;
}

// Returns true if character c is a digit 
// (0 .. 9).

function isDigit (c)
{   return ((c >= "0") && (c <= "9"))
}

function makeArray(n) 
{
   for (var i = 1; i <= n; i++) {
      this[i] = 0
   } 
   return this
}

// Check whether string s is empty.

function isEmpty(s)
{   return ((s == null) || (s.length == 0))
}
	
</script>