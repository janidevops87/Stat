<%
'****************************************************************************************************
'File Name:				default.sls
'Created:				07/31/00
'Created By:			Thomas T. Worster, Statline,LLC
'Description:			default entry point
'
'
'****************************************************************************************************
'Section I:  Variables
'****************************************************************************************************
'Pre-defined variables:
'Conn					'Variable used for Database Connection.  Used in \includes\Authorize.sls
'DataSourceName			'Variable defining Database to be used. Used and defined in \includes\Authorize.sls
'ReportID				'The ReportID of the desired Report. Passed from parameters\FrameCustomParams.sls
'RS						'Variable for RecordSets. Used in \includes\Authorize.sls
'UserID					'The current user's UserID. Used in \includes\Authorize.sls
'UserOrgID				'The Organization the current user belongs to. Used in \includes\Authorize.sls
'vQuery					'Variable that contains the Query sent to the Database. Used in \includes\Authorize.sls

Option Explicit

Dim UserName
Dim Password
Dim	TryNumber
Dim UserAgent

UserID = Request.QueryString("UserID")
If UserID=null or UserID="" then
	UserName = null
	UserOrgID = 0
	PassWord = null
Else
	UserName = GetUserLogin(UserID)
	UserOrgID = Request.QueryString("UserOrgID")
	PassWord = GetUserIDPassword(UserID)
End If

UserAgent = Request.ServerVariables("HTTP_USER_AGENT")

'Test if session timed out DEO 3/16/04
Dim strTimeout
strTimeout=request("TimeOut")
if strTimeout = "Yes" then
	response.write("<font face='Arial' color=Red size='4'><B>Sorry, your session has time out.<BR>Please login again.</B></font>")
end if

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 
%>
<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>User Login</title>
</head>

<body bgcolor="#F5EBDD" onload="focuser()" language = "JavaScript">
<div align="left">

<table border="0" cellpadding="5" cellspacing="0">
  <TR>
    <TD width="92" valign="center" align="middle"><img src="loginstatline/images/logo2.gif" width="64"
    height="65" ></td>
    <td width="142" valign="middle">
    <img src="loginstatline/images/logoText.gif">
    </TD>
  </TR>
</table>
</div>
<form name="loginForm"
    action="https://<%=Request.ServerVariables("SERVER_NAME")%>/loginstatline/parameters/parentframe.sls"
    method="POST">

<%If Request.QueryString("T") = "" Then%>
	<input type="hidden" name="TryNumber" value="0">
	<%'drh 12/29/03 - Set the DSNType field based on the URL parameter%>
	<input type="hidden" name="DSNType" value="<%=Request.QueryString%>">
<%Else%>
	<input type="hidden" name="TryNumber" value=<%=Request.QueryString("T")%>>
	<%'drh 12/29/03 - Set the DSNType field based on the URL parameter%>
	<input type="hidden" name="DSNType" value="<%=Request.QueryString("DSNType")%>">
<%End If%>
<table border =0 width="100%">
  <tr>
    <td valign="LEFT" align="LEFT">
      <table>
        <tr>
          <td></td>
          <td align="LEFT"><h2>Enter Login</h2>
          </td>
        </tr>
        <tr>
          <td align="LEFT">User ID:</td>
          <td><font face="Arial"><input type="Text" name="UserName" size="20" value="<%=UserName%>"></font></td>
        </tr>
        <tr>
          <td align="LEFT">Password:</td>
          <td><font face="Arial"><input type="Password" name="Password" size="20" value="<%=Password%>"></font></td>
        </tr>

        <tr>
          <td></td>
          <td align="LEFT"><input type="Submit" value="Login"><input type="Reset" value="Reset"></td>
        </tr>
        <tr>
          <td><p style="line-height: 10pt">&nbsp;</p>
          <p><!-- Determine what message to display --> <%Select Case Request.QueryString("Error")%> <%Case "Failed"%> </td>
        </tr>
        <tr>
          <td></td>
          <td nowrap><font face="Arial" color="#FF0000" size="4"><b>Login failed. Please re-enter
          login.</b></font></td>
        </tr>
<%Case "Timeout"%>
        <tr>
          <td></td>
          <td nowrap><font valign="Center" face="Arial" color="#FF0000" size="4"><b>Your session has
          timed-out. Please re-enter login.</b></font></td>
        </tr>
        <tr>
          <td></td>
          <td><font valign="Center" face="Arial" color="#FF0000" size="1">You are automatically
          logged out if there is no activity for 30 minutes.</font></td>
        </tr>
<%End Select%>


</table>

    </form>
    </td>
  </tr>
</table>
<table>

        <tr>
			<td></td>
			<td>
				<!--<dt><a href="http://<%= Request.ServerVariables("SERVER_NAME") %>/loginstatline/legal.sls" target="_blank"><font size="1" face="Arial">©1996-<%=DatePart("yyyy",Now)%> Statline, LLC. All rights reserved.</font></a></dt>-->
			</td>
		</tr>


</table>

</body>
</html>

<script language="JavaScript">
	//The function focuser() is called by the onload event.
	//The function gives focus to the UserName text box
	function focuser()
	{	    
        //detect the frameset and referesh page if not parent frame.
	    if (window.location !== window.parent.location) {
	        window.parent.location.href = document.URL;
	    }
	    document.loginForm.UserName.focus()
	}
</script>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
