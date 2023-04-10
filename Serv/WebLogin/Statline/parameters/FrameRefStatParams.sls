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
Dim CurrentMonth
Dim CurrentYear
Dim vErrorMsg
Dim ErrorReturn

'Get the current month and year
CurrentMonth = Month(now())
CurrentYear = Year(now())

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
<title>Parameters</title>
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
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
        <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Referral Statistics</b></font></td>
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
   cmd.Parameters("@ReportTypeID").Value = 4
   cmd.Parameters("@UserOrgID").Value = UserOrgID
   cmd.Parameters("@UserID").Value = UserID
   Set RS = cmd.Execute

%>

  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font face="Arial" size="2"><b>Report</b></font></td>
      <td valign="center">
        <select name="report" size="1" onChange="toggleBreakOnOrgID(this.options[this.selectedIndex].value);">
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
      <td valign="center" width="95"><font size="2" face="Arial"><b>From Month</b></font></td>
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
      <td valign="center" align="left"><font face="Arial" size="2"><b>Year</b></font></td>
      <td valign="center" align="left">
         <select name="fromYear" size="1">
            <%=buildDropDownOptionYearList("1996")%>
        </select>

      </td>
    </tr>
    <tr>
      <td valign="center"><font size="2" face="Arial"><b>Thru Month</b></font></td>
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
      </td>      <td valign="center" align="left"><font face="Arial" size="2"><b>Year</b></font></td>
      <td valign="center" align="left">
        <select name="toYear" size="1">
            <%=buildDropDownOptionYearList("1996")%>
        </select>
      </td>
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

        <%If UserOrgID = 194 Then%><option value="0" selected></option><%End If%>

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

<!--
<table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>Roll-up</b></font></td>
      <td valign="center">
            <font size="2" face="Arial">
            <input type="radio" name="rollup" value=0 checked>&nbsp;Monthly
            <input type="radio" name="rollup" value=1>&nbsp;Total Only
            </font>
      </td>
    </tr>
</table>
-->
<table cellPadding="0" cellSpacing="2">
<tr>
    <td width="95"><span id="divt1" style="visibility:hidden;position:relative;top:0;left:0"><font size="2" face="Arial"><b>Options</b></font></span></td>
    <td><span id="divt2" style="visibility:hidden;position:relative;top:0;left:0"><input type="checkbox" name="BreakOnOrgID"><small>Page Break on Organization</small></span></td>
</tr>
</table>
 <HR SIZE=1 width=550 align="left">

    <table>
      <tr>
        <td width="95"></td>
    <td><a href="javascript:clickShow()" onClick="MM_nbGroup('down','group1','Show','/loginstatline/images/Button_Show_Over.gif',1)" onMouseOver="MM_nbGroup('over','Show','/loginstatline/images/Button_Show_Over.gif','/loginstatline/images/Button_Show_Over.gif',1)" onMouseOut="MM_nbGroup('out')"><img src="/loginstatline/images/Button_Show.gif" alt="Show" name="Show" width="88" height="25" border="0" onload=""></a></td>
      </tr>
    </table>


</form>
</body>
</html>

<%End Function%>



<script language="JavaScript">

  var isIE=document.all?true:false;
  var isDOM=document.getElementById?true:false;
  var isNS4=document.layers?true:false;

  function toggleBreakOnOrgID(reportval) 
  {
  
    reportvalue = reportval;
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
            url = strHttpHeader + document.reportForm.serverName.value + "/StatLine.StatTrac.Web.UI/ReportParam.aspx?";
            url = url + "userID=" + document.reportForm.userID.value;
            url = url + "&userOrgID=" + document.reportForm.userOrgID.value;
            url = url + "&ReportID=" + reportid;
			url = url + "&sid=" + getCookie("sid")

            window.open(url,'_blank','toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1');

    }
    //alert(reportid); //Turn On to get reportid
    if (reportid=='47' || reportid=='64')
    {
      document.reportForm.BreakOnOrgID.checked=false;
      toggle('divt1','s');
      toggle('divt2','s');
    }
    else
    {
      document.reportForm.BreakOnOrgID.checked=false;
      toggle('divt1','h');
      toggle('divt2','h');
    }
  }
  
  //Get Cookie value by key name
  function getCookie(name) {
	  var value = "; " + document.cookie;
	  var parts = value.split("; " + name + "=");
	  if (parts.length == 2) return parts.pop().split(";").shift();
	}

  function toggle(_w,_h) {
  
  if (isDOM)
    {
      if (_h=='s') document.getElementById(_w).style.visibility='visible';
      if (_h=='h') document.getElementById(_w).style.visibility='hidden';
    }
    else if (isIE) {
      if (_h=='s') eval("document.all."+_w+".style.visibility='visible';");
      if (_h=='h') eval("document.all."+_w+".style.visibility='hidden';");
    }
    else if(isNS4)
    {
      if (_h=='s') eval("document.layers['"+_w+"'].visibility='show';");
      if (_h=='h') eval("document.layers['"+_w+"'].visibility='hide';");
    }
  }


  function newSelect(vID)  
  {
     frames[0].location.replace("/loginstatline/parameters/organizationList.sls?ReportGroupID=" + vID);
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
  var BreakOnOrgIDString = ""
  var orderby = ""
  var fromMonth = ""
  var fromYear = ""
  var fromDate = ""
  var toMonth = ""
  var toDay = ""
  var toYear = ""
  var toDate = ""
  
  //if (document.reportForm.rollup[0].checked) {optionString="0"}
  //if (document.reportForm.rollup[1].checked) {optionString="1"}
  
  reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value
  pipeIndex = reportvalue.indexOf("|",0)
  pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)
  reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2)
  reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length)

  fromMonth = document.reportForm.fromMonth.options[document.reportForm.fromMonth.selectedIndex].value
  fromYear = document.reportForm.fromYear.options[document.reportForm.fromYear.selectedIndex].value
  fromDate = fromMonth + "/1/" + fromYear
  
  toMonth = document.reportForm.toMonth.options[document.reportForm.toMonth.selectedIndex].value
  toYear = document.reportForm.toYear.options[document.reportForm.toYear.selectedIndex].value
  
  if (toMonth == 2)
    {
    toDay = daysInFebruary(toYear)
    }
  else
    {
    toDay = daysInMonth(toMonth)
    }
    
  toDate = toMonth + "/" + toDay + "/" + toYear  
  
  if (validate()) 
    {
    url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
    url = url + reportfile
    url = url + "StartDate=" + fromDate + "_00:00"
    url = url + "&EndDate=" + toDate + "_23:59"
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
    url = url + "&Options=" + optionString
    if (document.reportForm.BreakOnOrgID.checked)
          BreakOnOrgIDString = "TRUE"
        else
          BreakOnOrgIDString = "FALSE"
        
    url = url + "&BreakOnOrgID=" + BreakOnOrgIDString
    url = url + "&ReportID=" + reportid

    window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

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