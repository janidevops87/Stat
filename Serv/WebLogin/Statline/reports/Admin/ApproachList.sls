<%@ LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->


<%
On Error Resume Next

Dim pvStartDate
Dim pvEndDate
Dim vReportGroupID
Dim vReferralTypeID

Dim	vPath
Dim	vRecord
Dim vFileNum
Dim vFileName

Dim vText

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
vReportGroupID = Request.QueryString("ReportGroupID")
vReferralTypeID = Request.QueryString("ReferralType")

DataSourceName = DetermineReportingDSN(Request.QueryString("DSN"),Empty,Empty)
If IsEmpty(DataSourceName) Then
	Call Err.Raise(11,"GetOrgList.sls", "Cannot determine a proper DSN. Contact Statline for help.")
End If

If vReferralTypeID <> 4 Then

	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the report group name
	vQuery = "sps_ReportGroupName " & vReportGroupID & " "

	Set RS = Conn.Execute(vQuery)


	vReportGroupName = RS("WebReportGroupName")
	Set RS = Nothing

	vQuery = "sps_ApproachList '" & pvStartDate & "', '" & pvEndDate & "', " & vReportGroupID & ", " & 1 ' vReferralTypeID & " " 
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)

	If RS.EOF = True Then%>

		<HTML>
		<HEAD>
		<META NAME="GENERATOR" Content="Microsoft Visual InterDev 1.0">
		<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="EXPIRES" content="0">
		</HEAD>
		<BODY BGCOLOR = "#F5EBDD">


		<FONT SIZE=4 FACE=Arial FONT COLOR = Red>
		There are no records for the parameters selected.<BR>
		</FONT>

		</BODY>
		</HTML>

	<%Else

		Response.AddHeader "Content-Disposition", "attachment; filename=" & "ApproachList.log"
		Response.ContentType = "application/unknown" 

		'Write the column headers
		vRecord = ""
		For i = 0 to RS.Fields.Count - 1
			If i = RS.Fields.Count - 1 Then
				vRecord = vRecord & RS.Fields(i).Name & Chr(13) & Chr(10)
			Else
				vRecord = vRecord & RS.Fields(i).Name & Chr(9)
			End If
		Next

		Response.Write(vRecord)
		vRecord = ""

		Do Until RS.EOF

			vRecord =	RS("FCONSDATE") & Chr(9)
			vRecord = vRecord & RS("FCONSFNAME") & Chr(9)
			vRecord = vRecord & RS("FCONSLNAME") & Chr(9)
			vRecord = vRecord & RS("FCONSTITLE") & Chr(9)
			vRecord = vRecord & RS("FCONSOURCE") & Chr(9)
			vRecord = vRecord & RS("FAPHYSUNIT") & Chr(9)
			vRecord = vRecord & RS("FCONSADDR") & Chr(9)
			vRecord = vRecord & RS("FCONSCITY") & Chr(9)
			vRecord = vRecord & RS("FCONSSTATE") & Chr(9)
			vRecord = vRecord & RS("FCONSZIP") & Chr(9)
			vRecord = vRecord & RS("FDNAME") & Chr(13) & Chr(10)

			Response.Write(vRecord)

			vRecord = ""

			RS.MoveNext

		Loop

	End If

Set RS = Nothing
Set Conn = Nothing

Else%>

	<HTML>
	<HEAD>
	<META NAME="GENERATOR" Content="Microsoft Visual InterDev 1.0">
	<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
	<meta http-equiv="EXPIRES" content="0">
	</HEAD>
	<BODY BGCOLOR = "#F5EBDD">


	<FONT SIZE=4 FACE=Arial FONT COLOR = Red>
	This report requires a referral type other than "Ruleout". <BR>
	Please select a different referral type. <BR>
	</FONT>

	</BODY>
	</HTML>

<%End If


Private Sub FixQueryString(pvIn, pvOut)
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
