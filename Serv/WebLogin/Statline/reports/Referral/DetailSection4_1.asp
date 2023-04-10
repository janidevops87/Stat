<%  '00.0731 - Added MT not to Callout message description
    'only a temporary fix to the problem.
    'should update the query instead.
%>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"><%iPageRowCount = iPageRowCount + 1%>

<table border="0" width="100%" cellpadding="0" cellspacing="0">
  <tr><%iPageRowCount = iPageRowCount + 2%>
    <td colspan="3"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Event Log
    Information</i></b></font></td>  
  </tr>
  <tr><%iPageRowCount = iPageRowCount + 1%>
    <%'If UserOrgID = 194 Then%>
        <td colspan="7"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
        </td>
    <%'End If%>
  </tr>
  <tr><%iPageRowCount = iPageRowCount + 1%>
    <td width="2%"><b><u><font size="2">#</font></td>
    <td align="LEFT" width="10%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Date/Time</font></td>
    
    <%
    'If a Statline user is running the report, then add a column 
    'to display the name of the person who created the log item.
    'If UserOrgID = 194 Then%>
        <td align="LEFT" width="4%"><b><u><font size="<%=FontSizeHeadLog%>"
        face="<%=FontNameHeadLog%>">By</font></td> 
    <%'End If%>        
    
    <td align="LEFT" width="12%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Event Type</font></td>
    <td align="LEFT" width="22%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Organization</font></td>
    <td align="LEFT" width="17%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">To/From</font></td>
    <td align="LEFT" width="23%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Description</font></td>
  </tr>
  
<%Redim Section4(0,0)

    SET ErrorCatch =  server.CreateObject("ADODB.Error")                                    
    'ErrorReturn = Referral.GetLog(Section4, ResultArray(i, 1), vTZ,DataSourceName)
    vQuery = "Sps_ReferralLogEvent " & ResultArray(1,i) & ", '" & vTZ & "'"
    'Response.Write vQuery
    Set RS = Conn.Execute(vQuery)
    
    vNoRecords = False
    
    If RS.EOF Then
        
        vNoRecords = True
        reDim Section4(5,0)
        Section4(0,0) = "No Log Events"
        for x = 1 to Ubound(Section4,2)
        Section4(x,0)=" "
        Next
    Else    
        Section4 = RS.GetRows
    
    End if    


    If  ErrorCatch.Number <> 0 AND ErrorReturn <> 100 Then


        vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
        vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
        vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
        vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
        vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
        vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
        vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Referral.GetLog, Detail.sls) <BR> <BR>"
        vErrorMsg = vErrorMsg & "</FONT></FONT>"
        Response.Write(vErrorMsg)
        'Exit For
    End If
        
    'Format each record
    'Dim DateTime
     
    'dim ncount, nlen, firsttime
        'firsttime = 1
        'nlen = 0

    For x = 0 To Ubound(Section4,2)%>
        
      <% 
       'Just Do SSN AND Patient Name Headers for GOLM
       'IF CheckGOLM then 
       ' Poor Man's page breaker DEO 5/30/2003
       ' First time it breaks after 10 log rows then after 
       ' that it breaks after every 2000 words of log description
       ' MH 8/13/2003 - Changed from every 2000 chars of log description to 3600 chars total
       ' ncount = x+1
       ' if ncount = 11 AND firsttime = 1 then 
         'end if 
        %>
    
    
    <!-- ---------------------------------------------------------------------- -->
    <!-- ---------------------------------------------------------------------- -->
    <%

    Dim iAdditionalRowsNeeded

    'Get the number of rows the organization column will require.
    'And add to rowcount if over certain # of chars (i.e. 34 for organization).
    IF NOT isNull(Section4(2,x)) then 
        iAdditionalRowsNeeded = (INT(Len(Section4(2,x))/34))
        iPageRowCount = iPageRowCount + iAdditionalRowsNeeded
    End IF

    'Get the number of rows the log description column will require.
    'And add to rowcount if over certain # of chars (i.e. 40 for organization).
    IF NOT isNull(Section4(4,x)) then 
        iAdditionalRowsNeeded = (INT(Len(Section4(4,x))/40))
        iPageRowCount = iPageRowCount + iAdditionalRowsNeeded
    End IF


    'Set the number of rows that will require a page-break.
    Dim iRowBreakValue
    If bFirstPage then
        iRowBreakValue = 60
    Else
        iRowBreakValue = 70
    End if

    IF iPageRowCount > (iTempPageRowCount + iRowBreakValue) then
        
        'After first load, set bFirstPage to false so iRowBreakValue will change.
        bFirstPage = false    
        
        'Reset the iPageRowCount variable to iPageRowCount for next page.
        iTempPageRowCount = iPageRowCount 
        
        'iPageRowCount includes the extra rows added, but it placing a page-break here, then we want to start counting from the first row, and remove the extra rows that were added in previous check above (i.e. iAdditionalRowsNeeded).
        iTempPageRowCount = iTempPageRowCount - iAdditionalRowsNeeded 
    %>
    
        <TR><TD colspan='100'>&nbsp;</TD></TR>

        <%IF CheckGOLM then %>
          <TR><TD colspan='100'><!--#include virtual="/loginstatline/includes/copyright.shm"--></TD></TR>
          <TR><TD colspan='100'><UL></UL></TD></TR>
          <TR><TD colspan='100'>
            <TABLE border="0" width="100%">
                <TR>
                    <TD align="Left">
                    <Font size="2"><B>Patient SSN:&nbsp;&nbsp;<%'=ResultArray(123,i)%></B></font>
                    </TD>
                    <TD align="right">
                    <font size="2"><B>Patient Name:&nbsp;&nbsp;<%'=vPatientName%></B></font>
                    </TD>
                </TR>
              </TABLE>
              <hr align="CENTER" color="#000000" noshade size="1" width="100%">
          </TD></TR>

            <TR>
              <td width="2%"><b><u><font size="2">#</font></td>
              <td align="LEFT" width="10%"><b><u><font size="<%'=FontSizeHeadLog%>"
                face="<%'=FontNameHeadLog%>">Date/Time</font></td>
    
            <%
                'If a Statline user is running the report, then add a column 
                'to display the name of the person who created the log item.
                'If UserOrgID = 194 Then%>
            <td align="LEFT" width="4%"><b><u><font size="<%'=FontSizeHeadLog%>"
                face="<%'=FontNameHeadLog%>">By</font></td>
            <%''End If%>        

                <td align="LEFT" width="12%"><b><u><font size="<%'=FontSizeHeadLog%>"
                face="<%'=FontNameHeadLog%>">Event Type</font></td>
                <td align="LEFT" width="22%"><b><u><font size="<%'=FontSizeHeadLog%>"
            face="<%'=FontNameHeadLog%>">Organization</font></td>
            <td align="LEFT" width="17%"><b><u><font size="<%'=FontSizeHeadLog%>"
            face="<%'=FontNameHeadLog%>">To/From</font></td>

            <%''If UserOrgID = 194 Then%>
            <td align="LEFT" width="23%"><b><u><font size="--><%'=FontSizeHeadLog%>"
                face="--><%'=FontNameHeadLog%>">Description</font></td>
            <%''End If%>
          </TR>
        <%End If%>  <!-- CheckGOLM if-clause -->
    <%End if%>    <!-- Rowcount if-clause -->
    <!-- ---------------------------------------------------------------------- -->
    <!-- ---------------------------------------------------------------------- -->
    <%
    DIM backgroundcolor
    backgroundcolor=""
    IF Section4(4,x) <> "" THEN
       IF UCASE(Left(Replace(Section4(4,x), " ", ""),16)) = "SIGNIFICANTISSUE" then
          backgroundcolor="#FF9933"
       END IF
    END IF
    IF Section4(4,x) <> "" THEN
       IF UCASE(Left(Replace(Section4(4,x), " ", ""),8)) = "FOLLOWUP" then
          backgroundcolor="#3399FF"
       END IF
    END IF
    %>
      <tr><%iPageRowCount = iPageRowCount + 1%>
        <td align="LEFT" bgcolor="<%=backgroundcolor%>" valign="TOP"><font size="<%=FontSizeDataLog%>"
        face="<%=FontNameDataLog%>"><%=(x+1)%></font></td>
        <td align="LEFT"  bgcolor="<%=backgroundcolor%>" valign="TOP"><font size="<%=FontSizeDataLog%>"
        face="<%=FontNameDataLog%>"><%=Section4(0,x)%></font></td>
        <td align="LEFT"  bgcolor="<%=backgroundcolor%>" valign="TOP"><font size="<%=FontSizeDataLog%>"
        face="<%=FontNameDataLog%>"><%=Section4(5,x)%></font></td>
        <td align="LEFT"  bgcolor="<%=backgroundcolor%>" valign="TOP"><font size="<%=FontSizeDataLog%>"
        face="<%=FontNameDataLog%>"><%=Section4(1,x)%></font></td>
        <td align="LEFT"  bgcolor="<%=backgroundcolor%>" valign="TOP"><font size="<%=FontSizeDataLog%>"
        face="<%=FontNameDataLog%>"><%=Section4(2,x)%></font></td>
        <td align="LEFT"  bgcolor="<%=backgroundcolor%>" valign="TOP"><font size="<%=FontSizeDataLog%>"
        face="<%=FontNameDataLog%>"><%=Section4(3,x)%></font></td>
      <%If left(Section4(4,x),13) = "Callout after" then%>
            <td align="LEFT"  bgcolor="<%=backgroundcolor%>" valign="TOP"><font size="<%=FontSizeDataLog%>"
            face="<%=FontNameDataLog%>"><%=Section4(4,x)%>(MT)</font></td>
      <%Else%>
            <td align="LEFT"  bgcolor="<%=backgroundcolor%>" valign="TOP"><font size="<%=FontSizeDataLog%>"
            face="<%=FontNameDataLog%>"><%=Section4(4,x)%></font></td>
      <%End If%>
      </tr>
    <%Next %>
</table>
</u></b></u></b></u></b></u></b></u></b></u></b>


