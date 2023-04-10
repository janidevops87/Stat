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
Dim vErrorMsg
Dim ErrorReturn
Dim cmd


'Get the browser type
MSBrowser = "False"
BrowserUA = Request.ServerVariables("HTTP_USER_AGENT")
Temp = InStr(1, BrowserUA, "MSIE")
If Temp > 0 Then
    MSBrowser = "True"
End If
%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
'Verify Access
If AuthorizeMain Then
    Call DisplayParameters
End If


Function DisplayParameters()



    'Open Connection
    Set Conn = server.CreateObject("ADODB.Connection")
    Conn.Open DataSourceName, DBUSER, DBPWD
		     
    'Get the referral type list
    vQuery = "sps_ReferralTypeViewAccess " & UserOrgID
    'print(vQuery)
    Set RS1 = Conn.Execute(vQuery)
    ReferralTypeList = RS1.GetRows
    Set RS1 = Nothing

    'Check if there should be a blank (all types) referral type choice
    RestrictReferralType = False
    For i = 0 to Ubound(ReferralTypeList,2)
        If ReferralTypeList(2,i) = 0 Then
            RestrictReferralType = True
        End If
    Next

    'Get the master group for the user's organization
    vQuery = "sps_ReportGroupMaster " & UserOrgID
    Set RS = Conn.Execute(vQuery)
    If Not RS.EOF Then
        MasterReportGroupID = RS("WebReportGroupID")
    Else
        MasterReportGroupID = 0
    End If
    Set RS = Nothing

    %>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0"> 
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>Parameters</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK" onload="document.reportForm.report.focus();">

<form name="reportForm">
  <input type="hidden" name="serverName" value="<%=Request.ServerVariables("SERVER_NAME")%>">
  <input type="hidden" name="userID" value="<%=UserID%>">
  <input type="hidden" name="userOrgID" value="<%=UserOrgID%>">
  <input type="hidden" name="datasource" value="<%=DataSourceName%>">
  <input type="hidden" name="MSBrowser" value="<%=MSBrowser%>">

<!-- Information Notice--->
  <table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
    width="550" bgColor="#112084">
    <tr>
        <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Referral Activity</b></font></td>
    </tr>
  </table>

<p>&nbsp;</p>

<%
Dim ReportListIndex
   Set RS = Server.CreateObject("ADODB.Recordset")
   Set cmd = Server.CreateObject("ADODB.Command")
   cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
   cmd.CommandText = "SPS_ReportList"
   cmd.CommandType = adCmdStoredProc
   cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
   cmd.Parameters.Append cmd.CreateParameter("@ReportTypeID", adInteger, adParamInput)
   cmd.Parameters.Append cmd.CreateParameter("@UserOrgID", adInteger, adParamInput)
   cmd.Parameters.Append cmd.CreateParameter("@UserID", adInteger, adParamInput)
   cmd.Parameters("@ReportTypeID").Value = 1
   cmd.Parameters("@UserOrgID").Value = UserOrgID
   cmd.Parameters("@UserID").Value = UserID
   Set RS = cmd.Execute
%>

  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font face="Arial" size="2"><b>Report</b></font></td>
      <td valign="center">
        <select name="report" size="1"  onChange="verifyReportType();">
        <option value="0" selected></option>
        <%
        Do While Not RS.EOF
        %>
            <option value="<%=RS("ReportDescFileName") & "|" & RS("ReportVirtualUrl") & "|" & RS("ReportID")%>"><%=RS("ReportDisplayName")%></option>
            <%RS.MoveNext%>
        <%
        Loop
        Set RS = Nothing
        %>
        </select>
      </td>

      <td>
      <A href="javascript:clickDesc()">
          <IMG SRC="/loginstatline/images/ellipses2.gif" NAME="description" BORDER="0"></A></td>
    </tr>
  </table>

  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>From Date</b></font></td>
      <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="<%=FormatDateTime(Now-1,vbShortDate)%>" size="9" name="startDate" maxlength="10"> </td>
      <td valign="center" align="left"><font face="Arial" size="2"><b>Time</b></font></td>
      <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="00:00" size="7" name="startTime" maxlength="5"> </td>
    </tr>
    <tr>
      <td valign="center"><font size="2" face="Arial"><b>To Date</b></font></td>
      <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="<%=FormatDateTime(Now,vbShortDate)%>" size="9" name="toDate" maxlength="10"> </td>
      <td valign="center" align="left"><font face="Arial" size="2"><b>Time</b></font></td>
      <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="00:00" size="7" name="toTime" maxlength="5"> </td>
    </tr>
  </table>

<!--Get the report Groups for the Box-->
<%
'Get the report groups list
vQuery = "sps_ReportGroups " & UserOrgID
DebugPrint(vQuery)
Set RS = Conn.Execute(vQuery)
%>

<table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>Report Group</b></font></td>
      <td valign="center">
        <select name="reportGroup" width="95"
        <%If MSBrowser = "True" Then%>onChange="newSelect(this.options[this.selectedIndex].value);"<%End If%> size=0>

        <%If UserOrgID = 194 Then%><option value="0" selected>&nbsp;</option><%End If%>

        <%Do While Not RS.EOF%>
            <option value="<%=RS("WebReportGroupID")%>"><%=RS("ReportGroupName")%></option>
            <%RS.MoveNext%>
        <%
        Loop
        Set RS = Nothing
        %>
        </select>
      </td>
      <td>
            <A href="javascript:clickGroup()">
          <IMG SRC="/loginstatline/images/ellipses2.gif" NAME="groupMembers" BORDER="0"></A></td>
    </tr>
</table>

<table cellPadding="0" cellSpacing="2">
<%


If MSBrowser = "True" Then
%>
    <!-- Get the Children for this Box -->
    <tr>
      <td width="95" valign="center"><font size="2" face="Arial"><b>Organization</b></font></td>
      <td colspan="3">
        <iframe height=25 width=447 name="OrgFrame" Frameborder=0 MarginHeight=0 Marginwidth=0 Scrolling="no"
            src="/loginstatline/parameters/organizationList.sls?ReportGroupID=<%=MasterReportGroupID%>">
        </iframe>
      </td>
     <!-- Removed 6/29/99 = Bret Knoll
      <td>
            <A href="javascript:clickPerson()">
          <IMG SRC="/loginstatline/images/ellipses2.gif" NAME="HospitalMembers" BORDER="0"></A>

      </td>-->

    </tr>
<%
Else
    'Get the report groups list
    vQuery = "sps_ReportGroupOrgs " & MasterReportGroupID
    Set RS = Conn.Execute(vQuery)
%>
    <!-- Get the Children for this Box -->
    <tr>
      <td width="95" valign="center"><font size="2" face="Arial"><b>Organization</b></font></td>
      <td valign="center">
        <select name="organization" width="95">
        <option value="0" selected></option>
        <%Do While Not RS.EOF%>
            <option value="<%=RS("OrganizationID")%>"><%=RS("OrganizationName")%></option>
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

<table cellPadding="0" cellSpacing="2">
<!-- Set the Referral Types -->
    <tr>
      <td width="95" valign="center"><font size="2" face="Arial"><b>Type</b></font></td>
      <td colspan="3">

        <select name="type" size="1">

        <%If RestrictReferralType = False Then%>
            <option value="0" selected></option>
        <%End If%>

        <%For i = 0 to Ubound(ReferralTypeList,2)%>
            <%'If ReferralTypeList(2,i) = 1 Then%>
                <option value="<%=ReferralTypeList(0,i)%>"><%=ReferralTypeList(1,i)%></option>
            <%'End If%>
        <%Next%>

        </select>
     </td>
   </tr>
</table>



<!-- Set the Sort Order Options-->
  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td width="95"><font size="2" face="Arial"><b>Sort Order</b></font></td>
      <td colspan="1"><select name="order1" size="1" onChange="verifyReportType();">
        <option value="0" selected></option>
        <option value="CallDateTime">Date</option>
        <option value="OrganizationName">Organization</option>
        <option value="Referral.ReferralTypeID">Referral Type</option>
        <option value="ReferralDonorLastName">Patient Name</option>
        <option value="Referral.ReferralApproachTypeId">*Approach Type</option>
        <option value="GOrganizationName">*Group By Org</option>
      </select> </td>
      <td colspan="1"><select name="order2" size="1" onChange="verifyReportType();">
        <option value="0" selected></option>
        <option value="CallDateTime">Date</option>
        <option value="OrganizationName">Organization</option>
        <option value="Referral.ReferralTypeID">Referral Type</option>
        <option value="ReferralDonorLastName">Patient Name</option>
        <option value="Referral.ReferralApproachTypeId">*Approach Type</option>
        <option value="GOrganizationName">*Group By Org</option>
      </select> </td>
      <td colspan="1"><select name="order3" size="1" onChange="verifyReportType();">
        <option value="0" selected></option>
        <option value="CallDateTime">Date</option>
        <option value="OrganizationName">Organization</option>
        <option value="Referral.ReferralTypeID">Referral Type</option>
        <option value="ReferralDonorLastName">Patient Name</option>
        <option value="Referral.ReferralApproachTypeId">*Approach Type</option>
        <option value="GOrganizationName">*Group By Org</option>
      </select> </td>
    </tr>
  </table>

  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td width="95"><font size="2" face="Arial"><b>Options</b></font></td>
      <td><input type="checkbox" name="option1" value="ON"><small>No Patient Name /
      Med Rec. Num </small></td>
        <td width="20">&nbsp;</td>
        <td><font size="2" face="Arial"><b>Referral #&nbsp;</b></font></td>
        <td><font face="Arial"><input value="" size="10" name="referralNumber" maxlength="10"></font></td>
    </tr>
  </table>

 <HR SIZE=1 width=550 align="left">

    <table cellPadding="0" cellSpacing="2">
      <tr>
        <td width="95"></td>
    <td><a href="javascript:clickShow()"
onClick="MM_nbGroup('down','group1','Show','/loginstatline/images/Button_Show_Over.gif',1)"
onMouseOver="MM_nbGroup('over','Show','/loginstatline/images/Button_Show_Over.gif','/loginstatline/images/Button_Show_Over.gif',1)"
onMouseOut="MM_nbGroup('out')"><img src="/loginstatline/images/Button_Show.gif" alt="Show" name="Show" width="88" height="25" border="0" onload=""></a></td>
        </td>
        <td width="95"></td>



<%

    If 0=0 Then ''UserOrgId = 194  or UserOrgId = 2945 Then    'Temporary (Remove when go-live)

    dim vDLQuery
    vDLQuery = "SELECT ExportFileDirectoryPath FROM ExportFile "
    vDLQuery = vDLQuery & "WHERE OrganizationID = " & UserOrgId
    Set RS = Conn.Execute(vDLQuery)

    If Not RS.EOF or UserOrgId = 194 then %>
<td><a href="https://www2.statline.com/loginstatline/parameters/refdownload.sls?UserOrgId=<%=UserOrgId%>&DSN=<%=DataSourceName%>"
onClick="MM_nbGroup('down','group1','Download','/loginstatline/images/Button_Download_Over.gif',1)"
onMouseOver="MM_nbGroup('over','Download','/loginstatline/images/Button_Download_Over.gif','/loginstatline/images/Button_Download_Over.gif',1)"
onMouseOut="MM_nbGroup('out')"><img src="/loginstatline/images/Button_Download.gif" alt="Download" name="Download" width="88" height="25" border="0" onload=""></a></td>

<%    End If
    Set RS = Nothing

    End If    'Temporary (Remove when go-live)
%>

</tr>
    </table>

<table>
    <tr>
    <td></td><td colspan=3><font name=arial size=2>*Note: Sort Order <b>Approach Type</b> applies to Referral Summary and Referral Detail reports only.</font></td>
    </tr>
    <tr>
        <td></td><td colspan=3><font name=arial size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sort Order <b>Group By Org</b> applies to Referral Activity, Referral Summary, and Referral Summary - Condensed reports only.</font></td>
    </tr>
</table>

</form>
</body>
</html>

<%End Function
Function DebugPrint(printString)
    'Response.Write("DEBUG-> <br>" & printString)
End Function

%>


<script language="JavaScript">

    function verifyReportType(){
		//Add Functionality for New Reports
			reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value;
			pipeIndex = reportvalue.indexOf("|",0);
			pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1);
			reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2);
			reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length);

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
    
    
        //Verify for Sort By ApproachType (Activity and Detail Reports only)
        if(document.reportForm.report.options[document.reportForm.report.selectedIndex].value != "refsum.shm|/reports/referral/summary_A.sls?|49" && document.reportForm.report.options[document.reportForm.report.selectedIndex].value != "refdtl.shm|/reports/referral/detail_1.sls?|72"){
            if(document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value == "Referral.ReferralApproachTypeId"){
                document.reportForm.order1.selectedIndex = 0;
            }
            if(document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value == "Referral.ReferralApproachTypeId"){
                document.reportForm.order2.selectedIndex = 0;
            }
            if(document.reportForm.order3.options[document.reportForm.order3.selectedIndex].value == "Referral.ReferralApproachTypeId"){
                document.reportForm.order3.selectedIndex = 0;
            }
        }

        //Verify for Sort/Group By Organization (Activity, Summary, and Summary Condensed Reports only)
        if(document.reportForm.report.options[document.reportForm.report.selectedIndex].value != "refactv.shm|/reports/referral/activity1.sls?|65" && document.reportForm.report.options[document.reportForm.report.selectedIndex].value != "refsum.shm|/reports/referral/summary_A.sls?|49" && document.reportForm.report.options[document.reportForm.report.selectedIndex].value != "refsumcond.shm|/reports/referral/Condensed_A.sls?|18"){
            if(document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value == "GOrganizationName"){
                document.reportForm.order1.selectedIndex = 0;
            }
            if(document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value == "GOrganizationName"){
                document.reportForm.order2.selectedIndex = 0;
            }
            if(document.reportForm.order3.options[document.reportForm.order3.selectedIndex].value == "GOrganizationName"){
                document.reportForm.order3.selectedIndex = 0;
            }
        }
        return;
    }
	
	//Get Cookie value by key name
	function getCookie(name) {
	  var value = "; " + document.cookie;
	  var parts = value.split("; " + name + "=");
	  if (parts.length == 2) return parts.pop().split(";").shift();
	}

    function newSelect(vID)
    {
       frames[0].location.replace("/loginstatline/parameters/organizationList.sls?ReportGroupID=" + vID);
    }

    function clickShow()
    {

    if (document.reportForm.referralNumber.value != "")
            {
            clickFind();
            return;
        }

    var url = ""
    var reportvalue = ""
    var reportfile = ""
    var reportid = ""
    var pipeIndex = 0
    var pipeIndex2 = 0
    var optionString = ""
    var orderby = ""

    optionString = getOptions()

    reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value

    pipeIndex = reportvalue.indexOf("|",0)
    pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)

    reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2)
    reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length)


    if     (document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value != "0")
        {
            orderby = document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value
        }


    if     (document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value != "0")
        {
            if(document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value == document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value)
                {
                    alert ("Duplicate Sort Order. Please select a unique sort order.")
                    document.reportForm.order2.focus()
                    return
                }
            if(document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value != "0")
                {
                    orderby = orderby + ", " + document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value
                }
            if(document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value == "0")
                {
                    orderby = orderby + document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value
                }
        }

    if     (document.reportForm.order3.options[document.reportForm.order3.selectedIndex].value != "0")
        {
            if(document.reportForm.order3.options[document.reportForm.order3.selectedIndex].value == document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value)
                {
                    alert ("Dulpicate Sort Order. Please select a unique sort order.")
                    document.reportForm.order3.focus()
                    return
                }
            if(document.reportForm.order3.options[document.reportForm.order3.selectedIndex].value == document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value)
                {
                    alert ("Dulpicate Sort Order. Please select a unique sort order.")
                    document.reportForm.order3.focus()
                    return
                }
            if(document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value != "0" ||
            document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value != "0")
                {
                    orderby = orderby + ", " + document.reportForm.order3.options[document.reportForm.order3.selectedIndex].value
                }
            else
                orderby = orderby + document.reportForm.order3.options[document.reportForm.order3.selectedIndex].value
        }



    if (validate())
        {
        url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
        url = url + reportfile
        url = url + "StartDate=" + document.reportForm.startDate.value + "_" + document.reportForm.startTime.value
        url = url + "&EndDate=" + document.reportForm.toDate.value + "_" + document.reportForm.toTime.value
        url = url + "&ReportGroupID=" + document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value

        if (document.reportForm.MSBrowser.value == 'True')
            {
            url = url + "&OrgID=" + frames[0].organization.options[frames[0].organization.selectedIndex].value
            }

        if (document.reportForm.MSBrowser.value == 'False')
            {
            url = url + "&OrgID=" + document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value
            }

        url = url + "&ReferralType=" + document.reportForm.type.options[document.reportForm.type.selectedIndex].value
        url = url + "&userID=" + document.reportForm.userID.value
        url = url + "&userOrgID=" + document.reportForm.userOrgID.value
        url = url + "&OrderBy=" + orderby
        url = url + "&DSN=" + document.reportForm.datasource.value
        url = url + "&Options=" + optionString
        url = url + "&ReportID=" + reportid

        //document.write(url)

        window.open(url,'_blank','toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1')

        return
        }

    return

    }



    function clickGroup()
    {

    if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0)
        {
            alert ("Please select a report group.")
            document.reportForm.reportGroup.focus()
            return
        }

    var url = ""

    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reports/admin/GetOrgList.sls"
    url = url + "?ReportGroupID=" + document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value
    url = url + "&DSN=" + document.reportForm.datasource.value
    window.open(url,"_blank",'toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1')

    return

    }
    function clickPerson()
    {

    if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0)
        {
            alert ("Please select a report group.")
            document.reportForm.reportGroup.focus()
            return
        }
if (frames[0].organization.options[frames[0].organization.selectedIndex].value == 0)
        {
            alert ("Please select an organization.")
            document.reportForm.reportGroup.focus()
            return
        }

    var url = ""

    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/GetPersonList.sls"
    url = url + "?ReportGroupID=" + document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value
    url = url + "&OrgID=" + frames[0].organization.options[frames[0].organization.selectedIndex].value
    window.open(url,"_blank",'toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1')

    return

    }

    //Original clickFind function copied from 05/11/00 version.
    function clickFind()
    {
    var reportvalue = ""
    var reportfile = ""
    var reportid = ""
    var pipeIndex = 0
    var pipeIndex2 = 0

    reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value
    pipeIndex = reportvalue.indexOf("|",0)
    pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)
    reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2)
    reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length)

    var url = ""
    var callValue = ""
    var callId = ""
    var dashIndex = 0
    var optionString = ""

    optionString = getOptions()

    callValue = document.reportForm.referralNumber.value
    dashIndex = callValue.indexOf("-",0)
    callId = callValue.substring(dashIndex + 1,callValue.length)

    if (!isInteger(callId))
        {
            alert ("The referral number is invalid.")
            document.reportForm.referralNumber.focus()
            document.reportForm.referralNumber.select()
            return
        }

    if (reportid == 120 || reportid == 131 || reportid == 194)
        {
        url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
        url = url + reportfile.replace("?","");
        }
    else
        {
        url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reports/referral/detail_1.sls"

        }


    url = url + "?CallID=" + callId
    url = url + "&ReportGroupID=" + document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value
    url = url + "&userID=" + document.reportForm.userID.value
    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
    url = url + "&DSN=" + document.reportForm.datasource.value
    url = url + "&Options=" + optionString

    window.open(url,"_blank",'toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1')

    return

    }

    //renamed clickFind2 (ttw) 10/05/00 - caused problems with forms.
    //not documented changes between 5/11/00 - 08/01/00
    function clickFind2()
    {

    var url = ""
    var callValue = ""
    var callId = ""
    var dashIndex = 0
    var optionString = ""
    var reportfile = ""
    var reportid = ""
    var pipeIndex = 0
    var pipeIndex2 = 0

    optionString = getOptions()

    reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value

    pipeIndex = reportvalue.indexOf("|",0)
    pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)

    reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2)
    reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length)

    callValue = document.reportForm.referralNumber.value
    dashIndex = callValue.indexOf("-",0)
    callId = callValue.substring(dashIndex + 1,callValue.length)

    if (!isInteger(callId))
        {
            alert ("The referral number is invalid.")
            document.reportForm.referralNumber.focus()
            document.reportForm.referralNumber.select()
            return
        }

    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
    url = url + reportfile
    url = url + "CallID=" + callId
    url = url + "&userID=" + document.reportForm.userID.value
    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
    url = url + "&DSN=" + document.reportForm.datasource.value
    url = url + "&Options=" + optionString
    //document.write('Find ' + url)

    window.open(url,"_blank",'toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1')

    return

    }

    function clickDesc()
    {

    if (document.reportForm.report.options[document.reportForm.report.selectedIndex].value == 0)
        {
            alert ("Please select a report.")
            document.reportForm.report.focus()
            return
        }

    var url = ""
    var reportvalue = ""
    var reportdescfile = ""
    var pipeIndex = 0

    reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value
    pipeIndex = reportvalue.indexOf("|",0)
    reportdescfile = reportvalue.substring(0,pipeIndex)

    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reportdesc/" + reportdescfile
    window.open(url,"_blank",'toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1')

    return

    }


    function validate()
    {

    var url = ""
    var location = ""
    var errorNumber = ""
    var errorDescription = ""
    var reportURL = ""
    var reportvalue = ""
    var pipeIndex = 0

    reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value
    pipeIndex = reportvalue.indexOf("|",0)
    reportURL = reportvalue.substring(pipeIndex + 1,reportvalue.length)


    if (!isDate(document.reportForm.startDate.value))
        {
            alert ("Date error. Please enter a date in the format of mm/dd/yy.")
            document.reportForm.startDate.focus()
            document.reportForm.startDate.select()
            return false
        }
    if (!isTime(document.reportForm.startTime.value))
        {
            alert ("Time error. Please enter a time in the format of hh:mm.")
            document.reportForm.startTime.focus()
            document.reportForm.startTime.select()
            return false
        }
    if (!isDate(document.reportForm.toDate.value))
        {
            alert ("Date error. Please enter a date in the format of mm/dd/yy.")
            document.reportForm.toDate.focus()
            document.reportForm.toDate.select()
            return false
        }
    if (!isTime(document.reportForm.toTime.value))
        {

            alert ("Time error. Please enter a time in the format of hh:mm.")
            document.reportForm.toTime.focus()
            document.reportForm.toTime.select()
            return false
        }

    if (document.reportForm.report.selectedIndex == 0)
        {
            alert ("Please select a report.")
            document.reportForm.report.focus()
            return false
        }

    if (document.reportForm.MSBrowser.value == 'True')
        {
        if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0
            && frames[0].organization.options[frames[0].organization.selectedIndex].value == 0)
            {
            alert ("Please select either a report group or an organization.")
            return false
            }
        }
    else
        {
        if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0
            && document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value == 0)
            {
            alert ("Please select either a report group or an organization.")
            return false
            }
        }

    return true

    }



function getOptions()
{
    var optionString = ""

    if (document.reportForm.option1.checked)
        optionString = optionString + "1"
    else
        optionString = optionString + "0"


    return optionString;
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


// ****************************************************
// This section begins the date/time validation section
// ****************************************************

</script>

<!--#include virtual="/loginstatline/includes/datevalidation.js"-->



