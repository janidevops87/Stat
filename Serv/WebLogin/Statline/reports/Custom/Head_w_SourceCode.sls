<!-- Begin Header -->
<TABLE WIDTH = "100%" border ="0">
      <tr>
        <td width="14%" align="center">
        	<img src="/loginstatline/images/logo1.gif" width="60" height="60">
        </td>
        <td width="45%" valign="CENTER">
		<TABLE>
			<TR><TD><FONT SIZE="3" FACE="<%=FontNameHead%>"><B><%=vMainTitle%></B></TD></TR>
			<TR><TD><FONT SIZE="2" FACE="<%=FontNameHead%>"><B><%=vReportTitle%></B></TD></TR>
		</TABLE>

        </td>
        <td width="20%" align="center">
         	<%=GetLogoSourceCode(vSourceCodeName)%>        	
        </td>
     <%if isdate(vTitlePeriod) and isdate(vTitleTo) Then %>   
        
        <td width="21%" valign="CENTER" ALIGN="RIGHT">
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
        	<font size="1" face="<%=FontNameData%>">
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
