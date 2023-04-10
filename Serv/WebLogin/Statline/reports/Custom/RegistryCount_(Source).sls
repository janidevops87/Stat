
<% 
Option Explicit

Dim DonorRegistryConn
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrg
Dim pvOrgID
Dim pvReportGroupID
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn
Dim vReportName
Dim vCurrentColor
Dim LastOrganizationID
Dim LastMonthYear
Dim pvCallID
Dim pvSourceID

Dim FemaleOutreachTotal
Dim MaleOutreachTotal
Dim UnknownOutreachTotal

Dim CurrentAge
Dim CurrentSource

Dim SourceOutReachTotal
Dim AgeOutreachSubTotal

Dim OutreachTotal

Dim x
Dim i

Dim FontNameHead
Dim FontNameData

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim RegistryDSN
Dim pvReportID
Dim pvEventSource

pvCallID = 0
FontNameHead = "Arial"
FontNameData = "Times New Roman"
vReportTitle = ""
vReportName = ""
CurrentAge = "Initial"
CurrentSource = "Initial"
RegistryDSN = Request.QueryString("RegistryDSN")
pvEventSource = Request.QueryString("AsgChoice")
DIM PORGANIZATIONID
PORGANIZATIONID= 50

%>

<!-- Include any files here Response.Write("All Times " & ZoneName(vTZ)) -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%


'Execute the main page generating routine
If AuthorizeMain Then

	Set DonorRegistryConn = server.CreateObject("ADODB.Connection")
	DonorRegistryConn.Open RegistryDSN, DBUSER, DBPWD
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open PRODUCTIONDSN, DBUSER, DBPWD

	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrg = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvSourceID = Request.QueryString("SourceID")
	pvReportID = Request.QueryString("ReportID")
	
	'Get the report Name
	vQuery = "sps_ReportInformation " & pvReportID
	'print(vQuery)
	Set RS = Conn.Execute(vQuery)
	
	If RS.EOF = True Then
	  vReportTitle = "Registry Count (Source)"
	Else
	  'RS.MoveFirst
	  vReportTitle = RS("ReportDisplayName")
	End If

	Set RS = Nothing
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
	
		'If the user org = 194 use Colorado Donor as the default.
		'the replace the user org id with the org owner of the 
		'selected report group.
		vQuery = "sps_OrganizationName " & PORGANIZATIONID 'Colorado Donor Alliance
		'print(vQuery)
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

	End If

	vQuery = "sps_OrganizationTimeZone " & pvUserOrg & " "
	
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing	
%>
	<%	
	
	'Get Data  
	
	vQuery = " sps_DonorRegistryByGenderAgeAndSource2 '" & pvStartDate & "', '" & pvEndDate & "'" 
	
	If len(pvEventSource) > 0 Then
		vQuery = vQuery & ", '" & pvEventSource & "'"
	End If
	
	If len(pvSourceID) > 0 Then
		vQuery = vQuery & ", '" & pvSourceID & "'"
	End If
	
	' Print(vQuery)	
	Set RS = DonorRegistryConn.Execute(vQuery)

%>
<html>

<head>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">


<title><%=vReportTitle%></title>
<STYLE MEDIA=ALL >
	H1 {page-break-after: always}
</STYLE >
</head>


<BODY bgcolor="#F5EBDD" >
<%
	'Set Title Values		
	vMainTitle = ""
	If isdate(pvStartdate) and isdate(pvEndDate) Then
		vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
		vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
	Else
		vTitlePeriod = ""
		vTitleTo = ""	
	End If
	vTitleTimes = "All Times " & ZoneName(vTZ)	
%>
	<!--#include virtual="/loginstatline/reports/custom/RegistryCountHead.sls"--> 
<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

<!-- table header -->
<Table BORDER=0 WIDTH="93%" cellpadding=3 cellSpacing="0">
	<TR>
		<TH WIDTH="25%">
			<FONT face=FontNameHead size=2>Source Name
			</FONT>
		</TH>

		<TH WIDTH="25%">
			<FONT face=FontNameHead size=2>GENDER
			</FONT>
		</TH>
		<TH WIDTH="25%">
			<FONT face=FontNameHead size=2>AGE RANGE
			</FONT>
		</TH>
		
		<TH WIDTH="25%">	
			<FONT face=FontNameHead size=2>OUTREACH COUNT
			</FONT>
		</TH>		
	</TR>

<%
	Do While Not RS.EOF

	'Print Subtotal if the age range has changed and CurrentAge is not Initial
	If CurrentAge <> "Initial" AND CurrentAge <>RS("AgeRange") Then
		PrintAgeSubTotal(1)		
		AgeOutreachSubTotal = 0
	
	End If
	If CurrentSource <> "Initial" AND CurrentSource <> RS("EventName") Then
		PrintSourceTotal(1)
		SourceOutReachTotal = 0	
	End If
	
	CurrentAge = RS("AgeRange")	
	CurrentSource = RS("EventName")
%>

<!-- begin report -->

	<TR>
		<TD WIDTH="25%" ALIGN=CENTER>
			<FONT face=FontNameData size=2><%=RS("EventName")%>
			</FONT>
		</TD>

		<TD WIDTH="25%" ALIGN=CENTER>
			<FONT face=FontNameData size=2><%=RS("Gender")%>
			</FONT>
		</TD>
		<TD WIDTH="25%" ALIGN=CENTER>
			<FONT face=FontNameData size=2><%=RS("AgeRange")%>
			</FONT>
		</TD>
		<TD WIDTH="25%" ALIGN=CENTER>	
			<FONT face=FontNameData size=2><%=RS("Outreach")%>
			</FONT>			
		</TD>
		
	</TR>
	
	<%
	
	'Add to age SubTotal
		AgeOutreachSubTotal = AgeOutreachSubTotal + RS("Outreach")
		SourceOutReachTotal = SourceOutReachTotal + RS("Outreach")

	'Add to Gender Totals
		If RS("Gender") = "F" Then
			FemaleOutreachTotal = FemaleOutreachTotal + RS("Outreach")
		ElseIf RS("Gender") = "M" Then					
			MaleOutreachTotal = MaleOutreachTotal + RS("Outreach")
		ElseIf RS("Gender") = "U" Then						
			UnknownOutreachTotal = UnknownOutreachTotal + RS("Outreach")
		End If	

	'Add to Grand Total							
		OutreachTotal = OutreachTotal + RS("Outreach")
			
	RS.MoveNext
	
	Loop

	' call final subtotal
		PrintAgeSubTotal(0)

	%>	
	</TABLE>	
	
	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

	<Table BORDER=0 WIDTH="93%" cellpadding=3 cellSpacing="0">

		<TR>
				<TD WIDTH="25%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=RIGHT>
					<FONT face=FontNameData size=2><B>Female Totals:</B>
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=FemaleOutreachTotal%>
					</FONT>
				</TD>
		</TR>

		<TR>
				<TD WIDTH="25%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=RIGHT>
					<FONT face=FontNameData size=2><B>Male Totals:</B>
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=MaleOutreachTotal%>
					</FONT>
				</TD>
		</TR>

		<TR>
				<TD WIDTH="25%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=RIGHT>
					<FONT face=FontNameData size=2><B>Unknown Totals:</B>
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=UnknownOutreachTotal%>
					</FONT>
				</TD>
		</TR>
		<TR>
				<TD WIDTH="25%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=RIGHT>
					<FONT face=FontNameData size=2><B>Totals:</B>
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=OutreachTotal%>
					</FONT>
				</TD>
		</TR>
	</TABLE>	

</BODY>
</HTML>
	
	
<%
End If

Set RS = Nothing
Set Conn = Nothing
Set DonorRegistryConn = Nothing


%>


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


Private Function SubTotal(Label1, PrintLine, Value1)
	%>
		<TR>
			<TD WIDTH="25%" ALIGN=CENTER>
				<FONT face=FontNameData size=2>&nbsp
				</FONT>
			</TD>
			<TD WIDTH="25%" ALIGN=RIGHT>
				<FONT face=FontNameData size=2><B><%=Label1%></B>
				</FONT>
			</TD>
			<TD WIDTH="25%" ALIGN=CENTER>	
				<FONT face=FontNameData size=2>&nbsp
				</FONT>
			</TD>
			<TD WIDTH="25%" ALIGN=CENTER>	
				<FONT face=FontNameData size=2><%=Value1%>
				</FONT>
			</TD>
		</TR>	
	<% 
	If PrintLine = 1 Then 
	%>
		<TR>
			<TD COLSPAN=4><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
		</TR>
	<% 
	End If		
	
End Function

Function PrintAgeSubTotal(PrintLine)

	Call SubTotal(CurrentAge & " " & "Totals:", PrintLine, AgeOutreachSubTotal)

End Function

Function PrintSourceTotal(PrintLine)

	Call SubTotal(CurrentSource & " " & "Totals:", PrintLine, SourceOutReachTotal)
	
End Function

'End of Function Section
%>