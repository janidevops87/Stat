
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
Dim MaxReferralTypeID
Dim ReportListIndex
Dim v
Dim i
Dim vErrorMsg
Dim ErrorReturn
Dim cmd
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
%>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>Parameters</title>
</head>


<body bgcolor="#F5EBDD" onload="document.reportForm.report.focus()">

<form name="reportForm">
  <input type="hidden" name="serverName" value="<%=Request.ServerVariables("SERVER_NAME")%>">
  <input type="hidden" name="userID" value="<%=UserID%>">
  <input type="hidden" name="userOrgID" value="<%=UserOrgID%>">
  <input type="hidden" name="datasource" value="<%=DataSourceName%>">

<!-- Information Notice--->
  <table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
    width="550" bgColor="#112084">
    <tr>
        <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Messages</b></font></td>
    </tr>
  </table>

<p>&nbsp;</p>
<!--Get the list of reports -->
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
   cmd.Parameters("@ReportTypeID").Value = 2
   cmd.Parameters("@UserOrgID").Value = UserOrgID
   cmd.Parameters("@UserID").Value = UserID
   Set RS = cmd.Execute
%>

  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font face="Arial" size="2"><b>Report</b></font></td>
      <td valign="center">
        <select name="report" ONCHANGE="reportOnChange();" size="1">
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
      <A href="javascript:clickDesc();">
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

<!-- Set the Sort Order Options-->
  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td width="95"><font size="2" face="Arial"><b>Sort Order</b></font></td>
      <td colspan="1"><select name="order1">
        <option value="CallDateTime">Date</option>
        <option value="PersonLast" selected>Last Name</option>
      </select> </td>
    </tr>
  </table>

 <HR SIZE=1 width=550 align="left">

    <table cellPadding="0" cellSpacing="2">
      <tr>
        <td width="95"></td>
        <td>
    <td><a href="javascript:clickShow()"
onClick="MM_nbGroup('down','group1','Show','/loginstatline/images/Button_Show_Over.gif',1)"
onMouseOver="MM_nbGroup('over','Show','/loginstatline/images/Button_Show_Over.gif','/loginstatline/images/Button_Show_Over.gif',1)"
onMouseOut="MM_nbGroup('out')"><img src="/loginstatline/images/Button_Show.gif" alt="Show" name="Show" width="88" height="25" border="0" onload=""></a></td>        </td>
      </tr>
    </table>

</form>
</body>
</html>

<%End Function%>



<script language="JavaScript">

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
    var orderby = ""

    reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value

    pipeIndex = reportvalue.indexOf("|",0)
    pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)

    reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2)
    reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length)

    if     (document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value != "0")
        {
            orderby = document.reportForm.order1.options[document.reportForm.order1.selectedIndex].value
        }

    if (validate())
        {
        url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
        url = url + reportfile
        url = url + "StartDate=" + document.reportForm.startDate.value + "_" + document.reportForm.startTime.value
        url = url + "&EndDate=" + document.reportForm.toDate.value + "_" + document.reportForm.toTime.value
        url = url + "&userID=" + document.reportForm.userID.value
        url = url + "&userOrgID=" + document.reportForm.userOrgID.value
        url = url + "&OrderBy=" + orderby
        url = url + "&DSN=" + document.reportForm.datasource.value
        url = url + "&ReportID=" + reportid

        window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

        return
        }

    return

    }

    function clickDesc()
    {

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