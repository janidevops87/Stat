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
	

Select Case request("SearchMethod")
	Case "AccessType"
		'Open Connection
		Set Conn = server.CreateObject("ADODB.Connection")
		Conn.Open DataSourceName, DBUSER, DBPWD
		vQuery = "EXEC sps_WebUser "
		vQuery = vQuery & "'" & request("Accesstype")  & "'"
			
		'response.write(vQuery)
		Set RS = Server.CreateObject("ADODB.Recordset")
		RS.Open vQuery, Conn, 3, 3
     	Case "UserName"
     		'Open Connection
		Set Conn = server.CreateObject("ADODB.Connection")
		Conn.Open DataSourceName, DBUSER, DBPWD
		vQuery = "EXEC sps_WebUserName "
		vQuery = vQuery & "'" & request("SearchCriteria")  & "'"
			
		'response.write(vQuery)
		Set RS = Server.CreateObject("ADODB.Recordset")
		RS.Open vQuery, Conn, 3, 3

End Select
%>

<html>
<head>
<title>Washington Donor Registry - Search Results</title>
<meta name="description" content="Washington Donor Registry Search Results">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="../styles/common.css" type="text/css">

</head>

<body bgcolor="#F5EBDD" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top"> 
    <td width="100" height="270" bgcolor="#F5EBDD"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
    <td width="350" bgcolor="#F5EBDD"> 
      <table width="350" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td valign="top"> 
            <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Click on a user below to update:</font></p>
                         
            
            <table width="440" border="0" cellspacing="0" cellpadding="0" bordercolor="cccccc">
                <tr> 
                  <td> 
                    <table width="440" border="0" cellspacing="1" cellpadding="3">
			<TR>
			<TD bgcolor="#FFFFFF"><font class="menu_sub"><B>User Name</B></font></TD>
			<TD bgcolor="#FFFFFF"><font class="menu_sub"><B>Name</B></font></TD>
			<TD bgcolor="#FFFFFF"><font class="menu_sub"><B>Organization</B></font></TD>
			
			</TR>
                     <%	Do Until RS.EOF%>        
			<TR>
			<TD bgcolor="#FFFFFF"><A href="userDetail.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&webuserid=<%=RS("WebPersonID")%>"><%=RS("WebPersonUserName")%></A></TD>
			<TD bgcolor="#FFFFFF"><A href="userDetail.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&webuserid=<%=RS("WebPersonID")%>"><%=RS("PersonFirst")%>&nbsp;<%=RS("PersonLast")%></A></TD>
			<TD bgcolor="#FFFFFF"><A href="userDetail.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&webuserid=<%=RS("WebPersonID")%>"><%=RS("OrganizationName")%></A></TD>
			</TR>
			<%
			RS.MOVENEXT
			Loop
			Set RS 	= Nothing
			%>      
			</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="150" bgcolor="#F5EBDD"> 

    </td>
    <td width="150"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
  </tr>
</table>


<!--#include virtual="/loginstatline/includes/copyright.shm"-->
</body>
</html>
<%
End If
%>