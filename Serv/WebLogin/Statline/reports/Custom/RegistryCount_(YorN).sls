
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
Dim RegistryDSN

'TOTAL GENDER
Dim FemaleOnlineTotal
Dim MaleOnlineTotal
Dim UnknownOnlineTotal

Dim FemaleOutreachTotal
Dim MaleOutreachTotal
Dim UnknownOutreachTotal

'Total Donor
Dim YOnlineTotal
Dim NOnlineTotal
Dim UOnlineTotal

Dim YOutreachTotal
Dim NOutreachTotal
Dim UOutreachTotal

'DONOR STATUS Y
Dim YFemaleOnlineTotal
Dim YMaleOnlineTotal
Dim YUnknownOnlineTotal

Dim YFemaleOutreachTotal
Dim YMaleOutreachTotal
Dim YUnknownOutreachTotal

'DONOR STATUS N
Dim NFemaleOnlineTotal
Dim NMaleOnlineTotal
Dim NUnknownOnlineTotal

Dim NFemaleOutreachTotal
Dim NMaleOutreachTotal
Dim NUnknownOutreachTotal

'DONOR STATUS U
Dim UFemaleOnlineTotal
Dim UMaleOnlineTotal
Dim UUnknownOnlineTotal

Dim UFemaleOutreachTotal
Dim UMaleOutreachTotal
Dim UUnknownOutreachTotal


Dim CurrentAge
'subtotals 
Dim YesOnlineSubTotal
Dim YesOutreachSubTotal
Dim NoOnlineSubTotal
Dim NoOutreachSubTotal
Dim UOnlineSubTotal 
Dim UOutreachSubTotal

Dim OnlineTotal
Dim OutreachTotal

Dim x
Dim i

Dim FontNameHead
Dim FontNameData
Dim DataWarehouseConn
Dim PORGANIZATIONID

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim pvReportID
PORGANIZATIONID= 50
CurrentAge = "Initial"

pvCallID = 0
FontNameHead = "Arial"
FontNameData = "Times New Roman"
vReportTitle = "CO Registry Count (Y or N) "
vReportName = ""
RegistryDSN = Request.QueryString("RegistryDSN")
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
	pvReportID = Request.QueryString("ReportID")
	
	'Get the report Name
	vQuery = "sps_ReportInformation " & pvReportID
	'print(vQuery)
	Set RS = Conn.Execute(vQuery)
	
	If RS.EOF = True Then
	  vReportTitle = "Registry Count (Source Summary) "
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
	
	vQuery = " sps_DonorRegistryByGenderAgeAndDonorStatus2 '" & pvStartDate & "', '" & pvEndDate & "'"
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
	vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
	vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
	vTitleTimes = "All Times " & ZoneName(vTZ)	
%>

<!--#include virtual="/loginstatline/reports/custom/RegistryCountHead.sls"--> 
<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

<!-- table header -->
<Table BORDER=0 WIDTH="93%" cellpadding=3 cellSpacing="0">
	<TR>
		<TH WIDTH="20%">
			<FONT face=FontNameHead size=2>Donor Status
			</FONT>
		</TH>

		<TH WIDTH="20%">
			<FONT face=FontNameHead size=2>GENDER
			</FONT>
		</TH>
		<TH WIDTH="20%">
			<FONT face=FontNameHead size=2>AGE RANGE
			</FONT>
		</TH>
		<TH WIDTH="20%">	
			<FONT face=FontNameHead size=2>ONLINE COUNT
			</FONT>
		</TH>
		<TH WIDTH="20%">	
			<FONT face=FontNameHead size=2>OUTREACH COUNT
			</FONT>
		</TH>		
	</TR>

<%
	Do While Not RS.EOF
	
	'Print Subtotal if the age range has changed and CurrentAge is not Initial
	If CurrentAge <> "Initial" AND CurrentAge <>RS("AgeRange") Then
		PrintAgeSubTotal(1)
		YesOnlineSubTotal = 0
		YesOutreachSubTotal = 0 
		NoOnlineSubTotal = 0
		NoOutreachSubTotal = 0
		UOnlineSubTotal = 0
		UOutreachSubTotal = 0
	End If

	CurrentAge = RS("AgeRange")

%>

<!-- begin report -->

	<TR>
		<TD WIDTH="20%" ALIGN=CENTER>
			<FONT face=FontNameData size=2><%=RS("Donor")%>
			</FONT>
		</TD>

		<TD WIDTH="20%" ALIGN=CENTER>
			<FONT face=FontNameData size=2><%=RS("Gender")%>
			</FONT>
		</TD>
		<TD WIDTH="20%" ALIGN=CENTER>
			<FONT face=FontNameData size=2><%=RS("AgeRange")%>
			</FONT>
		</TD>
		<TD WIDTH="20%" ALIGN=CENTER>	
			<FONT face=FontNameData size=2><%=RS("OnLine")%>
			</FONT>
			
		</TD>
		<TD WIDTH="20%" ALIGN=CENTER>	
			<FONT face=FontNameData size=2><%=RS("Outreach")%>
			</FONT>
			
		</TD>
		
	</TR>
	
	<%		
		'Add to age SubTotal
			If RS("Donor") = "Y" Then
				YesOnlineSubTotal = YesOnlineSubTotal + RS("OnLine")
				YesOutreachSubTotal = YesOutreachSubTotal + RS("Outreach")
				YOnlineTotal = YOnlineTotal + RS("OnLine")
				YOutreachTotal = YOutreachTotal + RS("Outreach")
			ElseIF RS("Donor") = "N" Then
				NoOnlineSubTotal = NoOnlineSubTotal + RS("OnLine")
				NoOutreachSubTotal = NoOutreachSubTotal + RS("Outreach")
				NOnlineTotal = NOnlineTotal + RS("OnLine")
				NOutreachTotal = NOutreachTotal + RS("Outreach")
			Else
				UOnlineSubTotal = UOnlineSubTotal + RS("OnLine")
				UOutreachSubTotal = UOutreachSubTotal + RS("Outreach")
				UOnlineTotal = UOnlineTotal + RS("OnLine")			
				UOutreachTotal = UOutreachTotal + RS("Outreach")				
			End If
				
		'Add to Gender Totals
			If RS("Gender") = "F" Then
				FemaleOnlineTotal = FemaleOnlineTotal + RS("OnLine")
				FemaleOutreachTotal = FemaleOutreachTotal + RS("Outreach")
				If RS("Donor") = "Y" Then
					YFemaleOnlineTotal = YFemaleOnlineTotal + RS("OnLine")
					YFemaleOutreachTotal = YFemaleOutreachTotal + RS("Outreach")
				ElseIF RS("Donor") = "N" Then
					NFemaleOnlineTotal = NFemaleOnlineTotal + RS("OnLine")
					NFemaleOutreachTotal = NFemaleOutreachTotal + RS("Outreach")
				Else	
					UFemaleOnlineTotal = UFemaleOnlineTotal + RS("OnLine")
					UFemaleOnlineTotal = UFemaleOutreachTotal + RS("Outreach")				
				End If
			ElseIf RS("Gender") = "M" Then					
				MaleOnlineTotal = MaleOnlineTotal + RS("OnLine")
				MaleOutreachTotal = MaleOutreachTotal + RS("Outreach")
				
				If RS("Donor") = "Y" Then
					YMaleOnlineTotal = YMaleOnlineTotal + RS("OnLine")
					YMaleOutreachTotal = YMaleOutreachTotal + RS("Outreach")
				ElseIF RS("Donor") = "N" Then
					NMaleOnlineTotal = NMaleOnlineTotal + RS("OnLine")
					NMaleOutreachTotal = NMaleOutreachTotal + RS("Outreach")				
				Else
					UMaleOnlineTotal = UMaleOnlineTotal + RS("OnLine")
					UMaleOutreachTotal = UMaleOutreachTotal + RS("Outreach")				
				End If
				
			ElseIf RS("Gender") = "U" Then						
				UnknownOnlineTotal = UnknownOnlineTotal + RS("OnLine")
				UnknownOutreachTotal = UnknownOutreachTotal + RS("Outreach")
				If RS("Donor") = "Y" Then
					YUnknownOnlineTotal =  YUnknownOnlineTotal + RS("OnLine")			
					YUnknownOutreachTotal =  YUnknownOutreachTotal + RS("Outreach")
				ElseIF RS("Donor") = "N" Then
					NUnknownOnlineTotal =  NUnknownOnlineTotal + RS("OnLine")
					NUnknownOutreachTotal = NUnknownOutreachTotal + RS("Outreach")
				Else
					UUnknownOnlineTotal =  UUnknownOnlineTotal + RS("OnLine")
					UUnknownOutreachTotal =  UUnknownOutreachTotal + RS("Outreach") 				
				End If				
			End If	
		
		'Add to Grand Total	
			OnlineTotal = OnlineTotal + RS("OnLine")
			OutreachTotal = OutreachTotal + RS("Outreach")
	
	RS.MoveNext
	
	Loop
	
	' call final subtotal
		PrintAgeSubTotal(0)

	%>	
	</TABLE>
	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

	<Table BORDER=0 WIDTH="93%" cellpadding=3 cellSpacing="0">
	
	
	<% 
	' PrintTotal(pvLabel, pvOnline, pvOutreach)
	
	' Yes Female YFemaleOnlineTotal YFemaleOutreachTotal 
	Call PrintTotal("Yes Female", YFemaleOnlineTotal , YFemaleOutreachTotal)
	
	' Yes Male YMaleOnlineTotal YMaleOutreachTotal	
	Call PrintTotal("Yes Male", YMaleOnlineTotal, YMaleOutreachTotal)
	' Yes Unknown YUnknownOnlineTotal YUnknownOutreachTotal 
	Call PrintTotal("Yes Unknown", YUnknownOnlineTotal, YUnknownOutreachTotal)
	' Yes  YOnlineTotal YOutreachTotal
	Call PrintTotal("Yes", YOnlineTotal, YOutreachTotal)
	
	
	' No Female  NFemaleOnlineTotal NFemaleOutreachTotal 
	Call PrintTotal("No Female ", NFemaleOnlineTotal, NFemaleOutreachTotal)
	' No Male NMaleOnlineTotal NMaleOutreachTotal 	
	Call PrintTotal("No Male", NMaleOnlineTotal, NMaleOutreachTotal)
	' No Unknown NUnknownOnlineTotal NUnknownOutreachTotal 
	Call PrintTotal("No Unknown", NUnknownOnlineTotal, NUnknownOutreachTotal)
	' No NOnlineTotal NOutreachTotal
	Call PrintTotal("No", NOnlineTotal, NOutreachTotal)
	
	' Unknown Female UFemaleOnlineTotal UFemaleOnlineTotal	
	Call PrintTotal("Unknown Female", UFemaleOnlineTotal, UFemaleOnlineTotal)
	' Unknown Male  UMaleOnlineTotal UMaleOutreachTotal
	Call PrintTotal("Unknown Male", UMaleOnlineTotal, UMaleOutreachTotal)
	' Unknown Unknown Gender UUnknownOnlineTotal UUnknownOutreachTotal 
	Call PrintTotal("Unknown Unknown Gender", UUnknownOnlineTotal, UUnknownOutreachTotal)
	' Unknown UOnlineTotal UOutreachTotal
	Call PrintTotal("Unknown Status", UOnlineTotal, UOutreachTotal)
	
	
	' Male MaleOnlineTotal MaleOutreachTotal
	Call PrintTotal("Male", MaleOnlineTotal, MaleOutreachTotal)
	' Female  FemaleOnlineTotal FemaleOutreachTotal
	Call PrintTotal("Female", FemaleOnlineTotal, FemaleOutreachTotal)
	' Unknown Gender UnknownOnlineTotal UnknownOutreachTotal 
	Call PrintTotal("Unknown Gender", UnknownOnlineTotal, UnknownOutreachTotal)	
	' Total OnlineTotal OutreachTotal
	Call PrintTotal("Total", OnlineTotal, OutreachTotal)
	%>
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


Private Function SubTotal(PrintLine)
'Set PrintLine to Print a horizontal line after printing the subtotals.
%>
	<TR>
		<TD <%=vCurrentColor%>  ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i>&nbsp &nbsp &nbsp &nbsp Subtotal</i></B></TD>
		<TD <%=vCurrentColor%>  ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(0)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(1)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(2)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(3)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(4)%></i></B></FONT></TD>
	</TR>
	<% 
	If PrintLine = 1 Then 
	%>
		<TR>
			<TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
		</TR>
	<% 
	End If		
	%>	
<%	
	For i = 0 to UBound(vOrgTotals,1)
			vOrgTotals(i)=0
	Next
End Function
Function PrintTotal(pvLabel, pvOnline, pvOutReach)
	If pvOnline = 0 and pvOutReach = 0 Then	
		Exit Function
	End IF
%>
		<TR>
		
				<TD WIDTH="20%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
		
				<TD WIDTH="20%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=RIGHT COLSPAN=2>
					<FONT face=FontNameData size=2><B><%=pvLabel%>:</B>
					</FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=pvOnline%>
					</FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=pvOutReach%>
					</FONT>
				</TD>
				
		</TR>
		<%
End Function


Function PrintAgeSubTotal(PrintLine)
	%>
		<TR>
			<TD WIDTH="20%" ALIGN=CENTER>
				<FONT face=FontNameData size=2>&nbsp
				</FONT>
			</TD>
			<TD WIDTH="20%" ALIGN=CENTER>
				<FONT face=FontNameData size=2>&nbsp
				</FONT>
			</TD>
			<TD WIDTH="20%" ALIGN=RIGHT COLSPAN=1>
				<FONT face=FontNameData size=2><B><%=CurrentAge%> Yes Sub Total:</B>
				</FONT>
			</TD>
			<TD WIDTH="20%" ALIGN=CENTER>	
				<FONT face=FontNameData size=2><%=YesOnlineSubTotal%>
				</FONT>
			</TD>
			<TD WIDTH="20%" ALIGN=CENTER>	
				<FONT face=FontNameData size=2><%=YesOutreachSubTotal%>
				</FONT>
			</TD>
		</TR>	
		<TR>
			<TD WIDTH="20%" ALIGN=CENTER>
				<FONT face=FontNameData size=2>&nbsp
				</FONT>
			</TD>
			<TD WIDTH="20%" ALIGN=CENTER>
				<FONT face=FontNameData size=2>&nbsp
				</FONT>
			</TD>
			<TD WIDTH="20%" ALIGN=RIGHT COLSPAN=1>
				<FONT face=FontNameData size=2><B><%=CurrentAge%>  No&nbsp Sub Total:</B>
				</FONT>
			</TD>
			<TD WIDTH="20%" ALIGN=CENTER>	
				<FONT face=FontNameData size=2><%=NoOnlineSubTotal%>
				</FONT>
			</TD>
			<TD WIDTH="20%" ALIGN=CENTER>	
				<FONT face=FontNameData size=2><%=NoOutreachSubTotal%>
				</FONT>
			</TD>
		</TR>	

		<% If UOnlineSubTotal > 0 OR UOutreachSubTotal > 0 Then %>
			<TR>
				<TD WIDTH="20%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=RIGHT COLSPAN=1>
					<FONT face=FontNameData size=2><B><%=CurrentAge%> UnKnown Sub Total:</B>
					</FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=UOnlineSubTotal%>
					</FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=UOutreachSubTotal%>
					</FONT>
				</TD>
			</TR>	
			
		<% End If %>	


		
	<% 
	If PrintLine = 1 Then 
	%>
		<TR>
			<TD COLSPAN=5><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
		</TR>
	<% 
	End If		
	
End Function

'End of Function Section
%>