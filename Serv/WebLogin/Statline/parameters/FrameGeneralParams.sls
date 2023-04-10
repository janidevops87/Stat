
<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim pvStartDate
Dim pvEndDate
Dim RS1
Dim ReportListIndex
Dim i
Dim vErrorMsg
Dim ErrorReturn
Dim cmd
Dim Temp
Dim MSBrowser
Dim BrowserUA
Dim MasterReportGroupID
Dim ReportParameter

'Get the browser type
MSBrowser = false
BrowserUA = Request.ServerVariables("HTTP_USER_AGENT")

Temp = InStr(1, BrowserUA, "MSIE")
If Temp > 0 Then
    MSBrowser = true
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

<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>Parameters</title>

</head>

<body bgcolor="#F5EBDD" text="BLACK" onload="document.reportForm.report.focus()">

<form name="reportForm">
  <input type="hidden" name="serverName" value="<%=Request.ServerVariables("SERVER_NAME")%>">
  <input type="hidden" name="userID" value="<%=UserID%>">
  <input type="hidden" name="userOrgID" value="<%=UserOrgID%>">
  <input type="hidden" name="datasource" value="<%=DataSourceName%>">
  <input type="hidden" name="MSBrowser" value="<%=MSBrowser%>">

 <%
   Set RS = Server.CreateObject("ADODB.Recordset")
   Set cmd = Server.CreateObject("ADODB.Command")
   cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
   cmd.CommandText = "SPS_ReportList"
   cmd.CommandType = adCmdStoredProc
   cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
   cmd.Parameters.Append cmd.CreateParameter("@ReportTypeID", adInteger, adParamInput)
   cmd.Parameters.Append cmd.CreateParameter("@UserOrgID", adInteger, adParamInput)
   cmd.Parameters.Append cmd.CreateParameter("@UserID", adInteger, adParamInput)
   cmd.Parameters("@ReportTypeID").Value = 5
   cmd.Parameters("@UserOrgID").Value = UserOrgID
   cmd.Parameters("@UserID").Value = UserID
   Set RS = cmd.Execute
  %>
  <input type="hidden" name="ReportID" value="<%Do While NOT RS.EOF%>ReportID<%=RS("ReportID")%><%=RS("ReportFromDate")%><%=RS("ReportToDate") %><%=RS("ReportGroup") %><%=RS("ReportOrganization")%>E<%RS.MoveNext%><% Loop %>">
  <%

    'Set RS = Nothing
 'End IF
 
  %>


<!-- Information Notice--->
  <table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
    width="550" bgColor="#112084">
    <tr>
        <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;General</b></font></td>
    </tr>
  </table>

<p>&nbsp;</p>


<!--Get the list of reports -->
<%
'Get the report list
'vQuery = "SELECT ReportID, ReportDisplayName, ReportVirtualUrl, ReportDescFileName FROM Report WHERE ReportTypeID = 5 "
'If UserOrgID <> 194 Then
'    vQuery = vQuery & "AND ReportLocalOnly = 0 ORDER BY ReportDisplayName"
'Else
'    vQuery = vQuery & "ORDER BY ReportDisplayName"
'End If

Set RS = cmd.Execute

%>

  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font face="Arial" size="2"><b>Report</b></font></td>
      <td valign="center">
      <%
      	
      %>
        <select name="report" ONCHANGE="reportOnChange();" size="1">
        <option value selected></option>
        <%
        if RS.EOF Then
        	Response.Write("EOF")
        end if
        Do While Not RS.EOF
        %>
        Response.Write(RS.EOF) 
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
      <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="<%=FormatDateTime(Date-1,vbShortDate)%>" size="9" name="startDate" maxlength="10"> </td>
      <td valign="center" align="left"><font face="Arial" size="2"><b>Time</b></font></td>
      <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="00:00" size="7" name="startTime" maxlength="5"> </td>
    </tr>
    <tr>
      <td valign="center"><font size="2" face="Arial"><b>To Date</b></font></td>
      <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="<%=FormatDateTime(Date,vbShortDate)%>" size="9" name="toDate" maxlength="10"> </td>
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
        <%If MSBrowser = "True" Then%>onChange="newSelect(this.options[this.selectedIndex].value);"<%End If%> size=0>

        <option value="0" selected></option>

        <%Do While Not RS.EOF%>
            <option value="<%=RS("WebReportGroupID")%>"><%=RS("ReportGroupName")%></option>
            <%RS.MoveNext%>
        <%
        Loop
        Set RS = Nothing
        %>
        </select>
      </td>
      <!-- Removed 6/29/99 - Bret Knoll
      <td>
            <A href="javascript:clickGroup()">
          <IMG SRC="/loginstatline/images/ellipses2.gif" NAME="groupMembers" BORDER="0"></A></td>
      </tr>
      -->
</table>

<table cellPadding="0" cellSpacing="2">
<%
'Organization Box. Check for browser type
If MSBrowser = true Then
%>
    <!-- Organization Box Get the Children for this Box -->
    <tr>
      <td width="95" valign="center"><font size="2" face="Arial"><b>Organization</b></font></td>
      <td colspan="3">
        <iframe height=25 width=447 name="OrgFrame" Frameborder=0 MarginHeight=0 Marginwidth=0 Scrolling="no"
                src="/loginstatline/parameters/organizationList.sls?ReportGroupID=<%=MasterReportGroupID%>">
        </iframe>
      </td>
    </tr>
<%
Else
    'Get the organization list
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

<%
End Function

Set Conn = Nothing
%>



<script language="JavaScript">
    var intOrgDisabled  = -1

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

    function newSelect(vID)
    {

       frames[0].location.replace("/loginstatline/parameters/organizationList.sls?ReportGroupID=" + vID);
       reportOnChange();


    }
    function clickShow()
    {

    var url = ""
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
            url = url + "&userID=" + document.reportForm.userID.value
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value
            url = url + "&DSN=" + document.reportForm.datasource.value
            url = url + "&ReportID=" + reportid

            window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

            return

        }

    return

    }

    function clickGroup()
    {

    if (document.reportForm.reportGroup.selectedIndex == 0)
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


    function clickDesc()
    {

    if (document.reportForm.report.selectedIndex == 0)
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
    window.open(url,"_blank",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1')

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
    //check startdate, starttime, enddate, endtime
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
    */
    if ((       reportURL.indexOf("CallInfo",0) == -1
        && reportURL.indexOf("CallHoldTimes",0) == -1
        && reportURL.indexOf("CallVol",0) == -1
        && reportURL.indexOf("PageResponse",0) == -1
        && reportURL.indexOf("NoMasterGroup",0) == -1)
        && (!document.reportForm.reportGroup.disabled
        && document.reportForm.reportGroup.selectedIndex == 0)
        )

        {

            alert ("Please select a report group.")
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
    return true

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

<!--#include virtual="/loginstatline/includes/datevalidation.js"-->