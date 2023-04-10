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
DIM cmd, RSNAV, RSNAVLOOP
'Verify Access
If AuthorizeMain Then
   'Ready to update
   IF Request.ServerVariables("REQUEST_METHOD") = "POST" then
      Set RSNAVLOOP = Server.CreateObject("ADODB.Recordset")
      Set cmd = Server.CreateObject("ADODB.Command")
      cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
      cmd.CommandText = "SPS_NavigationBYNavType"
      cmd.CommandType = adCmdStoredProc
      cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
      cmd.Parameters.Append cmd.CreateParameter("@NAVTYPEID", adInteger, adParamInput)
      cmd.Parameters("@NAVTYPEID").Value = request("navtype")
      set RSNAVLOOP= cmd.execute

      DO WHILE NOT RSNAVLOOP.EOF
         IF (EVAL("request(" & String(1,34) & "delete_" & RSNAVLOOP("NAVID") & String(1,34) & ")") = "on") then
              Set cmd = Server.CreateObject("ADODB.Command")
              cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
              cmd.CommandText = "SPD_Navigation"
              cmd.CommandType = adCmdStoredProc
              cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
              cmd.Parameters.Append cmd.CreateParameter("@NAVID", adInteger, adParamInput)
              cmd.Parameters("@NAVID").Value = RSNAVLOOP("NAVID")
              cmd.Execute
         Else
             Set cmd = Server.CreateObject("ADODB.Command")
             cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
             cmd.CommandText = "SPU_Navigation"
             cmd.CommandType = adCmdStoredProc
             cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
             cmd.Parameters.Append cmd.CreateParameter("@NAVID", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@NAVTYPEID", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@HREF", adVarChar, adParamInput, 1000)
             cmd.Parameters.Append cmd.CreateParameter("@HREFTEXT", adVarChar, adParamInput, 1000)
             cmd.Parameters.Append cmd.CreateParameter("@TARGET", adVarChar, adParamInput, 50)
             cmd.Parameters.Append cmd.CreateParameter("@IMAGE", adVarChar, adParamInput, 1000)
             cmd.Parameters.Append cmd.CreateParameter("@IMAGEOVER", adVarChar, adParamInput, 1000)
             cmd.Parameters.Append cmd.CreateParameter("@SEQ", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ACTIVE", adBoolean, adParamInput)
             cmd.Parameters("@NAVID").Value = RSNAVLOOP("NAVID")
             cmd.Parameters("@NAVTYPEID").Value = request("navtype")
             cmd.Parameters("@HREF").Value = EVAL("request(" & String(1,34) & "href_" & RSNAVLOOP("NAVID") & String(1,34) & ")")
             cmd.Parameters("@HREFTEXT").Value = EVAL("request(" & String(1,34) & "HREFTEXT_" & RSNAVLOOP("NAVID") & String(1,34) & ")")
             cmd.Parameters("@TARGET").Value = EVAL("request(" & String(1,34) & "TARGET_" & RSNAVLOOP("NAVID") & String(1,34) & ")")
             cmd.Parameters("@IMAGE").Value = EVAL("request(" & String(1,34) & "IMAGE_" & RSNAVLOOP("NAVID") & String(1,34) & ")")
             cmd.Parameters("@IMAGEOVER").Value = EVAL("request(" & String(1,34) & "IMAGEOVER_" & RSNAVLOOP("NAVID") & String(1,34) & ")")
             cmd.Parameters("@SEQ").Value = EVAL("request(" & String(1,34) & "SEQ_" & RSNAVLOOP("NAVID") & String(1,34) & ")")
             IF (EVAL("request(" & String(1,34) & "ACTIVE_" & RSNAVLOOP("NAVID") & String(1,34) & ")") = "on") then
                cmd.Parameters("@ACTIVE").Value = 1
             ELSE
                cmd.Parameters("@ACTIVE").Value = 0
             END IF
             cmd.Execute
         End if
      RSNAVLOOP.MOVENEXT
      Loop
      IF request("href_New") <> "" then
         Set cmd = Server.CreateObject("ADODB.Command")
         cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
         cmd.CommandText = "SPI_Navigation"
         cmd.CommandType = adCmdStoredProc

         cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
         cmd.Parameters.Append cmd.CreateParameter("@NAVID", adInteger, adParamInputOutput)
         cmd.Parameters.Append cmd.CreateParameter("@NAVTYPEID", adInteger, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@HREF", adVarChar, adParamInput, 1000)
         cmd.Parameters.Append cmd.CreateParameter("@HREFTEXT", adVarChar, adParamInput, 1000)
         cmd.Parameters.Append cmd.CreateParameter("@TARGET", adVarChar, adParamInput, 50)
         cmd.Parameters.Append cmd.CreateParameter("@IMAGE", adVarChar, adParamInput, 1000)
         cmd.Parameters.Append cmd.CreateParameter("@IMAGEOVER", adVarChar, adParamInput, 1000)
         cmd.Parameters.Append cmd.CreateParameter("@SEQ", adInteger, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ACTIVE", adBoolean, adParamInput)
         cmd.Parameters("@NAVID").Value = NULL
         cmd.Parameters("@NAVTYPEID").Value = request("navtype")
         cmd.Parameters("@HREF").Value = request("HREF_New")
         cmd.Parameters("@HREFTEXT").Value = request("HREFTEXT_New")
         cmd.Parameters("@TARGET").Value = request("TARGET_New")
         cmd.Parameters("@IMAGE").Value = request("IMAGE_New")
         cmd.Parameters("@IMAGEOVER").Value = request("IMAGEOVER_New")
         cmd.Parameters("@SEQ").Value = request("SEQ_New")
         cmd.Parameters("@ACTIVE").Value = 1
         cmd.Execute
      END IF
   END IF

  ' Now that updates/inserts/deletes are complete get the record set
    Set RSNAV = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
      cmd.CommandText = "SPS_NavigationBYNavType"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@NAVTYPEID", adInteger, adParamInput)
    cmd.Parameters("@NAVTYPEID").Value = request("navtype")
    set RSNAV= cmd.execute

%>
<html>
<head>
<title>Navigation Admin.</title>
</head>
<body bgcolor="#F5EBDD" text="#000000">
  <table border="0" cellPadding="0" cellSpacing="0" width="450" bgColor="#112084">
    <tr>
        <td width="450"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Navigation Administration</b></font></td>
    </tr>
  </table>

<TABLE border=0>
<TR>
<TD><font color="000099"><B>VIEW</B></font></TD>
<TD><font color="000099"><B>DELETE</B></font></TD>
<TD><font color="000099"><B>HREF</B></font></TD>
<TD><font color="000099"><B>HREF TEXT</B></font></TD>
<TD><font color="000099"><B>TARGET</B></font></TD>
<TD><font color="000099"><B>IMAGE</B></font></TD>
<TD><font color="000099"><B>IMAGE OVER</B></font></TD>
<TD><font color="000099"><B>SEQ</B></font></TD>
<TD><font color="000099"><B>ACTIVE</B></font></TD>
</TR>
<form action="navigationadmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="navform" method="post">
<input type="hidden" name="navtype" value="<%=request("navtype")%>" />
<input type="hidden" name="navid" value="<%=RSNAV("navid")%>" />
<%
DO WHILE NOT RSNAV.EOF
%>
<TR>
<TD><%response.write("<A HREF='" & RSNAV("href") & "?UserID=" & UserID & "&UserOrgID=" & UserOrgID & "' TARGET='" & RSNAV("target") & "'><IMG SRC='" & RSNAV("image") & "' ALT=" & RSNAV("hreftext") & " BORDER='0'></A>")%></TD>
<TD align="center"><input type="checkbox" name="delete_<%=RSNAV("navid")%>" /></TD>
<TD><input type="text" name="href_<%=RSNAV("navid")%>" value="<%=RSNAV("HREF")%>" size="25" maxlength="255" /></TD>
<TD><input type="text" name="hreftext_<%=RSNAV("navid")%>" value="<%=RSNAV("HREFTEXT")%>" size="10" maxlength="255" /></TD>
<TD><input type="text" name="target_<%=RSNAV("navid")%>" value="<%=RSNAV("TARGET")%>" size="10" maxlength="255" /></TD>
<TD><input type="text" name="image_<%=RSNAV("navid")%>" value="<%=RSNAV("IMAGE")%>" size="25" maxlength="255" /></TD>
<TD><input type="text" name="imageover_<%=RSNAV("navid")%>" value="<%=RSNAV("IMAGEOVER")%>" size="25" maxlength="255" /></TD>
<TD><input type="text" name="Seq_<%=RSNAV("navid")%>" value="<%=RSNAV("SEQ")%>" size="2" maxlength="2" /></TD>
<TD align="center"><% IF RSNAV("ACTIVE") then%>
<input type="checkbox" name="active_<%=RSNAV("navid")%>" checked />
<%ELSE%>
<input type="checkbox" name="active_<%=RSNAV("navid")%>" />
<%END iF%>
</TD>
</TR>
<%
RSNAV.MOVENEXT
Loop
%>
<TR>
<TD colspan="2" align="right"><font color="000099"><B>Add New</B></font></TD>
<TD><input type="text" name="href_New" value="" size="25" maxlength="255" /></TD>
<TD><input type="text" name="hreftext_New" value="" size="10" maxlength="255" /></TD>
<TD><input type="text" name="target_New" value="" size="10" maxlength="255" /></TD>
<TD><input type="text" name="image_New" value="" size="25" maxlength="255" /></TD>
<TD><input type="text" name="imageover_New" value="" size="25" maxlength="255" /></TD>
<TD><input type="text" name="Seq_New" value="" size="2" maxlength="2" /></TD>
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
<% END IF %>
</body>
</HTML>