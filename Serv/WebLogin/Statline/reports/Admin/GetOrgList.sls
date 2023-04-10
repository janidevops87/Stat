<%@ LANGUAGE="VBSCRIPT"%>
<%Option Explicit%>


<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual InterDev 1.0">
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>Organization List</TITLE>
</HEAD>
<BODY BGCOLOR="#F5EBDD">
<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 
<!--#include virtual="/loginstatline/includes/CheckAuthorization.sls"-->

<%'Declare vaiables
Dim i
Dim vOrgList
Dim ErrorReturn
Dim vErrorMsg
Dim Org
Dim FontNameHead 
Dim FontSizeHead 
Dim FontNameData 
Dim FontSizeData 
Dim pvReportGroup
Dim vReportGroupName
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim pvUserOrgID

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
CheckAuthorization

pvUserOrgID = Request.QueryString("UserOrgID")
pvReportGroup = Request.QueryString("ReportGroupID")
ReportGroupID = pvReportGroup
DataSourceName = DetermineReportingDSN(Request.QueryString("DSN"),Empty,Empty)
	If IsEmpty(DataSourceName) Then
		Call Err.Raise(11,"GetOrgList.sls", "Cannot determine a proper DSN. Contact Statline for help.")
	End If

'Create a connection object
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD

'Set Title Values
vMainTitle = "Report Group Organizations"
vTitlePeriod = ""
vTitleTo = ""
vTitleTimes = ""

%>
<!-- Print the header. -->
<!--#include virtual="/loginstatline/reports/admin/Head.sls"-->	

<%
If GetChildren Then%>

	<TABLE BORDER=0 WIDTH="100%" RULES="NONE" FRAME="VOID">
		
		<TH COLSPAN=7 WIDTH="100%"> </TH>
		<TR><TD COLSPAN=7>&nbsp</TD></TR>
		<TR><TD COLSPAN=7><IMG SRC="/images/redline.gif" HEIGHT=2 WIDTH="100%"></TD></TR>
		<TR><TD COLSPAN=7><P STYLE="line-height: 2pt">&nbsp</P></TD></TR>
		<TR><TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>" ><I><%=vReportGroupName%> Report Group</I></B></TD></TR>
		<TR><TD COLSPAN=7><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>


		<TR>
			<TD WIDTH="4%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">#</TD>
			<TD WIDTH="30%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Name</TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Address</TD>
			<TD WIDTH="15%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">City</TD>
			<TD WIDTH="8%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">State</TD>
			<TD WIDTH="8%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Zip</TD>
		</TR>

		<TR><TD COLSPAN=5><P STYLE="line-height: 4pt">&nbsp</P></TD></TR>

		<%For i = 0 to Ubound(vOrgList, 2)%>

			<TR>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i+1%></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=vOrgList(1,i)%></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=vOrgList(2,i)%></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=vOrgList(5,i)%></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=vOrgList(7,i)%></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=vOrgList(6,i)%></TD>

			</TR>

		<%Next%>

	</TABLE>

<%End If

Function GetChildren()

	GetChildren = True

	 vQuery = "sps_GetReportGroupOrganization " & pvReportGroup
	 Set RS = Conn.Execute(vQuery)
	'Get each of the organizations in the group


	If RS.EOF Then
		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Org.GetReportGroupOrgs, GetOrgList.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		GetChildren = False
		Exit Function
		
	Else
		vOrgList = RS.GetRows	
		Set RS = Nothing
	End If


	'Get the report group name

	vQuery = "sps_ReportGroupName " & pvReportGroup
	Set RS = Conn.Execute(vQuery)
	
	If RS.EOF Then
		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B><BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Org.GetReportGroupName, GetOrgList.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		GetChildren = False
		Exit Function
		
	Else
		vReportGroupName = RS("WebReportGroupName")	
		Set RS = Nothing
	End If
	
	 
	 
	Set Conn = Nothing
	

End Function
%>

</BODY>
</HTML>
