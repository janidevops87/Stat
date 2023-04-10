<% Option Explicit%>
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
Dim rc 'row color switch
Dim prl ' print line value

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
Dim c
Dim x
Dim vErrorMsg
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

Dim vPreviousDate
Dim vLineTitle

Dim vAA
Dim vSPAN
Dim vGEN

Dim vtlAA
Dim vtlSPAN
Dim vtlGEN

Dim vTotalAA
Dim vTotalGEN
Dim vTotalSPAN
Dim vTotalALL

c  = 0
rc = 1
prl = 0

vtlAA = 0
vtlSPAN = 0
vtlGEN = 0

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
vOrgID = Request.QueryString("OrgID")	


'Set Title Values
vMainTitle = "Donate Life America Call Count By Day"
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

'Get the organization name for the table
vQuery = "sps_COD_GetCoalitionName " & vOrgID
Set RS = Conn.Execute(vQuery)

If RS.EOF = True then
	vOrgName = "All Coalitions"
Else
	vOrgName = RS("OrganizationName")
End if

vQuery = ""
Set RS = Nothing

'Get the data for the table
vQuery = "sps_COD_CallCountsByDay " & vOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "'"
'Print vQuery
'response.end

Set RS = Conn.Execute(vQuery)

If RS.EOF = True Then

%>

	<TABLE WIDTH="100%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Donate Life America Call Counts By Day  </B></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>"> No Calls Received During This Time Period </FONT> </TD></TR>
	</TABLE>

<%
Else
%>

<%vCurrentColor = "bgcolor=#F5EBDD"%>
			
		<!-- Create Table Header -->

		<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">
		
		
		<font FACE="<%=FontNameHead%>" size=2><b>Call Counts For <%Response.Write(vOrgName)%></b></font>
		
		<HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%">
		
		<TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">
					
		<TR>	
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B></B></TD>	
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B># of Calls</B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B># of Calls</B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B># of Calls</B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B># of Calls</B></TD>
		</TR>
		
		<TR>	
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B></B>Date</TD>	
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>African American line</B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>General line</B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Spanish line</B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>All lines</B></TD>
		</TR>
			<TD COLSPAN=5><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
			
			<%
			'zero out totals before counts
			vTotalAA = 0
			vTotalGEN = 0
			vTotalSPAN = 0

			'ccarroll 08/16/2006 - modified While clause to inlude multiple source codes
			
			While Not RS.EOF


			  If vPreviousDate <> RS("CallDate") Then
				prl = 1
			  Else
			        prl = 0
			  End if


			  Select Case RS("SourceCodeName")
				   
			    Case "DLAAA","CODAA" 
				'vAA = True
				vtlAA = vtlAA + RS("CallCount")
				vTotalAA = vTotalAA + RS("CallCount")
				vTotalALL = vTotalALL + RS("CallCount")

			    Case "DLAGEN","CODGEN"
				'vGEN = True
				vtlGEN = vtlGEN + RS("CallCount")
				vTotalGEN = vTotalGEN + RS("CallCount")
				vTotalALL = vTotalALL + RS("CallCount")

			    Case "DLASPAN","CODSPAN"
				'vSPAN = True
				vtlSPAN = vtlSPAN + RS("CallCount")
				vTotalSPAN = vTotalSPAN + RS("CallCount")
				vTotalALL = vTotalALL + RS("CallCount")
						
			  End Select



			  If prl = 1  then

				'Write line to screen

				response.write("<TR>")
				response.write("<TD " & vCurrentColor & "><FONT SIZE=1 FACE=" & FontNameHead & ">" & RS("CallDate") & "</TD>")

			  		If vtlAA = 0 then
					   response.write("<TD " & vCurrentColor & "><FONT SIZE=1 FACE=" & FontNameHead & "></TD>")
					Else
					   response.write("<TD " & vCurrentColor & "><FONT SIZE=1 FACE=" & FontNameHead & ">" & vtlAA & "</TD>")
					End if

			  		If vtlGEN = 0 then
					   response.write("<TD " & vCurrentColor & "><FONT SIZE=1 FACE=" & FontNameHead & "></TD>")
					Else
					   response.write("<TD " & vCurrentColor & "><FONT SIZE=1 FACE=" & FontNameHead & ">" & vtlGEN & "</TD>")
					End if

			  		If vtlSPAN = 0 then
					   response.write("<TD " & vCurrentColor & "><FONT SIZE=1 FACE=" & FontNameHead & "></TD>")
					Else
					   response.write("<TD " & vCurrentColor & "><FONT SIZE=1 FACE=" & FontNameHead & ">" & vtlSPAN & "</TD>")
					End if

		   		response.write("<TD " & vCurrentColor & "><FONT SIZE=1 FACE=" & FontNameHead & ">" & vTotalALL & "</TD>")
		   		response.write("</TR>")
						
						
				'reset all row data after printing line
				vtlAA = 0
				vtlGEN = 0
				vtlSPAN = 0
				vTotalALL = 0

				'set rov color for next line
				If rc = 1 Then
				   vCurrentColor = "bgcolor=#FFF5EE"
				   rc = 0
				Else
				   vCurrentColor = "bgcolor=#F5EBDD"
				   rc = 1
				End If


			  End If

			vPreviousDate = RS("CallDate")
	
	   		RS.MoveNext

		Wend

%>

		<TR>
			<TD COLSPAN=5><HR ALIGN=CENTER COLOR="#666666" NOSHADE SIZE=2 WIDTH="100%"></TD>
		
		</TR>

		<TR>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>TOTAL</B></TD>	
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%Response.Write(vTotalAA)%></B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%Response.Write(vTotalGEN)%></B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%Response.Write(vTotalSPAN)%></B></TD>
			<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%Response.Write(vTotalAA + vTotalGEN + vTotalSPAN)%></B></TD>
		</TR>
</TABLE>
<p>
</p>



<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<UL></UL>


<%	
Set RS = Nothing
%>

</BODY>
</HTML>

<%End If %>

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
