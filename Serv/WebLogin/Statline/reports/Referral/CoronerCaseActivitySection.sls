
	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

	<table border="0" width="100%" rules="NONE" frame="VOID">
		<tr>
			<td ALIGN=LEFT VALIGN=TOP width="3%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>#</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="9%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Number</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="12%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Type</b></u></font></td>	
			<td ALIGN=LEFT VALIGN=TOP width="13%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Date/Time</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="35%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Referral Location</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="18%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Patient Name</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="10%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Sex/Age</b></u></font></td>
			
		</tr>  	
	</table>

<table border="0" width="100%" rules="NONE" frame="VOID">
			
<%
ReferralCoronerPhone = ""

i = 1

Do Until RS.EOF = True	
	
	If RS("ReferralCoronerPhone") <> ReferralCoronerPhone Then
		ReferralCoronerPhone = RS("ReferralCoronerPhone")
		'Response.Write RS("ReferralCoronerOrganization")
	%>
		
		<tr>
			<td colspan="8"><hr align="CENTER" color="#000000" noshade size="1" width="100%"></td>
		</tr>	
		<tr>
			<td colspan="8"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>
		    <%=RS("ReferralCoronerOrganization")%></a></i></b></font></td>
		</tr>
	<%End If%>
	
	<tr>
		<td ALIGN=LEFT VALIGN=TOP width="3%"><font size="<%=FontSizeData%>"><%=i%></font></td>
	    <td ALIGN=LEFT VALIGN=TOP width="9%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
<%	    ' Modified to use statWindow javascript routine which hides menus, toolbars and address bar in new browser window.  2/15/05 - SAP  %>
	    <a href=javascript:statWindow('ReferralDetail','/loginstatline/reports/referral/detail_1.sls?CallID=<%=RS("CallID")%>&amp;<%=Request.QueryString%>&NoLog=1&CountCheck=False')><%=RS("CallNumber")%></a></FONT></td>
		  <!--UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;Options=0  &NoLog=1&CountCheck=False"><%=RS("CallNumber")%></a></FONT></td>-->
	    <td ALIGN=LEFT VALIGN=TOP width="12%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("ReferralTypeName")%></FONT></td>	
	    <td ALIGN=LEFT VALIGN=TOP width="13%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=FormatDateTime(RS("CallDateTime"), vbShortDate) & " " & FormatDateTime(RS("CallDateTime"), vbShortTime)%></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP width="35%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("OrganizationName")%></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP width="18%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("ReferralDonorFirstName")%>&nbsp<%=RS("ReferralDonorLastName")%></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP width="10%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("GenderAge")%></FONT></td>
	    
	</tr>

<%
	RS.MoveNext	
	i = i + 1
Loop
%>

</table>
