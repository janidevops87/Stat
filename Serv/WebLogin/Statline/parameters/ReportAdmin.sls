<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim PERMISSIONID
Dim cmdB
Dim nReportInDevelopment, nReportFromDate, nReportToDate, nReportGroup, nReportOrganization, nReportSortOrderID, nReportTypeID

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
DIM cmd, RSREPORT, RSREPORTLOOP, RSREPORTTYPE
'Verify Access
If AuthorizeMain Then
   'Ready to update
   IF Request.ServerVariables("REQUEST_METHOD") = "POST" then
      Set RSREPORTLOOP = Server.CreateObject("ADODB.Recordset")
      Set cmd = Server.CreateObject("ADODB.Command")
      cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
      cmd.CommandText = "SPS_Report"
      cmd.CommandType = adCmdStoredProc
      cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
      cmd.Parameters.Append cmd.CreateParameter("@REPORTID", adInteger, adParamInput)
      cmd.Parameters("@REPORTID").Value = NULL
      Set RSREPORTLOOP = cmd.execute

      DO WHILE NOT RSREPORTLOOP.EOF
             Set cmd = Server.CreateObject("ADODB.Command")
             cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
             cmd.CommandText = "SPU_Report"
             cmd.CommandType = adCmdStoredProc
             cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
             cmd.Parameters.Append cmd.CreateParameter("@ReportID", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportDisplayName", adVarChar, adParamInput, 50)
             cmd.Parameters.Append cmd.CreateParameter("@LastModified", adDBTimeStamp, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportLocalOnly", adInteger, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportVirtualURL", adVarChar, adParamInput, 100)
             cmd.Parameters.Append cmd.CreateParameter("@ReportTypeID", adSmallInt, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@Unused", adVarBinary, adParamInput, 50)
             cmd.Parameters.Append cmd.CreateParameter("@ReportDescFileName", adVarChar, adParamInput, 50)
             cmd.Parameters.Append cmd.CreateParameter("@UpdatedFlag", adSmallInt, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportSortOrderID", adSmallInt, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportInDevelopment", adSmallInt, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportFromDate", adSmallInt, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportToDate", adSmallInt, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportGroup", adSmallInt, adParamInput)
             cmd.Parameters.Append cmd.CreateParameter("@ReportOrganization", adSmallInt, adParamInput)

             cmd.Parameters("@ReportID").Value = RSREPORTLOOP("REPORTID")
             cmd.Parameters("@ReportDisplayName").Value = EVAL("request(" & String(1,34) & "ReportDisplayName_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             cmd.Parameters("@LastModified").Value = date()
             cmd.Parameters("@ReportLocalOnly").Value = EVAL("request(" & String(1,34) & "ReportLocalOnly_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             cmd.Parameters("@ReportVirtualURL").Value = EVAL("request(" & String(1,34) & "ReportVirtualURL_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             nReportTypeID=EVAL("request(" & String(1,34) & "ReportTypeID_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             IF nReportTypeID = "" then
                nReportTypeID = NULL
             END IF
             cmd.Parameters("@ReportTypeID").Value = nReportTypeID
             cmd.Parameters("@Unused").Value = NULL
             cmd.Parameters("@ReportDescFileName").Value = EVAL("request(" & String(1,34) & "ReportDescFileName_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             cmd.Parameters("@UpdatedFlag").Value = NULL
             nReportSortOrderID=EVAL("request(" & String(1,34) & "ReportSortOrderID_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             IF nReportSortOrderID = "" then
                nReportSortOrderID = NULL
             END IF
             cmd.Parameters("@ReportSortOrderID").Value = nReportSortOrderID
             nReportInDevelopment=EVAL("request(" & String(1,34) & "ReportInDevelopment_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             IF nReportInDevelopment = "" then
                nReportInDevelopment = NULL
             END IF
             cmd.Parameters("@ReportInDevelopment").Value = nReportInDevelopment
             nReportFromDate=EVAL("request(" & String(1,34) & "ReportFromDate_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             IF nReportFromDate = "" then
                nReportFromDate = NULL
             END IF
             cmd.Parameters("@ReportFromDate").Value = nReportFromDate
             nReportToDate=EVAL("request(" & String(1,34) & "ReportToDate_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             IF nReportToDate = "" then
                nReportToDate = NULL
             END IF
             cmd.Parameters("@ReportToDate").Value = nReportToDate
             nReportGroup=EVAL("request(" & String(1,34) & "ReportGroup_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             IF nReportGroup = "" then
                nReportGroup = NULL
             END IF
             cmd.Parameters("@ReportGroup").Value = nReportGroup
             nReportOrganization=EVAL("request(" & String(1,34) & "ReportOrganization_" & RSREPORTLOOP("REPORTID") & String(1,34) & ")")
             IF nReportOrganization = "" then
                nReportOrganization = NULL
             END IF
             cmd.Parameters("@ReportOrganization").Value = nReportOrganization
             cmd.Execute
      RSREPORTLOOP.MOVENEXT
      Loop

      IF request("ReportDisplayName_NEW") <> "" then
         'Add the new report to the DB
         Set cmd = Server.CreateObject("ADODB.Command")
         cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
         cmd.CommandText = "SPI_Report"
         cmd.CommandType = adCmdStoredProc
         cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
         cmd.Parameters.Append cmd.CreateParameter("ReportID", adInteger, adParamOutput, -1)
         cmd.Parameters.Append cmd.CreateParameter("@ReportDisplayName", adVarChar, adParamInput, 50)
         cmd.Parameters.Append cmd.CreateParameter("@LastModified", adDBTimeStamp, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ReportLocalOnly", adInteger, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ReportVirtualURL", adVarChar, adParamInput, 100)
         cmd.Parameters.Append cmd.CreateParameter("@ReportTypeID", adSmallInt, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@Unused", adVarBinary, adParamInput, 50)
         cmd.Parameters.Append cmd.CreateParameter("@ReportDescFileName", adVarChar, adParamInput, 50)
         cmd.Parameters.Append cmd.CreateParameter("@UpdatedFlag", adSmallInt, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ReportSortOrderID", adSmallInt, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ReportInDevelopment", adSmallInt, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ReportFromDate", adSmallInt, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ReportToDate", adSmallInt, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ReportGroup", adSmallInt, adParamInput)
         cmd.Parameters.Append cmd.CreateParameter("@ReportOrganization", adSmallInt, adParamInput)

         cmd.Parameters("@ReportDisplayName").Value = request("ReportDisplayName_new")
         cmd.Parameters("@LastModified").Value = DATE()
         cmd.Parameters("@ReportLocalOnly").Value = request("ReportLocalOnly_new")
         cmd.Parameters("@ReportVirtualURL").Value = request("ReportVirtualURL_new")
         nReportTypeID=request("ReportTypeID_new")
         IF nReportTypeID = "" then
            nReportTypeID = NULL
         END IF
         cmd.Parameters("@ReportTypeID").Value = nReportTypeID
         cmd.Parameters("@Unused").Value = NULL
         cmd.Parameters("@ReportDescFileName").Value = request("ReportDescFileName_new")
         cmd.Parameters("@UpdatedFlag").Value = NULL
         nReportSortOrderID=request("ReportSortOrderID_new")
         IF nReportSortOrderID = "" then
            nReportSortOrderID = NULL
         END IF
         cmd.Parameters("@ReportSortOrderID").Value = nReportSortOrderID
         nReportInDevelopment=request("ReportInDevelopment_new")
         IF nReportInDevelopment = "" then
            nReportInDevelopment = NULL
         END IF
         cmd.Parameters("@ReportInDevelopment").Value = nReportInDevelopment
         nReportFromDate=request("ReportFromDate_new")
         IF nReportFromDate = "" then
            nReportFromDate = NULL
         END IF
         cmd.Parameters("@ReportFromDate").Value = nReportFromDate
         nReportToDate=request("ReportToDate_new")
         IF nReportToDate = "" then
            nReportToDate = NULL
         END IF
         cmd.Parameters("@ReportToDate").Value = nReportToDate
         nReportGroup=request("ReportGroup_new")
         IF nReportGroup = "" then
            nReportGroup = NULL
         END IF
         cmd.Parameters("@ReportGroup").Value = nReportGroup
         nReportOrganization=request("ReportOrganization_new")
         IF nReportOrganization = "" then
            nReportOrganization = NULL
         END IF
         cmd.Parameters("@ReportOrganization").Value = nReportOrganization
         cmd.Execute
         REPORTID=Cmd.Parameters("REPORTID")
      END IF
   END IF

  ' Now that updates/inserts/deletes are complete get the record set
    Set RSREPORT = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_Report"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@REPORTID", adInteger, adParamInput)
    cmd.Parameters("@REPORTID").Value = NULL
    Set RSREPORT = cmd.execute

    Set RSREPORTTYPE = Server.CreateObject("ADODB.Recordset")
    RSREPORTTYPE.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    RSREPORTTYPE.Source = "{call dbo.SPS_Reporttype}"
    RSREPORTTYPE.CursorType = 0
    RSREPORTTYPE.CursorLocation = 2
    RSREPORTTYPE.LockType = 1
    RSREPORTTYPE.Open()
%>
<html>
<head>
<title>Report Admin.</title>
</head>
<body bgcolor="#F5EBDD" text="#000000">
  <table border="0" cellPadding="0" cellSpacing="0" width="450" bgColor="#112084">
    <tr>
        <td width="450"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Report Administration</b></font></td>
    </tr>
  </table>
<TABLE border=0>
<TR>
<TD></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Name</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Local<BR>Only</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Virtual URL</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Type</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report Desc<BR>File Name</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Sort<BR>Order</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report In<BR>Dev</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Display<BR>From Date</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Display<BR>To Date</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Display<BR>Report Group</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Org</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Last<BR>Modified</B></font></TD>
</TR>
<form action="reportadmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="reportform" method="post">
<%
DO WHILE NOT RSREPORT.EOF
%>
<TR>
<TD></TD>
<input type="hidden" name="ReportID_<%=RSREPORT("ReportID")%>" value="<%=RSREPORT("ReportID")%>" size="4" maxlength="4" />
<TD><input type="text" name="ReportDisplayName_<%=RSREPORT("ReportID")%>" value="<%=RSREPORT("ReportDisplayName")%>" size="25" maxlength="255" /></TD>
<TD>
<select name="ReportLocalOnly_<%=RSREPORT("ReportID")%>" size="1">
<option value="0">------</option>
<option value="0" <%IF RSREPORT("ReportLocalOnly") = 0 then response.write("selected") end if%>>No</option>
<option value="-1" <%IF RSREPORT("ReportLocalOnly") = -1 then response.write("selected") end if%>>Yes</option>
</select>
</TD>
<TD><input type="text" name="ReportVirtualURL_<%=RSREPORT("ReportID")%>" value="<%=RSREPORT("ReportVirtualURL")%>" size="25" maxlength="255" /></TD>
<TD>
<select name="ReportTypeID_<%=RSREPORT("ReportID")%>" size="1">
<option value="">------</option>
<%
DO WHILE NOT RSREPORTTYPE.EOF%>
<option value="<%=RSREPORTTYPE("REPORTTYPEID")%>" <%IF RSREPORT("REPORTTYPEID") = RSREPORTTYPE("REPORTTYPEID") then response.write("selected") end if%>><%=RSREPORTTYPE("REPORTTYPENAME")%></option>
<%
RSREPORTTYPE.MOVENEXT
Loop
RSREPORTTYPE.MOVEFIRST
%>
</select>
</TD>
<TD><input type="text" name="ReportDescFileName_<%=RSREPORT("ReportID")%>" value="<%=RSREPORT("ReportDescFileName")%>" size="25" maxlength="255" /></TD>
<TD><input type="text" name="ReportSortOrderID_<%=RSREPORT("ReportID")%>" value="<%=RSREPORT("ReportSortOrderID")%>" size="2" maxlength="2" /></TD>
<TD>
<select name="ReportInDevelopment_<%=RSREPORT("ReportID")%>" size="1">
<option value="">------</option>
<option value="0" <%IF RSREPORT("ReportInDevelopment") = 0 then response.write("selected") end if%>>No</option>
<option value="1" <%IF RSREPORT("ReportInDevelopment") = 1 then response.write("selected") end if%>>Yes</option>
</select>
</TD>
<TD>
<select name="ReportFromDate_<%=RSREPORT("ReportID")%>" size="1">
<option value="">------</option>
<option value="0" <%IF RSREPORT("ReportFromDate") = 0 then response.write("selected") end if%>>No</option>
<option value="1" <%IF RSREPORT("ReportFromDate") = 1 then response.write("selected") end if%>>Yes</option>
</select>
</TD>
<TD>
<select name="ReportToDate_<%=RSREPORT("ReportID")%>" size="1">
<option value="">------</option>
<option value="0" <%IF RSREPORT("ReportToDate") = 0 then response.write("selected") end if%>>No</option>
<option value="1" <%IF RSREPORT("ReportToDate") = 1 then response.write("selected") end if%>>Yes</option>
</select>
</TD>

<TD>
<select name="ReportGroup_<%=RSREPORT("ReportID")%>" size="1">
<option value="">------</option>
<option value="0" <%IF RSREPORT("ReportGroup") = 0 then response.write("selected") end if%>>No</option>
<option value="1" <%IF RSREPORT("ReportGroup") = 1 then response.write("selected") end if%>>Yes</option>
</select>
</TD>
<TD><input type="text" name="ReportOrganization_<%=RSREPORT("ReportID")%>" value="<%=RSREPORT("ReportOrganization")%>" size="2" maxlength="2" /></TD>
<TD><font size="-3"><%=RSREPORT("LastModified")%></font></TD>
</TR>
<%
RSREPORT.MOVENEXT
Loop
%>
<TR>
<TD></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Name</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Local<BR>Only</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Virtual URL</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Type</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report Desc<BR>File Name</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Sort<BR>Order</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report In<BR>Dev</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Display<BR>From Date</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Display<BR>To Date</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Display<BR>Report Group</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Report<BR>Org</B></font></TD>
<TD></TD>
</TR>
<TR>
<TD align="right"><font color="000099"><B>Add New</B></font></TD>
<input type="hidden" name="ReportID_NEW" value="" size="4" maxlength="4" />
<TD><input type="text" name="ReportDisplayName_NEW" value="" size="25" maxlength="255" /></TD>
<TD>
<select name="ReportLocalOnly_NEW" size="1">
<option value="0">------</option>
<option value="0">No</option>
<option value="-1">Yes</option>
</select>
</TD>
<TD><input type="text" name="ReportVirtualURL_NEW" value="" size="25" maxlength="255" /></TD>
<TD>
<select name="ReportTypeID_NEW" size="1">
<option value="">------</option>
<%
DO WHILE NOT RSREPORTTYPE.EOF%>
<option value="<%=RSREPORTTYPE("REPORTTYPEID")%>"><%=RSREPORTTYPE("REPORTTYPENAME")%></option>
<%
RSREPORTTYPE.MOVENEXT
Loop
RSREPORTTYPE.MOVEFIRST
%>
</select>
</TD>
<TD><input type="text" name="ReportDescFileName_NEW" value="" size="25" maxlength="255" /></TD>
<TD><input type="text" name="ReportSortOrderID_NEW" value="" size="2" maxlength="2" /></TD>
<TD>
<select name="ReportInDevelopment_NEW" size="1">
<option value="">------</option>
<option value="0">No</option>
<option value="1">Yes</option>
</select>
</TD>
<TD>
<select name="ReportFromDate_NEW" size="1">
<option value="">------</option>
<option value="0">No</option>
<option value="1">Yes</option>
</select>
</TD>
<TD>
<select name="ReportToDate_NEW" size="1">
<option value="">------</option>
<option value="0">No</option>
<option value="1">Yes</option>
</select>
</TD>
<TD>
<select name="ReportGroup_NEW" size="1">
<option value="">------</option>
<option value="0">No</option>
<option value="1">Yes</option>
</select>
</TD>
<TD><input type="text" name="ReportOrganization_NEW" value="" size="2" maxlength="2" /></TD>
<TD></TD>
</TR>
<TR>
<TD></TD>
<td colspan=11>
<input type="submit" name="submitform" value="Submit" />
<input type="reset" name="resetform" value="Reset" />
</TD>
</TR>
</form>
</body>
</HTML>
<% END IF %>