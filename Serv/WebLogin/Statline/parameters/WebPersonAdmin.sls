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
'response.write(UserOrgID)
    Dim RSaccesstype,cmd
    Set RSaccesstype = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_PermissionByWebPersonID"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@WEBPERSONID", adInteger, adParamInput)
    cmd.Parameters("@WEBPERSONID").Value = UserID
   ' response.write(userID)
    'response.write(UserOrgID)
    
    Set RSaccesstype = cmd.Execute
%>

<html>
<head>
<title></title>
<link rel="stylesheet" href="../styles/common.css" type="text/css">
<script language="JavaScript">

function SearchByAccessType()
{
    this.document.SearchForm.SearchMethod.value='AccessType';
    document.SearchForm.submit();
}

</script>

</head>

<body bgcolor="#F5EBDD" text="#000000">
<table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px" width="550" bgColor="#112084">
        <tr>
            <td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Web Person Administration</b></font></td>
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
            <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Select your method to search by:</font></p>
            <form method="POST" name="SearchForm" ACTION="../forms/WebPersonSearchResults.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>">
        <input type="hidden" name="SearchMethod" size="25" value="">
              <b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></b><br>
              <table width="340" border="0" cellspacing="0" cellpadding="0" bordercolor="cccccc">
                <tr>
                  <td bgcolor="#CCCCCC">
                    <table width="340" border="0" cellspacing="1" cellpadding="3">
                      <tr bgcolor="ffffff">
                        <td align="right" width="100" class="menu_background"><font class="menu_sub"><B>Users by AccessType:</B></font></td>
                        <td width="240"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
                        <select name="Accesstype" onChange="JavaScript:SearchByAccessType();">
                    <option value="0" selected>----------------------------------------------------------------------------------------</option>
                    <%Do While Not RSaccesstype.EOF%>
                        <option value="<%=RSaccesstype("PERMISSIONID")%>"><%=RSaccesstype("PERMISSIONNAME")%></option>
                        <%RSaccesstype.MoveNext%>
                    <%
                    Loop
                    Set RSaccesstype = Nothing
                    %>
            </select>
                          </font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </form>
            <form method="POST" name="EmailSearch" ACTION="../forms/WebPersonSearchResults.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>">
                  <input type="hidden" name="SearchMethod" size="25" value="UserName">
                        <table width="340" border="0" cellspacing="0" cellpadding="0" bordercolor="cccccc">
                          <tr>
                            <td bgcolor="#CCCCCC">
                              <table width="340" border="0" cellspacing="1" cellpadding="3">
                                <tr bgcolor="ffffff">
                                  <td align="right" width="100" class="menu_background"><font class="menu_sub"><B>Search by User Name:</B></font></td>
                                  <td width="240"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
                                  <input type="text" name="SearchCriteria" size="15" value=""><input type="Submit" value="Search"><input type="Reset" value="Reset">
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

<!--#include virtual="/loginstatline/includes/copyright.shm"-->

</body>
</html>
<%
End If
%>