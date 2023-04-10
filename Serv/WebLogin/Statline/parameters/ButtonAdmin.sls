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
DIM cmd, RSBUTTON, RSBUTTONLOOP
'Verify Access
If AuthorizeMain Then
   'Ready to update
   IF Request.ServerVariables("REQUEST_METHOD") = "POST" then
      Set RSBUTTONLOOP = Server.CreateObject("ADODB.Recordset")
      Set cmd = Server.CreateObject("ADODB.Command")
      cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
      cmd.CommandText = "SPS_BUTTON"
      cmd.CommandType = adCmdStoredProc
      cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
      cmd.Parameters.Append cmd.CreateParameter("@BUTTONID", adInteger, adParamInput)
      cmd.Parameters("@BUTTONID").Value = NULL
      set RSBUTTONLOOP = cmd.execute

      do WHILE NOT RSBUTTONLOOP.EOF
         IF (EVAL("request(" & String(1,34) & "delete_" & RSBUTTONLOOP("BUTTONID") & String(1,34) & ")") = "on") then
              Set cmd = Server.CreateObject("ADODB.Command")
              cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
              cmd.CommandText = "SPD_BUTTON"
              cmd.CommandType = adCmdStoredProc
              cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
              cmd.Parameters.Append cmd.CreateParameter("@BUTTONID", adInteger, adParamInput)
              cmd.Parameters("@BUTTONID").Value = RSBUTTONLOOP("BUTTONID")
              cmd.Execute
         Else
             Set cmd = Server.CreateObject("ADODB.Command")
             cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
             cmd.CommandText = "SPU_BUTTON"
             cmd.CommandType = adCmdStoredProc
             cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
             cmd.Parameters.Append cmd.CreateParameter("@BUTTONID", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@BUTTONNAME", adVarChar, adParamInput, 500)
             cmd.Parameters.Append cmd.CreateParameter("@BUTTONSTRING", adVarChar, adParamInput, 1000)
             cmd.Parameters.Append cmd.CreateParameter("@BUTTONDESCRIPTION", adVarChar, adParamInput, 1000)
             cmd.Parameters("@BUTTONID").Value = RSBUTTONLOOP("BUTTONID")
             cmd.Parameters("@BUTTONNAME").Value = EVAL("request(" & String(1,34) & "BUTTONNAME_" & RSBUTTONLOOP("BUTTONID") & String(1,34) & ")")
             cmd.Parameters("@BUTTONSTRING").Value = EVAL("request(" & String(1,34) & "BUTTONSTRING_" & RSBUTTONLOOP("BUTTONID") & String(1,34) & ")")
             cmd.Parameters("@BUTTONDESCRIPTION").Value = EVAL("request(" & String(1,34) & "BUTTONDESCRIPTION_" & RSBUTTONLOOP("BUTTONID") & String(1,34) & ")")
             cmd.Execute
         End if
      RSBUTTONLOOP.MOVENEXT
      Loop
      IF request("BUTTONNAME_New") <> "" then
         Set cmd = Server.CreateObject("ADODB.Command")
         cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
         cmd.CommandText = "SPI_BUTTON"
         cmd.CommandType = adCmdStoredProc
         cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
         cmd.Parameters.Append cmd.CreateParameter("@BUTTONID", adInteger, adParamInputOutput)
         cmd.Parameters.Append cmd.CreateParameter("@BUTTONNAME", adVarChar, adParamInput, 500)
         cmd.Parameters.Append cmd.CreateParameter("@BUTTONSTRING", adVarChar, adParamInput, 1000)
         cmd.Parameters.Append cmd.CreateParameter("@BUTTONDESCRIPTION", adVarChar, adParamInput, 1000)
         cmd.Parameters("@BUTTONID").Value = NULL
         cmd.Parameters("@BUTTONNAME").Value = request("BUTTONNAME_New")
         cmd.Parameters("@BUTTONSTRING").Value = request("BUTTONSTRING_New")
         cmd.Parameters("@BUTTONDESCRIPTION").Value = request("BUTTONDESCRIPTION_New")
         cmd.Execute
      END IF
   END IF

  ' Now that updates/inserts/deletes are complete get the record set
    Set RSBUTTON = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_BUTTON"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@BUTTONID", adInteger, adParamInput)
    cmd.Parameters("@BUTTONID").Value = NULL
    set RSBUTTON= cmd.execute

%>
<html>
<head>
<title>BUTTON Admin.</title>
</head>
<body bgcolor="#F5EBDD" text="#000000">
  <table border="0" cellPadding="0" cellSpacing="0" width="450" bgColor="#112084">
    <tr>
        <td width="450"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Button Administration</b></font></td>
    </tr>
  </table>

<TABLE border=0>
<TR>
<TD></TD>
<TD><font color="000099"><B>ACTION</B></font></TD>
<TD><font color="000099"><B>BUTTON NAME</B></font></TD>
<TD><font color="000099"><B>BUTTON<BR>STRING</B></font></TD>
<TD><font color="000099"><B>BUTTON DESCRIPTION</B></font></TD>
</TR>
<form action="BUTTONadmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="buttonform" method="post">

<% If Not RSBUTTON.Eof Then %>
	<input type="hidden" name="BUTTONID" value="<%=RSBUTTON("BUTTONID")%>" />
<% End If %>

<%
DO WHILE NOT RSBUTTON.EOF
%>
<TR>
<TD></TD>
<TD align="center"><input type="checkbox" name="delete_<%=RSBUTTON("BUTTONID")%>" /></TD>
<TD><input type="text" name="BUTTONNAME_<%=RSBUTTON("BUTTONID")%>" value="<%=RSBUTTON("BUTTONNAME")%>" size="35" maxlength="255" /></TD>
<TD><input type="text" name="BUTTONSTRING_<%=RSBUTTON("BUTTONID")%>" value="<%=RSBUTTON("BUTTONSTRING")%>" size="10" maxlength="255" /></TD>
<TD><input type="text" name="BUTTONDESCRIPTION_<%=RSBUTTON("BUTTONID")%>" value="<%=RSBUTTON("BUTTONDESCRIPTION")%>" size="35" maxlength="255" /></TD>
</TR>
<%
RSBUTTON.MOVENEXT
Loop
%>
<TR>
<TD colspan="2" align="right"><font color="000099"><B>Add New</B></font></TD>
<TD><input type="text" name="BUTTONNAME_New" value="" size="35" maxlength="255" /></TD>
<TD><input type="text" name="BUTTONSTRING_New" value="" size="10" maxlength="255" /></TD>
<TD><input type="text" name="BUTTONDESCRIPTION_New" value="" size="35" maxlength="255" /></TD>
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