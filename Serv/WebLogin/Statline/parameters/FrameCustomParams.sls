<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim cmd
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
   cmd.Parameters("@ReportTypeID").Value = 6
   cmd.Parameters("@UserOrgID").Value = UserOrgID
   cmd.Parameters("@UserID").Value = UserID
   Set RS = cmd.Execute
If RS.EOF Then
    Set RS = Nothing
%>
    <body bgcolor="#F5EBDD" text="BLACK">

    <table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px" width="550" bgColor="#112084">
        <tr>
            <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Custom Report</b></font></td>
        </tr>
    </table>

    <p>&nbsp;</p>

    <H3> No Custom Reports Available</H3>
    </body>
    </html>
<%
    Exit Function
End If
%>

<body bgcolor="#F5EBDD" text="BLACK">

<form name="reportForm">
  <input type="hidden" name="serverName" value="<%=Request.ServerVariables("SERVER_NAME")%>">
  <input type="hidden" name="userID" value="<%=UserID%>">
  <input type="hidden" name="userOrgID" value="<%=UserOrgID%>">
  <input type="hidden" name="datasource" value="<%=DataSourceName%>">
  <input type="hidden" name="MSBrowser" value="<%=MSBrowser%>">

 <%
 'IF MSBrowser = "True" Then
      'Get the report parameters list and send it to JavaScript to create a client side array
    vQuery = "sps_ReportParameters " & 6
    'Response.Write vQuery
    Set RS1 = Conn.Execute(vQuery)
    'Call createReportParameterArray(RS)

  %>
  <input type="hidden" name="ReportID" value="<%Do While NOT RS1.EOF%>ReportID<%=RS1("ReportID")%><%=RS1("ReportFromDate")%><%=RS1("ReportToDate") %><%=RS1("ReportGroup") %><%=RS1("ReportOrganization")%>E<%RS1.MoveNext%><% Loop %>">
  <%

    Set RS1 = Nothing
 'End IF
  %>

<!-- Information Notice--->
  <table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
    width="550" bgColor="#112084">
    <tr>
        <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Custom Report</b></font></td>
    </tr>
  </table>

  <p>&nbsp;</p>

  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font face="Arial" size="2"><b>Report</b></font></td>
      <td valign="center">
              <select name="report" <%'If MSBrowser = "True" Then%>ONCHANGE="ReportSelect();"<%'End If%> size="1">
        <option value="0"  selected></option>
        <%
        Do While Not RS.EOF
        %>
            <%'Response.Write("Count" & ReportDescFileName)%>
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
      <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="<%=FormatDateTime(Now-1, vbShortDate)%>" size="9" name="startDate" maxlength="10"> </td>
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
Set RS = Conn.Execute(vQuery)
%>

<table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>Report Group</b></font></td>
      <td valign="center">
        <select name="reportGroup"

        <%If MSBrowser = "True" Then%>onChange="newSelect(this.options[this.selectedIndex].value);"<%End If%>>

        <!-- MJH 08/28/03 - Modified code to add an empty select for all users, not just 194.  Also, pre-select the first non-empty option.-->
        <!--<%'If UserOrgID = 194 or RS.EOF Then%><option value="0" selected>&nbsp;</option><%'End If%>-->
        <option value="0" >&nbsp;</option>

        <%
        'MJH 08/28/03 - Count recCount and preselect only the first one. if
        Dim recCount
        recCount = 0
        %>

        <%Do While Not RS.EOF%>
            <%recCount = recCount + 1%>
            <option value="<%=RS("WebReportGroupID")%>" <%If UserOrgID <>  194 and recCount = 1 then response.write "selected" End If%>><%=RS("ReportGroupName")%></option>
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
        <iframe height=25 width=415 name="OrgFrame" Frameborder=0 MarginHeight=0 Marginwidth=0 Scrolling="no"
            src="/loginstatline/parameters/organizationList.sls?ReportGroupID=<%=MasterReportGroupID%>">
        </iframe>
      </td>
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
        <select name="organization">
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
            <%If ReferralTypeList(2,i) = 1 Then%>
                <option value="<%=ReferralTypeList(0,i)%>"><%=ReferralTypeList(1,i)%></option>
            <%End If%>
        <%Next%>

        </select>
     </td>
   </tr>
</table>

<!-- Set the Sort Order Options-->
  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td width="95"><font size="2" face="Arial"><b>Sort Order</b></font></td>
      <td colspan="1"><select name="order1" size="1">
        <option value="0" selected></option>
        <option value="CallDateTime">Date</option>
        <option value="OrganizationName">Organization</option>
        <option value="Referral.ReferralTypeID">Referral Type</option>
      </select> </td>
      <td colspan="1"><select name="order2" size="1">
        <option value="0" selected></option>
        <option value="CallDateTime">Date</option>
        <option value="OrganizationName">Organization</option>
        <option value="Referral.ReferralTypeID">Referral Type</option>
      </select> </td>
      <td colspan="1"><select name="order3" size="1">
        <option value="0" selected></option>
        <option value="CallDateTime">Date</option>
        <option value="OrganizationName">Organization</option>
        <option value="Referral.ReferralTypeID">Referral Type</option>
      </select> </td>
    </tr>
  </table>

  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td width="95"><font size="2" face="Arial"><b>Options</b></font></td>
      <td><input type="checkbox" name="option1" value="ON"><small>No Patient Name /
      Med Rec. Num </small></td>
<%        If UserOrgId=194 then%>
        <td width="20">&nbsp;</td>
        <td><font size="2" face="Arial"><b>Referral #&nbsp;</b></font></td>
        <td><font face="Arial"><input value="" size="10" name="referralNumber" maxlength="10"></font></td>
<%        Else%>
        <td><input type="hidden" name="referralNumber" value=""></td>
<%        End If%>
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

      </tr>
    </table>

</form>
</body>
</html>

<%End Function%>



<script language="JavaScript">
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

        /* Determinie what report was selected */
        var intSelectedID = "ReportID" + reportid;

        /* Build Parameter HTML strings            */

        //this portion of the code pulls the parameter options for the report.
        //values are start and end date time, report Group and organization.
        var pipeIndex = 0;
        var pipeIndex2 = 0;
        var strReportSub =  document.reportForm.ReportID.value;
        pipeIndex = strReportSub.indexOf(intSelectedID,0);
        pipeIndex2 = strReportSub.indexOf("E",pipeIndex + 1);
        var strReportParams = strReportSub.slice(pipeIndex +  intSelectedID.length, pipeIndex2);



        /* Enable and disable parameters according to report selected */
        document.reportForm.startDate.disabled =  strReportParams.substr(0,1)/1;
        document.reportForm.startTime.disabled = strReportParams.substr(0,1)/1;
        document.reportForm.toDate.disabled = strReportParams.substr(1,1)/1;
        document.reportForm.toTime.disabled = strReportParams.substr(1,1)/1;
        document.reportForm.reportGroup.disabled = strReportParams.substr(2,1)/1;
        intOrgDisabled = strReportParams.substr(3,1)/1;

        /*    Check if parameter for Organization list is 0. If 0 generate the list based on the
            Report Group. If 1 do nothing.
            1/7/01 BJK: Changed: Previous code populated Organization list if the Organization Parameter
            was 0. In addition if Organization was 0 Organization was required. I change the code so it checks
            if the value is not equal 1 it grabs the Organization list.  With this if the value is 0 Organization
            is populated and required. If the value is 1 the Organization is not populated. If the value is 2
            Organization is populated but not required. This was change was added to account for Page Response Report
            changes where the client wanted to select Page Response by Report Group alone or with Organization.

        */
        if (strReportParams.substr(3,1) != 1)
        {


            frames[0].location.replace("/loginstatline/parameters/organizationList.sls?ReportGroupID=" + document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value);
        }
        else
        {
            frames[0].location.replace("/loginstatline/parameters/organizationList.sls?ReportGroupID=" + 0);
        }


    }
    function ReportSelect()
    {
        var pipeIndex = 0
        var pipeIndex2 = 0
        var reportvalue = ""

        optionString = getOptions()
        reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value

        pipeIndex = reportvalue.indexOf("|",0)
        pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)

        reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length)
        reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2)


        if (reportid == 70)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
            url = url + reportfile
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&DSN=" + document.reportForm.datasource.value
            url = url + "&Options=" + optionString
            url = url + "&ReportID=" + reportid

            window.open(url,'_blank','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 73)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/OrganizationParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=73"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 75)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/OrganizationParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=75"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 76)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/OrganizationParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=76"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 80)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/AlertParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=80"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 82)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/PersonListParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=82"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 86)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/AssignmentParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=86"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 87)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/AssignmentParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=87"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }

        if (reportid == 88)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/AlertCriteriaParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=88"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 129)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/AssignmentParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=129"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 137)
                {

                    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/AssignmentParams.sls?"
                    url = url + "userID=" + document.reportForm.userID.value
                    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
                    url = url + "&ReportID=137"
                    url = url + "&RegistryDSN=DMV_CO"

                    window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 142)
                {

                    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/AssignmentParams.sls?"
                    url = url + "userID=" + document.reportForm.userID.value
                    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
                    url = url + "&ReportID=142"
                    url = url + "&RegistryDSN=DMV_NE"

                    window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 147)
                {

                    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/AssignmentParams.sls?"
                    url = url + "userID=" + document.reportForm.userID.value
                    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
                    url = url + "&ReportID=147"
                    url = url + "&RegistryDSN=DMV_TA"

                    window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 149)
                {

                    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/CMSParams.sls?"
                    url = url + "userID=" + document.reportForm.userID.value
                    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
                    url = url + "&ReportID=149"

                    window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (document.reportForm.report.options[document.reportForm.report.selectedIndex].text.substring(0,9) == "CONTRACTS")
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
            url = url + reportfile
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=" + reportid
            //confirm(String(reportfile));
            //confirm(String(reportfile).indexOf(String("CONTRACTS_AffiliatedHospitals"),0));

            if (String(reportfile).indexOf(String("CONTRACTS_AffiliatedHospitals"),0) < 1)
            {
            window.open(url,'CONTRACTS','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
            }

        }

        if (reportid == 150)
                {

                    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
                    url = url + reportfile
                    url = url + "userID=" + document.reportForm.userID.value
                    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
                    url = url + "&DSN=" + document.reportForm.datasource.value
                    url = url + "&Options=" + optionString
                    url = url + "&ReportID=" + reportid

                    window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        //removed hospital referral
        //if (reportid == 154)
        //                {
        //                    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/HospitalReferralDetailParams.sls?"
        //                    url = url + "userID=" + document.reportForm.userID.value
        //                    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
        //                    url = url + "&ReportID=154"
        //                    url = url + "&ReportGroupID=" + <%=request("ReportGroupID")%>
        //
        //                    window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        //}
        if (reportid == 155)
                                {

                                    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/ReferralOverviewParams.sls?"
                                    url = url + "userID=" + document.reportForm.userID.value
                                    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
                                    url = url + "&ReportID=155"
                                    url = url + "&ReportGroupID=" + <%=request("ReportGroupID")%>

                                    window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 156)
                                {

                                    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/ApproachPersonConsentParams.sls?"
                                    url = url + "userID=" + document.reportForm.userID.value
                                    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
                                    url = url + "&ReportID=156"
                                    url = url + "&ReportGroupID=" + <%=request("ReportGroupID")%>

                                    window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }


        //MH 08/15/2003
        //Added for UNOS Report (development reportID=167).
        if (reportid == 167)
        {
            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/UNOSParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=167"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        //MH 08/18/2003
        //Added for Clinical Triggers Report (development reportID=169).
        if (reportid == 169)
        {
            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/ClinicalTriggersParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=169"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }

        if (reportid == 171)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/ReasonSummaryParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=171"
            url = url + "&ReportGroupID=" + <%=request("ReportGroupID")%>

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }

        if (reportid == 172)
                                        {

                                            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/ReferralAnalysisParams.sls?"
                                            url = url + "userID=" + document.reportForm.userID.value
                                            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
                                            url = url + "&ReportID=172"
                                            url = url + "&ReportGroupID=" + <%=request("ReportGroupID")%>

                                            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }

        //MDS 11/04/2003
        //Added for Coalition Call Count Summary Report (development reportID=173).
        if (reportid == 173)
        {
            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/CoalitionCallCountParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=173"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }

        //MDS 11/05/2003
        //Added for Coalition Call Count by Day Summary Report (development reportID=174).
        if (reportid == 174)
        {
            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/CoalitionCallCountByDayParams.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=174"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }
        if (reportid == 187)
        {

            url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reports/custom/AlphaPagerMonitor.sls?"
            url = url + "userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&ReportID=187"

            window.open(url,'main','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
        }        
  
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
        reportOnChange();
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

    //if (document.reportForm.referralNumber.value != "")
    //    {
    //    clickFind();
    //    return;
    //    }

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

    if (reportid == 70)
        {
            ReportSelect()
            return
        }
    if     (document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value != "0")
        {
            orderby = document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value
        }


    if     (document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value != "0")
        {
            if(document.reportForm.order2.options[document.reportForm.order2.selectedIndex].value == document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value)
                {
                    alert ("Dulpicate Sort Order. Please select a unique sort order.")
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
        if (document.reportForm.referralNumber.value != "")
        {
            url = url + "&ReferralNumber=" + document.reportForm.referralNumber.value
        }

        url = url + "&ReferralType=" + document.reportForm.type.options[document.reportForm.type.selectedIndex].value
        url = url + "&userID=" + document.reportForm.userID.value
        url = url + "&userOrgID=" + document.reportForm.userOrgID.value
        url = url + "&OrderBy=" + orderby
        url = url + "&DSN=" + document.reportForm.datasource.value
        url = url + "&Options=" + optionString

        //==================================================================
        //MH 8/21/03
        if (reportid == 170)    //(ECD Form A)
        {
            //This Querystring is used for displaying the Referral Summary Report with ECD parameters.
            url = url + "&ReportID=11&NoLog=1&JOIN=_JOIN__CallCustomField_ON_CallCustomField.CallID=_Call.CallID&AND=_AND_CallCustomField.CallCustomField11='Yes'_AND_Referral.ReferralDonorAge_Between_50_AND_80_AND_Referral.ReferralDonorAgeUnit='Years'_AND_Referral.ReferralOrganConversionID_<>_1";
        }
        else
        {
            //All reports except the ECD report, which displays the Referral Summary report.
            url = url + "&ReportID=" + reportid

        }
        //==================================================================



        //put check for hospital referral detail and add callid
        //alert(document.reportForm.referralNumber.value);
        if (reportid == 154)
        {
            if (document.reportForm.referralNumber.value != "")
            {

                url = url + "&Callid=" + document.reportForm.referralNumber.value;
            }
        }

        window.open(url,'_blank','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

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
    window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

    return

    }

    function clickFind()
    {

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

    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reports/referral/detail_1.sls"
    url = url + "?CallID=" + callId
    url = url + "&userID=" + document.reportForm.userID.value
    url = url + "&userOrgID=" + document.reportForm.userOrgID.value
    url = url + "&DSN=" + document.reportForm.datasource.value
    url = url + "&Options=" + optionString

    window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

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
    window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

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
    if (document.reportForm.report.options[document.reportForm.report.selectedIndex].text.substring(0,9) == "CONTRACTS")
        {
            return true
        }

    if (document.reportForm.referralNumber.value != "")
    {
        return true;
    }
    else
        {
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
            /*
            bjk 02/26/2002:
            added check for report group disabled. If report group is disabled it is not
            required. if the value is not required but it is optional the catch is hard coded
            with the indexOf statments.
            TODO: change to a single bit wise value for each of the parameters. create values for
            Optional, Required, and not required for each of; StartDate, StartTime, ToDate, ToTime, ReportGroupID
            OrganizationID

            bjk 02/26/2002:
            removing: not used
            reportURL.indexOf("import",0) == -1
            && reportURL.indexOf("message",0) == -1

            drh 02/28/03 - Added && document.reportForm.report.options[document.reportForm.report.selectedIndex].value != "OrgPerson.shm|/reports/custom/GetOrganizationPersonList.sls?|132")
            because "All Referrals" is a valid report group for that report
            */
            if ((       reportURL.indexOf("CallInfo",0) == -1
                && reportURL.indexOf("CallHoldTimes",0) == -1
                && reportURL.indexOf("CallVol",0) == -1
                && reportURL.indexOf("PageResponse",0) == -1
                && reportURL.indexOf("NoMasterGroup",0) == -1
                && reportURL.indexOf("ReferralComp_CTDN",0) == -1)
                && (!document.reportForm.reportGroup.disabled
                && document.reportForm.reportGroup.selectedIndex == 0
                && document.reportForm.report.options[document.reportForm.report.selectedIndex].value != "OrgPerson.shm|/reports/custom/GetOrganizationPersonList.sls?|132")
                )

                {

                    alert ("Please select a report group.")
                    //alert(document.reportForm.report.options[document.reportForm.report.selectedIndex].value)
                    document.reportForm.reportGroup.focus()
                    return false
                }
            if (document.reportForm.MSBrowser.value == 'True')
                {
                if (intOrgDisabled == 0 && frames[0].organization.options[frames[0].organization.selectedIndex].value < 1 )
                    {
                        alert ("Please select an organization")
                        frames[0].organization.focus()
                        return false
                    }
                }
            if (document.reportForm.MSBrowser.value == 'False')
                {
                if (intOrgDisabled == 0 && document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value == 0)
                    {
                        alert ("Please select an organization")
                        document.reportForm.organizations.focus()
                        return false
                    }
                }
            /*
            if (document.reportForm.MSBrowser.value == 'True')
                {
                if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0
                    && frames[0].organization.options[frames[0].organization.selectedIndex].value == 0
                    && reportURL.indexOf("RegistryLookup",0) == -1)
                    {
                    alert ("Please select either a report group or an organization.")
                    return false
                    }
                }
            else
                {
                if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0
                    && document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value == 0
                    && reportURL.indexOf("RegistryLookup",0) == -1)
                    {
                    alert ("Please select either a report group or an organization.")
                    return false
                    }
                }
            */
            return true

            }
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




// ****************************************************
// This section begins the date/time validation section
// ****************************************************

</script>

<!--#include virtual="/loginstatline/includes/datevalidation.js"-->



