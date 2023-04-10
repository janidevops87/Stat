<html>

<head>
<title></title>
</head>

<body bgcolor="#F5EBDD">
<!-- Include any files here Response.Write("All Times " & ZoneName(vTZ)) -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<table width="100%">
  <tr valign="TOP">
    <td width="100%" valign="TOP"><table width="100%">
      <tr>
        <td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
        <td width="50%" valign="CENTER"><b><font size="5" face="Arial Black">Import Activity<br>
        <font size="4" face="<%=FontNameHead%>"><%=vReportTitle%></font></font></td>
        </b><td valign="CENTER"><font size="3" face="<%=FontNameHead%>"><b>Period:&nbsp;</b> <font
        size="2" face="<%=FontNameData%>"><%=pvStartDate%>&nbsp; &nbsp; <font size="3" face="<%=FontNameHead%>"><b>To:&nbsp;
        &nbsp;</b> <font size="2" face="<%=FontNameData%>"><%=pvEndDate%><br>
        <font size="2" face="<%=FontNameData%>">
			<%	Response.Write("All Times " & ZoneName(TZ)) %>
		</font></font></font></font></font></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
