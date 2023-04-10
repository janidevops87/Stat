<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->


<%If pvCallID <> 0 Then%>
<%'Header section%>
<table width="100%" border="0">
  <tr>
    	<td width="85">
    		<img src="/loginstatline/images/logo1.gif" width="60" height="60">
    	</td>
    	<td width="40%" align="Left">
    <%If pvUserOrgID = 194 And Not IsEmpty(ResultArray) Then%>	
		<b><font size="5" face="Arial Black">IIAM - Referral Detail - <%=ResultArray(10,0)%></font>
		
    <%Else%>	
		<b><font size="5" face="Arial Black">IIAM - Referral Detail</font>
    <%End If%>
        	<br>    		
    	</td>
	<td width="85" align="LEFT">
		<%=GetLogoReportGroup(ReportGroupID)%>
	</td>    	
    	<td width="30%" valign="CENTER" ALIGN="RIGHT">
    		<font size="2" face="<%=FontNameData%>"><% Response.Write("All Times " & ZoneName(vTZ)) %></font>
    	</td>
  </tr>
</table>
<%Else%>

    <table width="100%" border="0">
      <tr>
        <td width="85">
        	<img src="/loginstatline/images/logo1.gif" width="60" height="60">
        </td>
        <td width="40%" align="Left">
       <%If pvUserOrgID = 194 And Not IsEmpty(ResultArray) Then%>
	
	 	<b><font size="5" face="Arial Black">IIAM - Referral Detail - <%=ResultArray(10,0)%>	 	
       <%Else%>	
	 	<b><font size="5" face="Arial Black">IIAM - Referral Detail	
       <%End If%>
       		<br>
        	<font size="4" face="<%=FontNameHead%>"><%=vReportTitle%></font></font>
        </td>   </b>
        <td width="85" align="LEFT">
        	<%=GetLogoReportGroup(ReportGroupID)%>
        </td>
        <td width="30%" valign="CENTER" ALIGN="RIGHT">
        	<table border="0" width="100%">	
	            <tr>
	             <td>
	        	<font size="3" face="<%=FontNameHead%>">
	        		<b>Period:&nbsp;</b> 
	        	</font>	
	             </td>
	             <td>
			<font size="3" face="<%=FontNameHead%>">
				<b>To:&nbsp; </b> 
			</font>	
		     </td>
		    </tr>
		    <tr>
		      <td>
	
	        	<font size="2" face="<%=FontNameData%>">
	        		<%=FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)%>&nbsp; 
	        	</font>
	              </td>
	              <td>
	        	<font size="2" face="<%=FontNameData%>">
	        		<%=FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)%><br>
	        	</font>	
	              </td>
	            </tr>  
	            <tr>
	              <td colspan="2">
	        	<font size="2" face="<%=FontNameData%>">
	        <%	Response.Write("All Times " & ZoneName(vTZ)) 
	        
	        %>	</font>
	              </td>
	            </tr>
	        
	        
	          </table>
	<%End If%>
	   </td> 
      </tr>
    </table>
</b>
<!--


<%If pvCallID <> 0 Then%>
<%'Header section%>

<table width="100%">
  <tr>
    <td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
    <%If pvUserOrgID = 194 And Not IsEmpty(ResultArray) Then%>
	    <td width="50%" align="Left"><b><font size="5" face="Arial Black">IIAM - Referral Detail - <%=ResultArray(10,0)%><br>
    <%Else%>
		<td width="50%" align="Left"><b><font size="5" face="Arial Black">IIAM - Referral Detail<br>
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
		    <td width="50%" align="Left"><b><font size="5" face="Arial Black">IIAM - Referral Detail - <%=ResultArray(10,0)%><br>
		<%Else%>
			<td width="50%" align="Left"><b><font size="5" face="Arial Black">IIAM - Referral Detail<br>
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
-->