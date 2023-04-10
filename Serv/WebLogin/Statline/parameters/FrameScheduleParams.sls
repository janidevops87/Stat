<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim pvStartDate
Dim pvEndDate
Dim RS1
Dim RestrictReferralType
Dim ReferralTypeList
Dim i
Dim vErrorMessage
Dim BrowserUA
Dim MasterReportGroupID
Dim Temp
Dim MSBrowser
Dim MaxDay
Dim CurrentDay
Dim CurrentMonth
Dim CurrentYear
Dim vErrorMsg
Dim ErrorReturn
Dim OnlineSetAccess
Dim OnlineScheduleAccess
Dim cmd
Dim ForLoopCounter


'Get the current month and year
CurrentMonth = Month(now())
CurrentYear = Year(now())
CurrentDay = Day(now())
MaxDay    = GetMaxDay(CurrentMonth, CurrentDay, CurrentYear)

'Get the browser type
MSBrowser = "False"
BrowserUA = Request.ServerVariables("HTTP_USER_AGENT")
Temp = InStr(1, BrowserUA, "MSIE")
If Temp > 0 Then
    MSBrowser = "True"
End If

%>


<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/ParamDates.sls"-->

<%
'Verify Access
If AuthorizeMain Then
    Call DisplayParameters

Else
            vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
            vErrorMsg = vErrorMsg & "The User Oganization does not have access.<BR> <BR>"
            vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
            vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
            vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, Activity.sls) <BR> <BR>"
            vErrorMsg = vErrorMsg & "</FONT></FONT>"
            Response.Write(vErrorMsg)
End If


Function DisplayParameters()
   
    'Open Connection
    Set Conn = server.CreateObject("ADODB.Connection")
    Conn.Open DataSourceName, DBUSER, DBPWD

    'Get the master group for the user's organization
    vQuery = "sps_ReportGroupMaster " & UserOrgID
    DebugPrint(vQuery)
    Set RS = Conn.Execute(vQuery)
    If Not RS.EOF Then
        MasterReportGroupID = RS("WebReportGroupID")
    Else
        MasterReportGroupID = 0
    End If
    Set RS = Nothing
    DebugPrint(Request.ServerVariables("QUERY_STRING"))
%>

<html >

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>Schedule Lookup </title>
</head>

<body bgcolor="#F5EBDD" text="BLACK" ONLOAD="reportOnChange();" >

<form name="reportForm"  >
  <input type="hidden" name="serverName" value="<%=Request.ServerVariables("SERVER_NAME")%>">
  <input type="hidden" name="userID" value="<%=UserID%>">
  <input type="hidden" name="userOrgID" value="<%=UserOrgID%>">
  <input type="hidden" name="datasource" value="<%=DataSourceName%>">
  <input type="hidden" name="MSBrowser" value="<%=MSBrowser%>">
  <input type="hidden" name="MasterReportGroupId" value="<%=MasterReportGroupID%>">

<!-- Information Notice--->
  <table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
    width="550" bgColor="#112084">
    <tr>
        <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Schedule Lookup</b></font></td>
    </tr>
  </table>

<p>&nbsp;</p>

<%
    'check for access to SetAccess and OnlineScheduleAccess
    vQuery = "SELECT ISNULL(AllowSecurityAccess,0) AS 'AllowSecurityAccess'  FROM statemployee RIGHT JOIN WebPerson ON WebPerson.PersonID = StatEmployee.PersonID WHERE WebPersonID = " & UserID
    Set RS = Conn.Execute(vQuery)

    If Not RS.EOF Then
        OnlineSetAccess = RS("AllowSecurityAccess")
    Else
        OnlineSetAccess = 0
    End If
    Set RS = Nothing
    vQuery = "SELECT CASE WHEN AllowInternetScheduleAccess IS NULL THEN 0 ELSE AllowInternetScheduleAccess END AS 'AllowInternetScheduleAccess' FROM PERSON JOIN WebPerson ON WebPerson.PersonID = Person.PersonID WHERE WebPersonID = " & UserID
    Set RS = Conn.Execute(vQuery)
    IF Not RS.EOF Then
        OnlineScheduleAccess = RS("AllowInternetScheduleAccess")
    Else
        OnlineScheduleAccess = 0
    End If
    Set RS = Nothing

   Set RS = Server.CreateObject("ADODB.Recordset")
   Set cmd = Server.CreateObject("ADODB.Command")
   cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
   cmd.CommandText = "SPS_ReportList"
   cmd.CommandType = adCmdStoredProc
   cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
   cmd.Parameters.Append cmd.CreateParameter("@ReportTypeID", adInteger, adParamInput)
   cmd.Parameters.Append cmd.CreateParameter("@UserOrgID", adInteger, adParamInput)
   cmd.Parameters.Append cmd.CreateParameter("@UserID", adInteger, adParamInput)
   cmd.Parameters("@ReportTypeID").Value = 7
   cmd.Parameters("@UserOrgID").Value = UserOrgID
   cmd.Parameters("@UserID").Value = UserID
   Set RS = cmd.Execute

%>
 <table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font face="Arial" size="2"><b>Scheduler</b></font></td>
      <td valign="center">
        <select name="report" ONCHANGE="reportOnChange();" size="1" >

        <%
        Do While Not RS.EOF
            'Call DisplayReport()
            IF RS("ReportID") = 85 Then 'Report ID 85 for ScheduleAccessSetup
                IF OnlineSetAccess = -1 Then
                    Call DisplayReport()
                End If

            ElseIF RS("ReportID") = 84 or RS("ReportID") = 81 Then '84 or 81 ScheduleLog and ScheduleUpdate
                IF OnlineScheduleAccess = -1 Then
                    Call DisplayReport()
                End If
            Else

                Call DisplayReport()

            End If
            RS.MoveNext%>
        <%
        Loop
        Set RS = Nothing
        %>
        </select>
      </td>

    </tr>
  </table>

  <table cellPadding="0" cellSpacing="2">

    <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>From Date</b></font></td>
      <td valign="center" align="left">
        <select name="fromMonth" size="1">
            <option value="1" <%If CurrentMonth = 1 Then%>selected<%End If%>>January</option>
            <option value="2" <%If CurrentMonth = 2 Then%>selected<%End If%>>February</option>
            <option value="3" <%If CurrentMonth = 3 Then%>selected<%End If%>>March</option>
            <option value="4" <%If CurrentMonth = 4 Then%>selected<%End If%>>April</option>
            <option value="5" <%If CurrentMonth = 5 Then%>selected<%End If%>>May</option>
            <option value="6" <%If CurrentMonth = 6 Then%>selected<%End If%>>June</option>
            <option value="7" <%If CurrentMonth = 7 Then%>selected<%End If%>>July</option>
            <option value="8" <%If CurrentMonth = 8 Then%>selected<%End If%>>August</option>
            <option value="9" <%If CurrentMonth = 9 Then%>selected<%End If%>>September</option>
            <option value="10" <%If CurrentMonth = 10 Then%>selected<%End If%>>October</option>
            <option value="11" <%If CurrentMonth = 11 Then%>selected<%End If%>>November</option>
            <option value="12" <%If CurrentMonth = 12 Then%>selected<%End If%>>December</option>
        </select>
      </td>

      <td valign="center" align="left">
        <select name="fromDay" size="1" >
            <% For ForLoopCounter = 1 to 31 %>

            <option value=<%=LeadingZero(ForLoopCounter)%> <%If ForLoopCounter = 1 Then%> selected <%End If%>><%=LeadingZero(ForLoopCounter)%></option>

            <% Next %>

        </select>
      </td>

      <td valign="center" align="left"><font face="Arial" size="2"><b></b></font></td>
      <td valign="center" align="left">
        <select name="fromYear" size="1">
            <%=buildDropDownOptionYearList(CurrentYear - 1)%>

        </select>
      </td>
       <td valign="center" align="left"><font face="Arial" size="2"><b>Time</b></font></td>
      <td valign="center" align="left">
        <select name="fromHour" size="1">
        <% For ForLoopCounter = 0 to 23 %>
            <option value=<%=LeadingZero(ForLoopCounter)%> <%If ForLoopCounter = 0 Then%> selected<%End If%>><%=LeadingZero(ForLoopCounter)%></option>
            <% NEXT %>

        </select>
      </td>
             <td valign="center" align="left"><font face="Arial" size="2"><b>:</b></font></td>
      <td valign="center" align="left">
        <select name="fromMinute" size="1">
        <% For ForLoopCounter = 0 to 59 %>
            <option value=<%=LeadingZero(ForLoopCounter)%> <%If ForLoopCounter = 0 Then%> selected<%End If%>><%=LeadingZero(ForLoopCounter)%></option>
            <% NEXT %>

        </select>
      </td>
    </tr>
    <tr>
      <td valign="center"><font size="2" face="Arial"><b>To Date</b></font></td>
      <td valign="center" align="left">
        <select name="toMonth" size="1">
            <option value="1" <%If CurrentMonth = 1 Then%>selected<%End If%>>January</option>
            <option value="2" <%If CurrentMonth = 2 Then%>selected<%End If%>>February</option>
            <option value="3" <%If CurrentMonth = 3 Then%>selected<%End If%>>March</option>
            <option value="4" <%If CurrentMonth = 4 Then%>selected<%End If%>>April</option>
            <option value="5" <%If CurrentMonth = 5 Then%>selected<%End If%>>May</option>
            <option value="6" <%If CurrentMonth = 6 Then%>selected<%End If%>>June</option>
            <option value="7" <%If CurrentMonth = 7 Then%>selected<%End If%>>July</option>
            <option value="8" <%If CurrentMonth = 8 Then%>selected<%End If%>>August</option>
            <option value="9" <%If CurrentMonth = 9 Then%>selected<%End If%>>September</option>
            <option value="10" <%If CurrentMonth = 10 Then%>selected<%End If%>>October</option>
            <option value="11" <%If CurrentMonth = 11 Then%>selected<%End If%>>November</option>
            <option value="12" <%If CurrentMonth = 12 Then%>selected<%End If%>>December</option>
        </select>
      </td>
      <td valign="center" align="left">
        <select name="toDay" size="1">
            <% For ForLoopCounter = 1 to 31 %>

            <option value=<%=LeadingZero(ForLoopCounter)%> <%If ForLoopCounter = MaxDay Then%> selected<%End If%>><%=LeadingZero(ForLoopCounter)%></option>

            <% Next %>

        </select>
      </td>
      <td valign="center" align="left"><font face="Arial" size="2"><b></b></font></td>
      <td valign="center" align="left">
        <select name="toYear" size="1">
            <%=buildDropDownOptionYearList(CurrentYear - 1)%>
        </select>
      </td>
       <td valign="center" align="left"><font face="Arial" size="2"><b>Time</b></font></td>
      <td valign="center" align="left">
        <select name="toHour" size="1">
        <% For ForLoopCounter = 0 to 23 %>
            <option value=<%=LeadingZero(ForLoopCounter)%> <%If ForLoopCounter = 23 Then%> selected<%End If%>><%=LeadingZero(ForLoopCounter)%></option>
            <% NEXT %>

        </select>
      </td>
             <td valign="center" align="left"><font face="Arial" size="2"><b>:</b></font></td>
      <td valign="center" align="left">
        <select name="toMinute" size="1">
        <% For ForLoopCounter = 0 to 59 %>
            <option value=<%=LeadingZero(ForLoopCounter)%> <%If ForLoopCounter = 59 Then%> selected<%End If%>><%=LeadingZero(ForLoopCounter)%></option>
            <% NEXT %>

        </select>
      </td>
    </tr>
  </table>

<!--Get the report Groups for the Box-->
<%
'Get the report groups list
vQuery = "EXEC sps_ScheduleOrganizations1 " & UserOrgID
DebugPrint(vQuery)
Set RS = Conn.Execute(vQuery)
%>

<table cellPadding="0" cellSpacing="2" >
    <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>Schedule Organizations</b></font></td>
      <td valign="center">
        <select name="UserOrgId" <%If MSBrowser = "True" Then%> onChange="newSelect(this.options[this.selectedIndex].value);" onselectstart="newSelect(this.options[this.selectedIndex].value);"<%End If%>>

        <% If MSBrowser = "True" Then %>
            <option value="0" selected></option>
        <% End If %>

        <%Do While Not RS.EOF%>

            <% If MSBrowser = "True" Then %> <option  value="<%=RS("OrganizationID")%>"><%=RS("OrganizationName")%></option>
            <% else %> <option selected value="<%=RS("OrganizationID")%>"><%=RS("OrganizationName")%></option>
            <% End If %>
            <%RS.MoveNext%>
        <%
        Loop
        Set RS = Nothing
        %>
        </select>
      </td>

    </tr>
</table>

<table cellPadding="0" cellSpacing="2">
<%
If MSBrowser = "True" Then
%>
    <!-- Get the Children for this Box -->
    <tr>
      <td width="95" valign="center"><font size="2" face="Arial"><b>Schedule Groups</b></font></td>
      <td colspan="3">
        <iframe height=25 width=415 name="OrgFrame" Frameborder=0 MarginHeight=0 Marginwidth=0 Scrolling="no"
            src="/loginstatline/parameters/ScheduleGroupList.sls?<%=Request.ServerVariables("Query_string")%>&ReportGroupID=<%=MasterReportGroupID%>">

        </iframe>
      </td>
    </tr>
<%
Else
    'Get the report groups list
    vQuery = "sps_ScheduleGroups " & userOrgID 'MasterReportGroupID
    DebugPrint(vQuery)
    Set RS = Conn.Execute(vQuery)
%>
    <!-- Get the Children for this Box -->
    <tr>
      <td width="95" valign="center"><font size="2" face="Arial"><b>Schedule Groups</b></font></td>
      <td valign="center">
        <select name="organization">

        <%Do While Not RS.EOF
            If RS.CursorLocation = 1 Then
        %>
                <option selected value="<%=RS("ScheduleGroupID")%>"><%=RS("ScheduleGroupName")%></option>
        <%
            ELSE
        %>
                <option value="<%=RS("ScheduleGroupID")%>"><%=RS("ScheduleGroupName")%></option>
        <%
            End IF
        %>

            <%RS.MoveNext%>
        <%
        Loop
        Set RS = Nothing
        %>
        </select>
      </td>
    </tr>
<%
End If
%>
</table>

 <HR SIZE=1 width=550 align="left">

    <table>
      <tr>
        <td width="95"></td>
    <td><a href="javascript:reportOnChange();"
onClick="MM_nbGroup('down','group1','Show','/loginstatline/images/Button_Show_Over.gif',1)"
onMouseOver="MM_nbGroup('over','Show','/loginstatline/images/Button_Show_Over.gif','/loginstatline/images/Button_Show_Over.gif',1)"
onMouseOut="MM_nbGroup('out')"><img src="/loginstatline/images/Button_Show.gif" alt="Show" name="Show" width="88" height="25" border="0" onload=""></a></td>
      </tr>
    </table>


</form>
</body>
</html>

<%End Function


Function DisplayReport()
%>
    <option value="<%=RS("ReportDescFileName") & "|" & RS("ReportVirtualUrl") & "|" & RS("ReportID")%>"><%=RS("ReportDisplayName")%></option>
<%
End Function
Function LeadingZero(CurrentNumber)

    If CurrentNumber < 10 Then
        LeadingZero = "0" & CurrentNumber
    Else
        LeadingZero = CurrentNumber
    End If

End Function

Function GetMaxDay(CurrentMonth, CurrentDay, CurrentYear)
    Dim MaxDate
    MaxDate = "" & CurrentMonth & "/" & CurrentDay & "/" & CurrentYear & ""

    'Response.Write MaxDate
    'Function deteremines the last day of the month
    For ForLoopCounter = CurrentDay to 31
        MaxDate = DateAdd("d",1, MaxDate)

        IF DatePart("m", MaxDate ) <> CurrentMonth Then
            GetMaxDay = DatePart("d",DateAdd("d",-1, MaxDate))
            Exit function
        End If

    Next


End Function

Sub FixQueryString(pvIn, pvOut)
    Dim x
    pvOut = ""
    For x=1 TO Len(pvIn)
        If Mid(pvIn,x,1) = "_" Then
            pvOut = pvOut & " "
        Else
            pvOut = pvOut & Mid(pvIn,x,1)
        End If
    Next
End Sub
Function DebugPrint(printString)
    'Response.Write("DEBUG-> <br>" & printString)
End Function

%>



<script language="JavaScript">
    function newSelect(vID)
    {
        var url;
        if (vID == 0)
        {
            return;
        }
        else
        {

            url = "/loginstatline/parameters/ScheduleGroupList.sls?";
            //url = url + "ReportGroupID=" + vID;  
            url = url + "ReportGroupID=" + document.reportForm.MasterReportGroupId.value;
            url = url + "&userID=" + document.reportForm.userID.value;
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value;
<%' In the case of StatTrac, add the value in the UserOrgId dropdown to show options for that org.  4/29/05 - SAP 
   If UserOrgID = 194 Then %>    
            url = url + "&StatOrgID=" + document.reportForm.UserOrgId.options[document.reportForm.UserOrgId.selectedIndex].value
<% End If  %>             
            frames[0].location.replace(url);
        }
    }

    function reportOnChange()
    {
	
        var reportvalue = ""; //string of selected report
        var reportid = 0; //reportid in reportvalue that pulled out.
        var pipeIndex = 0; //records first location of the | in reportValue
        var pipeIndex2 = 0; //records second location of the | in reportValue

        reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value;


        pipeIndex = reportvalue.indexOf("|",0);
        pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1);
        reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length);
	reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2);


		//if the reportID > 194  and the file contains /StatTrac/ it is a new reporting service report
		if(reportid >194 && reportfile.indexOf("StatTrac", 0 ) != -1)
		{
			
			for(i=0;i<document.reportForm.report.options.length;i++)
			{

				if (document.reportForm.report.options[i].text == "")
				{
					document.reportForm.report.options[i].selected = true;
				}
			}
			//Added new parameter -sid- in QueryString with generated GUID value in DB - Added by Ilya Osipov
			url = strHttpHeader + document.reportForm.serverName.value + "/StatLine.StatTrac.Web.UI/ReportParam.aspx?"
			url = url + "userID=" + document.reportForm.userID.value
			url = url + "&userOrgID=" + document.reportForm.userOrgID.value
			url = url + "&ReportID=" + reportid
			url = url + "&sid=" + getCookie("sid")

			window.open(url,'_blank','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

		}
    }

	//Get Cookie value by key name
	function getCookie(name) {
	  var value = "; " + document.cookie;
	  var parts = value.split("; " + name + "=");
	  if (parts.length == 2) return parts.pop().split(";").shift();
	}

    function clickShow()
    {

    var url = ""
    var reportvalue = ""
    var reportfile = ""
    var reportid = ""
    var pipeIndex = 0
    var pipeIndex2 = 0
    var optionString = ""
    var orderby = ""
    var fromMonth = ""
    var fromYear = ""
    var fromDate = ""
    var fromHour = ""
    var fromMinute = ""
    var toMonth = ""
    var toDay = ""
    var toYear = ""
    var toDate = ""
    var toHour = ""
    var toMinute = ""

    //if (document.reportForm.rollup[0].checked) {optionString="0"}
    //if (document.reportForm.rollup[1].checked) {optionString="1"}

    reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value

    pipeIndex = reportvalue.indexOf("|",0)
    //alert("PAST FIRST INDEXof")
    pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)
    reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2)
    reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length)

    fromMonth = document.reportForm.fromMonth.options[document.reportForm.fromMonth.selectedIndex].value
    fromDay = document.reportForm.fromDay.options[document.reportForm.fromDay.selectedIndex].value
    fromYear = document.reportForm.fromYear.options[document.reportForm.fromYear.selectedIndex].value
    fromHour = document.reportForm.fromHour.options[document.reportForm.fromHour.selectedIndex].value
    fromMinute = document.reportForm.fromMinute.options[document.reportForm.fromMinute.selectedIndex].value


    toMonth = document.reportForm.toMonth.options[document.reportForm.toMonth.selectedIndex].value
    toDay =    document.reportForm.toDay.options[document.reportForm.toDay.selectedIndex].value
    toYear = document.reportForm.toYear.options[document.reportForm.toYear.selectedIndex].value
    toHour = document.reportForm.toHour.options[document.reportForm.toHour.selectedIndex].value
    toMinute = document.reportForm.toMinute.options[document.reportForm.toMinute.selectedIndex].value


    fromDate = fromMonth + "/" + fromDay + "/" + fromYear + "_" + fromHour + ":" + fromMinute
    toDate = toMonth + "/" + toDay + "/" + toYear + "_" + toHour + ":" + toMinute
    if (validate())
        {
        url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
        url = url + reportfile
        url = url + "StartDate=" + fromDate
        url = url + "&EndDate=" + toDate
<%' In the case of StatTrac, set the ReportGroupId to the value from UserOrgId dropdown.  4/29/05 - SAP 
   If UserOrgID = 194 Then %>    
        url = url + "&ReportGroupID=" + document.reportForm.UserOrgId.options[document.reportForm.UserOrgId.selectedIndex].value
<% Else  %>
	url = url + "&ReportGroupID=" + document.reportForm.MasterReportGroupId.value
<% End If  %>
        document.reportForm.UserOrgId.options[document.reportForm.UserOrgId.selectedIndex].value

        if (document.reportForm.MSBrowser.value == 'True')
            {
            url = url + "&ScheduleGroupID=" + frames[0].organization.options[frames[0].organization.selectedIndex].value
            }

        if (document.reportForm.MSBrowser.value == 'False')
            {
            url = url + "&ScheduleGroupID=" + document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value
            }

        url = url + "&userID=" + document.reportForm.userID.value
        url = url + "&userOrgID=" + document.reportForm.userOrgID.value
        url = url + "&DSN=" + document.reportForm.datasource.value
        url = url + "&Options=" + optionString
        url = url + "&ReportID=" + reportid
        window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

        return
        }

    return

    }


    function clickGroup()
    {

    if (document.reportForm.UserOrgId.options[document.reportForm.UserOrgId.selectedIndex].value == 0)
        {
            alert ("Please select a report group.")
             document.reportForm.UserOrgId.focus()
            return
        }

    var url = ""

    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reports/admin/GetOrgList.sls"
    url = url + "?ReportGroupID=" + document.reportForm.UserOrgId.options[document.reportForm.UserOrgId.selectedIndex].value
    window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

    return

    }

    function clickDesc()
    {

    /*if (document.reportForm.report.options[document.reportForm.report.selectedIndex].value == 0)
        {
            alert ("Please select a report.")
            // document.reportForm.report.focus()
            return
        }
*/
    var url = ""
    var reportvalue = ""
    var reportdescfile = ""
    var pipeIndex = 0

    reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value
    pipeIndex = reportvalue.indexOf("|",0)
    reportdescfile = reportvalue.substring(0,pipeIndex)

    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reportdesc/" + reportdescfile
    window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

    return

    }


    function validate()
    {


    if (document.reportForm.MSBrowser.value == 'True')
        {
        if (document.reportForm.UserOrgId.options[document.reportForm.UserOrgId.selectedIndex].value == 0)
            {
            alert ("Please select a schedule organization and schedule group.")
            return false
            }

        if (frames[0].organization.options[frames[0].organization.selectedIndex].value == 0)
                {
                    alert ("Please select a schedule group.")
                    return false
                }

        }
    else
        {
        if (document.reportForm.UserOrgId.options[document.reportForm.UserOrgId.selectedIndex].value == 0)
            {
            alert ("Please select a schedule organization and schedule group.")
            return false
            }
        if (document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value == 0)
            {
                alert ("Please select a schedule group.")
                return false
            }
        }

    return true

    }

// daysInFebruary (INTEGER year)
//
// Given integer argument year,
// returns number of days in February of that year.

function daysInFebruary (year)
{
    // February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    var intYear

    intYear = parseInt(year,10)

    return (  ((intYear % 4 == 0) && ( (!(intYear % 100 == 0)) || (intYear % 400 == 0) ) ) ? 29 : 28 );
}

function daysInMonth (month)
{
    var monthDays = makeArray(12);

    monthDays[1] = 31;
    monthDays[2] = 29;
    monthDays[3] = 31;
    monthDays[4] = 30;
    monthDays[5] = 31;
    monthDays[6] = 30;
    monthDays[7] = 31;
    monthDays[8] = 31;
    monthDays[9] = 30;
    monthDays[10] = 31;
    monthDays[11] = 30;
    monthDays[12] = 31;

    return monthDays[parseInt(month,10)];
}

function makeArray(n)
{
   for (var i = 1; i <= n; i++) {
      this[i] = 0
   }
   return this
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v6.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}
</script>

