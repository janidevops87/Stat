<%
Option Explicit

Server.ScriptTimeout = 300

Dim UserName
Dim strDefaultMsg
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim RSUSER, RSAccessType, RSWebUser, cmd
Dim lTime
%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
'Verify Access
If AuthorizeMain Then

lTime = Timer
strDefaultMsg=""

DataSourceName = TRANSACTIONDSN

If Request.ServerVariables("REQUEST_METHOD") <> "GET" Then
   Set cmd = Server.CreateObject("ADODB.Command")
   cmd.ActiveConnection = "DSN=" & DataSourceName & ";UID=" & DBUSER & ";Password=" & DBPWD
   cmd.CommandText = "SPD_WebPersonPermissionbyWebPersonID"
   cmd.CommandType = adCmdStoredProc
   cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
   cmd.Parameters.Append cmd.CreateParameter("@WEBPERSONID", adInteger, adParamInput)
   cmd.Parameters("@WEBPERSONID").Value = request("WebUserID")
   cmd.Execute

    Dim intNumberSelected ' Count of items selected
    Dim strSelectedAccess' String returned from QS (or Form)
    Dim arrSelectedAccess' Variable To hold team array
    Dim I ' Looping variable
    Dim nCount, updateTime
    'Retrieve the count of items selected
    intNumberSelected = Request.Form("Access").Count
    strSelectedAccess = Request.Form("Access")
    arrSelectedAccess = Split(strSelectedAccess, ", ", -1, 1)
    nCount=0
    For I = LBound(arrSelectedAccess) To UBound(arrSelectedAccess)
      Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = "DSN=" & DataSourceName & ";UID=" & DBUSER & ";Password=" & DBPWD
        cmd.CommandText = "SPI_WebPersonPermission"
        cmd.CommandType = adCmdStoredProc
        cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
        cmd.Parameters.Append cmd.CreateParameter("@WEBPERSONPERMISSIONID", adInteger, adParamInputOutput)
        cmd.Parameters.Append cmd.CreateParameter("@WEBPERSONID", adInteger, adParamInput)
        cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONID", adInteger, adParamInput)
        cmd.Parameters("@WEBPERSONPERMISSIONID").Value = NULL
        cmd.Parameters("@WEBPERSONID").Value = request("WebUserID")
        cmd.Parameters("@PERMISSIONID").Value = arrSelectedAccess(I)
        cmd.Execute
    Next 'I
    updateTime= Date & "&nbsp;" & Time
End IF

IF request("webuserid") <> "" then
    ' First, get current user's existing web permissions as a default set.
    ' Changed how sproc is run to eliminate "read-only" locktype. 5/2/05 - SAP
    Set RSUSER = Server.CreateObject("ADODB.Recordset")
    RSUSER.ActiveConnection = "DSN=" & DataSourceName & ";UID=" & DBUSER & ";Password=" & DBPWD
    RSUSER.Source = "{call dbo.SPS_PermissionByWebPersonID (" & request("WebUserID") & ")}"
    RSUSER.CursorType = 0
    RSUSER.CursorLocation = 2
    RSUSER.LockType = 4  ' Changed from 1 (read-only)
    RSUSER.Open()
    
    If RSUSER.EOF = True then
    	strDefaultMsg = "Default permissions have been selected, but not saved. Please click the update button to save."
    End if

    'Then, look at the existing permissions for the webuser being edited.
    Set RSAccessType = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & DataSourceName & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_PermissionByWebPersonID"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@WEBPERSONID", adInteger, adParamInput)
    cmd.Parameters("@WEBPERSONID").Value =UserID
    Set RSAccessType = cmd.Execute

    'Open Connection
    Set Conn = server.CreateObject("ADODB.Connection")
    Conn.Open DataSourceName, DBUSER, DBPWD
    vQuery = "EXEC sps_WebUSerbyID "
    vQuery = vQuery & "'" & request("WebUserID")  & "'"

    'response.write(vQuery)
    Set RSWebUser = Server.CreateObject("ADODB.Recordset")
RSWebUser.Open vQuery, Conn, 3, 3

END IF
%>

<html>
<head>
<title>Donor Registry - User Detail</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="../styles/common.css" type="text/css">

</head>
<!--  <%=Server.ScriptTimeout%> -->


<body bgcolor="#F5EBDD" text="#000000">
  <table border="0" cellPadding="0" cellSpacing="0" width="450" bgColor="#112084">
    <tr>
        <td width="450"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Web Person Detail</b></font></td>
    </tr>
  </table>
<table align="left" width="450" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
    <td width="100" height="270" bgcolor="#F5EBDD"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
    <td width="350" bgcolor="#FFFFFF">
      <table width="350" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td valign="top">
            <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Hold down the "ctrl" key to select multiple values.</font></p>
            <%
            If Request.ServerVariables("REQUEST_METHOD") <> "GET" Then
                response.write("<font class='menu_sub' size=-1><B>Updated at: " & updateTime & "</B></font>")
            END IF %>

            <table width="340" border="0" cellspacing="0" cellpadding="0" bordercolor="#CCCCCC">

		<TR>
                <TD align="left" width="5%" class="menu_background"><font class="menu_sub"><B>Name:</B></font>
                </TD>
                <TD align="left"><%=RSWebUser("PersonFirst")%>&nbsp;<%=RSWebUser("PersonLast")%>&nbsp;
                </TD>
                </TR>
                <TR>
            <TD align="left" width="10%" class="menu_background" height="5"></TD>
                <TD align="left" height="5"></TD>
                </TR>
                <TR>
            <TD align="left" width="5%" class="menu_background"><font class="menu_sub"><B>User Name:</B></font>
                </TD>
                <TD align="left"><%=RSWebUser("WebPersonUserName")%>
                </TD>
                </TR>
                <TR>
            <TD align="left" width="10%" class="menu_background" height="5"></TD>
                <TD align="left" height="5"></TD>
                </TR>
	<TR>
	<TD align="left" colspan="2"><font color="red"><b><i><%=strDefaultMsg%></i></b>
	</TD>
	</TR>

	<TR>
	<TD><font color="white">test</font></TD>
	</TR>
                <TR>
            <TD align="left" valign="top" width="10%" class="menu_background"><font class="menu_sub"><B>Access Types:</B></font>
                </TD>
                  <TD>
                  <Form ACTION="webuserDetail.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" METHOD="POST">

                  <input type="hidden" name="webuserid" value="<%=request("webuserid")%>">
                  <Select name="Access" size="20" multiple>
              <%

          While (NOT RSAccessType.EOF)
              Dim strSelected
              strSelected=""

              If RSUser.EOF = False Then
                  If NOT RSUSER.EOF AND NOT RSUSER.BOF then
                      While (NOT RSUSER.EOF)
                          'response.write(RSUSER("PERMISSIONID") & "-" & RSAccessType("PERMISSIONID"))
                          IF (RSUSER("PERMISSIONID") = RSAccessType("PERMISSIONID")) then
                              strSelected="selected"
                          end if
                          RSUSER.MoveNext()
                      Wend
                      RSUSER.MOVEFIRST
                  end if
              Else
                  If instr(1, RSAccessType("PermissionName"), "Admin") = 0  And _
                     instr(1, RSAccessType("PermissionName"), "Intranet") = 0 AND _
                     instr(1, RSAccessType("PermissionName"), "Audit") = 0 Then

                      strSelected="selected"
                  end if
              End If%>
              <option value="<%=RSAccessType("PERMISSIONID")%>" <%=strSelected%>><%=RSAccessType("PERMISSIONName")%></option>
            <%
          RSAccessType.MoveNext()
          Wend

          If (RSAccessType.CursorType > 0) Then
            RSAccessType.MoveFirst
          Else
            RSAccessType.Requery
          End If
          %>
            </select>
                </td>
                </tr>
                 <TR>
              <TD align="left" width="5%" class="menu_background"><font class="menu_sub"><B></B></font>
                </TD>
                <TD align="left"><input type="Submit" value="Update"><input type="Reset" value="Reset"></TD>
                </TR>
                  </form>
                </TR>
              </table>
          </td>
        </tr>
      </table>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
    </td>
    <td width="150" bgcolor="#F5EBDD">

    </td>
    <td width="150"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
  </tr>
</table>
</body>
</html>

<!-- Time: <%= Timer - lTime %> -->

<%
End If
%>