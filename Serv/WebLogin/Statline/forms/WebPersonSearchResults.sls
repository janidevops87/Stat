<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim cmd

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%

'Verify Access
If AuthorizeMain Then
Select Case request("SearchMethod")
    Case "AccessType"
        Set RS = Server.CreateObject("ADODB.Recordset")
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
        cmd.CommandText = "SPS_WebPersonByPermission2"
        cmd.CommandType = adCmdStoredProc
'        cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
        cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONID", adInteger, adParamInput)
        cmd.Parameters.Append cmd.CreateParameter("@ORGID", adInteger, adParamInput)
        cmd.Parameters("@PERMISSIONID").Value =request("Accesstype")
        cmd.Parameters("@ORGID").Value =UserOrgID
        Set RS = cmd.Execute
    Case "UserName"
        Set RS = Server.CreateObject("ADODB.Recordset")
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
        cmd.CommandText = "sps_WebUserName3"
        cmd.CommandType = adCmdStoredProc
'        cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
        cmd.Parameters.Append cmd.CreateParameter("@vUserName", adVarChar, adParamInput, 500)
        cmd.Parameters.Append cmd.CreateParameter("@ORGID", adInteger, adParamInput)
        cmd.Parameters.Append cmd.CreateParameter("@UserID", adInteger, adParamInput)
        cmd.Parameters("@vUserName").Value = request("SearchCriteria")
        cmd.Parameters("@ORGID").Value =UserOrgID
        cmd.Parameters("@UserID").Value =UserID
        Set RS = cmd.Execute
        
'        response.write(request("SearchCriteria"))
End Select
%>
<html>
<head>
<title></title>
<link rel="stylesheet" href="../styles/common.css" type="text/css">

</head>

<body bgcolor="#F5EBDD" text="#000000">
  <table border="0" cellPadding="0" cellSpacing="0" width="600" bgColor="#112084">
    <tr>
        <td width="600"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Web Search Results</b></font></td>
    </tr>
  </table>
<table algin="left" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
    <td width="600" bgcolor="#F5EBDD">
      <table width="600" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td valign="top">
            <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Click on a user below to update:</font></p>


            <table width="600" border="0" cellspacing="0" cellpadding="0" bordercolor="cccccc">
                <tr>
                  <td>
                  <font face="Verdana, Arial, Helvetica, sans-serif" size="2">Results for "<font color="#000066"><B><% if request("SearchMethod") = "AccessType" Then response.write(RS("PermissionName")) Else response.write(request("SearchCriteria")) End If%></font></B>" search:</font>
                    <table width="600" border="0" cellspacing="1" cellpadding="3">
            <TR>
            <TD bgcolor="#FFFFFF"><font class="menu_sub"><B>User Name</B></font></TD>
            <TD bgcolor="#FFFFFF"><font class="menu_sub"><B>Name</B></font></TD>
            <TD bgcolor="#FFFFFF"><font class="menu_sub"><B>Organization</B></font></TD>

            </TR>
                     <%    Do Until RS.EOF%>
            <TR>
            <TD bgcolor="#FFFFFF"><A href="webuserDetail.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&webuserid=<%=RS("WebPersonID")%>"><%=RS("WebPersonUserName")%></A></TD>
            <TD bgcolor="#FFFFFF"><A href="webuserDetail.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&webuserid=<%=RS("WebPersonID")%>"><%=RS("PersonFirst")%>&nbsp;<%=RS("PersonLast")%></A></TD>
            <TD bgcolor="#FFFFFF"><A href="webuserDetail.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&webuserid=<%=RS("WebPersonID")%>"><%=RS("OrganizationName")%></A></TD>
            </TR>
            <%
            RS.MOVENEXT
            Loop
            Set RS     = Nothing
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
  </tr>
</table>


<!--#include virtual="/loginstatline/includes/copyright.shm"-->
</body>
</html>
<%
End If
%>