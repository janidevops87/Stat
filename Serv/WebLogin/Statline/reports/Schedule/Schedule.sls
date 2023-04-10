<%
Option Explicit

'Declare variables
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim pvUserOrgID
Dim pvReportGroupID
Dim pvScheduleGroupID
Dim pvReferralTypeID
Dim vReportTitle
Dim vTZ
Dim i
Dim vScheduleGroupName
Dim vSizeofRows
Dim ScheduleArray
Dim ForLoopCounter
Dim ForLoopColumnCounter

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog

'Declare format vaiables
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "1"
FontNameHeadLog = "Arial"
FontSizeHeadLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"
%>

<html>

<head>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Schedule</title>
</head>

<body bgcolor="#F5EBDD">
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%

'Execute the main page generating routine
If AuthorizeMain Then

    'Create a connection object
    Set Conn = server.CreateObject("ADODB.Connection")
    Conn.Open DataSourceName, DBUSER, DBPWD
    
    'Get the query variables
    Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
    Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
    pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
    pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
    
    pvScheduleGroupID = FormatNumber(Request.QueryString("ScheduleGroupID"),0,,0,0)
        
    If ExecuteMain Then
    %>
        <!-- Print the header. -->
        <!--#include virtual="/loginstatline/reports/schedule/Head.sls"-->
                    
        <!-- Get the counts of each alert group and referral type. -->
        <!--#include virtual="/loginstatline/reports/schedule/Schedule_ActivitySection.sls"-->
    <%
    Else
    %>
        No Data Available
    <%                    
    End If

End If

Set RS = Nothing
Set Conn = Nothing

%>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"></hr>
</body>
</html>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

<%
Function ExecuteMain()

    If pvReportGroupID = 0 Then

        vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
        vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
        vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
        vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
        vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
        vErrorMsg = vErrorMsg & "Error:     (-1, Schedule.sls) <BR> <BR>"
        vErrorMsg = vErrorMsg & "</FONT></FONT>"
        Response.Write(vErrorMsg)
        ExecuteMain = False
        Exit Function
    
    End if
    
    vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
    Set RS = Conn.Execute(vQuery)
    vTZ = RS("OrganizationTimeZone")
    Set RS = Nothing
    'Response.Write vQuery
    
    vQuery = " sps_ScheduleGroupName " & pvScheduleGroupID
    'Response.Write vQuery
    Set RS = Conn.Execute(vQuery)
    
    IF RS.EOF = FALSE Then
        vScheduleGroupName = RS("ScheduleGroupname")    
        vReportTitle = RS("OrganizationName")
    ELSE
        vScheduleGroupName = ""
    END IF    
    
    Set RS = Nothing
    
    'Get data rows
    vQuery = "sps_GetSchedule '" & pvStartDate & "', '" & pvEndDate & "', " & pvScheduleGroupID & ", " & vTZ & ", " & pvUserOrgID & ""
    'Response.Write vQuery
    Set RS = Conn.Execute(vQuery)

    If RS.EOF = True Then
        ExecuteMain = False
    Else
        ExecuteMain = True
        ScheduleArray = RS.GetRows
    End If
    
End Function


Sub FixQueryString(pvIn, pvOut)
    Dim x
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