<% Option Explicit %>
<HTML>
<HEAD>
<TITLE>Call Volume By Month</TITLE>
</HEAD>
<BODY BGCOLOR="#F5EBDD">
<%	
Dim FontNameHead 
Dim FontSizeHead 
Dim FontNameData 
Dim FontSizeData 
Dim FontNameHeadLog 
Dim FontSizeDataLog 
Dim FontNameDataLog 
Dim x, ConnDash
	
Dim pvStartDate
Dim pvEndDate
Dim vCountArray
Dim vMonths
Dim vRows
Dim i, j

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeDataLog = "1.5"
FontNameDataLog = "Times New Roman"

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%If AuthorizeMain Then%>

<!-- Begin Header -->
<TABLE Width="100%">
<TD VALIGN=TOP>
	<TABLE WIDTH = "100%">
	<TR>
		<TD WIDTH="10%"><IMG SRC="/loginstatline/images/logo1.gif" WIDTH=60 HEIGHT=60></TD>
		<TD WIDTH="50%" ALIGN=LEFT>
			<TABLE> 
				<TR><TD ALIGN=LEFT><FONT SIZE="5" FACE="Arial Black"><B>Call Volumes By Month</TD></TR>
			</TABLE>
		</TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>Period:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvStartDate%></TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>To:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvEndDate%></TD>
	</TABLE>
</TD></TABLE>
<!-- End Header -->



<!-- Get Referral Source Codes -->
<%
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD

'Get # of rows
vQuery = "SELECT Count(SourceCodeID) AS CodeCount FROM SourceCode WHERE SourceCodeType = 1 "

Set RS = Conn.Execute(vQuery)

vRows = RS("CodeCount")
Set RS = Nothing

'Get the source code names
vQuery = "SELECT SourceCodeName FROM SourceCode WHERE SourceCodeType = 1 ORDER BY SourceCodeName"

Set RS = Conn.Execute(vQuery)
%>


<!-- Calculate Array Size and Initialize -->
<%	
'Figure # of columns
vMonths = DateDiff("m", pvStartDate, pvEndDate)

'Set the array
ReDim CountArray(vRows + 1, vMonths + 1)

'Initialize months
CountArray(0,0) = "Code/Month"

For j = 1 to vMonths 
	CountArray(0,j) = Year(DateAdd("m", j - 1, pvStartDate)) & "-" & Month(DateAdd("m", j - 1, pvStartDate))
Next

CountArray(0,vMonths + 1) = "Total"


'Get source codes
For i = 1 To vRows 
	CountArray(i,0) = RS("SourceCodeName")
	RS.MoveNext
Next

CountArray(vRows + 1,0) = "Total"

Set RS = Nothing

'Initialize other array values
For i = 1 to vMonths + 1
	For j = 1 to vRows + 1
		CountArray(j, i) = 0
	Next
Next


'Get data
vQuery = "sps_CallVolumeSC '" & pvStartDate & "', '" & pvEndDate & "', " & 1 & ", " & 1

debug(vQuery)
Set RS = Conn.Execute(vQuery)


'Fill Array
'Find matching date
Do Until RS.EOF

	For j = 1 to vMonths

		If RS("Date") = CountArray(0,j) Then

			'Find matching source code
			For i = 1 to vRows

				If RS("SourceCodeName") = CountArray(i,0) Then
					CountArray(i,j) = RS("CallCount")
					Exit For
				End If

			Next

			Exit For 

		End If
		
	Next

	RS.MoveNext

Loop

Set RS = Nothing


'Calculate Column Totals
For j = 1 to vMonths
	For i = 1 to vRows
		CountArray(vRows + 1,j) = CountArray(vRows + 1,j) + CountArray(i,j)
	Next
Next

'Calculate Row Totals
For i = 1 to vRows
	For j = 1 to vMonths
		CountArray(i,vMonths + 1) = CountArray(i,vMonths + 1) + CountArray(i,j)
	Next
Next

'Calculate Grand Total
For j = 1 to vMonths
	CountArray(vRows+1, vMonths+1) = CountArray(vRows+1, vMonths+1) + CountArray(vRows+1, j)
Next

%>



<P STYLE="line-height: 1pt">&nbsp</P>

<!-- Referral Volume Header -->
<TABLE WIDTH="100%" BORDER=0>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Referral Call Volumes </B></FONT> </TD></TR>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> (by source code) </FONT> </TD></TR>
</TABLE>


	<!-- Format Referral Volume Table -->
	<TABLE BORDER=1>
		
		<%For i = 0 to vRows + 1%>
			<TR> 
				<%For j = 0 To vMonths + 1%>
					<TD VALIGN=LEFT><FONT FACE="Arial" SIZE=2><%=CountArray(i,j)%></FONT> </TD>
				<%Next%>
			</TR>
		<%Next%>

	</TABLE>





<!-- Get Message Source Codes -->
<%
'Get # of rows
vQuery = "sps_SourceCodeCountMI"

Set RS = Conn.Execute(vQuery)

vRows = RS("CodeCount")

Set RS = Nothing

'Get the source code names
vQuery = "SELECT DISTINCT SourceCodeName FROM SourceCode WHERE SourceCodeType = 2 OR SourceCodeType = 4 ORDER BY SourceCodeName"

Set RS = Conn.Execute(vQuery)

%>


<!-- Calculate Array Size and Initialize -->
<%	
'Set the array
ReDim CountArray(vRows + 1, vMonths + 1)

'Initialize days
CountArray(0,0) = "Code/Month"

For j = 1 to vMonths 
	CountArray(0,j) = Year(DateAdd("m", j - 1, pvStartDate)) & "-" & Month(DateAdd("m", j - 1, pvStartDate))
Next

CountArray(0,vMonths + 1) = "Total"


'Get source codes
For i = 1 To vRows 
	CountArray(i,0) = RS("SourceCodeName")
	RS.MoveNext
Next

CountArray(vRows + 1,0) = "Total"

Set RS = Nothing

'Initialize other array values
For i = 1 to vMonths + 1
	For j = 1 to vRows + 1
		CountArray(j, i) = 0
	Next
Next

'Get data
vQuery = "sps_CallVolumeSC '" & pvStartDate & "', '" & pvEndDate & "', " & 2 & ", " & 1
debug(vQuery)
Set RS = Conn.Execute(vQuery)

'Fill Array
'Find matching date
Do Until RS.EOF

	For j = 1 to vMonths

		If RS("Date") = CountArray(0,j) Then

			'Find matching source code
			For i = 1 to vRows

				If RS("SourceCodeName") = CountArray(i,0) Then
					CountArray(i,j) = RS("CallCount")
					Exit For
				End If

			Next

			Exit For 

		End If
		
	Next

	RS.MoveNext

Loop

Set RS = Nothing


'Calculate Column Totals
For j = 1 to vMonths
	For i = 1 to vRows
		CountArray(vRows + 1,j) = CountArray(vRows + 1,j) + CountArray(i,j)
	Next
Next

'Calculate Row Totals
For i = 1 to vRows
	For j = 1 to vMonths
		CountArray(i,vMonths + 1) = CountArray(i,vMonths + 1) + CountArray(i,j)
	Next
Next

'Calculate Grand Total
For j = 1 to vMonths
	CountArray(vRows+1, vMonths+1) = CountArray(vRows+1, vMonths+1) + CountArray(vRows+1, j)
Next

Set Conn = Nothing
%>

<P STYLE="line-height: 1pt">&nbsp</P>

<!-- Message Volume Header -->
<TABLE WIDTH="100%" BORDER=0>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Message Call Volumes </B></FONT> </TD></TR>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> (by source code) </FONT> </TD></TR>
</TABLE>


	<!-- Message Referral Volume Table -->
	<TABLE BORDER=1>
		
		<%For i = 0 to vRows + 1%>
			<TR> 
				<%For j = 0 To vMonths + 1%>
					<TD VALIGN=LEFT><FONT FACE="Arial" SIZE=2><%=CountArray(i,j)%></FONT> </TD>
				<%Next%>
			</TR>
		<%Next%>

	</TABLE>



</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

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
Sub debug(printString)
	'Print(printString)
End Sub
%>