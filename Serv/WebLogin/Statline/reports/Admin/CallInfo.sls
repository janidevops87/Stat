<% Option Explicit %>
<%
Dim FontNameHead 
Dim FontSizeHead 
Dim FontNameData 
Dim FontSizeData 
Dim FontNameHeadLog 
Dim FontSizeDataLog 
Dim FontNameDataLog 

Dim pvStartDate
Dim pvEndDate
Dim pvOutput
Dim vQuery
Dim pvUserOrgID
Dim Conn
Dim RS
Dim ErrorReturn
Dim DataSourceName
Dim x, ConnDash, MessageCount, MessageTime, NoCallTime
Dim LastType, NoCallCount, ReferralCount, ReferralTime
Dim Refer
Dim vErrorMsg

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeDataLog = "1.5"
FontNameDataLog = "Times New Roman"

%>

<HTML>
<HEAD>
<TITLE>Call Staff Statisical Analysis</TITLE>
</HEAD>
<BODY BGCOLOR="#F5EBDD">
<!--#include virtual="/loginstatline/includes/DBConnection.sls"-->
<!--#include virtual="/loginstatline/includes/CheckAuthorization.sls"-->

<%
CheckAuthorization

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = Request.QueryString("UserOrgID")

''Use DetermineReportingDSN function to get a connection DSN
	DataSourceName = DetermineReportingDSN(Request.QueryString("DSN"),pvStartDate,pvEndDate)
	If IsEmpty(DataSourceName) Then
		PrintError "Date Range is invalid. <BR> Change your date range before or after " + CStr(rs.Fields("maxDate")), "Get Reporting DSN", "DBConnection.sls"
		Set Conn = Nothing
		Set RS = Nothing
	End If


'Create a connection object
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD



'Set Refer = Server.CreateObject("StatWebReferral.clsStatistics")
vQuery = " sps_CallStaffStats '" & pvStartDate & "', '" & pvEndDate & "', " & pvUserOrgID

'Response.Write vQuery
SET RS = Conn.Execute(vQuery)
'ErrorReturn =  Refer.CallTakeStatistics(pvOutput, pvStartDate, pvEndDate)

'Dim ForLoop1, ForLoop2
'For ForLoop1 = 0 to Ubound(pvOutput,1)
'	For ForLoop2 = 0 to Ubound(pvOutput,2)
'	Response.Write(ForLoop1 & " " & ForLoop2 & " " & pvOutput(ForLoop1, ForLoop2) & "<br>")
'	Next
'Next

If RS.EOF Then
	vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
	vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
	vErrorMsg = vErrorMsg & "Please hit refresh to try your request again. <BR> <BR>"
	vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
	vErrorMsg = vErrorMsg & "please contact the system administrator for assistance. </B> <BR> <BR> <BR>"
	vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
	vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Org.IdentifyOrganization, CallInfo.sls) <BR> <BR>"
	vErrorMsg = vErrorMsg & "</FONT></FONT>"
	Response.Write(vErrorMsg)
Else
	pvOutPut = RS.GetRows


%>


<!-- Begin Header -->
<TABLE Width="100%">
<TD VALIGN=TOP>
	<TABLE WIDTH = "100%">
	<TR>
		<TD WIDTH="10%"><IMG SRC="/loginstatline/images/logo1.gif" WIDTH=60 HEIGHT=60></TD>
		<TD WIDTH="50%" ALIGN=LEFT>
			<TABLE>
				<TR><TD ALIGN=LEFT><FONT SIZE="5" FACE="Arial Black"><B>Call Staff Statistics</TD></TR>
				<TR><TD ALIGN=LEFT><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>Call Times</B></TD></TR>
			</TABLE>
		</TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>Period:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvStartDate%></TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>To:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvEndDate%></TD>
	</TABLE>
</TD></TABLE>
<!-- End Header -->

<% MessageCount = 0
	MessageTime = 0
	NoCallTime = 0
	NoCallCount = 0
	ReferralCount = 0
	ReferralTime = 0

	For x = 0 to UBound(pvOutput,2)
	Select Case pvOutput(0,x)
		Case "Message"
			MessageCount = MessageCount + pvOutput(2, x)
			MessageTime = MessageTime + pvOutput(5, x)
		Case "No Call"
			NoCallCount = NoCallCount + pvOutput(2, x)
			NoCallTime = NoCallTime + pvOutput(5, x)
		Case "Referral"
			ReferralCount = ReferralCount + pvOutput(2, x)
			ReferralTime = ReferralTime + pvOutput(5, x)
	End Select
 Next
 LastType = ""%>


<% For x = 0 to UBound(pvOutput,2)

		If LastType <> pvOutput(0, x) Then%>
			<%If LastType <> "" Then%>

			<TR><TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <B>TOTALS</B></TD>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<B><% Select Case LastType
						Case "Message"
							Response.Write(MessageCount)
						Case "No Call"
							Response.Write(NoCallCount)
						Case "Referral"
							Response.Write(ReferralCount)
					End Select %></TD></B>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<B><% Select Case LastType
						Case "Message"
							Response.Write(ConvertSectoTime(MessageTime/MessageCount))
						Case "No Call"
							Response.Write(ConvertSectoTime(NoCallTime/NoCallCount))
						Case "Referral"
							Response.Write(ConvertSectoTime(ReferralTime/ReferralCount))
					End Select %></TD></B>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">&nbsp </TD>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<B><% Select Case LastType
						Case "Message"
							Response.Write(ConvertSectoTime(MessageTime))
						Case "No Call"
							Response.Write(ConvertSectoTime(NoCallTime))
						Case "Referral"
							Response.Write(ConvertSectoTime(ReferralTime))
					End Select %></B></TD></TR>
			<% End If %>

			</TD></TR></TABLE></TABLE>

			<TR><TD>&nbsp</TD></TR>

			<TABLE WIDTH="100%" BORDER=0>
			<TR><TD ALIGN=LEFT COLSPAN=5> <FONT FACE="Arial"><B> &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp<%=pvOutput(0, x)%></FONT></TD></TR>
			<TR><TD WIDTH="100%">
			<TABLE WIDTH="100%">

			<TR>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp Call Taker</TD></B>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># of Calls</TD></B>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Avg. Call Time</TD></B>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Max. Call Time</TD></B>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total Call Time</TD></B>
			</TR>

			<TR><TD></TD></TR>

			<%LastType = pvOutput(0, x)

		End If%>

			<TR>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <%=pvOutput(1, x)%></TD>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=pvOutput(2, x)%></TD>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ConvertSectoTime(pvOutput(3, x))%></TD>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ConvertSectoTime(pvOutput(4, x))%></TD>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ConvertSectoTime(pvOutput(5, x))%></TD>
			</TR>

<% Next %>


			<TR><TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <B>TOTALS</B></TD>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<B><%=ReferralCount%></TD></B>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<B><%=ConvertSecToTime(ReferralTime/ReferralCount)%></TD></B>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">&nbsp </TD>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<B><%=ConvertSecToTime(ReferralTime)%></B></TD></TR>


</TD></TR></TABLE></TABLE>
<% End If %>
</BODY>
</HTML>


<% Set Refer = Nothing
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
Function ConvertSectoTime(vSeconds)

Dim vHour, vMinute, vSecond

vHour = vSeconds\3600
vSeconds = vSeconds - (vHour * 3600)

vMinute= vSeconds\60
vSeconds = vSeconds - (vMinute * 60)
vSecond= CInt(vSeconds)

ConvertSectoTime = FormatNumber(vHour,0,-1) & ":" & LeadingZero(vMinute) & ":" & LeadingZero(vSecond)

End Function

Function LeadingZero(vInteger)

	If vInteger < 10 Then
		LeadingZero = 0 & VInteger
	Else
		LeadingZero = VInteger
	End If

End Function

%>