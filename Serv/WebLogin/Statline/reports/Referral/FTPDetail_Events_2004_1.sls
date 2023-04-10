<% Option Explicit %>


<%
'Declare variables
Dim ErrorReturn
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim vOrgList
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim pvReferralTypeID
Dim pvCallID
Dim pvOrderBy
Dim pvOptions
Dim pvNoName
Dim vReportGroupName
Dim vReportTitle
Dim vShowGroup1
Dim Identify
Dim Org
Dim Children
Dim Referral
Dim vTZ
Dim i
Dim RHead(3)
Dim y
Dim x
Dim ResultArray
Dim TypeName
Dim RefDataArray
Dim Section2
Dim Section4
Dim vNoRecords
Dim CountCheck

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog
Dim ErrorCatch
Dim vRecord
'07/15/2004 BJK added functionality to name the file in the format 'RYYMMDDhhmm.TXT
' The change uses the following three variables
Dim FileName 'store the text of the file name
Dim FileNameDate ' stores the date the FileName is based on.
Dim FileNameTime ' stores the time the FileName is based on.

'Declare format vaiables
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeHeadLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"


'07/15/2004 BJK SET THE date and time variables.
FileNameDate = FormatDateTime(Now(), 2)
FileNameTime = FormatDateTime(Now(), 4)

' Set the file name based on the date and time variables
FileName = ""
FileName = FileName & "R"
FileName = FileName & DatePart("yyyy",FileNameDate)  ' Use date part to get year
FileName = FileName & Right("0" & DatePart("m", FileNameDate), 2)  'Use date part to get month, force leading zero
FileName = FileName & Right("0" & DatePart("d", FileNameDate), 2)  'Use date part to get date, force leading zero

FileName = FileName & LEFT(FileNameTime,2) 'DatePart("h",FileNameDate)  'use left of time to get hour
FileName = FileName & RIGHT(FileNameTime,2)'DatePart("n",FileNameDate)  ' use right of time to get minute
FileName = FileName & ".txt"

Response.AddHeader "Content-Disposition", "attachment; filename=" & FileName
Response.ContentType = "application/unknown"
Response.Buffer = True

%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/VerifyRefType.vbs"-->
<!--#include virtual="/loginstatline/includes/FTPQueryReferral_Events_2004.sls"-->
<%

'Execute the main page generating routine

'Print " Detail_1 " & DataSourceName
'Get the query variables
Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
pvReferralTypeID = FormatNumber(Request.QueryString("ReferralType"),0,,0,0)
pvCallID = FormatNumber(Request.QueryString("CallID"),0,,0,0)
pvOrderBy = Request.QueryString("OrderBy")
pvOptions = Request.QueryString("Options")



If AuthorizeMain Then



	'Create a connection object
	Set Conn = server.CreateObject("ADODB.Connection")
	Server.ScriptTimeout = 270
	Conn.CommandTimeout = 90
	Conn.Open DataSourceName, DBUSER, DBPWD


	'Call the referral type verification routine
	If VerifyReferralTypeAccess(True) Then



		If ExecuteMain Then
		%>

			<%TypeName = ""
			If vNoRecords Then
				'print an empty string

				Response.Clear

			Else


				'CLEAR ANY CONTENT
				Response.Clear

				'LastModified
				'ReferralEventID
				'ReferralID
				'ReferralNumber
				'ReferralEventTypeID
				'ReferralEventType
				'ReferralEventDateTime
				'ReferralEventNameID
				'ReferralEventName
				'ReferralEventPhone
				'ReferralEventOrganizationID
				'ReferralEventOrganization
				'ReferralEventDescription
				'ReferralEventCreatedBy
				'ReferralEventAttnTo
				'ReferralEventCalloutMin
				'ReferralEventCalloutAfter
				'ReferralEventContactConfirm
				'ReferralEventDocName				
				

				For i = 0 to Ubound(ResultArray, 2)

					'vRecord = ""
					'for x = 0 to Ubound(ResultArray,1)
					'vRecord = vRecord & resultarray(x, i)& chr(9) '118 LastModified
					'Next
					'Response.Write(vRecord)

					vRecord = ""
					vRecord = right("0" & Datepart("m",resultarray(0, i)),2)  & "/" & right("0" & Datepart("d",resultarray(0, i)),2) & "/" & Datepart("yyyy",resultarray(0, i)) & " " & right("0" & Datepart("h",resultarray(0, i)),2)& ":" & right("0" & Datepart("n",resultarray(0, i)),2)& ":" & right("0" & Datepart("s",resultarray(0, i)),2)& chr(9) '0 LastModified
					vRecord = vRecord & resultarray(1, i)& chr(9) '1 ReferralEventID
					vRecord = vRecord & resultarray(2, i)& chr(9) '2 ReferralID
					vRecord = vRecord & resultarray(3, i)& chr(9) '3 ReferralNumber
					vRecord = vRecord & resultarray(4, i)& chr(9) '4 ReferralEventTypeID
					vRecord = vRecord & resultarray(5, i)& chr(9) '5 ReferralEventType
					vRecord = vRecord & right("0" & Datepart("m",resultarray(6, i)),2)  & "/" & right("0" & Datepart("d",resultarray(6, i)),2) & "/" & Datepart("yyyy",resultarray(6, i)) & " " & right("0" & Datepart("h",resultarray(6, i)),2)& ":" & right("0" & Datepart("n",resultarray(6, i)),2)& ":" & right("0" & Datepart("s",resultarray(6, i)),2)& chr(9) '6 ReferralEventDateTime
					vRecord = vRecord & resultarray(7, i)& chr(9) '7 ReferralEventNameID
					vRecord = vRecord & resultarray(8, i)& chr(9) '8 ReferralEventName
					vRecord = vRecord & resultarray(9, i)& chr(9) '9 ReferralEventPhone
					vRecord = vRecord & resultarray(10, i)& chr(9) '10 ReferralEventOrganizationID
					vRecord = vRecord & resultarray(11, i)& chr(9) '11 ReferralEventOrganization
					vRecord = vRecord & resultarray(12, i)& chr(9) '13 ReferralEventDescription
					vRecord = vRecord & resultarray(13, i)& chr(9) '13 ReferralEventCreatedBy
					vRecord = vRecord & resultarray(14, i)& chr(9) '14 ReferralEventAttnTo
					vRecord = vRecord & resultarray(15, i)& chr(9) '15 ReferralEventCalloutMin
					vRecord = vRecord & resultarray(16, i)& chr(9) '16 ReferralEventCalloutAfter
					vRecord = vRecord & resultarray(17, i)& chr(9) '17 ReferralEventContactConfirm
					
					  ' Format ReferralEventFaxNbr as a phone number
                    If Len(resultarray(18, i)) > 0 Then
                        'Trim off initial "1", if present
                        If Left(resultarray(18, i), 1) = "1" Then
                           resultarray(18, i) = Right(resultarray(18, i), Len(resultarray(18, i)) - 1)
                        End If
                        vRecord = vRecord & "(" & Mid(resultarray(18, i), 1, 3) & ")" & Mid(resultarray(18, i), 4, 3) & "-" & Mid(resultarray(18, i), 7, 4) & chr(9) '18 ReferralEventFaxNbr
                    Else
                        vRecord = vRecord & resultarray(18, i) & chr(9) '18 ReferralEventFaxNbr
                    End If
					'vRecord = vRecord & resultarray(18, i)& chr(9) '18 ReferralEventFaxNbr
					
					vRecord = vRecord & resultarray(19, i)& chr(13) & Chr(10)'19 ReferralEventDocName
										
					
					Response.Write(vRecord)


					'FOR forLoop = 0 to UBound(ResultArray,1)
						'Response.Write(forLoop & " " & ResultArray(forLoop,i) & "<br>")
					'Next

					%>



				<%Next
			End If

			Set Referral = Nothing

		End If



	End If

End If

Set Conn = Nothing

%>


<%
Function ExecuteMain()

	'Parse the option settings
	If pvOptions = "" Then
		pvOptions = 0
	End If

	pvNoName = Mid(pvOptions, 1, 1)


	'Set Order By
	If pvOrderBy = "" Or pvOrderBy = "0" Then
		pvOrderBy = "LogEvent.LogEventDateTime"
		vShowGroup1 = True
	End If

	If Right(pvOrderBy,1) = "," Then
		pvOrderBy = Mid(pvOrderBy, 1, Len(pvOrderBy) - 1)
	End If

	'Verify the requesting organization if it not Statline
	If pvUserOrgID <> 194 then

		vQuery = "sps_OrganizationName " & pvUserOrgID
		Set RS = Conn.Execute(vQuery)

		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetOrganization, Detail.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function
		End If

		Set RS = Nothing

	End If


	If pvCallID = 0 Then

		'This is a multiple referral request
		If pvReportGroupID <> 0 AND pvOrgID = 0 Then

			'If a report group has been selected, get the report group name
			'and set the report title to the name of the report group
			vQuery = "sps_ReportGroupName " & pvReportGroupID & " "
			Set RS = Conn.Execute(vQuery)

			If RS.EOF = True Then
				vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
				vErrorMsg = vErrorMsg & "The selected report group is no longer valid. Please select another group.<BR> <BR>"
				vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
				vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
				vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
				vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, Activity.sls) <BR> <BR>"
				vErrorMsg = vErrorMsg & "</FONT></FONT>"
				Response.Write(vErrorMsg)
				Response.Write(vErrorMsg)
				ExecuteMain = False
				Exit Function
			Else
				vReportTitle = RS("WebReportGroupName")
			End If

			Set RS = Nothing

		ElseIf pvOrgID <> 0  Then

			'Else if a single organization has been selected, get the organization data
			'and set the report title to the name of the selected organization

			'Get the organization information
			vQuery = "sps_OrganizationName " & pvOrgID

			Set RS = Conn.Execute(vQuery)

			If RS.EOF = True Then
				vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
				vErrorMsg = vErrorMsg & "The organization selected for this report does not exist. <BR> <BR>"
				vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
				vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
				vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
				vErrorMsg = vErrorMsg & "Error:     (100, GetOrganizationName, Detail.sls) <BR> <BR>"
				vErrorMsg = vErrorMsg & "</FONT></FONT>"
				Response.Write(vErrorMsg)
				ExecuteMain = False
				Exit Function
			Else
				vReportTitle = RS("OrganizationName")
			End If

			Set RS = Nothing

		ElseIf pvOrgID = 0 AND pvReportGroupID = 0 Then

			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (-1, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function

		Else

			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "Unexpected Error. <BR> "
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function

		End If

	End If

	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing

	SET ErrorCatch =  server.CreateObject("ADODB.Error")
	'Response.Write formatDateTime(Now(),vblongtime)
	vQuery = GetDetailList()
	'Response.Write vQuery
	If isnull(GetDetailList) Then
		Set RS = Nothing
		ExecuteMain = True
		vNoRecords = True
		Exit Function

	End if

	Response.Write vQuery

	Set RS = Conn.Execute(vQuery)
	'Response.Write formatDateTime(Now(),vblongtime)
	vNoRecords = False


	If ErrorCatch.Number <> 0 Then
		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Referral.GetCallList, Activity.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function
	Else
		If RS.EOF Then
			vNoRecords = True
		Else
			ResultArray = RS.GetRows
		End if
	End If

	Set RS = Nothing

	ExecuteMain = True

End Function



Sub FixQueryString(pvIn, pvOut)

	Dim j

	pvOut = ""

	For j=1 TO Len(pvIn)

		If Mid(pvIn,j,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,j,1)
		End If

	Next

End Sub

'This sub is used by DetailSection3 to format note fields
Sub OutputMemo(memo)

	IF IsNull(memo) or memo = "" Then

		Exit Sub

	End If
	Dim mx

	For mx=1 to Len(memo)

		If Asc(Mid(memo, mx, 1)) = 13 Then
			Response.Write("<BR>")
		Else
			Response.Write(Mid(memo,mx,1))
		End If
	Next
End Sub%>
