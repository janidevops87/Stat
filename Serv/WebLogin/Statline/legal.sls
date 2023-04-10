<%
Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

%>
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="DESCRIPTION" content="Statline, LLC legal information">
<meta name="KEYWORDS" content="legal disclaimer, restriction, copyright, warranty, license, users">
<meta http-equiv="Expires" content="now">
<title>Legal Information</title>
</head>

<body bgcolor="#F5EBDD">

<table border="0" cellpadding="0" cellspacing="0" width="575">
  <tr>
    <td><font face="Arial" size="4"><strong>Legal Information...<br></strong></font></td>
  </tr>

  <tr><td><p>&nbsp</p></td></tr>

  <tr>
    <td>
    <font size="2" face="Arial">
	<!--ccarroll 03/26/2008 - changed legal notice to reflect MTF ownership. -->
	<p>
		This Web site is for your personal and non-commercial use. You may not modify,
		copy, distribute, transmit, display, perform, reproduce, publish, license,
		create derivative works from, transfer, or sell any information, software,
		products or services obtained from this Web site, for any purpose,
		without the express written permission of Statline.
		Information on this Web site is subject to change without notice.
	</p>

    <p>
		Statline may have
        patents, patent applications, trademarks, copyrights, or
        other intellectual property rights covering subject
        matter in this document. Except as expressly provided in
        any written license agreement from Statline the
        furnishing of this document does not give you any license
        to these patents, trademarks, copyrights, or other
        intellectual property. Other product and company names
        mentioned herein may be the trademarks of their respective owners.
    </p>

    <p>

		©1996-<%=DatePart("yyyy",Now)%> Statline, A Division of MTF, All rights reserved.
	</p>
    <p>
		Statline is a registered trademark of Statline, A Division of MTF.
	<p>
	<p>
		6400 S. Fiddler's Green Circle, Ste. 300, <BR>Greenwood Village, CO 80111.  <BR>1-888-881-7828.
	</p>

    </font>
    </td>
  </tr>
</table>


</body>
</html>


