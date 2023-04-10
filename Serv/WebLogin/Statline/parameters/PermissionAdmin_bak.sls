<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim PERMISSIONID
Dim cmdB

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
DIM cmd, RSPERM, RSPERMLOOP, RSFUNCTION
'Verify Access
If AuthorizeMain Then
   'Ready to update
   IF Request.ServerVariables("REQUEST_METHOD") = "POST" then
      Set RSPERMLOOP = Server.CreateObject("ADODB.Recordset")
      Set cmd = Server.CreateObject("ADODB.Command")
      cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
      cmd.CommandText = "SPS_PermissionBYPermType"
      cmd.CommandType = adCmdStoredProc
      cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
      cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONTYPEID", adInteger, adParamInput)
      cmd.Parameters("@PERMISSIONTYPEID").Value = request("permtype")
      set RSPERMLOOP= cmd.execute

      DO WHILE NOT RSPERMLOOP.EOF
             Set cmd = Server.CreateObject("ADODB.Command")
             cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
             cmd.CommandText = "SPU_Permission"
             cmd.CommandType = adCmdStoredProc

             cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
             cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONID", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONNAME", adVarChar, adParamInput, 500)
             cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONTYPEID", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONDESCRIPTION", adVarChar, adParamInput, 1000)
             cmd.Parameters.Append cmd.CreateParameter("@ACTIVE", adBoolean, adParamInput)
             cmd.Parameters("@PERMISSIONID").Value =  RSPERMLOOP("PERMISSIONID")
             cmd.Parameters("@PERMISSIONNAME").Value = EVAL("request(" & String(1,34) & "PERMISSIONNAME_" & RSPERMLOOP("PERMISSIONID") & String(1,34) & ")")
             cmd.Parameters("@PERMISSIONTYPEID").Value = request("permtype")
             'Modified the functionid value for task #360. The report functionality was not working do to commented out
             'code was trying to convert an integer to a string. CAC 2/3/2005
             'cmd.Parameters("@FUNCTIONID").Value = EVAL("request(" & String(1,34) & "FUNCTIONID_" & RSPERMLOOP("PERMISSIONID") & String(1,34) & ")")
             cmd.Parameters("@FUNCTIONID").Value = RSPERMLOOP("FUNCTIONID")
             cmd.Parameters("@PERMISSIONDESCRIPTION").Value = EVAL("request(" & String(1,34) & "PERMISSIONDESCRIPTION_" & RSPERMLOOP("PERMISSIONID") & String(1,34) & ")")
             IF (EVAL("request(" & String(1,34) & "ACTIVE_" & RSPERMLOOP("PERMISSIONID") & String(1,34) & ")") = "on") then
                cmd.Parameters("@ACTIVE").Value = 1
             ELSE
                cmd.Parameters("@ACTIVE").Value = 0
             END IF
             cmd.Execute
      RSPERMLOOP.MOVENEXT
      Loop
      IF request("PERMISSIONNAME_New") <> "" then
         'Add the new permission to the DB
         Set cmd = Server.CreateObject("ADODB.Command")
         cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
         cmd.CommandText = "SPI_Permission"
         cmd.CommandType = adCmdStoredProc
         cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
         cmd.Parameters.Append cmd.CreateParameter("PERMISSIONID", adInteger, adParamOutput, -1)
         cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONNAME", adVarChar, adParamInput, 500)
         cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONTYPEID", adInteger, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONDESCRIPTION", adVarChar, adParamInput, 1000)
         cmd.Parameters.Append cmd.CreateParameter("@ACTIVE", adBoolean, adParamInput)
         cmd.Parameters("@PERMISSIONNAME").Value = request("PERMISSIONNAME_new")
         cmd.Parameters("@PERMISSIONTYPEID").Value = request("permtype")
         cmd.Parameters("@FUNCTIONID").Value = request("FUNCTIONID_new")
         cmd.Parameters("@PERMISSIONDESCRIPTION").Value = request("PERMISSIONDESCRIPTION_new")
         cmd.Parameters("@ACTIVE").Value = 1
         cmd.Execute
         PERMISSIONID=Cmd.Parameters("PERMISSIONID")
         ' Add the new permission to the user who added the permission above
         Set cmdB = Server.CreateObject("ADODB.Command")
         cmdB.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
         cmdB.CommandText = "SPI_WebPersonPermission"
         cmdB.CommandType = adCmdStoredProc
         cmdB.Parameters.Append cmdB.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
         cmdB.Parameters.Append cmdB.CreateParameter("@WEBPERSONPERMISSIONID", adInteger, adParamInputOutput)
         cmdB.Parameters.Append cmdB.CreateParameter("@WEBPERSONID", adInteger, adParamInput)
         cmdB.Parameters.Append cmdB.CreateParameter("@PERMISSIONID", adInteger, adParamInput)
         cmdB.Parameters("@WEBPERSONPERMISSIONID").Value = NULL
         cmdB.Parameters("@WEBPERSONID").Value = UserID
         cmdB.Parameters("@PERMISSIONID").Value = PERMISSIONID
         cmdB.Execute
      END IF
   END IF

  ' Now that updates/inserts/deletes are complete get the record set
    Set RSPERM = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_PermissionBYPermType"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@PERMISSIONTYPEID", adInteger, adParamInput)
    cmd.Parameters("@PERMISSIONTYPEID").Value = request("permtype")
    set RSPERM= cmd.execute

    ' Pick the FunctionIDs 1=Navigation, 2=Reports, 3=Buttons, 4=Functions
    IF request("permtype") = "1" then
       Set RSFUNCTION = Server.CreateObject("ADODB.Recordset")
       RSFUNCTION.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
       RSFUNCTION.Source = "{call dbo.SPS_Navigation}"
       RSFUNCTION.CursorType = 0
       RSFUNCTION.CursorLocation = 2
       RSFUNCTION.LockType = 1
       RSFUNCTION.Open()
    End IF
    IF request("permtype") = "2" then
       Set RSFUNCTION = Server.CreateObject("ADODB.Recordset")
       RSFUNCTION.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
       RSFUNCTION.Source = "{call dbo.SPS_Report}"
       RSFUNCTION.CursorType = 0
       RSFUNCTION.CursorLocation = 2
       RSFUNCTION.LockType = 1
       RSFUNCTION.Open()
    End IF
    IF request("permtype") = "3" then
       Set RSFUNCTION = Server.CreateObject("ADODB.Recordset")
       RSFUNCTION.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
       RSFUNCTION.Source = "{call dbo.SPS_Button}"
       RSFUNCTION.CursorType = 0
       RSFUNCTION.CursorLocation = 2
       RSFUNCTION.LockType = 1
       RSFUNCTION.Open()
    End IF
    IF request("permtype") = "4" then
       Set RSFUNCTION = Server.CreateObject("ADODB.Recordset")
       RSFUNCTION.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
       RSFUNCTION.Source = "{call dbo.SPS_Functions}"
       RSFUNCTION.CursorType = 0
       RSFUNCTION.CursorLocation = 2
       RSFUNCTION.LockType = 1
       RSFUNCTION.Open()
    End IF

%>
<html>
<head>
<title>Permission Admin.</title>
</head>
<body bgcolor="#F5EBDD" text="#000000">
<% IF NOT RSFUNCTION.EOF then%>
  <table border="0" cellPadding="0" cellSpacing="0" width="450" bgColor="#112084">
    <tr>
        <td width="450"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Permission Administration</b></font></td>
    </tr>
  </table>
<TABLE border=0>
<TR>
<TD></TD>
<TD><font color="000099"><B>PERMISSION NAME</B></font></TD>
<TD><font color="000099"><B>FUNCTION</B></font></TD>
<TD><font color="000099"><B>PERMISSION DESCRIPTION</B></font></TD>
<TD><font color="000099"><B>ACTIVE</B></font></TD>
</TR>
<form action="permissionadmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="permform" method="post">
<input type="hidden" name="permtype" value="<%=request("permtype")%>" />
<input type="hidden" name="permissionid" value="<%=RSPERM("PERMISSIONID")%>" />
<%
DO WHILE NOT RSPERM.EOF
%>
<TR>
<TD></TD>
<TD><input type="text" name="PERMISSIONNAME_<%=RSPERM("PERMISSIONID")%>" value="<%=RSPERM("PERMISSIONNAME")%>" size="25" maxlength="255" /></TD>
<TD>
<select name="FUNCTIONID_<%=RSPERM("PERMISSIONID")%>" size="1">
<option value="">----------------------</option>
<% DO WHILE NOT RSFUNCTION.EOF
IF request("permtype") = "1" then%>
   <option value="<%=RSFUNCTION("NAVID")%>" <%IF RSPERM("FunctionID") = RSFUNCTION("NAVID") then response.write("selected") end if%>><%=RSFUNCTION("HREFTEXT")%></option>
<%END IF
IF request("permtype") = "2" then%>
   <option value="<%=RSFUNCTION("ReportID")%>" <%IF RSPERM("FunctionID") = RSFUNCTION("REPORTID") then response.write("selected") end if%>><%=RSFUNCTION("ReportDisplayName")%></option>
<%END IF
IF request("permtype") = "3" then%>
   <option value="<%=RSFUNCTION("ButtonID")%>" <%IF RSPERM("FunctionID") = RSFUNCTION("BUTTONID") then response.write("selected") end if%>><%=RSFUNCTION("ButtonName")%></option>
<%END IF
IF request("permtype") = "4" then%>
   <option value="<%=RSFUNCTION("FunctionID")%>" <%IF RSPERM("FunctionID") = RSFUNCTION("FUNCTIONID") then response.write("selected") end if%>><%=RSFUNCTION("FunctionName")%></option>
<%END IF
RSFUNCTION.MOVENEXT
Loop
RSFUNCTION.MOVEFIRST
%>
</select>


</TD>
<TD><input type="text" name="PERMISSIONDESCRIPTION_<%=RSPERM("PERMISSIONID")%>" value="<%=RSPERM("PERMISSIONDESCRIPTION")%>" size="50" maxlength="255" /></TD>
<TD align="center"><% IF RSPERM("ACTIVE") then%>
<input type="checkbox" name="active_<%=RSPERM("PERMISSIONID")%>" checked />
<%ELSE%>
<input type="checkbox" name="active_<%=RSPERM("PERMISSIONID")%>" />
<%END iF%>
</TD>
</TR>
<%
RSPERM.MOVENEXT
Loop
%>
<TR>
<TD align="right"><font color="000099"><B>Add New</B></font></TD>
<TD><input type="text" name="PERMISSIONNAME_New" value="" size="25" maxlength="255" /></TD>
<TD><select name="FUNCTIONID_New" size="1">
<option value="" selected>----------------------</option>
<% DO WHILE NOT RSFUNCTION.EOF
IF request("permtype") = "1" then%>
   <option value="<%=RSFUNCTION("NAVID")%>"><%=RSFUNCTION("HREFTEXT")%></option>
<%END IF
IF request("permtype") = "2" then%>
   <option value="<%=RSFUNCTION("ReportID")%>"><%=RSFUNCTION("ReportDisplayName")%></option>
<%END IF
IF request("permtype") = "3" then%>
   <option value="<%=RSFUNCTION("ButtonID")%>"><%=RSFUNCTION("ButtonName")%></option>
<%END IF
IF request("permtype") = "4" then%>
   <option value="<%=RSFUNCTION("FunctionID")%>"><%=RSFUNCTION("FunctionName")%></option>
<%END IF%>
<%
RSFUNCTION.MOVENEXT
Loop
%>
</select></TD>
<TD><input type="text" name="PERMISSIONDESCRIPTION_New" value="" size="50" maxlength="255" /></TD>
<TD align="center"><input type="checkbox" name="active_New" checked /></TD>
</TR>
<TR>
<TD></TD>
<td colspan=8>
<input type="submit" name="submitform" value="Submit" />
<input type="reset" name="resetform" value="Reset" />
</TD>
</TR>
</form>

<%ELSE%>
<font color="red">No elements exist for assignment of permissions for this permission type.</font>
<%END IF%>
</body>
</HTML>
<% END IF %>