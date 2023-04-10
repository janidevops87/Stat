<% Option Explicit %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual InterDev 6.0">
<TITLE>Organization Person List</TITLE>
</HEAD>

<BODY BGCOLOR="#F5EBDD">

<%
	Dim i
	Dim ErrorReturn
	Dim vErrorMsg
	Dim Org
	Dim FontNameHead
	Dim FontSizeHead
	Dim FontNameData
	Dim FontSizeData
	Dim pvReportGroup
	Dim pvOrgID
	Dim pvStartDate
	Dim pvEndDate
	Dim pvUserOrgID
	Dim vReportGroupName
	Dim ReportStartDate
	Dim ReportEndDate
		
	Dim vReportTitle
	Dim vMainTitle
	Dim vTitlePeriod
	Dim vTitleTo
	Dim vTitleTimes

	'Dim vQuery
	'Dim Conn
	'Dim RS

	FontNameHead = "Arial"
	FontSizeHead = "2"
	FontNameData = "Times New Roman"
	FontSizeData = "2"
	
	pvUserOrgID = Request.QueryString("UserOrgID")
	pvReportGroup = Request.QueryString("ReportGroupID")
	pvOrgID = Request.QueryString("OrgID")
	'Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	'Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	ReportStartDate = left(Request.QueryString("StartDate"),len(Request.QueryString("StartDate"))-6)
	ReportEndDate = left(Request.QueryString("EndDate"), len(Request.QueryString("EndDate"))-6)


	''Declare vaiables
%>
	<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%
	If AuthorizeMain Then
	
	vReportTitle = ""
	vMainTitle = "Organization People"
	vTitlePeriod = ""
	vTitleTo = ""
	vTitleTimes = ""
%>
	<!-- Print the header. -->
	<!--#include virtual="/loginstatline/reports/custom/Head_w_ReportGroup.sls"-->

	
	<TABLE BORDER=0 WIDTH="100%">

	<TR><TD COLSPAN=7><IMG SRC="/loginstatline/images/redline.gif" HEIGHT=2 WIDTH="100%"></TD></TR>

	<%

	'Get the Person List
	pvStartDate = "'" & pvStartDate & "'"
	pvEndDate = "'" & pvEndDate & "'"

	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	vQuery = "sps_GetPersonList " & "2, '" & pvReportGroup & "', " & pvStartDate & ", " & pvEndDate & ", " & pvOrgID
	'Print Organization Adress
	'Response.Write "2: " & vQuery
	Set RS = Conn.Execute(vQuery)
	IF NOT RS.EOF Then
		Call PrintHeader
	End IF
	SET RS = Nothing

	'Print Organization Personnel Designated as Requestors
	vQuery = "sps_GetPersonList1 " & "5, " & pvReportGroup & ", " & pvStartDate & ", " & pvEndDate & ", " & pvOrgID
	'Response.Write "1: " & vQuery
	Set RS = Conn.Execute(vQuery)
	IF NOT RS.EOF Then
		Call DesignatedRequestor()
	End IF
	Set RS = Nothing
Else

	Response.Write "Access Denied"

End If
	Function PrintHeader()
		%>
		<TR>
			<TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=RS("Hospital")%></FONT></B></TD>
		</TR>
		<TR>
			<TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=RS("Address")%></FONT></B></TD>
		</TR>
		<TR>
			<TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=RS("City")%>, <%=RS("State")%>&nbsp <%=RS("Zip")%></FONT></B></TD>
		</TR>
		<TR>
			<TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=RS("Phone")%></FONT></B></TD>
		</TR>


<%	End Function
	Function DesignatedRequestor()
		i = 1
%>
		<TR><TD COLSPAN=7><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
		<TR><TD COLSPAN=7><P STYLE="line-height: 2pt">&nbsp</P></TD></TR>
		<TR><TD COLSPAN=2 ALIGN=Left><B><FONT SIZE="3" FACE="<%=FontNameHead%>">
						<A	HREF="javascript:doNothing();"
						onclick="window.open('../../forms/UpdateDesignatedRequestor.sls?<%=("ReportGroupID=" & pvReportGroup & "&OrgID=" & pvOrgID & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&DesignatedRequestorID=0")%>',
						'UpdateDesignatedRequestor',
						'width=600,height=275')">Add New >>
						</A></FONT>
		</TD></TR>
		<TR><TD COLSPAN=7><P STYLE="line-height: 4pt">&nbsp</P></TD></TR>
		
		

		<TR>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">#</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Name</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Title</FONT></U></B></TD>
			<TD WIDTH="25%" ALIGN=center ><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Status</FONT></U></B></TD>
			<TD WIDTH="20%" ALIGN=center><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><U>Log</U>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></B></TD>
			<TD WIDTH="20%"><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">&nbsp;</FONT></B></TD>

		<%
		i=1
		DO While NOT RS.EOF

		%>

			<TR>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i%></FONT></TD>
				
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>">
													<A	HREF="javascript:doNothing();"
														onclick="window.open('../../forms/UpdateDesignatedRequestor.sls?<%=("ReportGroupID=" & pvReportGroup & "&OrgID=" & pvOrgID & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&DesignatedRequestorID=" & RS("PersonID"))%>',
														'UpdateDesignatedRequestor',
														'width=600,height=275')"><%=RS("PersonLast")%>, <%=RS("PersonFirst")%>
													</A>
				</TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("Title")%></FONT></TD>
				<TD VALIGN=TOP ALIGN=CENTER><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>" <%if RS("Status")=1 then response.write("COLOR=red>Inactive") else response.write(">Active") end if%></FONT></TD>
				<TD VALIGN=TOP ALIGN=CENTER><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>">
																	<A	HREF="javascript:doNothing();"
																		onclick="window.open('../../forms/DesignatedRequestorChangeLog.sls?<%=("ReportGroupID=" & pvReportGroup & "&OrgID=" & pvOrgID & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&DesignatedRequestorID=" & RS("PersonID"))%>',
																		'DesignatedRequestorChangeLog',
																		'width=600,height=600,scrollbars=1')">View Log
																	</A>
				</TD>
				
		
			</TR>
<%
		i=i+1
		RS.MoveNext
		Loop
	End Function
%>
	</TABLE>

</BODY>
</HTML>

<%
Function FixQueryString(pvIn, pvOut)

	Dim j

	pvOut = ""

	For j=1 TO Len(pvIn)

		If Mid(pvIn,j,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,j,1)
		End If

	Next
	 pvOut = pvOut & ""
End Function
%>

<script language="JavaScript">

	function doNothing()
	{
	}
</script>