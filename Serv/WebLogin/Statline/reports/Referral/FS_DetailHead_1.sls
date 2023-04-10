<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->


<%If pvCallID <> 0 Then%>
<%'Header section%>

	<table width="100%">
	  <tr>
	    <td width="85">
		<img src="/loginstatline/images/logo1.gif" width="60" height="60">
	    </td>
	    <td width="40%" align="Left">
		<b><font size="5" face="Arial Black">
		<%If pvUserOrgID = 194 And Not IsEmpty(ResultArray) Then%>
			Referral Detail - <%=ResultArray(10,0)%><br>
		<%Else%>
			Referral Detail
		<%End If%>
		<br></font>	
	    </td>
	    <td width="85" align="LEFT">
			<%=GetLogoReportGroup(ReportGroupID)%>
	    </td>
	    <td width="30%" valign="CENTER">
		<font size="2" face="<%=FontNameData%>">
		<% Response.Write("All Times " & ZoneName(vTZ)) %>
		</font>
	    </td>
	  </tr>
	</table>
<%Else%>
    <table width="100%">
      <tr>
        <td width="85">
        	<img src="/loginstatline/images/logo1.gif" width="60" height="60">
        </td>
	<td width="40%" align="Left"><b><font size="5" face="Arial Black">
		<%If pvUserOrgID = 194 And Not IsEmpty(ResultArray) Then%>
		    Referral Detail - <%=ResultArray(10,0)%>
		<%Else%>
		    Referral Detail
		<%End If%><br></font>
        	<font size="4" face="<%=FontNameHead%>">
        	<%=vReportTitle%></font></b>
        </td>
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
         </td> 
       </tr>  
    </table>
<% End If %>
<br>
