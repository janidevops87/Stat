<!-- Begin Header -->

<html>

<head>
<title></title>
</head>

<body bgcolor="#F5EBDD">

<table width="100%">
  <tr valign="TOP">
    <td width="100%" valign="TOP">
		<table width="100%">
			<tr>
				<td width="75">
					<img src="/loginstatline/images/logo1.gif" width="60" height="60">
				</td>
				<td width="50%" valign="CENTER">
					<b>
					<font size="5" face="Arial Black">
						Import Offer Detail<br>
					</font>	
					<font size="4" face="<%=FontNameHead%>">
						<%=vOrgList(1,i)%>
					</font>
					</b>
				</td>
				<td valign="CENTER">
					<font size="3" face="<%=FontNameHead%>">
						<b>Period:&nbsp;</b>
					</font>
					<font size="2" face="<%=FontNameData%>">
						<%=pvStartDate%>&nbsp; &nbsp; 
					</font>
					<font size="3" face="<%=FontNameHead%>">
						<b>To:&nbsp; &nbsp;</b> 
					<font size="2" face="<%=FontNameData%>">
						<%=pvEndDate%>
					</font>
					<br>
					<font size="2" face="<%=FontNameData%>">
						<% Response.Write("All Times " & ZoneName(TZ)) %><!-- End Header -->
					</font>
				</td>
			</tr>
		</table>
		<p> 
	</td>
  </tr>
</table>
</body>
</html>
