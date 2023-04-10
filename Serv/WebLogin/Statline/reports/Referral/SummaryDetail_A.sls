
<%    'updated ttw - 11/28/00
      DIM UpdateReferralTest
      DIM RSUdateReferral
      Dim cmd
      'Check the Update Referral View Permission
      Set RSUdateReferral = Server.CreateObject("ADODB.Recordset")
      Set cmd = Server.CreateObject("ADODB.Command")
      cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
      cmd.CommandText = "SPS_FunctionsPermission"
      cmd.CommandType = adCmdStoredProc
      cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
      cmd.Parameters.Append cmd.CreateParameter("@USERID", adInteger, adParamInput)
      cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
      cmd.Parameters("@USERID").Value = USERID
      cmd.Parameters("@FUNCTIONID").Value = 2 'FunctionID of the Update Referral View
      Set RSUdateReferral = cmd.Execute
      IF Not RSUdateReferral.EOF then
          UpdateReferralTest=RSUdateReferral("FunctionString")
      ELSE
          UpdateReferralTest=FALSE
      END IF

If vShowGroup1 = False Then

    TypeName = "All Referrals"%>
    <html>

    <head>
    <title></title>
    </head>

    <body bgcolor="#F5EBDD">

    <p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"> </p>

    <table border="0" width="100%" rules="NONE" frame="VOID">
      <tr>
        <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=TypeName%></i></b></font></td>
      </tr>
      <tr>
        <td><hr align="CENTER" color="#000000" noshade size="1" width="100%">
        </td>
      </tr>
    </table>
<%if not vInsertBreaks then%>
    <table border="0" width="100%" rules="NONE" frame="VOID">
      <tr>
        <td width="4%" valign="TOP">
            <b><u>
            <font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">#</font></td>
        <td width="10%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
        face="<%=FontNameHeadLog%>">Call Date</font></td>
        <td width="38%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
        face="<%=FontNameHeadLog%>">Referral Info</font></td>
        <td width="48%"><table border="0" width="100%">
          <tr>
            <td width="4%"></td>
            <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Organs</font></td>
            <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Bone</font></td>
            <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Tissue</font></td>
            <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Skin</font></td>
            <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Valves</font></td>
            <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Eyes</font></td>
          </tr>
        </table>
<%end if%>
        </td>
      </tr>
    </table>
<%End If%>

<%TypeName = ""
For i = 0 to Ubound(ResultArray,2)

    If vShowGroup1 = True Then
        If ResultArray(12,i) <> TypeName Then

            TypeName = ResultArray(12,i)%>
            <html>

            <head>
            <title></title>
            </head>

            <body>

            <p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"> </p>

            <table border="0" width="100%" rules="NONE" frame="VOID">
              <tr>
                <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=TypeName%></i></b></font></td>
              </tr>
              <tr>
                <td><hr align="CENTER" color="#000000" noshade size="1" width="100%">
                </td>
              </tr>
            </table>
        
            <table border="0" width="100%" rules="NONE" frame="VOID">
              <tr>
                <td width="4%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
                face="<%=FontNameHeadLog%>">#</font></td>
                <td width="10%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
                face="<%=FontNameHeadLog%>">Call Date</font></td>
                <td width="38%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
                face="<%=FontNameHeadLog%>">Referral Info</font></td>
                <td width="48%"><table border="0" width="100%">
                  <tr>
                    <td width="4%"></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Organs</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Bone</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Tissue</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Skin</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Valves</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Eyes</font></td>
                  </tr>
                </table>
                </td>
              </tr>
            </table>
        
        <%End If%>
    <%End If%>

    
    <%if vInsertBreaks and i = 0 then%>
        <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%=ResultArray(15,i)%></b></font>
        <img src="/loginstatline/images/redline.jpg" height="2" width="100%">    
        
        <table border="0" width="100%" rules="NONE" frame="VOID">
          <tr>
            <td width="4%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
            face="<%=FontNameHeadLog%>">#</font></td>
            <td width="10%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
            face="<%=FontNameHeadLog%>">Call Date</font></td>
            <td width="38%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
            face="<%=FontNameHeadLog%>">Referral Info</font></td>
            <td width="48%"><table border="0" width="100%">
              <tr>
                <td width="4%"></td>
                <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Organs</font></td>
                <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Bone</font></td>
                <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Tissue</font></td>
                <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Skin</font></td>
                <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Valves</font></td>
                <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Eyes</font></td>
              </tr>
            </table>
            </td>
          </tr>
        </table>
    <%end if%>    

    <%'drh 1/17/02 Add page break logic here
    if vInsertBreaks and i > 0 then
        if ResultArray(15,i) <> vBreakValue then
            if not isEmpty(vBreakValue) then
                response.write("</H5>")
            end if

            vBreakValue = ResultArray(15,i)
            response.write("<H5>")%>
            <img src="/loginstatline/images/redline.jpg" height="2" width="100%">
            <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%=ResultArray(15,i)%></b></font>
            <img src="/loginstatline/images/redline.jpg" height="2" width="100%">
            
            <table border="0" width="100%" rules="NONE" frame="VOID">
              <tr>
                <td width="4%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
                face="<%=FontNameHeadLog%>">#</font></td>
                <td width="10%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
                face="<%=FontNameHeadLog%>">Call Date</font></td>
                <td width="38%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
                face="<%=FontNameHeadLog%>">Referral Info</font></td>
                <td width="48%"><table border="0" width="100%">
                  <tr>
                    <td width="4%"></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Organs</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Bone</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Tissue</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Skin</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Valves</font></td>
                    <td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Eyes</font></td>
                  </tr>
                </table>
                </td>
              </tr>
            </table>
    <%    end if
    end if%>

    <table border="0" width="100%" rules="NONE">
      <tr>
        <th colspan="4" width="100%"></th>
      </tr>
      <tr>
        <td width="4%" valign="TOP">
            <font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=i+1%></font></td>
        <td width="10%" valign="TOP">
            <font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(4,i) & " " & ResultArray(5,i)%>
            <p><%' Changed links to access statWindow() javascript routine to pop up browser windows without tool or address bars.  The javascript file allowing this (statUtility.js) was included in Activity1.sls.  2/14/05 - SAP %>             
               <%' Replaced any ">" in the querysting to prevent breaking link.  2/23/05 - SAP 
                 ' Replaced any apostrophe in the querystring with a ¿ to prevent terminating the string within the javascript.  Kluge fix.  2/25/05 - SAP  %>
                <a href=javascript:statWindow('ReferralDetail','detail_1.sls?CallID=<%=ResultArray(1,i)%>&<%=Replace(Replace(Replace(Request.QueryString, "&CallID=-1",""),">", "&gt;"),"'","&iquest;")%>&NoLog=1&CountCheck=False')><%=ResultArray(2,i)%></a>
            <br><br>
            <%'02/28/03 drh - Added link to Update Referrals page
            IF UpdateReferralTest then
               If vUpdateReferralAccess = true Then%>
                   <A    HREF="javascript:doNothing();"
                       onclick="window.open('/loginstatline/forms/UpdateReferral.sls?CallID=<%=ResultArray(1,i)%>&amp;UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=DataSourceName%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>','updateReferral','resizable,scrollbars');">Update Referral
                   </A>
               <%End If
            END IF%>
            </font></td>

            <%'Determine how to display patient name.
            Dim vPatientName
            Dim vMedRecNum
			Dim vPatientSSN
            
            If pvNoName = "1" Then
                vPatientName = "Anonymous"
                vMedRecNum = ""
            Else
                If ResultArray(13,i) = "" And ResultArray(14,i) <> "" Then
                    vPatientName = ResultArray(14,i)
                ElseIf ResultArray(14,i) = "" And ResultArray(13,i) <> "" Then
                    vPatientName = ResultArray(13,i)
                ElseIf ResultArray(13,i) = "" And ResultArray(14,i) = "" Then
                    vPatientName = "N/A"
                Else
                    vPatientName = ResultArray(14,i) & " " & ResultArray(13,i)
                End If
                vMedRecNum = ResultArray(23,i)
            End If%>  

    <%If LastOrganization <> ResultArray(15,i) Then%>
    <%End If%>
    
    <%'    Referral Info%>
        <td width="38%" valign="TOP">
            <font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(15,i)%>
    <%If ResultArray(19,i) <> "" Then Response.Write(", " & ResultArray(19,i) & " " & ResultArray(20,i))%>    <br>
    <%Response.Write(ResultArray(16,i) & " " & ResultArray(17,i))%>    <br>
    <%If ResultArray(36,i) <> "" Then Response.Write(ResultArray(36,i)) Else Response.Write("Not Approached") End If%>
    <%'Response.Write("field 80 is: " & ResultArray(80,i)) %>
    <%If ResultArray(80,i) <> "" Then Response.Write(", " & ResultArray(80,i)) %> 
    <%If ResultArray(38,i) <> "" Then Response.Write(", " & ResultArray(37,i) & " " & ResultArray(38,i)) End If%>    <br>
    <%Response.Write(vPatientName)%>    , <%=ResultArray(26,i)%>, <%Response.Write(ResultArray(24,i) & " " & ResultArray(25,i))%>, <%=ResultArray(34,i)%><br>
    MR #<%=vMedRecNum%><BR>
    <%=ResultArray(35,i)%><%If ResultArray(31,i) <> "" Then Response.Write(", " & ResultArray(31,i) & " " & ResultArray(32,i))%>    </font></td>
    <!-- Begin Options Grid -->
        <td width="48%" valign="TOP"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><table
        border="0" width="100%" rules="NONE" frame="VOID">
          <tr>
            <th colspan="7" width="100%"></th>
    <!-- Appropriate Row -->
          </tr>
          <tr>
            <td width="4%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>A</b></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(47,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(51,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(55,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(59,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(63,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(67,i)%></font></td>
          </tr>
    <!-- Approach Row -->
          <tr>
            <td width="4%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>A</b></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(48,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(52,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(56,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(60,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(64,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(68,i)%></font></td>
          </tr>
    <!-- Consent Row -->
          <tr>
            <td width="4%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>C</b></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(49,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(53,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(57,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(61,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(65,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(69,i)%></font></td>
          </tr>
    <!-- Recovery Row -->
          <tr>
            <td width="4%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>R</b></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(50,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(54,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(58,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(62,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(66,i)%></font></td>
            <td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(70,i)%></font></td>
          </tr>
          <tr>
            <td><font size="1"></font></td>
            <td></td>
            <td></td>
            <td></font></td>
          </tr>
        </table>
        </td>
    <!-- End Options Grid -->
      </tr>
      <tr>
        <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
        </td>
      </tr>
    </table>
<%
if vInsertBreaks and i = Ubound(ResultArray,2) then
    response.write("</H5>")
end if
%>
<%Next%>


<!-- Begin Legend -->

<p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"> </p>

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
    <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Legend</i></b></font></td>
  </tr>
  <tr>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr>
    <td width="4%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameHeadLog%>">#</font></td>
    <td width="10%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameHeadLog%>">Call Date</font></td>
    <td width="39%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameHeadLog%>">Referral Info</font></td>
    <td width="47%"></td>
  </tr>
  <tr>
    <td valign="TOP" align="LEFT"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">#</font></td>
    <td valign="TOP" align="LEFT"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">Referral Date<p>Referral Number</font></td>
    <td valign="TOP" align="LEFT"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">Referring Hospital, Referring Unit<br>
    Referring Person<br>
    Approach Method, Approach Outcome, Approach Person<br>
    Patient Name, Gender, Age, Race<br>
    Cause Of Death, Date/Time of Death</font></td>
    <td valign="TOP" align="LEFT"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">A - Appropriate options at time of Referral with available
    information. If other than 'Yes', then this field is the reason the option was not
    appropriate.<br>
    A - Approached. If other than 'Yes', then this field is the reason approach was not made.<br>
    C - Consented. If other than 'Yes', then this field is the reason consent was not
    obtained.<br>
    R - Recovered. If Other than 'Yes', then this field is the reason for non-recovery.</font></td>
  </tr>
  <tr>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
</table>
<!-- End Legend -->
</u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b>
</body>
</html>

<script language="JavaScript">
    function doNothing()
    {
        
    }

</script>