
<%
Dim DataWarehouseConn
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn
Dim vCurrentColor
Dim vQString
Dim vPrevOrgID
Dim vTotals(3)
Dim i
Dim x
Dim FontNameHead
Dim FontNameData
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim CompUpdateTest
Dim RSTestPermission
Dim cmd

FontNameHead = "Arial"
FontNameData = "Times New Roman"

%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Referral Compliance</title>
</head>
<body bgcolor="#F5EBDD">
<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%
Call Process

Function Process

'Execute the main page generating routine
If AuthorizeMain Then

    Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
    DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD    'drh 1/6/04 - Un-hardcoded DSN
    
    Set Conn = server.CreateObject("ADODB.Connection")
    Conn.Open DataSourceName, DBUSER, DBPWD    'drh 1/6/04 - Un-hardcoded User/Pwd

    'Get the query variables
    Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
    Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
    pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
    pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
    pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)

    vQString = Request.QueryString

    'Check the Referral Compliance Update View Permission
    Set RSTestPermission = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_FunctionsPermission"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@USERID", adInteger, adParamInput)
    cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
    cmd.Parameters("@USERID").Value = USERID
    cmd.Parameters("@FUNCTIONID").Value = 4 'FunctionID of the Referral Compliance Update
    Set RSTestPermission = cmd.Execute
    IF Not RSTestPermission.EOF then
        CompUpdateTest=RSTestPermission("FunctionString")
    ELSE
        CompUpdateTest=FALSE
    END IF


    
    'Verify the requesting organization if it not Statline
    If pvUserOrgID <> 194 then
        
        vQuery = "sps_OrganizationName " & pvUserOrgID
        Set RS = Conn.Execute(vQuery)
        
        If RS.EOF = True Then
            vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
            vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
            vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
            vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
            vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
            vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
            vErrorMsg = vErrorMsg & "</FONT></FONT>"
            Response.Write(vErrorMsg)        
        End If
        
        Set RS = Nothing
    
    Else
    
        'If the user org = 194 and a report group has been selected,
        'the replace the user org id with the org owner of the 
        'selected report group.
        If pvReportGroupID <> 0 Then
            vQuery = "sps_ReportGroupOrgParentID " & pvReportGroupID & " "
            Set RS = Conn.Execute(vQuery)
            If RS.EOF <> True Then
                pvUserOrgID = RS("OrgHierarchyParentID")
                vReportTitle = RS("OrganizationName") & " - "
            End If
            Set RS = Nothing
        End If        

    End If

    If pvReportGroupID <> 0 AND pvOrgID = 0 Then
        
        'If a report group has been selected, get the report group name
        'and set the report title to the name of the report group
        vQuery = "sps_ReportGroupName " & pvReportGroupID & " "
        Set RS = Conn.Execute(vQuery)

        If Conn.Errors.Count > 0 Then
            vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
            vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
            vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
            vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
            vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
            vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
            vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
            vErrorMsg = vErrorMsg & "</FONT></FONT>"
            Response.Write(vErrorMsg)
        End If
        
        If RS.EOF = True Then
            vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
            vErrorMsg = vErrorMsg & "The selected report group is no longer valid. Please select another group.<BR> <BR>"
            vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
            vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
            vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
            vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
            vErrorMsg = vErrorMsg & "</FONT></FONT>"
            Response.Write(vErrorMsg)
            
        Else
            vReportTitle = vReportTitle & RS("WebReportGroupName")        
        End If
        
        Set RS = Nothing
        
    ElseIf pvOrgID <> 0  Then

        'Else if a single organization has been selected, get the organization data 
        'and set the report title to the name of the selected organization

        'Get the organization information
        vQuery = "sps_OrganizationName " & pvOrgID
        
        Set RS = Conn.Execute(vQuery)
        
        If RS.EOF = True Then
            vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
            vErrorMsg = vErrorMsg & "The organization selected for this report does not exist. <BR> <BR>"
            vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
            vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
            vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
            vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
            vErrorMsg = vErrorMsg & "</FONT></FONT>"
        Else
            vReportTitle = RS("OrganizationName")            
        End If
        
        Set RS = Nothing
        
    ElseIf pvOrgID = 0 AND pvReportGroupID = 0 Then

        vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
        vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
        vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
        vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
        vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
        vErrorMsg = vErrorMsg & "Error:     (-1, UnitSummary.sls) <BR> <BR>"
        vErrorMsg = vErrorMsg & "</FONT></FONT>"
        Response.Write(vErrorMsg)

    Else

        vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
        vErrorMsg = vErrorMsg & "Unexpected Error. <BR> "
        vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
        vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
        vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
        vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
        vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, UnitSummary.sls) <BR> <BR>"
        vErrorMsg = vErrorMsg & "</FONT></FONT>"
        Response.Write(vErrorMsg)

    End if

    vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
    Set RS = Conn.Execute(vQuery)
    vTZ = RS("OrganizationTimeZone")
    Set RS = Nothing
    
    'Set Title Values    
    vMainTitle = "Referral Compliance (w/Reg)"
    vTitlePeriod = DateLiteral(pvStartDate)
    vTitleTo = DateLiteral(pvEndDate)
    vTitleTimes = "All Times " & ZoneName(vTZ)
    
    %>    
    <!-- Print Report Header -->
    <!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->
    
    <!-- Display Table Header -->

    <IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

    <TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

    <TR>
        <%If pvOrgID <> 0 Then%>
            <TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Year / Month</B></TD>
        <%Else%>
            <TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referral Facility</B></TD>
        <%End If%>
        
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>%</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
        <TD ALIGN=Left width="11%"><% If CompUpdateTest then %><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Update</B><% End IF %></TD>
                
        
        
    <TR><TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp;</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Deaths</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Compliance</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Registered</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Deaths</B></TD>    
        
    <TR><TD COLSPAN=6><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>    
        
<%
    vCurrentColor = "bgcolor=#FFFFFF"
    vTotals(0) = 0
    vPrevOrgID = 0
    
    'A report group has been selected so get the list of organizations
    'to be processed
    vQuery = "sps_ReferralCompliance4 " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
    
    Set RS = DataWarehouseConn.Execute(vQuery)

    Do While Not RS.EOF
%>
        <TR>
            <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">
                <%
                If pvOrgID <> 0 Then
                    Response.Write(RS("MonthYear"))
                Else
                    Response.Write(RS("OrganizationName"))
                End If    
                %>    
            </TD>
            
            <%If IsNull(RS("AllTypes")) Then%>
                <TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">0</FONT></TD>
            <%Else%>
                <TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AllTypes")%></FONT></TD>
            <%End If%>
            
            <%
            If IsNull(RS("AllTypes")) Then
                vTotals(0) = vTotals(0) + 0
            Else
                vTotals(0) = vTotals(0) + RS("AllTypes")
            End If
            %>
            
            <!-- Detail -->
            <%' Added If statement to check if the value of RS("TotalDeaths") is equal
	    ' to -1. Value of -1 means that organization did not report any deaths during timeframe
	    ' specified. If Organization's Source Code = "GOLM" then insert cross symbol (&#134),
	    ' if not, insert a 0  -- Copied from ReferralComp.sls 11/2/04 - SAP %>
	    <%If RS("TotalDeaths")=-1 then%>
		<%If GetSourceCodeNameReportGroupID(request("ReportGroupID"))="GOLM" Then%>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%="&#134"%></FONT></TD>
		<%Else%>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">-</FONT></TD>
		<%End If%>
	    <%Else
		vTotals(1) = vTotals(1) + RS("TotalDeaths")   ' Moved inside of IF/Else to eliminate adding -1.  9/9/04 - SAP  %>
		<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("TotalDeaths")%></FONT></TD>
            <%End If%>
            
            <%If (RS("TotalDeaths") = 0 Or IsNull(RS("TotalDeaths")) Or RS("TotalDeaths") = -1) And RS("AllTypes") > 0 Then%>
	        <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">-</FONT></I></TD>            
	    <%ElseIf (RS("TotalDeaths") = 0 Or IsNull(RS("TotalDeaths"))) And RS("AllTypes") = 0 Then%> 
	        <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">100%</FONT></I></TD>    
	    <%Else%>
	        <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("AllTypes")/RS("TotalDeaths"))*100,0)%>%</FONT></I></TD>
            <%End If%>
    
            <%
            'Response.write vPrevOrgID
            
            vQString = Replace(vQString, "&OrgID=" & vPrevOrgID, "&OrgID=" & RS("OrganizationID"))
            vPrevOrgID = RS("OrganizationID")
            'Response.Write (" RS(OrganizationID) " & RS("OrganizationID"))
            'Response.Write (" OrgID " & OrgID)
            'Response.Write (" UserOrgID " & UserOrgID)
            
            %>
            
            <%
                vTotals(3) = vTotals(3) + RS("TotalRegistry")
            %>
            <%If IsNull(RS("TotalRegistry")) Then%>
                <TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">0</FONT></TD>
            <%Else%>
                <TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("TotalRegistry")%></FONT></TD>
            <%End If%>
            
            
            <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">
            <% If CompUpdateTest then %>
               <A target="UpdateReferralCompliance" HREF="/loginstatline/forms/UpdateReferralComp.sls?<%=vQString%>&NoLog=1&Update=1">Update<A>
            <% End If %>
            </FONT>
            </TD>
            
        </TR>
            
    <%
        If vCurrentColor = "bgcolor=#FFFFFF" Then
            vCurrentColor = "bgcolor=#F5EBDD"
        Else
            vCurrentColor = "bgcolor=#FFFFFF"
        End If
            
        RS.MoveNext
        
    Loop
    %>

    <!-- Process Totals -->
    <TR><TD COLSPAN=6><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

    <TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
        <TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
        <TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
        <%If  vTotals(0) > 0 And vTotals(1) = 0 Then%>
            <TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">-</FONT></I></TD>            
        <%ElseIf vTotals(0) = 0 And vTotals(1) = 0 Then%>
            <TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">100%</FONT></I></TD>
        <%Else%>    
            <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(0)/vTotals(1))*100,0)%>%</B></I></FONT></TD>        
        <%End If%>
        <TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></FONT></TD>
    </TR>

    </TABLE>
<%
End If

Set RS = Nothing
Set Conn = Nothing
Set DataWarehouseConn = Nothing

End Function
%>

<!--#include virtual="/loginstatline/includes/copyright.shm"-->
</body>
</html>


<%
Function DateLiteral(pvDate)

    Select Case Month(pvDate)
    
        Case 1
            DateLiteral = "Jan "
        Case 2
            DateLiteral = "Feb "
        Case 3
            DateLiteral = "March "
        Case 4
            DateLiteral = "April "
        Case 5
            DateLiteral = "May "
        Case 6
            DateLiteral = "June "
        Case 7
            DateLiteral = "July "
        Case 8
            DateLiteral = "Aug "
        Case 9
            DateLiteral = "Sept "
        Case 10
            DateLiteral = "Oct "
        Case 11
            DateLiteral = "Nov "
        Case 12
            DateLiteral = "Dec "
    End Select
    
    DateLiteral = DateLiteral & Year(pvDate)
    
End Function

Sub FixQueryString(pvIn, pvOut)
    pvOut = ""
    For x=1 TO Len(pvIn)
        If Mid(pvIn,x,1) = "_" Then
            pvOut = pvOut & " "
        Else
            pvOut = pvOut & Mid(pvIn,x,1)
        End If
    Next
End Sub

%>