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

    DIM cmd, RSNAVTYPE


    Set RSNAVTYPE = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_NavigationType"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@NAVIGATIONTYPEID", adInteger, adParamInput)
    cmd.Parameters("@NAVIGATIONTYPEID").Value = NULL
    Set RSNAVTYPE = cmd.Execute
%>

<html>
<head>
<title></title>
<script language="JavaScript">

function AdminNavType()
{
    document.NavTypeForm.submit();
}

</script>

</head>

<body bgcolor="#F5EBDD" text="#000000">

<table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px" width="550" bgColor="#112084">
        <tr>
            <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Navigation Administration</b></font></td>
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
            <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Select a navigation type to edit:</font></p>
            <form method="GET" name="NavTypeForm" ACTION="NavigationAdmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>">
<input type="hidden" name="UserID" size="25" value="<%=UserID%>">
<input type="hidden" name="UserOrgID" size="25" value="<%=UserOrgID%>">
        <input type="hidden" name="NavTypeID" size="25" value="">
              <b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></b><br>
              <table width="340" border="0" cellspacing="0" cellpadding="0" bordercolor="cccccc">
                <tr>
                  <td bgcolor="#CCCCCC">
                    <table width="340" border="0" cellspacing="1" cellpadding="3">
                      <tr bgcolor="ffffff">
                        <td align="right" width="100" class="menu_background"><font class="menu_sub"><B>Navigation Types:</B></font></td>
                        <td width="240"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
                        <select name="Navtype" onChange="JavaScript:AdminNavType();">
                    <option value="0" selected></option>

                    <%Do While Not RSNAVTYPE.EOF%>
                        <option value="<%=RSNAVTYPE("NAVIGATIONTYPEID")%>"><%=RSNAVTYPE("NAVIGATIONTYPENAME")%></option>
                    <%
                    RSNAVTYPE.MoveNext
                    Loop
                    Set RSNAVTYPE = Nothing
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