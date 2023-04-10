<% Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

%>
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>Call Count Summary</title>
</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%	
Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData

Dim vCurrentColor

Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim vOrgID
Dim vReportGroupID
Dim vSourceCodeID

Dim ReferralTypeList
Dim RSAccess

Dim vOrgName

Dim vValue
Dim x
Dim vErrorMsg
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

Dim vPreviousSourceCodeID
Dim vLineTitle
Dim vTotalCountForSource
Dim vTotalBrochureYesForSource
Dim vTotalBrochureNoForSource

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"

%>

<%

'Execute the main page generating routine
If AuthorizeMain Then
DataSourceName="Production"

pvUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
vOrgID = 0	


'Set Title Values
vMainTitle = "Donate Life America Call Count Summary"
vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
vTitleTimes = "All Times Mountain Time"

End If

%>
	<!-- Print the header. -->
	<!--#include virtual="/loginstatline/reports/admin/Head.sls"-->
<%

'Open data connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD

%>


<!-- User Org Section -->

<%

If pvUserOrgID = 194 Then

	'Replace user org id with the owner of the selected report group
	If vReportGroupID <> 0 Then

		'Get number of rows
		vQuery = "sps_ReportGroupOrgParentID " & vReportGroupID

		Set RS = Conn.Execute(vQuery)
	
		pvUserOrgID = RS("OrgHierarchyParentID")

		Set RS = Nothing

	End If

End If

%>


<!-- Call Count Section -->

<P STYLE="line-height: 1pt">&nbsp</P>


<!-- Get Raw Data -->

<%

'Get the data for the table
vQuery = "sps_COD_CallCounts " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "'"
'Print vQuery
'response.end

Set RS = Conn.Execute(vQuery)

If RS.EOF = True Then

%>

	<TABLE WIDTH="100%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Donate Life America Call Counts  </B></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>"> No Calls Received During This Time Period </FONT> </TD></TR>
	</TABLE>

<%
Else
%>

<%vCurrentColor = "bgcolor=#FFF5EE"%>

<%While Not RS.EOF
	
	If vPreviousSourceCodeID =  RS("SourceCodeID") Then
		
%>
		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(RS("OrganizationName"))%></TD>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(RS("CallCount"))%></TD>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(RS("BrochureYes"))%></TD>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(RS("BrochureNo"))%></TD>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(FormatPercent((RS("BrochureYes")/RS("CallCount")),1))%></TD>
			
		</TR>
		
		
					
<%
		vTotalCountForSource = vTotalCountForSource + RS("CallCount")
		vTotalBrochureYesForSource = vTotalBrochureYesForSource + RS("BrochureYes")
		vTotalBrochureNoForSource = vTotalBrochureNoForSource + RS("BrochureNo")
		
		If vCurrentColor = "bgcolor=#FFF5EE" Then
			vCurrentColor = "bgcolor=#F5EBDD"
		Else
			vCurrentColor = "bgcolor=#FFF5EE"
		End If
				
		vPreviousSourceCodeID =  RS("SourceCodeID")
		
		RS.MoveNext
		
		If not RS.EOF Then
			If vPreviousSourceCodeID <> RS("SourceCodeID") Then
%>
				<TR>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><b>TOTAL</b></TD>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(vTotalCountForSource)%></TD>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(vTotalBrochureYesForSource)%></TD>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(vTotalBrochureNoForSource)%></TD>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(FormatPercent((vTotalBrochureYesForSource/vTotalCountForSource),1))%></TD>
					
				</TR>
				</TABLE>
				<UL></UL>
				<UL></UL>
				<UL></UL>
<%
			End If
		End if
%>
		
		
<%
	Else
%>
			
		<!-- Create Table Header -->

		<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">
		
		<%
		Select Case RS("SourceCodeName")
			Case "CODGEN","DLAGEN" 
				vLineTitle = "General Line (" & RS("SourceCodeName") &")" 
			Case "CODAA","DLAAA"
				vLineTitle = "African American Line (" & RS("SourceCodeName") &")"
			Case "CODSPAN","DLASPAN"
				vLineTitle = "Spanish Line (" & RS("SourceCodeName") & ")"
		End Select
		
		vTotalCountForSource = 0
		vTotalBrochureYesForSource = 0
		vTotalBrochureNoForSource = 0
		
		%>
		
		<font FACE="<%=FontNameHead%>" size=2><b>Call Counts For <%Response.Write(vLineTitle)%></b></font>
		
		<HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%">
		
		<TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">
					
		<TR>	
			<TD ALIGN=Left width="40%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Coalition Name</B></TD>	
			<TD ALIGN=Left width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total # of Calls</B></TD>
			<TD ALIGN=Left width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B># Receiving Brochures</B></TD>
			<TD ALIGN=Left width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B># Not Receiving Brochures</B></TD>
			<TD ALIGN=Left width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>% of Callers Receiving Brochures</B></TD>
		<TR>
			<TD COLSPAN=5><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>	
		
		<%
		If vCurrentColor = "bgcolor=#FFF5EE" Then
			vCurrentColor = "bgcolor=#F5EBDD"
		Else
			vCurrentColor = "bgcolor=#FFF5EE"
		End If
		
		
		vPreviousSourceCodeID =  RS("SourceCodeID")
		
	End If
		
Wend%>

<TR>
	<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><b>TOTAL</b></TD>
	<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(vTotalCountForSource)%></TD>
	<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(vTotalBrochureYesForSource)%></TD>
	<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(vTotalBrochureNoForSource)%></TD>
	<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%Response.Write(FormatPercent((vTotalBrochureYesForSource/vTotalCountForSource),1))%></TD>
</TR>

</TABLE>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<UL></UL>


<%	
Set RS = Nothing
%>

</BODY>
</HTML>
<%End If%>

<%
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

<%
Sub GetPhoneLineTitle(vIn, vOut)
	Select Case vIn
		Case "CODGEN","DLAGEN"
			vOut = "General Line"
		Case "CODAA","DLAAA"
			vOut = "African American Line"
		Case "CODSPAN","DLASPAN"
			vOut = "Spanish Line"
	End Select
End Sub
%>
