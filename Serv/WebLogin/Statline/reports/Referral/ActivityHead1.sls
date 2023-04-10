<%

%>


<html>

<head>
<title></title>
</head>

<body bgcolor="#F5EBDD">

<table width="100%">
  <tr valign="TOP">
    <td width="100%" valign="TOP"><table width="100%">
      <tr>
        <td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
        <td width="50%" valign="CENTER"><b><font size="5" face="Arial Black"><%=vMainReportTitle%><br>
        <font size="4" face="<%=FontNameHead%>"><%=vReportTitle%></font></font></td>
        </b><td valign="CENTER"><font size="3" face="<%=FontNameHead%>"><b>Period:&nbsp;</b> <font
        size="2" face="<%=FontNameData%>"><%=FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)%>&nbsp; &nbsp; <font size="3" face="<%=FontNameHead%>"><b>To:&nbsp;
        &nbsp;</b> <font size="2" face="<%=FontNameData%>"><%=FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)%><br>
        <font size="2" face="<%=FontNameData%>"><%	Select Case vTZ
						Case "PT"
							Response.Write("All Times Pacific Time")
						Case "MT"
							Response.Write("All Times Mountain Time")
						Case "CT"
							Response.Write("All Times Central Time")
						Case "ET"
							Response.Write("All Times Eastern Time")
					End Select %></font></font></font></font></font></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>

