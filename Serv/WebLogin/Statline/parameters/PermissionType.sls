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

    DIM cmd, RSPERMTYPE


    Set RSPERMTYPE = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_PermissionType"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONTYPEID", adInteger, adParamInput)
    cmd.Parameters("@PERMISSIONTYPEID").Value = NULL
    cmd.Execute
    Set RSPERMTYPE = cmd.Execute
%>

<html>
<head>
<title></title>
<script language="JavaScript">

function AdminPermType()
{
    document.PermTypeForm.submit();
}

</script>

</head>

<body bgcolor="#F5EBDD" text="#000000">

<table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px" width="550" bgColor="#112084">
        <tr>
            <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Permission Administration</b></font></td>
        </tr>
    </table>

    <p>&nbsp;</p>

<table width="450" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
    <td width="100" height="270" bgcolor="#F5EBDD"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
    <td width="350" bgcolor="#F5EBDD">
      <table width="350" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td valign="top">
            <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Select a permission type to edit:</font></p>
            <form method="GET" name="PermTypeForm" ACTION="PermissionAdmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>">
<input type="hidden" name="UserID" size="25" value="<%=UserID%>">
<input type="hidden" name="UserOrgID" size="25" value="<%=UserOrgID%>">
        <input type="hidden" name="PermTypeID" size="25" value="">
              <b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></b><br>
              <table width="340" border="0" cellspacing="0" cellpadding="0" bordercolor="cccccc">
                <tr>
                  <td bgcolor="#CCCCCC">
                    <table width="340" border="0" cellspacing="1" cellpadding="3">
                      <tr bgcolor="ffffff">
                        <td align="right" width="100" class="menu_background"><font class="menu_sub"><B>Permission Types:</B></font></td>
                        <td width="240"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
                        <select name="Permtype" onChange="JavaScript:AdminPermType();">
                    <option value="0" selected></option>

                    <%Do While Not RSPERMTYPE.EOF%>
                        <option value="<%=RSPERMTYPE("PERMISSIONTYPEID")%>"><%=RSPERMTYPE("PERMISSIONTYPENAME")%></option>
                    <%
                    RSPERMTYPE.MoveNext
                    Loop
                    Set RSPERMTYPE = Nothing
                    %>
            </select>
                          </font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </form>
            </td>
            </tr>
          </table>
        </td>
        <td width="150" bgcolor="#F5EBDD">

        </td>
        <td width="150"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
      </tr>
</table>

</body>
</html>
<% end if %>