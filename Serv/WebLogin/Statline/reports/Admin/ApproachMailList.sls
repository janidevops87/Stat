<%@ LANGUAGE="VBSCRIPT"%>
<%Option Explicit%>


<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual InterDev 6.0">
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>Organization Person List</TITLE>
</HEAD>
<BODY BGCOLOR="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%'Declare vaiables

If AuthorizeMain Then
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
	Dim vReportGroupName
	Dim ReportStartDate
	Dim ReportEndDate
	Dim vReportTitle
	Dim vMainTitle
	Dim vTitlePeriod
	Dim vTitleTo
	Dim vTitleTimes
	Dim pvUserOrgID

	
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
	pvStartDate = CStr(pvStartDate)
	pvEndDate = CStr(pvEndDate)
	ReportStartDate = left(Request.QueryString("StartDate"),len(Request.QueryString("StartDate"))-6)
	ReportEndDate = left(Request.QueryString("EndDate"), len(Request.QueryString("EndDate"))-6)
	
	'Set Title Values
	vMainTitle = "Regional Trained Requestors"
	vTitlePeriod = ""
	vTitleTo = ""
	vTitleTimes = ""
%>
	<!-- Print the header. -->
	<!--#include virtual="/loginstatline/reports/admin/Head.sls"-->	

	
	<TABLE BORDER=0 WIDTH="100%">
					
			
	<%
					
	'Get the Person List
					
	Set Conn = server.CreateObject("ADODB.Connection")
	Server.ScriptTimeout = 270
	Conn.CommandTimeout = 90
	Conn.Open "Production", DBUSER, DBPWD
	vQuery = "sps_ApproachMailList " & pvReportGroup & " "
	'Print Organization Adress
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)
	IF NOT RS.EOF Then
		Call PrintList
	End IF
	Set RS = Nothing
	Set Conn = Nothing
Else

	Response.Write "Access Denied"

End If		
	Function PrintList()		
		
%>
		<TR>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">#</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">FirstName</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">LastName</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Title</FONT></U></B></TD>
			<TD WIDTH="23%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Organization Name</FONT></U></B></TD>
			<TD WIDTH="12%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Address</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">City</FONT></U></B></TD>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">State</FONT></U></B></TD>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Zip</FONT></U></B></TD>
							
		<%
		i=1
		DO While NOT RS.EOF 
				
		%>

			<TR>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FCONSFNAME")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FCONSLNAME")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FCONSTITLE")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FCONSOURCE")%></FONT></TD>
				
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FCONSADDR")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FCONSCITY")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FCONSSTATE")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FCONSZIP")%></FONT></TD>
				
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

Function DesignatedRequestorByDate() 
		i = 1		
%>
		<TR><TD COLSPAN=7><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
		<TR><TD COLSPAN=7><P STYLE="line-height: 2pt">&nbsp</P></TD></TR>
		<TR>
			<BR>
			<TD COLSPAN=4 VALIGN=TOP><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Designated Requestors <BR> From <%= ReportSTartDate%> To <%= ReportEndDate %></FONT></B></TD>
		</TR>	
		<TR>
			<TD COLSPAN=4 VALIGN=TOP ><FONT SIZE=1 FACE="<%=FontNameHead%>">Employees trained to request consent.</FONT></TD>
			<BR>
		</TR>
		<TR><TD COLSPAN=5><P STYLE="line-height: 4pt">&nbsp</P></TD></TR>

		<TR>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">#</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Name</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Title</FONT></U></B></TD>
			<TD WIDTH="25%" ALIGN=center ><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Number of Approaches</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">First Approached</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Last Approached</FONT></U></B></TD>
				
		<%
		i=1
		DO While NOT RS.EOF 
				
		%>

			<TR>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("PersonName")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("Title")%></FONT></TD>
				<TD VALIGN=TOP ALIGN=center><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("NumberOfCalls")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FirstCalled")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("LastCalled")%></FONT></TD>
			</TR>
<%
		i=i+1
		RS.MoveNext
		Loop
	End Function
%>