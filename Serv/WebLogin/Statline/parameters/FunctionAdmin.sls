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
DIM cmd, RSFunc, RSFuncLOOP
'Verify Access
If AuthorizeMain Then
   'Ready to update
   IF Request.ServerVariables("REQUEST_METHOD") = "POST" then
      Set RSFuncLOOP = Server.CreateObject("ADODB.Recordset")
      Set cmd = Server.CreateObject("ADODB.Command")
      cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
      cmd.CommandText = "SPS_Functions"
      cmd.CommandType = adCmdStoredProc
      cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
      cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
      cmd.Parameters("@FUNCTIONID").Value = NULL
      set RSFuncLOOP = cmd.execute

      DO WHILE NOT RSFuncLOOP.EOF
         IF (EVAL("request(" & String(1,34) & "delete_" & RSFuncLOOP("FUNCTIONID") & String(1,34) & ")") = "on") then
              Set cmd = Server.CreateObject("ADODB.Command")
              cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
              cmd.CommandText = "SPD_Functions"
              cmd.CommandType = adCmdStoredProc
              cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
              cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
              cmd.Parameters("@FUNCTIONID").Value = RSFuncLOOP("FUNCTIONID")
              cmd.Execute
         Else
             Set cmd = Server.CreateObject("ADODB.Command")
             cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
             cmd.CommandText = "SPU_Functions"
             cmd.CommandType = adCmdStoredProc
             cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
             cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONNAME", adVarChar, adParamInput, 500)
             cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONSTRING", adVarChar, adParamInput, 1000)
             cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONDESCRIPTION", adVarChar, adParamInput, 1000)
             cmd.Parameters("@FUNCTIONID").Value = RSFuncLOOP("FUNCTIONID")
             cmd.Parameters("@FUNCTIONNAME").Value = EVAL("request(" & String(1,34) & "FUNCTIONNAME_" & RSFuncLOOP("FUNCTIONID") & String(1,34) & ")")
             cmd.Parameters("@FUNCTIONSTRING").Value = EVAL("request(" & String(1,34) & "FUNCTIONSTRING_" & RSFuncLOOP("FUNCTIONID") & String(1,34) & ")")
             cmd.Parameters("@FUNCTIONDESCRIPTION").Value = EVAL("request(" & String(1,34) & "FUNCTIONDESCRIPTION_" & RSFuncLOOP("FUNCTIONID") & String(1,34) & ")")
             cmd.Execute
         End if
      RSFuncLOOP.MOVENEXT
      Loop
      IF request("FUNCTIONNAME_New") <> "" then
         Set cmd = Server.CreateObject("ADODB.Command")
         cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
         cmd.CommandText = "SPI_Functions"
         cmd.CommandType = adCmdStoredProc
         cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
         cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInputOutput)
         cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONNAME", adVarChar, adParamInput, 500)
         cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONSTRING", adVarChar, adParamInput, 1000)
         cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONDESCRIPTION", adVarChar, adParamInput, 1000)
         cmd.Parameters("@FUNCTIONID").Value = NULL
         cmd.Parameters("@FUNCTIONNAME").Value = request("FUNCTIONNAME_New")
         cmd.Parameters("@FUNCTIONSTRING").Value = request("FUNCTIONSTRING_New")
         cmd.Parameters("@FUNCTIONDESCRIPTION").Value = request("FUNCTIONDESCRIPTION_New")
         cmd.Execute
      END IF
   END IF

  ' Now that updates/inserts/deletes are complete get the record set
    Set RSFunc = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_Functions"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
    cmd.Parameters("@FUNCTIONID").Value = NULL
    set RSFunc= cmd.execute

%>
<html>
<head>
<title>Function Admin.</title>
</head>
<body bgcolor="#F5EBDD" text="#000000">
  <table border="0" cellPadding="0" cellSpacing="0" width="450" bgColor="#112084">
    <tr>
        <td width="450"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Function Administration</b></font></td>
    </tr>
  </table>

<TABLE border=0>
<TR>
<TD></TD>
<TD><font color="000099"><B>ACTION</B></font></TD>
<TD><font color="000099"><B>FUNCTION NAME</B></font></TD>
<TD><font color="000099"><B>FUNCTION<BR>STRING</B></font></TD>
<TD><font color="000099"><B>FUNCTION DESCRIPTION</B></font></TD>
</TR>
<form action="Functionadmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="functionform" method="post">
<input type="hidden" name="FUNCTIONID" value="<%=RSFunc("FUNCTIONID")%>" />
<%
DO WHILE NOT RSFunc.EOF
%>
<TR>
<TD></TD>
<TD align="center"><input type="checkbox" name="delete_<%=RSFunc("FUNCTIONID")%>" /></TD>
<TD><input type="text" name="FUNCTIONNAME_<%=RSFunc("FUNCTIONID")%>" value="<%=RSFunc("FUNCTIONNAME")%>" size="35" maxlength="255" /></TD>
<TD><input type="text" name="FUNCTIONSTRING_<%=RSFunc("FUNCTIONID")%>" value="<%=RSFunc("FUNCTIONSTRING")%>" size="10" maxlength="255" /></TD>
<TD><input type="text" name="FUNCTIONDESCRIPTION_<%=RSFunc("FUNCTIONID")%>" value="<%=RSFunc("FUNCTIONDESCRIPTION")%>" size="35" maxlength="255" /></TD>
</TR>
<%
RSFunc.MOVENEXT
Loop
%>
<TR>
<TD colspan="2" align="right"><font color="000099"><B>Add New</B></font></TD>
<TD><input type="text" name="FUNCTIONNAME_New" value="" size="35" maxlength="255" /></TD>
<TD><input type="text" name="FUNCTIONSTRING_New" value="" size="10" maxlength="255" /></TD>
<TD><input type="text" name="FUNCTIONDESCRIPTION_New" value="" size="35" maxlength="255" /></TD>
</TR>
<TR>
<TD></TD>
<td colspan=8>
<input type="submit" name="submitform" value="Submit" />
<input type="reset" name="resetform" value="Reset" />
</TD>
</TR>
</form>
<% END IF %>
</body>
</HTML>