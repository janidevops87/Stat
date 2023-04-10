<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->


<%If pvCallID <> 0 Then%>
<%'Header section%>

<table width="100%">
  <tr>
    <td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
    <%If pvUserOrgID = 194 And Not IsEmpty(ResultArray) Then%>
	    <td width="50%" align="Left"><b><font size="5" face="Arial Black">Referral Detail - <%=ResultArray(10,0)%><br>
    <%Else%>
		<td width="50%" align="Left"><b><font size="5" face="Arial Black">Referral Detail<br>
    <%End If%>
    <font size="4" face="<%=FontNameHead%>"></font></font></td>
    <td valign="CENTER"><font size="2" face="<%=FontNameData%>">
		<%	Response.Write("All Times " & ZoneName(vTZ)) %>
	</font></td>
  </tr>
</table>
<%Else%>

<table width="100%">
  <tr valign="TOP">
    <td width="100%" valign="TOP"><table width="100%">
      <tr>
        <td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
		<%If pvUserOrgID = 194 And Not IsEmpty(ResultArray) Then%>
		    <td width="50%" align="Left"><b><font size="5" face="Arial Black">Referral Detail - <%=ResultArray(10,0)%><br>
		<%Else%>
			<td width="50%" align="Left"><b><font size="5" face="Arial Black">Referral Detail<br>
		<%End If%>
        <font size="4" face="<%=FontNameHead%>"><%=vReportTitle%></font></font></td>
        </b><td valign="CENTER"><font size="3" face="<%=FontNameHead%>"><b>Period:&nbsp;</b> <font
        size="2" face="<%=FontNameData%>"><%=FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)%>&nbsp; &nbsp; <font size="3" face="<%=FontNameHead%>"><b>To:&nbsp;
        &nbsp;</b> <font size="2" face="<%=FontNameData%>"><%=FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)%><br>
        <font size="2" face="<%=FontNameData%>">
			<%	Response.Write("All Times " & ZoneName(vTZ)) %>
		<%End If%></font></font></font></font></font></td>
      </tr>
    </table>
    <p> </td>
  </tr>
</table>
</b>
