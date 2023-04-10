
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>Conditions of Participation Report</title>
<STYLE>
UL {
   page-break-before: always
   }
a:link {
  color: #000000;
  text-decoration: none;
  }
a:visited { 
  color: #000000;
  text-decoration: none;
  }
a:hover { 
  color: #D13028;
  text-decoration: none;
  }
</STYLE>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=400,height=125,left = 312,top = 134');");
}
// End -->
</script>

</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%
Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData

Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim vOrgID
Dim vReportGroupID
Dim vSourceCodeID

Dim ReferralTypeList
Dim RSAccess

Dim vOrgName
Dim vMsgCount
Dim vImportCount

Dim vTotalNoSecondary
Dim vTotalSecondary
Dim vFamilyApproachTotals
Dim vFamilyUnavailableTotals    '1/20/03 drh
Dim vCryolifeFormTotals        '1/20/03 drh
Dim vFamilyApproachTotalsCount    '1/20/03 drh
Dim vMedSocTotalsCount        '1/20/03 drh
Dim vCryolifeFormTotalsCount    '1/20/03 drh
Dim vTotalMedSoc

Dim vTotalOTE
Dim vTotalTissue
Dim vTotalTE
Dim vTotalE
Dim vTotalOther
Dim vTotalOtherEye
Dim vTotalRO
Dim vTotalROA
Dim vTotalROM

Dim vGrandTotal

Dim vValue
Dim x
Dim vErrorMsg
Dim RS0, RS1
Dim DataWarehouseConn
Dim ErrorReturn

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes


FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
vOrgID = Request.QueryString("OrgID")
%>

<%'Execute the main page generating routine
If AuthorizeMain Then
        'Set Title Values
        vMainTitle = "Conditions of Participation Report"
        vTitlePeriod = DateLiteral(pvStartDate)
        vTitleTo = DateLiteral(pvEndDate)
        vTitleTimes = ""

        %>


        <%
        'Open data connection
        Set Conn = server.CreateObject("ADODB.Connection")
        Conn.Open DataSourceName, DBUSER, DBPWD

        'Open DataWarehouse Connection
        Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
        DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD

        %>

        <!-- User Org Section -->
        <%If pvUserOrgID = 194 Then

            'Replace user org id with the owner of the selected report group
            If vReportGroupID <> 0 Then

                'Get number of rows
                vQuery = "sps_ReportGroupOrgParentID " & vReportGroupID

                Set RS = Conn.Execute(vQuery)

                pvUserOrgID = RS("OrgHierarchyParentID")

                Set RS = Nothing

            End If

        End If


        IF Request("BreakOnOrgID") then
            vOrgID=0
        End IF
        'Get total data rows
        'Preliminary Data Setup
        PreliminaryData = TRUE
        UserEndYear    = DatePart("yyyy", pvEndDate)
        UserEndMonth     = DatePart("m", pvEndDate)
        UserStartYear    = DatePart("yyyy", pvStartDate)
        UserStartMonth     = DatePart("m", pvStartDate)

        CurrentYear    = DatePart("yyyy", Date)
        CurrentMonth    = DatePart("m", Date)


        'DRH 1/5/04 - Use DateAdd so we don't end up with a negative Month
        'PreliminaryMonth = CurrentMonth - 2                'OLD
        PreliminaryMonth = DatePart("m", DateAdd("m", -2, Date))    'CORRECTED
        PreliminaryYear = DatePart("yyyy", DateAdd("m", -2, Date))


        'DRH 1/5/04 - See change below
        'If UserEndYear = CurrentYear AND PreliminaryMonth < UserEndMonth then
        '    IF UserStartMonth > PreliminaryMonth then
        '        StartMonth = UserStartMonth
        '    ELSE
        '        StartMonth = PreliminaryMonth
        '    END IF
        '
        'Else
        '    PreliminaryData = FALSE
        'End if

        'DRH 1/5/04 - This is how we THINK the commented code above should be (this matches 6/23/03 requirements)
        'MDS 1/9/04 - Switched around the IF check order and set to >=
        'MDS 1/9/04 - Added setting StartYear variable
        'print pvEndDate
        'print DateAdd("m", -2, Date)
        'print DateDiff("m", pvEndDate, DateAdd("m", -2, Date))
        'print DateDiff("m",DateAdd("m", -2, Date),pvEndDate)
        'print DateDiff("m", pvStartDate, DateAdd("m", -2, Date))
        If DateDiff("m",DateAdd("m", -2, Date),pvEndDate) >= 0 then
            IF DateDiff("m", pvStartDate, DateAdd("m", -2, Date)) > 0 then
                StartMonth = PreliminaryMonth
                StartYear = PreliminaryYear
                'StartMonth = UserStartMonth     MDS 1/9/04: these were switched around
            ELSE
                StartMonth = UserStartMonth
                StartYear = UserStartYear
                'StartMonth = PreliminaryMonth    MDS 1/9/04: these were switched around
            END IF
            PreliminaryData = TRUE
        Else
            PreliminaryData = FALSE
            StartYear = UserEndYear
        End if


        If PreliminaryData then
            '1/9/04 MDS: Replaced CurrentYear with StartYear
            'PreliminaryStartDate=CStr(StartMonth) & "/1/" & CStr(CurrentYear) & " 00:00"     'OLD
            PreliminaryStartDate=CStr(StartMonth) & "/1/" & CStr(StartYear) & " 00:00"    'CORRECTED
            PreliminaryEndDate= pvEndDate


            PreliminaryQuery = "sps_referral_cmsreport " & vReportGroupID & ", '" & PreliminaryStartDate & "', '" &  PreliminaryEndDate & "', " & vOrgID
            Set RS_PRELIM = DataWarehouseConn.Execute(PreliminaryQuery)
            IF RS_PRELIM.EOF then
                PreliminaryData = FALSE
            end if
            'response.write("PRE: " & PreliminaryQuery & "<BR>")
        End if

        'Validated Data Setup
        ValidData     = TRUE
        UserStartYear    = DatePart("yyyy", pvStartDate)
        UserStartMonth     = DatePart("m", pvStartDate)
        UserEndYear    = DatePart("yyyy", pvEndDate)
        UserEndMonth     = DatePart("m", pvEndDate)

        'MDS 1/9/04 - Already calculated above, so commented out
        'CurrentYear=DatePart("yyyy", Date)
        'CurrentMonth=DatePart("m", Date)

        'DRH 1/5/04 - Use DateAdd so we don't end up with a negative Month
        'ValidMonth = CurrentMonth - 2                'OLD
        ValidMonth = DatePart("m", DateAdd("m", -2, Date))    'CORRECTED

        '*******************************************************************************
        'MDS 1/9/04 - Commented IF statement below is original
        'If UserEndYear = CurrentYear AND ValidMonth < UserEndMonth then
        '    EndMonth=ValidMonth-1
        'Else
        '    EndMonth=UserEndMonth
        'End if
        '*******************************************************************************

        '*******************************************************************************
        'MDS 1/9/04 - Changed IF statement above to the following based on whether
        'there's preliminary data (determined above)
        If PreliminaryData = TRUE then
            EndMonth = DatePart("m", DateAdd("m", -3, Date))
        Else
            EndMonth = UserEndMonth
        End if

        '*******************************************************************************


        IF  UserStartYear = CurrentYear AND UserStartMonth > EndMonth then
            ValidData=False
        end if

        IF ValidData then
            ValidStartDate=pvStartDate
            'LastDay = 1

            'MDS 1/9/04 - In lines below, replaced UserEndYear with StartYear which is retrieved during Preliminary logic section
            'LastDay = LastDayOfMonth(CStr(EndMonth) & "/1/" & CStr(UserEndYear))                'OLD
            'ValidEndDate= CStr(EndMonth) & "/" & CStr(LastDay) & "/" & CStr(UserEndYear) & " 23:59"     'OLD

            LastDay = LastDayOfMonth(CStr(EndMonth) & "/1/" & CStr(StartYear))                'CORRECT
            ValidEndDate= CStr(EndMonth) & "/" & CStr(LastDay) & "/" & CStr(StartYear) & " 23:59"        'CORRECT

            ValidQuery = "sps_referral_cmsreport " & vReportGroupID & ", '" & ValidStartDate & "', '" &  ValidEndDate & "', " & vOrgID
            Set RS_VALID = DataWarehouseConn.Execute(ValidQuery)
            IF RS_VALID.EOF then
                ValidData = FALSE
            end if
            'response.write("VAL: " & ValidQuery & "<BR>")
        end if

        'DRH 1/5/04 - YTD should begin at the beginning of the year that the user selected as their Start Date, not the current year
        'YTD Date Setup
        'strYear=DatePart("yyyy", Date)    'OLD
        strYear=DatePart("yyyy", pvStartDate)    'CORRECTED
        YTDStartDate = "1/1/" & CStr(strYear) & " 00:00"

        'MH 08/19/03
        'YTD should begin at January 1, but end with the ending month selected by the user, not today's date.
        'YTDEndDate=Date    'OLD
        YTDEndDate=pvEndDate    'CORRECTED

        YTDQuery = "sps_referral_cmsreport " & vReportGroupID & ", '" & YTDStartDate & "', '" &  YTDEndDate & "', " & vOrgID
        Set RS_YTD = DataWarehouseConn.Execute(YTDQuery)


        If RS_YTD.EOF = True Then%>

            <P STYLE="line-height: 1pt">&nbsp</P>

            <!-- Header -->
            <TABLE WIDTH="100%" BORDER=0>
                <TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Referral Counts </B></FONT> </TD></TR>
                <TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>"> No Data Available </FONT> </TD></TR>
            </TABLE>

        <%Else%>
                <!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->


                <TABLE WIDTH="100%" BORDER=1>
                <!-- Header -->
                <TR>
                    <TD BGColor="#FFFFFF" WIDTH="15%" ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Hospital's Name</B></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#FacilityDeaths')"><B>Facility Deaths</B></A></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#DeathsReported')"><B>Deaths Reported</B></A></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#AllFamilyApproaches')"><B>All Family Approaches</B></A></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#TrainedRequestorApproaches')"><B>Trained Requestor Approaches</B></A></TD>
                    <!-- <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Imminent Death Calls</B></TD> -->
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#VentedNotifications')"><B>Vented Notifications</B></A></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#EligibleDeaths')"><B>Eligible Deaths &#135;</B></A></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#SuitableOrganApproaches')"><B>Suitable Organ Approaches</B></A></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#SuitableOrganConsents')"><B>Suitable Organ Consents</B></A></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#ActualOrganDonors')"><B>Actual Organ Donors</B></A></TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><A HREF="javascript:popUp('CMSReportDefinitions.sls#NonUNOSDonors')"><B>Non-UNOS Donors</B></A></TD>
                </TR>
            <%Do Until RS_YTD.EOF%>

                <TR>
                    <TD BGColor="#FFFFFF" WIDTH="15%" ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table width="100%" border=0>
                        <TR>
                        <TD width="30" ALIGN="LEFT">
                            <%=RS_YTD("OrganizationName")%>
                        </TD>
                        <TD ALIGN="RIGHT">
                            <Table border=0>
                                <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="-2">P: <%=FormatDateTime(PreliminaryStartDate, 2)%> - <%=FormatDateTime(PreliminaryEndDate, 2)%></FONT><IMG SRC="/loginstatline/images/Small_Arrow.jpg" alt="All data within two months of the current date is considered to be preliminary data."></TD></TR><% End IF %>
                                <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="-2">V: <%=FormatDateTime(ValidStartDate, 2)%> - <%=FormatDateTime(ValidEndDate, 2)%></FONT><IMG SRC="/loginstatline/images/Small_Arrow.jpg" alt="All data From your start date to within two months of the current date is considered to be validated data."></TD></TR><% End IF %>
                                <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="-2">Y: <%=FormatDateTime(YTDStartDate, 2)%> - <%=FormatDateTime(YTDEndDate, 2)%></FONT><IMG SRC="/loginstatline/images/Small_Arrow.jpg" alt="Current year to current date data."></TD></TR>
                            </Table>
                        </TD>
                        </TR>
                        </Table>
                    </TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><% IF RS_PRELIM("Deaths") = 0 then response.write("&#134") ELSE response.write(RS_PRELIM("Deaths")) END IF%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><% IF RS_VALID("Deaths") = 0 then response.write("&#134") ELSE response.write(RS_VALID("Deaths")) END IF%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><% IF RS_YTD("Deaths") = 0 then response.write("&#134") ELSE response.write(RS_YTD("Deaths")) END IF%></FONT></TD></TR>
                        </Table>
                    </TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("DeathsReported")%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("DeathsReported")%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("DeathsReported")%></FONT></TD></TR>
                        </Table>
                    </TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("Approached")%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("Approached")%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("Approached")%></FONT></TD></TR>
                        </Table>
                    </TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("Approached")-RS_PRELIM("Approached_NonDR")%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("Approached")-RS_VALID("Approached_NonDR")%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("Approached")-RS_YTD("Approached_NonDR")%></FONT></TD></TR>
                        </Table>
                    </TD>
<!-- Comment out the following when ImminentDeaths go live
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                                        <Table>
                                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("Referral_CT")%></FONT></TD></TR><% End IF %>
                                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("Referral_CT")%></FONT></TD></TR><% End IF %>
                                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("Referral_CT")%></FONT></TD></TR>
                                        </Table>
                    </TD>
-->

                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("VentedNotification")%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("VentedNotification")%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("VentedNotification")%></FONT></TD></TR>
                        </Table>
                    </TD>



                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("BDMSuitable")%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("BDMSuitable")%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("BDMSuitable")%></FONT></TD></TR>
                        </Table>
                    </TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("Approach_Organ_CT")%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("Approach_Organ_CT")%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("Approach_Organ_CT")%></FONT></TD></TR>
                        </Table>
                    </TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("Consent_Organ_CT")%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("Consent_Organ_CT")%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("Consent_Organ_CT")%></FONT></TD></TR>
                        </Table>
                    </TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_PRELIM("Recovery_Organ_CT")%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_VALID("Recovery_Organ_CT")%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS_YTD("Recovery_Organ_CT")%></FONT></TD></TR>
                        </Table>
                    </TD>
                    <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
                        <Table>
                            <% If PreliminaryData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%response.write(RS_PRELIM("Recovery_Organ_All_CT") - RS_PRELIM("Recovery_Organ_CT"))%></FONT></TD></TR><% End IF %>
                            <% If ValidData then %><TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%response.write(RS_VALID("Recovery_Organ_All_CT") - RS_VALID("Recovery_Organ_CT"))%></FONT></TD></TR><% End IF %>
                            <TR><TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%response.write(RS_YTD("Recovery_Organ_All_CT") - RS_YTD("Recovery_Organ_CT"))%></FONT></TD></TR>
                        </Table>
                    </TD>

                </TR>
                <%
                IF Request("BreakOnOrgID") then %>
                    </TABLE>
                    <DIV>
                    <font size='-3'>&#134; This section will be updated once the facility provides the actual number of total deaths during this period.</font>
                    <BR>
                    <font size='-3'>&#135; Patients up to 70 years that have met neurological criteria for death set by the American Academy of Neurology,
                    <BR>&nbsp;&nbsp;&nbsp;have been officially declared brain dead, and are medically suitable w/o UNOS medical contraindications.</font></DIV>
                    <BR>
                    <!--#include virtual="/loginstatline/includes/copyright.shm"-->
                    </BODY>
                    </HTML>

                    <%
                END IF

            If PreliminaryData then
                RS_PRELIM.MOVENEXT
            End IF
            If ValidData then
                RS_VALID.MOVENEXT
            End if
            RS_YTD.MOVENEXT
            If NOT RS_YTD.EOF AND Request("BreakOnOrgID") Then
            %>
            <UL></UL>
                        <!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->
                        <TABLE BORDER=1>
                        <!-- Header -->
                        <TR>
                            <TD BGColor="#FFFFFF" WIDTH="15%" ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Hospital's Name</B></TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Facility Deaths</B></TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Deaths Reported</B></TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>All Family Approaches</TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Trained Requestor Approaches</B></TD>
                            <!--<TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Imminent Death Calls</B></TD>-->
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Vented Notifications</B></TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Eligible Deaths &#135;</B></TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Suitable Organ Approaches</B></TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Suitable Organ Consents</B></TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Actual Organ Donors</B></TD>
                            <TD BGColor="#FFFFFF" WIDTH="5%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="1"><B>Non-UNOS Donors</B></TD>
            </TR>
            <%
            END IF
            Loop
            Set RS_PRELIM     = Nothing
            Set RS_VALID      = Nothing
            Set RS_YTD     = Nothing

        End If
        'If for Build Table
        IF NOT Request("BreakOnOrgID") Then
        %>
                    </TABLE>
            <DIV>
            <font size='-3'>&#134; This section will be updated once the facility provides the actual number of total deaths during this period.</font>
            <BR>
            <font size='-3'>&#135; Patients up to 70 years that have met neurological criteria for death set by the American Academy of Neurology,
            <BR>&nbsp;&nbsp;&nbsp;have been officially declared brain dead, and are medically suitable w/o UNOS medical contraindications.</font></DIV>
            <BR>
            <!--#include virtual="/loginstatline/includes/copyright.shm"-->

            </BODY>
            </HTML>
<%        END IF
 End If
  'End IF AuthorizeMain
'*************************************************************************************
' Subs and Funcs.
'*************************************************************************************
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

function LastDayOfMonth(DateIn)
        Dim TempDate
        TempDate = Year(dateIn) & "-" & Month(DateIn) & "-"
        if IsDate(TempDate & "28") Then LastDayOfMonth = 28
        if IsDate(TempDate & "29") Then LastDayOfMonth = 29
        if IsDate(TempDate & "30") Then LastDayOfMonth = 30
        if IsDate(TempDate & "31") Then LastDayOfMonth = 31
End function



%>