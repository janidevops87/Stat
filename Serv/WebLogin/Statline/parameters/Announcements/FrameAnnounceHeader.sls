<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
'Verify Access
If AuthorizeMain Then

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	

	'Get the user name
	vQuery = "sps_WebPerson " & UserID
	Set RS = Conn.Execute(vQuery)
	UserName = RS("PersonFirst") & " " & RS("PersonLast")
	Set RS = Nothing
	Set Conn = Nothing

%>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta name="Microsoft Border" content="none">
<meta http-equiv="EXPIRES" content="0">
<title>ParametersFrameDefault</title>
</head>

<body bgcolor="#f5ebdd">

  <table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
	 width="550" bgColor="#112084">
	<tr>
		<td width="540"><font color=#ffffff face="Arial" size="4"><B>&nbsp;Home</B></font></td>
	</tr>
  </table>

<br><br>

<table align="left" border="0" cellPadding="5" cellSpacing="0" style="WIDTH: 550px"
 width="550" bgColor="linen">
  <tr>
    <td checked = "false" valign="center" align="left" width="15%"><font face="Arial" size="2"><strong>Date</strong></font></td>
    <td width="20%" valign="center"><font face="Arial" size="2">
            <%=FormatDateTime(now(),vbShortDate)%></font></td>
    <td checked = "false" valign="center" align="left" width="15%"><font face="Arial" size="2"><strong>User</strong></font></td>
    <td valign="center"width="35%"><font face="Arial" size="2">
            <%=UserName%></font></td>
    <td checked = "false" valign="center" align="left" width="10%"><font face="Arial" size="2"><strong>Comments&nbsp;&nbsp;</strong></font></td>
    <td valign="center" width="25%"><font face="Arial" size="2">&nbsp;&nbsp;<!--#include virtual="/loginstatline/includes/ClientServicesMailTo.sls"--></a></font></td>
  </tr>
</table>

<p>&nbsp;</p>


<table align="left" border="1" cellPadding="5" cellSpacing="0" style="WIDTH: 550px"
 width="550">
  <tr>
    <td colspan="2" width="540"><font face="Arial" size="3"><B>Announcements</B></font></td>
  </tr>

	<!--<tr>
	  <td checked = "false" valign="top" align="left" width="50"><font face="Arial" size="2"><strong>7/28/99</strong></font></td>
	  <td width="452">
            <P><font face="Times New Roman" size="2"><B><Center><MARQUEE>A New Statline Family Member &nbsp --
	--  <BR>Congratulations to Kristi Polly for giving birth to a healthy baby boy on Wednesday, June 30, 1999 at 2:49 AM.
             <A href=http://www.rosebabies.com/scripts/rosebabyhomepage.sls?ID=2441 target="_blank" >Ryan Polly</A> weighed 7 lbs&nbsp; 11 oz
            and measured 19 3/4 inches at birth.
	  </font></P></td>

	</tr>
	-->

   <tr>
    <td checked = "false" valign="top" align="left" width="50"><font face="Arial" size="2"><strong>3/31/99</strong></font></td>
    <td width="452"><font face="Times New Roman" size="2"><B>Faster than a
            speeding....?</B><BR>Recently, we have heard
            from several of our clients that they wish the reports would run
            faster. Although the speed of the reports is ultimately limited by
            the speed of your Internet connection, we are constantly looking at
            ways of making the report generation on our end as fast as possible.
            Over the next month we will be upgrading our web server as well as
            redesigning most reports so as to maximize the speed at which
            reports are generated and downloaded. Improvements are on the
            way!</font></td>
  </tr>

   <tr>
    <td checked = "false" valign="top" align="left" width="50"><font face="Arial" size="2"><strong>3/31/99</strong></font></td>
    <td width="452"><font face="Times New Roman" size="2">
    <B>Minimum
            Requirements</B>
    <BR>With the new design of the
            Statline Information Center we have a few recommendations to acheive
            the best results from this site.

    <BR><B>Memory and Processor:</B>&nbsp;&nbsp;To acheive
            best performance, we recommend at least a 133 Mhz computer with at
            least 32 Megabytes of memory. While both Microsoft's and Netscape's
            browsers can run on less memory, the nature of the referral reports
            require the download of a significant amount of data therefore
            increasing the memory requirements of your computer system.

    <BR><B>Internet Connection
            Speed:</B>&nbsp;&nbsp;Everyone would like to have blazing Internet
            speed for <I>any</I> web browsing.
            Unfortunately, ubiquitous high-speed Internet access has not quite
            arrived yet. Additionally, referral reporting is by nature highly
            data intensive. Therefore, we recommend a 56K modem connection or
            faster. Most Internet Service Providers (ISPs) offer 56K connections
            these days. If you only have a 28.8K modem or your ISP only offers
            28.8K connections, the reporting site will work fine, just slower.

    <BR><B>Screen
            Resolution:</B>&nbsp;&nbsp;To acheive the best display results your
            screen resolution should be set to at least 800 x 600 and at least
            256 colors. A resolution of less than 800 x 600 may result in
            graphics which are misaligned or appear cut-off. Less than 256
            colors may make the background and graphics appear grainy. If you
            are unsure of your settings, and are using Windows 95 or later,
            simply set your mouse anywhere on your computer desktop, right click
            your mouse button, and select 'Properties'. A window should come up
            with a 'Settings' tab. Adjust your settings accordingly.

    </font></td>
  </tr>

  <tr>
    <td width="50" valign="top" align="left"><font face="Arial" size="2"><strong>6/22/98</strong></font></td>
    <td width="452"><font face="Times New Roman" size="2"><a

            href="/loginstatline/reportdesc/hcfaletter.shm" target="_blank"
           >Statline letter on the HCFA ruling of August
            1998.</a> </font></td>
  </tr>
</table>
<DIV></DIV>



</body>
</html>

<%
End If
%>