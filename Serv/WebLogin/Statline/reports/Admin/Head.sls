<!-- Begin Header -->
<TABLE WIDTH = "100%" border ="0">
      <tr>
        <td width="15%">
        	<img src="/loginstatline/images/logo1.gif" width="60" height="60">
        </td>
        <td width="45%" valign="CENTER">
        	<b><font size="5" face="Arial Black">
        	<%=vMainTitle%>
        	</font>
        	<br>
        	<font size="4" face="<%=FontNameHead%>">
        	<%=vReportTitle%>
        	</font></b>
        </td>
        <td width="15%" align="LEFT">
        	<%=GetLogoReportGroup(ReportGroupID)%>
        </td>
     <%if isdate(vTitlePeriod) and isdate(vTitleTo) Then %>   
        
        <td width="25%" valign="CENTER" ALIGN="RIGHT">
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
        		<%=vTitlePeriod%>&nbsp; 
        	</font>
              </td>
              <td>
        	<font size="2" face="<%=FontNameData%>">
        		<%=vTitleTo%><br>
        	</font>	
              </td>
            </tr>  
            <tr>
              <td colspan="2">
        	<font size="2" face="<%=FontNameData%>">
        	<%=vTitleTimes%>
        	</font>
              </td>
              
     <% Else %>                       
	<td width="25%" valign="CENTER" ALIGN="RIGHT">
	
	</td>
     <% End IF %>              
            </tr>
        
        
          </table>
         </td> 
      </tr>
</TABLE>

<!-- End Header -->


