<%Option Explicit
dim WebDataSourceName
dim bolSurveyOK
dim bolNewSurvey

WebDataSourceName = "WebProd"
bolSurveyOK = true		'used to determine if SURVEY is valid for person
bolNewSurvey = true		'used to determine if SURVEY is a new survey
%>
<!--Survey.sls - created 6/9 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		Survey.sls								Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		6/9 2000
'Description:	This is an online survey created for Mimi in Client Services.  Results are tabulated
'				in a database.
'
'Changes:		6/22 2000 by TTW.  Code Formatting changes.
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
'ReportID = Request.QueryString("ReportID")
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
<meta http-equiv="Expires" content="0">
<title>Customer Survey</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK"
<%'onload="document.AlertRepForm.AlertChoice.focus()"%>>

<%
	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open WebDataSourceName, DBUSER, DBPWD

	'Get the user name
	vQuery = "SELECT * FROM Survey"
	vQuery = vQuery & " WHERE UserId = " & UserId & ";"
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		rs.AddNew
		bolNewSurvey = true
	Else
		'check for existing survey for person.
		rs.MoveFirst
		bolNewSurvey = false
		If rs.Fields("SubmitDate")<dateadd("h",-1,now()) then
			'do not allow edit if survey older than 1 hour
			bolSurveyOK=false
		End If
	End If

	If bolSurveyOK then
%>

<table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
width="550" bgColor="#112084">
  <tr>
    <td width="50%"><font color="#ffffff" face="Arial" size="4"><b>&nbsp;Customer Satisfaction Survey</b></font></td>
<%	If bolNewSurvey then%>
		<td width="50%"><font color="#ffffff" face="Arial" size="2">&nbsp;(We appreciate your time)</font></td>
<%	Else%>
		<td width="50%"><font color="#ffffff" face="Arial" size="2">&nbsp;(Submitted: <%=rs.Fields("SubmitDate")%>)</font></td>
<%	End If%>
  </tr>
</table>

<p><br>
<br>
</p>

<form method="POST" action="updateSurvey.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>">
  <p>1)&nbsp;&nbsp;&nbsp;&nbsp; How do you rate the overall service that you receive from
  us?</p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select
  name="1_Rating" size="1">
    <%If rs.Fields("1_Rating")=0 then%>
		<option value="0" selected>&nbsp;</option>
	<%Else%>
		<option value="0">&nbsp;</option>
	<%End If%>
    <%If rs.Fields("1_Rating")=1 then%>
		<option value="1" selected>1</option>
	<%Else%>
		<option value="1">1</option>
	<%End If%>
	<%If rs.Fields("1_Rating")=2 then%>
		<option value="2" selected>2</option>
	<%Else%>
		<option value="2">2</option>
	<%End If%>
    <%If rs.Fields("1_Rating")=3 then%>
		<option value="3" selected>3</option>
	<%Else%>
		<option value="3">3</option>
	<%End If%>
    <%If rs.Fields("1_Rating")=4 then%>
		<option value="4" selected>4</option>
	<%Else%>
		<option value="4">4</option>
	<%End If%>
    <%If rs.Fields("1_Rating")=5 then%>
		<option value="5" selected>5</option>
	<%Else%>
		<option value="5">5</option>
	<%End If%>
  </select>&nbsp;&nbsp;&nbsp; (Poor)&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5 &nbsp;
  (Excellent)</p>
  <p>&nbsp;&nbsp;&nbsp; Comments:</p>
  <p><textarea rows="4" name="1_Comments" cols="77"><%=rs.Fields("1_Comments")%></textarea></p>
  <p>2)&nbsp;&nbsp;&nbsp;&nbsp; How often do you access the Internet site?</p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select name=2_Rating size="1">
	<%If rs.Fields("2_Rating")=0 then%>
		<option value="0" selected>&nbsp;</option>
	<%Else%>
		<option value="0">&nbsp;</option>
	<%End If%>
	<%If rs.Fields("2_Rating")=1 then%>
		<option value="1" selected>Hourly</option>
	<%Else%>
		<option value="1">Hourly</option>
	<%End If%>
	<%If rs.Fields("2_Rating")=2 then%>
		<option value="2" selected>Daily</option>
	<%Else%>
		<option value="2">Daily</option>
	<%End If%>
    <%If rs.Fields("2_Rating")=3 then%>
		<option value="3" selected>Weekly</option>
	<%Else%>
		<option value="3">Weekly</option>
	<%End If%>
    <%If rs.Fields("2_Rating")=4 then%>
		<option value="4" selected>Once A Month</option>
	<%Else%>
		<option value="4">Once A Month</option>
	<%End If%>
    <%If rs.Fields("2_Rating")=5 then%>
		<option value="5" selected>Several Times A Month</option>
	<%Else%>
		<option value="5">Several Times A Month</option>
	<%End If%>
	<%If rs.Fields("2_Rating")=6 then%>
		<option value="6" selected>Yearly</option>
	<%Else%>
		<option value="6">Yearly</option>
	<%End If%>
	<%If rs.Fields("2_Rating")=7 then%>
		<option value="7" selected>Never</option>
	<%Else%>
		<option value="7">Never</option>
	<%End If%>
  </select></p>
  <p>3)&nbsp;&nbsp;&nbsp;&nbsp; Which reports do you use most often?&nbsp; (Availability of
  reports varies for service level)</p>
  <table border="1" width="100%">
    <tr>
      <td width="33%">
		<%If rs.Fields("3_ReferralActivity")=true then%>
			<input type="checkbox" name="C1" Checked value="ON">Referral Activity</td>
		<%Else%>
			<input type="checkbox" name="C1" value="ON">Referral Activity</td>
		<%End If%>
      <td width="33%">
		<%If rs.Fields("3_CallCountSummary")=true then%>
			<input type="checkbox" name="C8" checked value="ON">Call Count Summary</td>
		<%Else%>
			<input type="checkbox" name="C8" value="ON">Call Count Summary</td>
		<%End If%>
      <td width="34%">
		<%If rs.Fields("3_RecoveredDonor")=true then%>
			<input type="checkbox" name="C14" checked value="ON">Recovered Donor Summary</td>
		<%Else%>
			<input type="checkbox" name="C14" value="ON">Recovered Donor Summary</td>
		<%End If%>
    </tr>
    <tr>
      <td width="33%">
		<%If rs.Fields("3_ReferralDetail")=true then%>
			<input type="checkbox" name="C2" checked value="ON">Referral Detail</td>
		<%Else%>
			<input type="checkbox" name="C2" value="ON">Referral Detail</td>
		<%End If%>
	  <td width="33%">
		<%If rs.Fields("3_CallHoldTimes")=true then%>
			<input type="checkbox" name="C9" checked value="ON">Call Hold Times</td>
		<%Else%>
			<input type="checkbox" name="C9" value="ON">Call Hold Times</td>
		<%End If%>
	  <td width="34%">
        <%If rs.Fields("3_AgeDemographics")=true then%>
			<input type="checkbox" name="C15" checked value="ON">Age Demographics</td>
		<%Else%>
			<input type="checkbox" name="C15" value="ON">Age Demographics</td>
		<%End If%>
    </tr>
    <tr>
      <td width="33%">
		<%If rs.Fields("3_PendingReferrals")=true then%>
			<input type="checkbox" name="C3" value="ON">Pending Referrals</td>
		<%Else%>
			<input type="checkbox" name="C3" value="ON">Pending Referrals</td>
		<%End If%>
      <td width="33%">
        <%If rs.Fields("3_PageResponseTimes")=true then%>
			<input type="checkbox" name="C10" checked value="ON">Page Response Times</td>
		<%Else%>
			<input type="checkbox" name="C10" value="ON">Page Response Times</td>
		<%End If%>
      <td width="34%">
		<%If rs.Fields("3_RaceDemographics")=true then%>
			<input type="checkbox" name="C16" checked value="ON">Race Demographics</td>
		<%Else%>
			<input type="checkbox" name="C16" value="ON">Race Demographics</td>
		<%End If%>
    </tr>
    <tr>
      <td width="33%">
		<%If rs.Fields("3_CoronerCaseActivity")=true then%>
			<input type="checkbox" name="C4" checked value="ON">Coroner Case Activity</td>
		<%Else%>
			<input type="checkbox" name="C4" value="ON">Coroner Case Activity</td>
		<%End If%>
      <td width="33%">
		<%If rs.Fields("3_AppropriateSummary")=true then%>
			<input type="checkbox" name="C11" checked value="ON">Appropriate Summary</td>
		<%Else%>
			<input type="checkbox" name="C11" value="ON">Appropriate Summary</td>
		<%End If%>
      <td width="34%">
		<%If rs.Fields("3_ReasonSummary")=true then%>
			<input type="checkbox" name="C17" checked value="ON">Reason Summary</td>
		<%Else%>
			<input type="checkbox" name="C17" value="ON">Reason Summary</td>
		<%End If%>
    </tr>
    <tr>
      <td width="33%">
		<%If rs.Fields("3_ReferralSummary")=true then%>
			<input type="checkbox" name="C5" checked value="ON">Referral Summary</td>
		<%Else%>
			<input type="checkbox" name="C5" value="ON">Referral Summary</td>
		<%End If%>
      <td width="33%">
		<%If rs.Fields("3_ApproachSummary")=true then%>
			<input type="checkbox" name="C12" checked value="ON">Approach Summary</td>
		<%Else%>
			<input type="checkbox" name="C12" value="ON">Approach Summary</td>
		<%End If%>
      <td width="34%">
		<%If rs.Fields("3_UnitSummary")=true then%>
			<input type="checkbox" name="C19" checked value="ON">Unit Summary</td>
		<%Else%>
			<input type="checkbox" name="C19" value="ON">Unit Summary</td>
		<%End If%>
    </tr>
    <tr>
      <td width="33%">
		<%If rs.Fields("3_ReferralSummaryCondensed")=true then%>
			<input type="checkbox" name="C6" checked value="ON">Referral Summary Condensed</td>
		<%Else%>
			<input type="checkbox" name="C6" value="ON">Referral Summary Condensed</td>
		<%End If%>
      <td width="33%">
		<%If rs.Fields("3_ConsentSummary")=true then%>
			<input type="checkbox" name="C13" checked value="ON">Consent Summary</td>
		<%Else%>
			<input type="checkbox" name="C13" value="ON">Consent Summary</td>
		<%End If%>
      <td width="34%">
		<%If rs.Fields("3_CallerPersonSummary")=true then%>
			<input type="checkbox" name="C20" checked value="ON">Caller Person Summary</td>
		<%Else%>
			<input type="checkbox" name="C20" value="ON">Caller Person Summary</td>
		<%End If%>
    </tr>
    <tr>
      <td width="33%">
		<%If rs.Fields("3_ReferralCompliance")=true then%>
			<input type="checkbox" name="C7" checked value="ON">Referral Compliance</td>
		<%Else%>
			<input type="checkbox" name="C7" value="ON">Referral Compliance</td>
		<%End If%>
      <td width="33%">
		<%If rs.Fields("3_HospitalReportTimes")=true then%>
			<input type="checkbox" name="C18" checked value="ON">Hospital Report Times</td>
		<%Else%>
			<input type="checkbox" name="C18" value="ON">Hospital Report Times</td>
		<%End If%>
      <td width="34%">&nbsp;</td>
    </tr>
  </table>
  <p>4) A.&nbsp;&nbsp;&nbsp; How do you rate the reports received from Statline?</p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select name="4_A_Rating" size="1">
    <%If rs.Fields("4_A_Rating")=0 then%>
		<option value="0" selected>&nbsp;</option>
	<%Else%>
		<option value="0">&nbsp;</option>
	<%End If%>
	<%If rs.Fields("4_A_Rating")=1 then%>
		<option value="1" selected>1</option>
	<%Else%>
		<option value="1">1</option>
	<%End If%>
	<%If rs.Fields("4_A_Rating")=2 then%>
		<option value="2" selected>2</option>
	<%Else%>
		<option value="2">2</option>
	<%End If%>
    <%If rs.Fields("4_A_Rating")=3 then%>
		<option value="3" selected>3</option>
	<%Else%>
		<option value="3">3</option>
	<%End If%>
    <%If rs.Fields("4_A_Rating")=4 then%>
		<option value="4" selected>4</option>
	<%Else%>
		<option value="4">4</option>
	<%End If%>
    <%If rs.Fields("4_A_Rating")=5 then%>
		<option value="5" selected>5</option>
	<%Else%>
		<option value="5">5</option>
	<%End If%>
  </select>&nbsp;&nbsp;&nbsp; (Poor)&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5 &nbsp;
  (Excellent)</p>
  <p>&nbsp;&nbsp; B.&nbsp;&nbsp;&nbsp; Are you obtaining the information you need from the
  reports?&nbsp;&nbsp;&nbsp;&nbsp; <%If bolNewSurvey=true then%>
		<input type="radio" value=Yes name="R1">Yes <input type="radio" name="R1" value=No>No</p>
<%  Else
		If rs.Fields("4_B_Need")=true then%>
			<input type="radio" Checked value=Yes name="R1">Yes <input type="radio" name="R1" value=No>No</p>
<%		Else%>
			<input type="radio" value=Yes name="R1">Yes <input type="radio" name="R1" Checked value=No>No</p>
<%		End If
	End If%>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If not, please
  explain what is missing?</p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <textarea rows="4"
  name="4_B_Comments" cols="77"><%=rs.Fields("4_B_Comments")%></textarea></p>
  <p>5)&nbsp;&nbsp;&nbsp; If you have had the opportunity to interact with one of the triage
  coordinators at Statline, how would you rate the following:</p>
  <table border="1" width="100%">
    <tr>
      <td width="250"><strong>Helpfulness -</strong></td>
      <td width="50%"><select name="5_Helpfulness" size="1">
		<%If rs.Fields("5_Helpfulness")=0 then%>
			<option value="0" selected>&nbsp;</option>
		<%Else%>
			<option value="0">&nbsp;</option>
		<%End If%>
		<%If rs.Fields("5_Helpfulness")=1 then%>
			<option value="1" selected>1</option>
		<%Else%>
			<option value="1">1</option>
		<%End If%>
		<%If rs.Fields("5_Helpfulness")=2 then%>
			<option value="2" selected>2</option>
		<%Else%>
			<option value="2">2</option>
		<%End If%>
		<%If rs.Fields("5_Helpfulness")=3 then%>
			<option value="3" selected>3</option>
		<%Else%>
			<option value="3">3</option>
		<%End If%>
		<%If rs.Fields("5_Helpfulness")=4 then%>
			<option value="4" selected>4</option>
		<%Else%>
			<option value="4">4</option>
		<%End If%>
		<%If rs.Fields("5_Helpfulness")=5 then%>
			<option value="5" selected>5</option>
		<%Else%>
			<option value="5">5</option>
		<%End If%>
      </select>&nbsp;&nbsp;&nbsp; (Poor)&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5 &nbsp;
      (Excellent)</td>
    </tr>
    <tr>
      <td width="250"><strong>Friendliness - </strong></td>
      <td width="50%"><select name="5_Friendliness" size="1">
		<%If rs.Fields("5_Friendliness")=0 then%>
			<option value="0" selected>&nbsp;</option>
		<%Else%>
			<option value="0">&nbsp;</option>
		<%End If%>
		<%If rs.Fields("5_Friendliness")=1 then%>
			<option value="1" selected>1</option>
		<%Else%>
			<option value="1">1</option>
		<%End If%>
		<%If rs.Fields("5_Friendliness")=2 then%>
			<option value="2" selected>2</option>
		<%Else%>
			<option value="2">2</option>
		<%End If%>
		<%If rs.Fields("5_Friendliness")=3 then%>
			<option value="3" selected>3</option>
		<%Else%>
			<option value="3">3</option>
		<%End If%>
		<%If rs.Fields("5_Friendliness")=4 then%>
			<option value="4" selected>4</option>
		<%Else%>
			<option value="4">4</option>
		<%End If%>
		<%If rs.Fields("5_Friendliness")=5 then%>
			<option value="5" selected>5</option>
		<%Else%>
			<option value="5">5</option>
		<%End If%>
      </select>&nbsp;&nbsp;&nbsp; (Poor)&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5 &nbsp;
      (Excellent)</td>
    </tr>
    <tr>
      <td width="250"><strong>Knowledge of their job -</strong></td>
      <td width="50%"><select name=5_Knowledge size="1">
		<%If rs.Fields("5_Knowledge")=0 then%>
			<option value="0" selected>&nbsp;</option>
		<%Else%>
			<option value="0">&nbsp;</option>
		<%End If%>
		<%If rs.Fields("5_Knowledge")=1 then%>
			<option value="1" selected>1</option>
		<%Else%>
			<option value="1">1</option>
		<%End If%>
		<%If rs.Fields("5_Knowledge")=2 then%>
			<option value="2" selected>2</option>
		<%Else%>
			<option value="2">2</option>
		<%End If%>
		<%If rs.Fields("5_Knowledge")=3 then%>
			<option value="3" selected>3</option>
		<%Else%>
			<option value="3">3</option>
		<%End If%>
		<%If rs.Fields("5_Knowledge")=4 then%>
			<option value="4" selected>4</option>
		<%Else%>
			<option value="4">4</option>
		<%End If%>
		<%If rs.Fields("5_Knowledge")=5 then%>
			<option value="5" selected>5</option>
		<%Else%>
			<option value="5">5</option>
		<%End If%>
      </select>&nbsp;&nbsp;&nbsp; (Poor)&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5 &nbsp;
      (Excellent)</td>
    </tr>
  </table>
  <p>&nbsp;&nbsp;&nbsp; Comments:
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <textarea rows="4"
  name=5_Comments cols="77"><%=rs.Fields("5_Comments")%></textarea>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
  <p>6)&nbsp;&nbsp;&nbsp; Does your agency currently use Statline for Family
  Services/tele-approach for donation?</p>
  <p>&nbsp;&nbsp;&nbsp; A.&nbsp;&nbsp;&nbsp; If so, how do you rate this service?</p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select name="6_A_Rating"
  size="1">
	<%If rs.Fields("6_A_Rating")=0 then%>
		<option value="0" selected>&nbsp;</option>
	<%Else%>
		<option value="0">&nbsp;</option>
	<%End If%>
	<%If rs.Fields("6_A_Rating")=1 then%>
		<option value="1" selected>1</option>
	<%Else%>
		<option value="1">1</option>
	<%End If%>
	<%If rs.Fields("6_A_Rating")=2 then%>
		<option value="2" selected>2</option>
	<%Else%>
		<option value="2">2</option>
	<%End If%>
	<%If rs.Fields("6_A_Rating")=3 then%>
		<option value="3" selected>3</option>
	<%Else%>
		<option value="3">3</option>
	<%End If%>
	<%If rs.Fields("6_A_Rating")=4 then%>
		<option value="4" selected>4</option>
	<%Else%>
		<option value="4">4</option>
	<%End If%>
	<%If rs.Fields("6_A_Rating")=5 then%>
		<option value="5" selected>5</option>
	<%Else%>
		<option value="5">5</option>
	<%End If%>
  </select>&nbsp;&nbsp;&nbsp; (Poor)&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5 &nbsp;
  (Excellent)</p>
  <p>&nbsp;&nbsp;&nbsp; Comments:
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <textarea rows="4"
  name="6_A_Comments" cols="77"><%=rs.Fields("6_A_Comments")%></textarea></p>
  <p>&nbsp;&nbsp;&nbsp; B.&nbsp;&nbsp;&nbsp; If not, would you be interested in receiving
  information about this service?&nbsp;&nbsp;&nbsp;&nbsp; <%If bolNewSurvey=true then%>
		<input type="radio" value="Yes" name=R2>Yes <input type="radio" name="R2" value="No">No</p>
  <%Else
		If rs.Fields("6_B_Information").Value=true then%>
			<input type="radio" value="Yes" Checked name=R2>Yes <input type="radio" name="R2" value="No">No</p>
<%		Else%>
			<input type="radio" value="Yes" name=R2>Yes <input type="radio" name="R2" Checked value="No">No</p>
<%		End If
	End If%>
  <p>7)&nbsp;&nbsp;&nbsp; Generally speaking, does our company:&nbsp; <select name="7_Rating"
  size="1">
	<%If rs.Fields("7_Rating")=0 then%>
		<option value="0" selected>&nbsp;</option>
	<%Else%>
		<option value="0">&nbsp;</option>
	<%End If%>
	<%If rs.Fields("7_Rating")=1 then%>
		<option value="1" selected>Exceed your expectations</option>
	<%Else%>
		<option value="1">Exceed your expectations</option>
	<%End If%>
	<%If rs.Fields("7_Rating")=2 then%>
		<option value="2" selected>Satisfy your expectations</option>
	<%Else%>
		<option value="2">Satisfy your expectations</option>
	<%End If%>
	<%If rs.Fields("7_Rating")=3 then%>
		<option value="3" selected>Not live up to your expectations</option>
	<%Else%>
		<option value="3">Not live up to your expectations</option>
	<%End If%>
  </select></p>
  <p>&nbsp;&nbsp;&nbsp; Comments:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <textarea rows="4" name="7_Comments" cols="77"><%=rs.Fields("7_Comments")%></textarea></p>
  <p>8)&nbsp;&nbsp;&nbsp; Is there any service that you would like to see Statline provide?
  &nbsp; What can we do to better serve you?</p>
  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <textarea rows="4" name="8_Comments" cols="77"><%=rs.Fields("8_Comments")%></textarea></p>
  <p><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset"
  name="B2"></p>
</form>
<%	Else%>
	<p>Thank you for your interest,</p>
	<p>however, your survey was already processed online at: <%=rs.Fields("SubmitDate")%></p>
<%	End If%>
</body>
</html>
