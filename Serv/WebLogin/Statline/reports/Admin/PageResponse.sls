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
<title>Page Response Times</title>
</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%	
Dim ErrorReturn
Dim FontNameHead 
Dim FontSizeHead 
Dim FontNameData 
Dim FontSizeData 
Dim FontNameHeadLog 
Dim FontSizeDataLog 
Dim FontNameDataLog 
	
Dim pvStartDate
Dim pvEndDate
Dim vCountArray
Dim vRows
Dim i, j
Dim pvUserOrgID
Dim vReportGroupID
Dim vRefOrgID

Dim vLastPerson
Dim vLastCallID
Dim vLastTypeID
Dim vFirstPageTime
Dim vLastPageTime

Dim vTotalPages
Dim vNumRepages
Dim vTotalRepages
Dim vTotalNoResponses

Dim vTotalPageTime
Dim vMaxPageTime
Dim vMaxCallID
Dim vPageResponse

Dim vOverallPageTime

Dim vRowData

Dim x, ConnDash, RS0,RS1, vErrorMsg
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeDataLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"


Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)

pvUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
vRefOrgID = Request.QueryString("OrgID")
%>

<%'Execute the main page generating routine
If AuthorizeMain Then
	'Set Title Values
	vMainTitle = "Page Reponse Times"
	vTitlePeriod = pvStartDate
	vTitleTo = pvEndDate
	vTitleTimes = ""
%>
	<!-- Print the header. -->
	<!--#include virtual="/loginstatline/reports/admin/Head.sls"-->	


<!-- User Org Section -->
<%
'Open Connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD

If pvUserOrgID = 194 Then

	'Replace user org id with the owner of the selected report group
	If vReportGroupID <> 0 Then

		vQuery = "sps_ReportGroupOrgParentID " & vReportGroupID
		Set RS = Conn.Execute(vQuery)
		pvUserOrgID = RS("OrgHierarchyParentID")
		Set RS = Nothing
		
	End If

End If
%>


<!-- Referral Page Response Section -->

<P STYLE="line-height: 1pt">&nbsp</P>

<TABLE WIDTH="100%" BORDER=0>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Page Response Times </B></FONT> </TD></TR>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> (Referrals) </FONT> </TD></TR>
</TABLE>


<!-- Get Raw Data -->
<%
'Get number of rows
'bjk 1/1/02 added vRefOrgID and vReportGroupID to query strings
vQuery = "sps_PageResponsePerson1 " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', 1, " & vRefOrgID & ", " & vReportGroupID  
'Print vQuery
Set RS = Conn.Execute(vQuery)

vRows = RS("PersonCount")
Set RS = Nothing

'Set size of array
ReDim vCountArray(vRows,6)


'Get data rows
vQuery = "sps_PageResponse1 " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', 1, " & vRefOrgID & ", " & vReportGroupID
'Print vQuery
Set RS = Conn.Execute(vQuery)

If RS.EOF = True Then%>

	<%ReDim vCountArray(1,6)
	vCountArray(0,0) = "No Data Available"
	For i = 0 to 1
		For j = 1 to 6
			vCountArray(i,j) = 0
		Next
	Next%>

<%Else

	vLastPerson = RS("Person")
	vLastCallID = RS("CallID")
	vLastTypeID = RS("TypeID")
	vFirstPageTime = ""
	vPageResponse = False
	vTotalPages = 0
	vTotalRepages = 0
	vTotalNoResponses = 0
	vTotalPageTime = 0 
	vMaxPageTime = 0
	i = 0
	vCountArray(Ubound(vCountArray, 1), 5) = 0

	Do Until RS.EOF

		If RS("Person") = vLastPerson Then
					

			'Process Person Data
			Call ProcessPersonData()
			

		Else
					
			'No more calls for the person so tally
			vCountArray(i, 0) = vLastPerson
			vCountArray(i, 1) = vTotalPages
			vCountArray(i, 2) = vTotalNoResponses
			vCountArray(i, 3) = vTotalRepages
			If vTotalPages <> 0 Then
				vCountArray(i, 4) = FormatNumber(vTotalPageTime/vTotalPages,1)
			Else
				vCountArray(i, 4) = 0
			End If
			vCountArray(i, 5) = vMaxPageTime
			vCountArray(i,6) = vMaxCallID

			'Initialize for next person
			vLastPerson = RS("Person")
			vLastCallID = RS("CallID")
			vLastTypeID = RS("TypeID")
			vFirstPageTime = CStr(RS("DateTime"))
			vTotalPages = 0
			vTotalRepages = 0
			vTotalNoResponses = 0
			vMaxPageTime = 0
			vMaxCallID = 0
			vTotalPageTime = 0
			vPageResponse = False
			i = i + 1
				
			'Process FIRST Person Data
			Call ProcessPersonData()
							

		End If

		RS.MoveNext

	Loop

	'No more calls for the person so tally
	vCountArray(i, 0) = vLastPerson
	vCountArray(i, 1) = vTotalPages
	vCountArray(i, 2) = vTotalNoResponses
	vCountArray(i, 3) = vTotalRepages
	If vTotalPages <> 0 Then
		vCountArray(i, 4) = FormatNumber(vTotalPageTime/vTotalPages,1)
	Else
		vCountArray(i, 4) = 0
	End If
	vCountArray(i, 5) = vMaxPageTime
	vCountArray(i,6) = vMaxCallID

	'Calculate totals
	For j = 1 to 3
		For i = 0 to Ubound(vCountArray, 1)-1
			vCountArray(Ubound(vCountArray, 1), j) = vCountArray(Ubound(vCountArray, 1), j) + vCountArray(i, j)
		Next
	Next

	'Calculate overall average
	For i = 0 to Ubound(vCountArray, 1)-1
		'Calculate total minutes
		vOverallPageTime = vOverallPageTime + (vCountArray(i,1) * vCountArray(i, 4))
	Next

		If vCountArray(Ubound(vCountArray, 1), 1) = 0 Then
			vCountArray(Ubound(vCountArray, 1), 4) = 0
		Else
			vCountArray(Ubound(vCountArray, 1), 4) = vOverallPageTime / vCountArray(Ubound(vCountArray, 1), 1)
		End If
	End If

Set RS = Nothing

%>

	<!-- Format Table -->
	<TABLE BORDER=1>

		<TR>
			<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Person</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Initial Pages</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>No Responses</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Repages</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Avg Time (min)</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Longest Time (min)</TD></B>	
		</TR>

		<%For i = 0 to Ubound(vCountArray, 1)-1%>
			<TR> 
				<%For j = 0 to Ubound(vCountArray,2)-1
					If j = Ubound(vCountArray,2)-1 Then%>
						<TD ALIGN=CENTER><FONT FACE="Arial" SIZE=2>
					    <a href="/loginstatline/reports/referral/detail_1.sls?CallID=<%=vCountArray(i,6)%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;Options=0"><%=vCountArray(i,j)%></a></FONT></TD>
					<%ElseIf j = 0 Then%>
						<TD ALIGN=LEFT><FONT FACE="Arial" SIZE=2><%=vCountArray(i,j)%></FONT> </TD>
					<%Else%>
						<TD ALIGN=CENTER><FONT FACE="Arial" SIZE=2><%=vCountArray(i,j)%></FONT> </TD>
					<%End If
				Next%>
			</TR>
		<%Next%>

		<TR>
			<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Totals</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vCountArray(Ubound(vCountArray, 1), 1)%></TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vCountArray(Ubound(vCountArray, 1), 2)%></TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vCountArray(Ubound(vCountArray, 1), 3)%></TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=FormatNumber(vCountArray(Ubound(vCountArray, 1), 4),1)%></TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vCountArray(Ubound(vCountArray, 1), 5)%></TD></B>	
		</TR>

	</TABLE>





<!-- Message Page Response Section -->


<P STYLE="line-height: 1pt">&nbsp</P>

<!-- Header -->
<TABLE WIDTH="100%" BORDER=0>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Page Response Times </B></FONT> </TD></TR>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> (Messages & Imports) </FONT> </TD></TR>
</TABLE>


<!-- Get Raw Data -->
<%
'Get number of rows
vQuery = "sps_PageResponsePersonMessage1 " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', 2"

'Print vQuery
Set RS = Conn.Execute(vQuery)

vRows = RS("PersonCount")
Set RS = Nothing

'Set size of array
ReDim vCountArray(vRows,6)

'Get data rows
vQuery = "sps_PageResponseMessage1 " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', 2" 

'Print vQuery
Set RS = Conn.Execute(vQuery)

If RS.EOF = True Then%>

	<%ReDim vCountArray(1,6)
	vCountArray(0,0) = "No Data Available"
	For i = 0 to 1
		For j = 1 to 6
			vCountArray(i,j) = 0
		Next
	Next%>

<%Else

	vLastPerson = RS("Person")
	vLastCallID = RS("CallID")
	vLastTypeID = RS("TypeID")
	vFirstPageTime = ""
	vPageResponse = False
	vTotalPages = 0
	vTotalRepages = 0
	vTotalNoResponses = 0
	vTotalPageTime = 0 
	vMaxPageTime = 0
	vOverallPageTime = 0
	i = 0
	vCountArray(Ubound(vCountArray, 1), 5) = 0

	Do Until RS.EOF

		If RS("Person") = vLastPerson Then

			'Process Person Data
			Call ProcessPersonData()

		Else
					
			'No more calls for the person so tally
			vCountArray(i, 0) = vLastPerson
			vCountArray(i, 1) = vTotalPages
			vCountArray(i, 2) = vTotalNoResponses
			vCountArray(i, 3) = vTotalRepages
			If vTotalPages <> 0 Then
				vCountArray(i, 4) = FormatNumber(vTotalPageTime/vTotalPages,1)
			Else
				vCountArray(i, 4) = 0
			End If
			vCountArray(i, 5) = vMaxPageTime
			vCountArray(i,6) = vMaxCallID

			'Initialize for next person
			vLastPerson = RS("Person")
			vLastCallID = RS("CallID")
			vLastTypeID = RS("TypeID")
			vFirstPageTime = CStr(RS("DateTime"))
			vTotalPages = 0
			vTotalRepages = 0
			vTotalNoResponses = 0
			vMaxPageTime = 0
			vMaxCallID = 0
			vTotalPageTime = 0
			vPageResponse = False
			i = i + 1

			'Process FIRST Person Data
			Call ProcessPersonData()


		End If

		RS.MoveNext

	Loop

	'No more calls for the person so tally
	vCountArray(i, 0) = vLastPerson
	vCountArray(i, 1) = vTotalPages
	vCountArray(i, 2) = vTotalNoResponses
	vCountArray(i, 3) = vTotalRepages
	If vTotalPages <> 0 Then
		vCountArray(i, 4) = FormatNumber(vTotalPageTime/vTotalPages,1)
	Else
		vCountArray(i, 4) = 0
	End If
	vCountArray(i, 5) = vMaxPageTime
	vCountArray(i,6) = vMaxCallID

	'Calculate totals
	For j = 1 to 3
		For i = 0 to Ubound(vCountArray, 1)-1
			vCountArray(Ubound(vCountArray, 1), j) = vCountArray(Ubound(vCountArray, 1), j) + vCountArray(i, j)
		Next
	Next

	'Calculate overall average
	For i = 0 to Ubound(vCountArray, 1)-1
		'Calculate total minutes
		vOverallPageTime = vOverallPageTime + (vCountArray(i,1) * vCountArray(i, 4))
	Next


	If vOverallPageTime = 0 Or vCountArray(Ubound(vCountArray, 1), 1) = 0 Then
		vCountArray(Ubound(vCountArray, 1), 4) = 0
	Else
		vCountArray(Ubound(vCountArray, 1), 4) = vOverallPageTime / vCountArray(Ubound(vCountArray, 1), 1)
	End If

End If

Set RS = Nothing

%>

	<!-- Format Table -->
	<TABLE BORDER=1>
		
		<TR>
			<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Person</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Initial Pages</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>No Responses</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Repages</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Avg Time (min)</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Longest Time (min)</TD></B>	
		</TR>
						

		<%For i = 0 to Ubound(vCountArray, 1)-1%>
			<TR> 
				<%For j = 0 to Ubound(vCountArray,2)-1
					If j = Ubound(vCountArray,2)-1 Then%>
						<TD ALIGN=CENTER><FONT FACE="Arial" SIZE=2>
					    <a href="/loginstatline/reports/message/detail.sls?CallID=<%=vCountArray(i,6)%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;Options=0"><%=vCountArray(i,j)%></a></FONT></TD>
					<%ElseIf j = 0 Then%>
						<TD ALIGN=LEFT><FONT FACE="Arial" SIZE=2><%=vCountArray(i,j)%></FONT> </TD>
					<%Else%>
						<TD ALIGN=CENTER><FONT FACE="Arial" SIZE=2><%=vCountArray(i,j)%></FONT> </TD>
					<%End If
				Next%>
			</TR>
		<%Next%>


		<TR>
			<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Totals</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vCountArray(Ubound(vCountArray, 1), 1)%></TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vCountArray(Ubound(vCountArray, 1), 2)%></TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vCountArray(Ubound(vCountArray, 1), 3)%></TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=FormatNumber(vCountArray(Ubound(vCountArray, 1), 4),1)%></TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vCountArray(Ubound(vCountArray, 1), 5)%></TD></B>	
		</TR>

	</TABLE>





</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<%End If

Set Conn = Nothing

Function ProcessPersonData()

			Select Case RS("TypeID")

				Case 6	'Page Pending
					'Response.Write(RS("Person") & " " &	vLastCallId & " " & RS("CallID") & " " & vFirstPageTime & "<BR>" )						
					If RS("CallID") <> vLastCallID Then
						vFirstPageTime = ""
					End If					

					'If vLastTypeID = 12 Or (vLastTypeID = 6 And DateDiff("n", vFirstPageTime, RS("DateTime"))> 0 ) Then
					'	vTotalRepages = vTotalRepages + 1
					'Else
					'   vTotalPages = vTotalPages + 1 
					'End If
					
					If vFirstPageTime = "" Then
						vFirstPageTime = CStr(RS("DateTime"))
						vTotalPages = vTotalPages + 1 
					Else
						'Check if it is really a repage or a new page
						'by looking at how much time has elapsed since 
						'original page
						'If more than 60 minutes, consider it a new page
						'If DateDiff("n", vFirstPageTime, RS("DateTime")) > 60 Then
						If vLastTypeID = 12 Or (vLastTypeID = 6 And DateDiff("n", vFirstPageTime, RS("DateTime"))> 0 ) Then
							
							vTotalRepages = vTotalRepages + 1
						Else
							vTotalPages = vTotalPages + 1 
							vFirstPageTime = CStr(RS("DateTime"))
						End If
					End If					

				Case 9	'Page Response
							
					If RS("TypeID") <> vLastTypeID Then
						vPageResponse = True
						vTotalPageTime = vTotalPageTime + DateDiff("n", vFirstPageTime, RS("DateTime"))
						If DateDiff("n", vFirstPageTime, RS("DateTime")) > vMaxPageTime Then
							vMaxPageTime = DateDiff("n", vFirstPageTime, RS("DateTime"))
							vMaxCallID = RS("CallID")
						End If
								
						If vMaxPageTime > vCountArray(Ubound(vCountArray, 1), 5) Then
							vCountArray(Ubound(vCountArray, 1), 5) = vMaxPageTime
						End If

						'vTotalPages = vTotalPages + 1
						'vFirstPageTime = ""
					End If

				Case 12	'No Page Response
							
					vTotalNoResponses = vTotalNoResponses + 1

			End Select

			vLastCallID = RS("CallID")
			vLastTypeID = RS("TypeID")
End Function


%>


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