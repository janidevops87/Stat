<%Option Explicit
dim WebDataSourceName
dim strOkToUpdate
dim bolNewRecord

WebDataSourceName = "WebProd"
strOkToUpdate = null
bolNewRecord = false
%>
<!--updateSurvey.sls - created 6/19 2000 by Thomas T. Worster. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		updateSurvey.sls						Created By:		Thomas T. Worster  Statline, LLC.
'Date(s):		6/19 2000
'Description:	This is an online survey created for Mimi in Client Services.  Results are tabulated
'				in a database.  This file validates and updates the data passed from the form
'
'Changes:		
'****************************************************************************************************
'Section I:  Variables and Includes
'****************************************************************************************************
'Pre-defined variables:
'Conn					'Variable used for Database Connection.  Used in \includes\Authorize.sls
'DataSourceName			'Variable defining Database to be used. Used and defined in \includes\Authorize.sls
'ReportID				'The ReportID of the desired Report. Passed from parameters\FrameCustomParams.sls
'RS						'Variable for RecordSets. Used in \includes\Authorize.sls
'UserID					'The current user's UserID. Used in \includes\Authorize.sls
'UserOrgID				'The Organization the current user belongs to. Used in \includes\Authorize.sls
'vQuery					'Variable that contains the Query sent to the Database. Used in \includes\Authorize.sls

'New variables:
Dim pvStartDate			'Required for \includes\Authorize.sls to work.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.
Dim vErrorMsg			'Required for \includes\Authorize.sls to work.

'Get values for the incoming variables (already aquired in Authorize.sls)
UserID = Request.QueryString("UserID")
UserOrgID = Request.QueryString("UserOrgID")

'Includes for this page:
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%
'****************************************************************************************************
'Section II:  HTML and Page Header
'****************************************************************************************************
%>
<html>

<head>
<title>update Survey</title>
<meta http-equiv="Expires" content="0">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
</head>

<body bgcolor="#F5EBDD" text="BLACK">
<%
'Verify Access
'If AuthorizeMain Then

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user name
	vQuery = "SELECT * FROM Survey"
	vQuery = vQuery & " WHERE UserId = " & UserId & ";"
	'Response.Write(vQuery)
	
	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3
	
	'old method below
	'Set rs = Conn.Execute(vQuery)
	
	If rs.EOF then
		rs.AddNew
		rs.Fields("1_Rating").Value = 0
		rs.Fields("1_Comments").Value = null
		rs.Fields("2_Rating").Value = 0
		rs.Fields("3_ReferralActivity").Value = 0
		rs.Fields("3_ReferralDetail").Value = 0
		rs.Fields("3_PendingReferrals").Value = 0
		rs.Fields("3_CoronerCaseActivity").Value = 0
		rs.Fields("3_ReferralSummary").Value = 0
		rs.Fields("3_ReferralSummaryCondensed").Value = 0
		rs.Fields("3_ReferralCompliance").Value = 0
		rs.Fields("3_CallCountSummary").Value = 0
		rs.Fields("3_CallHoldTimes").Value = 0
		rs.Fields("3_PageResponseTimes").Value = 0
		rs.Fields("3_AppropriateSummary").Value = 0
		rs.Fields("3_ApproachSummary").Value = 0
		rs.Fields("3_ConsentSummary").Value = 0
		rs.Fields("3_RecoveredDonor").Value = 0
		rs.Fields("3_AgeDemographics").Value = 0
		rs.Fields("3_RaceDemographics").Value = 0
		rs.Fields("3_ReasonSummary").Value = 0
		rs.Fields("3_HospitalReportTimes").Value = 0
		rs.Fields("3_UnitSummary").Value = 0
		rs.Fields("3_CallerPersonSummary").Value = 0
	
		rs.Fields("4_A_Rating").Value = 0
		rs.Fields("4_B_Need").Value = 0
		rs.Fields("4_B_Comments").Value = null
		rs.Fields("5_Helpfulness").Value = 0
		rs.Fields("5_Friendliness").Value = 0
		rs.Fields("5_Knowledge").Value = 0
	
		rs.Fields("5_Comments").Value = null
		rs.Fields("6_A_Rating").Value = 0
		rs.Fields("6_A_Comments").Value = null
		rs.Fields("6_B_Information").Value = 0
		rs.Fields("7_Rating").Value = 0
		rs.Fields("7_Comments").Value = null
		rs.Fields("8_Comments").Value = null
	
		bolNewRecord = true
	Else
		rs.MoveFirst
	End If
	
	'validate survey
		'allow for multiple surveys per client/person?
		'YES
			'after what duration?
			'initialize existing survey
	'ELSE
		'initialize new survey
	'On Error Resume Next
	'validate the survey information

	If Request.Form("1_Rating")="" then
		rs.Fields("1_Rating").Value = 0
	Else
		rs.Fields("1_Rating") = Request.Form("1_Rating")
	End If
	If Request.Form("1_Comments")="" then
		rs.Fields("1_Comments").Value = null
	Else
		rs.Fields("1_Comments").Value = Request.Form("1_Comments")
	End If
	
	If Request.Form("2_Rating")="" then
		rs.Fields("2_Rating").Value = 0
	Else
		rs.Fields("2_Rating").Value = Request.Form("2_Rating")
	End If
	
	If Request.Form("C1")="ON" then
		rs.Fields("3_ReferralActivity").Value = 1
	Else
		rs.Fields("3_ReferralActivity").Value = 0
	End If
	If Request.Form("C2")="ON" then
		rs.Fields("3_ReferralDetail").Value = 1
	Else
		rs.Fields("3_ReferralDetail").Value = 0
	End If
	If Request.Form("C3")="ON" then
		rs.Fields("3_PendingReferrals").Value = 1
	Else
		rs.Fields("3_PendingReferrals").Value = 0
	End If
	If Request.Form("C4")="ON" then
		rs.Fields("3_CoronerCaseActivity").Value = 1
	Else
		rs.Fields("3_CoronerCaseActivity").Value = 0
	End If
	If Request.Form("C5")="ON" then
		rs.Fields("3_ReferralSummary").Value = 1
	Else
		rs.Fields("3_ReferralSummary").Value = 0
	End If
	If Request.Form("C6")="ON" then
		rs.Fields("3_ReferralSummaryCondensed").Value = 1
	Else
		rs.Fields("3_ReferralSummaryCondensed").Value = 0
	End If
	If Request.Form("C7")="ON" then
		rs.Fields("3_ReferralCompliance").Value = 1
	Else
		rs.Fields("3_ReferralCompliance").Value = 0
	End If
	If Request.Form("C8")="ON" then
		rs.Fields("3_CallCountSummary").Value = 1
	Else
		rs.Fields("3_CallCountSummary").Value = 0
	End If
	If Request.Form("C9")="ON" then
		rs.Fields("3_CallHoldTimes").Value = 1
	Else
		rs.Fields("3_CallHoldTimes").Value = 0
	End If
	If Request.Form("C10")="ON" then
		rs.Fields("3_PageResponseTimes").Value = 1
	Else
		rs.Fields("3_PageResponseTimes").Value = 0
	End If
	If Request.Form("C11")="ON" then
		rs.Fields("3_AppropriateSummary").Value = 1
	Else
		rs.Fields("3_AppropriateSummary").Value = 0
	End If
	If Request.Form("C12")="ON" then
		rs.Fields("3_ApproachSummary").Value = 1
	Else
		rs.Fields("3_ApproachSummary").Value = 0
	End If
	If Request.Form("C13")="ON" then
		rs.Fields("3_ConsentSummary").Value = 1
	Else
		rs.Fields("3_ConsentSummary").Value = 0
	End If
	If Request.Form("C14")="ON" then
		rs.Fields("3_RecoveredDonor").Value = 1
	Else
		rs.Fields("3_RecoveredDonor").Value = 0
	End If
	If Request.Form("C15")="ON" then
		rs.Fields("3_AgeDemographics").Value = 1
	Else
		rs.Fields("3_AgeDemographics").Value = 0
	End If
	If Request.Form("C16")="ON" then
		rs.Fields("3_RaceDemographics").Value = 1
	Else
		rs.Fields("3_RaceDemographics").Value = 0
	End If
	If Request.Form("C17")="ON" then
		rs.Fields("3_ReasonSummary").Value = 1
	Else
		rs.Fields("3_ReasonSummary").Value = 0
	End If
	If Request.Form("C18")="ON" then
		rs.Fields("3_HospitalReportTimes").Value = 1
	Else
		rs.Fields("3_HospitalReportTimes").Value = 0
	End If
	If Request.Form("C19")="ON" then
		rs.Fields("3_UnitSummary").Value = 1
	Else
		rs.Fields("3_UnitSummary").Value = 0
	End If
	If Request.Form("C20")="ON" then
		rs.Fields("3_CallerPersonSummary").Value = 1
	Else
		rs.Fields("3_CallerPersonSummary").Value = 0
	End If
	
	If Request.Form("4_A_Rating")="" then
		rs.Fields("4_A_Rating").Value = 0
	Else
		rs.Fields("4_A_Rating").Value = Request.Form("4_A_Rating")
	End If
	
	If Request.Form("R1")="Yes" then
		rs.Fields("4_B_Need").Value = 1
	Else
		rs.Fields("4_B_Need").Value = 0
	End If

	If Request.Form("4_B_Comments")="" then
		rs.Fields("4_B_Comments").Value = null
	Else
		rs.Fields("4_B_Comments").Value = Request.Form("4_B_Comments")
	End If
	
	If Request.Form("5_Helpfulness")="" then
		rs.Fields("5_Helpfulness").Value = 0
	Else
		rs.Fields("5_Helpfulness").Value = Request.Form("5_Helpfulness")
	End If
	If Request.Form("5_Friendliness")="" then
		rs.Fields("5_Friendliness").Value = 0
	Else
		rs.Fields("5_Friendliness").Value = Request.Form("5_Friendliness")
	End If
	If Request.Form("5_Knowledge")="" then
		rs.Fields("5_Knowledge").Value = 0
	Else
		rs.Fields("5_Knowledge").Value = Request.Form("5_Knowledge")
	End If
	
	If Request.Form("5_Comments")="" then
		rs.Fields("5_Comments").Value = null
	Else
		rs.Fields("5_Comments").Value = Request.Form("5_Comments")
	End If
	
	If Request.Form("6_A_Rating")="" then
		rs.Fields("6_A_Rating").Value = 0
	Else
		rs.Fields("6_A_Rating").Value = Request.Form("6_A_Rating")
	End If
	
	If Request.Form("6_A_Comments")="" then
		rs.Fields("6_A_Comments").Value = null
	Else
		rs.Fields("6_A_Comments").Value = Request.Form("6_A_Comments")
	End If
	
	If Request.Form("R2")="Yes" then
		rs.Fields("6_B_Information").Value = 1
	Else
		rs.Fields("6_B_Information").Value = 0
	End If
	
	If Request.Form("7_Rating")="" then
		rs.Fields("7_Rating").Value = 0
	Else
		rs.Fields("7_Rating").Value = Request.Form("7_Rating")
	End If
	
	If Request.Form("7_Comments")="" then
		rs.Fields("7_Comments").Value = null
	Else
		rs.Fields("7_Comments").Value = Request.Form("7_Comments")
	End If
	
	If Request.Form("8_Comments")="" then
		rs.Fields("8_Comments").Value = null
	Else
		rs.Fields("8_Comments").Value = Request.Form("8_Comments")
	End If
	
	'On Error Resume Next
	rs.Fields("UserID").Value = UserId
	rs.Fields("UserOrgID").Value = UserOrgId
	rs.Fields("SubmitDate").Value = now()
	
	'post new survey information
	If bolNewRecord = true then
		'currently no difference
		rs.Update
	Else
		rs.Update
	End If
		
	'save (INSERT) the new survey
	
	Set RS = Nothing	
	Set Conn = Nothing

%>
	<p>Thank you for submitting your survey.</p>
<%
'End If
%>	
</body>
</html>
