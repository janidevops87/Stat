<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ReportParamsControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.ReportParamsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="uc41" TagName="CustomParamsRegistryDMVWebControl" Src="CustomParamsRegistryDMVWebControl.ascx" %>
<%@ Register TagPrefix="uc40" TagName="CustomParamsRegistryMailingLabelsSourceControl" Src="CustomParamsRegistryMailingLabelsSourceControl.ascx" %>
<%@ Register TagPrefix="uc39" TagName="CustomParamsRegistryDonorStatusControl" Src="CustomParamsRegistryDonorStatusControl.ascx" %>
<%@ Register TagPrefix="uc38" TagName="CustomParamsAgeRangeControl" Src="CustomParamsAgeRangeControl.ascx" %>
<%@ Register TagPrefix="uc37" TagName="CustomParamsPendingReferralTypeControl" Src="CustomParamsPendingReferralTypeControl.ascx" %>
<%@ Register Src="CustomParamsTrackingTypeControl.ascx" TagName="CustomParamsTrackingTypeControl"
    TagPrefix="uc36" %>
<%@ Register Src="CustomParamsSummarizeByEmployeeControl.ascx" TagName="CustomParamsSummarizeByEmployeeControl"
    TagPrefix="uc35" %>
<%@ Register Src="CustomParamsEmployeeControl.ascx" TagName="CustomParamsEmployeeControl"
    TagPrefix="uc34" %>
<%@ Register Src="CustomParamsPageBreakByEmployeeControl.ascx" TagName="CustomParamsPageBreakByEmployeeControl"
    TagPrefix="uc33" %>
<%@ Register Src="CustomParamsSummarizeByMonthControl.ascx" TagName="CustomParamsSummarizeByMonthControl"
    TagPrefix="uc31" %>
<%@ Register Src="CustomParamsErrorInfoControl.ascx" TagName="CustomParamsErrorInfoControl"
    TagPrefix="uc32" %>
<%@ Register Src="CustomParamsCAPANumberControl.ascx" TagName="CustomParamsCAPANumberControl"
    TagPrefix="uc30" %>
<%@ Register Src="CustomParamsTrackingNumberControl.ascx" TagName="CustomParamsTrackingNumberControl"
    TagPrefix="uc29" %>
<%@ Register Src="CustomParamsCompletedByControl.ascx" TagName="CustomParamsCompletedByControl"
    TagPrefix="uc28" %>
<%@ Register Src="CustomParamsApproacher.ascx" TagName="CustomParamsApproacher" TagPrefix="uc27" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="CustomParamsErrorControl.ascx" TagName="CustomParamsErrorControl"
    TagPrefix="uc26" %>
<%@ Register Src="CustomParamsDisplayDisposition.ascx" TagName="CustomParamsDisplayDisposition"
    TagPrefix="uc25" %>
<%@ Register Src="CustomParamsScheduleLookupControl.ascx" TagName="CustomParamsScheduleLookupControl"
    TagPrefix="uc24" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDataInput.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Src="CustomParamsFSSummaryControl.ascx" TagName="CustomParamsFSSummaryControl"
    TagPrefix="uc23" %>
<%@ Register Src="CustomParamsAlertsControl.ascx" TagName="CustomParamsAlertsControl"
    TagPrefix="uc22" %>
<%@ Register Src="CustomParamsMessageImportControl.ascx" TagName="CustomParamsMessageImportControl"
    TagPrefix="uc21" %>
<%@ Register Src="CustomParamsRegistryZipCode.ascx" TagName="CustomParamsRegistryZipCode"
    TagPrefix="uc20" %>
<%@ Register TagPrefix="uc19" TagName="CustomParamsRegistryDonorDesignationStatus" Src="CustomParamsRegistryDonorDesignationStatus.ascx" %>
<%@ Register TagPrefix="uc18" TagName="CustomParamsRegistryGroupByControl" Src="CustomParamsRegistryGroupByControl.ascx" %>
<%@ Register TagPrefix="uc17" TagName="CustomParamsRegistryOutreachEvents" Src="CustomParamsRegistryOutreachEvents.ascx" %>
<%@ Register TagPrefix="uc16" TagName="CustomParamsRegistryStateControl" Src="CustomParamsRegistryStateControl.ascx" %>
<%@ Register TagPrefix="uc15" TagName="CustomParamsDisplayEventLog" Src="CustomParamsDisplayEventLog.ascx" %>
<%@ Register TagPrefix="uc14" TagName="CustomParamsGroupByFacilityControl" Src="CustomParamsGroupByFacilityControl.ascx" %>
<%@ Register TagPrefix="uc13" TagName="CustomParamsDisplayTriageFSControl" Src="CustomParamsDisplayTriageFSControl.ascx" %>
<%@ Register TagPrefix="uc12" TagName="CustomParamsCauseOfDeathControl" Src="CustomParamsCauseOfDeathControl.ascx" %>
<%@ Register TagPrefix="uc11" TagName="CustomParamsReferralTypeControl" Src="CustomParamsReferralTypeControl.ascx" %>
<%@ Register TagPrefix="uc10" TagName="CustomParamsMedicalRecordNumberControl" Src="CustomParamsMedicalRecordNumberControl.ascx" %>
<%@ Register TagPrefix="uc9" TagName="CustomParamsPatientNameControl" Src="CustomParamsPatientNameControl.ascx" %>
<%@ Register TagPrefix="uc8" TagName="CustomParamsPersonControl" Src="CustomParamsPersonControl.ascx" %>
<%@ Register TagPrefix="uc7" TagName="CustomParamsOrganizationControl" Src="CustomParamsOrganizationControl.ascx" %>
<%@ Register TagPrefix="uc6" TagName="CustomParamsStatTracUserControl" Src="CustomParamsStatTracUserControl.ascx" %>
<%@ Register TagPrefix="uc5" TagName="CustomParamsProcessor" Src="CustomParamsProcessor.ascx" %>
<%@ Register TagPrefix="uc4" TagName="CustomParamsReferralDetail" Src="CustomParamsReferralDetail.ascx" %>
<%@ Register TagPrefix="uc3" TagName="CustomParamsCallControl" Src="CustomParamsCallControl.ascx" %>
<%@ Register TagPrefix="uc1" TagName="CustomParamsAvayaTroubleReportControl" Src="CustomParamsAvayaTroubleReportControl.ascx" %>
<%@ Register TagPrefix="uc2" TagName="CustomParamsFSConversionRateControl" Src="CustomParamsFSConversionRateControl.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<script type='text/javascript'>
function dateTimeCheckArchive(webTextEdit, oldValue, oEvent)
{
    var archiveDate = new Date();
    var startDate = new Date();
    var endDate = new Date();
    
    var dateStartObject = igedit_getById('<%= webDateTimeEditStart.ClientID %>');
    var dateEndObject = igedit_getById('<%= webDateTimeEditEnd.ClientID %>');


    ////var newDate = new Date();
    //javascript uses a zero based array for months. To converet from C# DateTime to javascript subtract 1 example: ArchiveDateTime.Month-1 
    archiveDate.setFullYear(<%= ArchiveDateTime.Year %>, <%= ArchiveDateTime.Month-1 %>, <%= ArchiveDateTime.Day %>);     
    archiveDate.setHours(23, 59, 59, 999);
    
    
    // split the date into month day year
    // ignore the space between year and time
    
    var dateParts = dateStartObject.txt.split(" ")[0].split("/");
    var setStartMonth;
    var setStartDay;
    var setStartYear;
    //if date contains month day year then the count will be 3
    if(dateParts.length == 3)
    {
    setStartYear = dateParts[2];
    setStartMonth = dateParts[0]-1;
    setStartDay =  dateParts[1];
    }
    //if the date containts month year assume count is 2
    // assume month is position 0
    // assume year is position 1
    else
    {
    setStartYear = dateParts[1];
    setStartMonth = dateParts[0]-1
    //hardcode 1 for first day month
    setStartDay =  1;
    
    }
    
    //setFullYear(Year, Month, day
    startDate.setFullYear(setStartYear, setStartMonth, setStartDay);
    if(dateParts = dateStartObject.txt.split(" ")[1] != undefined)
    {
        var dateParts = dateStartObject.txt.split(" ")[1].split(":");
        startDate.setHours(dateParts[0], dateParts[1], 0, 0);
    }
    else
    {
        startDate.setHours(0, 0, 0, 0);
    }

    var dateParts = dateEndObject.txt.split(" ")[0].split("/");
    var setEndMonth;
    var setEndDay;
    var setEndYear;
    //if date contains month day year then the count will be 3
    if(dateParts.length == 3)
    {
    setEndYear = dateParts[2];
    setEndMonth = dateParts[0]-1;
    setEndDay =  dateParts[1];
    }
    //if the date containts month year assume count is 2
    // assume month is position 0
    // assume year is position 1
    else
    {
    setEndYear = dateParts[1];
    setEndMonth = dateParts[0]-1
    //hardcode 1 for first day month
    setEndDay =  daysInMonth(setEndMonth, setEndYear);
    }    
        
    //setFullYear(Year, Month, day
    endDate.setFullYear(setEndYear, setEndMonth, setEndDay);

    if(dateEndObject.txt.split(" ")[1] != undefined)
    {
        var dateParts = dateEndObject.txt.split(" ")[1].split(":");
        endDate.setHours(dateParts[0], dateParts[1], 0, 0);
    }
    else
    {
        endDate.setHours(0, 0, 0, 0);
    }
    
	
	var lblArchiveDateTimeWarning = $get('<%= lblArchiveDateWarning.ClientID %>');
    
	if(startDate < archiveDate || endDate < archiveDate)
	{
    	lblArchiveDateTimeWarning.innerText = 'Warning: The chosen dates will query the archive database, requiring a long time to run.' ;
	}
	else
	{
    	lblArchiveDateTimeWarning.innerText = '' ;

	}
    function daysInMonth(iMonth, iYear)
    {
         return 32 - new Date(iYear, iMonth, 32).getDate();
    }    
}
</script>

<!--  This script is used to popup the display window. -->
<script id="igClientScript" type="text/javascript">
<!--


function ajaxPanelViewReport_RefreshComplete(oPanel)
{
    var pageName = '<%= ResolveUrl("~/ReportDisplay.aspx") %>';
    openPage(pageName);
}
 -->
</script>
<asp:ScriptManager id="scmReportParams" runat="server">
</asp:ScriptManager>
<LINK rel="SHORTCUT ICON" href=images/favicon.ico>
<cc1:SectionHeader runat="server" Text="Report Parameters" ID="topSectionHeader" 
				CssClass="SectionHeader"
				></cc1:SectionHeader>
<div class="ContentTitle">
<asp:Label  CssClass="ContentTitle" ID="lblReportDisplayName" runat="server"></asp:Label>
</div>				
<div class="SectionSeperator">
    <div class="Section" id="divReportSpecificParams" runat="server"  >
        <div class="sectionTitle">
            <asp:Label ID="Label1" runat="server" Text="Report Specific Params" />
        </div>
        <div class="SectionControl" >
                <!-- Custom Conrols add their own row -->
	            <uc1:CustomParamsAvayaTroubleReportControl id="avayaCustomParams" runat="server"></uc1:CustomParamsAvayaTroubleReportControl>
	            <uc2:CustomParamsFSConversionRateControl id="fSConversionParams" runat="server"></uc2:CustomParamsFSConversionRateControl>
	            <uc3:CustomParamsCallControl id="callParams" runat="server"></uc3:CustomParamsCallControl>
	            <uc15:CustomParamsDisplayEventLog id="customParamsDisplayEventLog" runat="server"></uc15:CustomParamsDisplayEventLog>
	            <uc4:CustomParamsReferralDetail id="referralDetailParams" runat="server"></uc4:CustomParamsReferralDetail>
	            <uc5:CustomParamsProcessor id="customParamsProcessor" runat="server"></uc5:CustomParamsProcessor>
	            <uc6:CustomParamsStatTracUserControl id="customParamsStatTracUser" runat="server"></uc6:CustomParamsStatTracUserControl>
	            <uc7:CustomParamsOrganizationControl id="customParamsOrganization" runat="server"></uc7:CustomParamsOrganizationControl>
	            <uc8:CustomParamsPersonControl id="customParamsPerson" runat="server"></uc8:CustomParamsPersonControl>
	            <uc9:CustomParamsPatientNameControl id="customParamsPatientName" runat="server"></uc9:CustomParamsPatientNameControl>
	            <uc10:CustomParamsMedicalRecordNumberControl id="customParamsMedicalRecordNumber" runat="server"></uc10:CustomParamsMedicalRecordNumberControl>
	            <uc11:CustomParamsReferralTypeControl id="customparamsReferralType" runat="server"></uc11:CustomParamsReferralTypeControl>
	            <uc37:CustomParamsPendingReferralTypeControl id="customParamsPendingReferralTypeControl" runat="server"></uc37:CustomParamsPendingReferralTypeControl>
	            <uc12:CustomParamsCauseOfDeathControl id="customParamsCauseOfDeath" runat="server"></uc12:CustomParamsCauseOfDeathControl>
	            <uc13:CustomParamsDisplayTriageFSControl id="customParamsDisplayTriageFSControl" runat="server"></uc13:CustomParamsDisplayTriageFSControl>
	            <uc14:CustomParamsGroupByFacilityControl id="customParamsGroupByFacilityControl" runat="server"></uc14:CustomParamsGroupByFacilityControl>
	            <uc20:CustomParamsRegistryZipCode id="customParamsRegistryZipCode" runat="server" />
                <uc40:CustomParamsRegistryMailingLabelsSourceControl id="customParamsRegistryMailingLabelsSourceControl" runat="server"></uc40:CustomParamsRegistryMailingLabelsSourceControl>	            
                <uc39:CustomParamsRegistryDonorStatusControl id="customParamsRegistryDonorStatusControl" runat="server"></uc39:CustomParamsRegistryDonorStatusControl>	            
	            <uc16:CustomParamsRegistryStateControl id="customParamsRegistryState" runat="server"></uc16:CustomParamsRegistryStateControl>
	            <uc41:CustomParamsRegistryDMVWebControl id="customParamsRegistryDMVWebControl" runat="server"></uc41:CustomParamsRegistryDMVWebControl>
                <uc34:CustomParamsEmployeeControl id="customParamsEmployeeControl" runat="server"></uc34:CustomParamsEmployeeControl>
	            <uc17:CustomParamsRegistryOutreachEvents id="customParamsRegistryOutreachEvents" runat="server"></uc17:CustomParamsRegistryOutreachEvents>
	            <uc18:CustomParamsRegistryGroupByControl id="customParamsRegistryGroupBy" runat="server"></uc18:CustomParamsRegistryGroupByControl>
	            <uc19:CustomParamsRegistryDonorDesignationStatus id="customParamsRegistryDonorDesignationStatus" runat="server"></uc19:CustomParamsRegistryDonorDesignationStatus>
                <uc21:CustomParamsMessageImportControl id="customParamsMessageImport" runat="server"></uc21:CustomParamsMessageImportControl>
                <uc38:CustomParamsAgeRangeControl ID="customParamsAgeRangeControl" runat="server"></uc38:CustomParamsAgeRangeControl>
                <uc22:CustomParamsAlertsControl ID="customParamsAlert" runat="server"  Visible="true"/>
                <uc23:CustomParamsFSSummaryControl id="customParamsFSSummary" runat="server"/>
                <uc24:CustomParamsScheduleLookupControl ID="customParamsScheduleLookup" runat="server" />
                <uc25:CustomParamsDisplayDisposition ID="customParamsDisplayDisposition" runat="server" />                
                <uc26:CustomParamsErrorControl id="customParamsError" runat="server" />
                <uc27:CustomParamsApproacher id="customParamsApproacher" runat="server" />
                <uc35:CustomParamsSummarizeByEmployeeControl id="customParamsSummarizeByEmployeeControl" runat="server" />
                <uc31:CustomParamsSummarizeByMonthControl ID="customParamsSummarizeByMonthControl" runat="server" />
                <uc33:CustomParamsPageBreakByEmployeeControl ID="customParamsPageBreakByEmployeeControl" runat="server" />
                <uc29:CustomParamsTrackingNumberControl ID="customParamsTrackingNumberControl" runat="server" />
                <uc30:CustomParamsCAPANumberControl ID="customParamsCAPANumberControl" runat="server" />
                <uc36:CustomParamsTrackingTypeControl ID="customParamsTrackingTypeControl" runat="server" />
                <uc32:CustomParamsErrorInfoControl ID="customParamsErrorInfoControl" runat="server" />
                <uc28:CustomParamsCompletedByControl ID="customParamsCompletedByControl" runat="server" />
                
                
            </div>
    </div>
</div>
<div class="SectionSeperator">
    <div class="Section" id="divDateAndTime" runat="server">
    <div class="sectionTitle">
        <asp:Label ID="lblReportDateType" runat="server" Text="Based on Date Type" />&nbsp;
    </div>
    <div class="sectionControl" >
        <div class="SubSectionControl">
            <div class="ParamControlLabel">
                        <asp:Label ID="Label2" runat="server" Text="Based on Date Type:" ></asp:Label>
            </div>
            <div class="ParamControl">                        
			    <cc1:DropDownDateType id="ddlReportDateType" runat="server" ></cc1:DropDownDateType>
            </div>			    
        </div>
        <div class="SubSectionControl">
            <div class="ParamControlLabel">
                <asp:Label ID="Label3" runat="server" Text="Start D/T:"  ></asp:Label>
            </div>						
            <div class="ParamControl">
                <cc1:WebDateTime ID="webDateTimeEditStart" runat="server" WebCalendarID="webCalendar" EditModeFormat="MM/dd/yyyy HH:mm" EnableAppStyling="True" >
                    <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif"></ButtonsAppearance>
                    <SpinButtons Display="OnRight" />
                    <ClientSideEvents TextChanged="dateTimeCheckArchive" />  
                </cc1:WebDateTime>
            </div>                            
            <div style="clear:both; "></div>
            <div class="ParamControlLabel">
                <asp:Label ID="Label4" runat="server" Text="End D/T:"   ></asp:Label>
            </div>
            <div class="ParamControl">
                <cc1:WebDateTime ID="webDateTimeEditEnd" runat="server" WebCalendarID="webCalendar" >
                    <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif"></ButtonsAppearance>                            
                    <SpinButtons Display="OnRight" />
                    <ClientSideEvents TextChanged="dateTimeCheckArchive" />                              
                </cc1:WebDateTime>
            </div>    
            <asp:Label ID="lblArchiveDateWarning" runat="server" Text=" "></asp:Label>            
        </div>
    </div>
</div>
</div>
<div class="Section" id="divCoordinatorOrganization" runat="server">
    <div class="SectionTitle">
        <asp:Label ID="Label5" runat="server" Text="Coordinator/Organization" />
    </div>
    <div class="sectionControl">
    <igmisc:WebAsyncRefreshPanel ID="ajaxPanelCooridnatorOrganizationGroup" runat="server" Height="20px" Width="100%">
        <div id="divReportGroup" class="ParamLabeldAndControlWrapper" runat="server">
            <div class="ParamControlLabel">Report Group:</div>
            <div class="ParamControl"><cc1:dropdownreportgroup id="ddlReportGroup" Width="500px" runat="server" AutoPostBack="True"></cc1:dropdownreportgroup></div>
        </div>
        <div id="divOrganization" class="ParamLabeldAndControlWrapper" runat="server">
        <div class="ParamControlLabel">Organization:</div>
        <div class="ParamControl"><cc1:DropDownReportOrganization id="ddlOrganization" Width="500px" runat="server" AutoPostBack="True" DefaultText="..."></cc1:DropDownReportOrganization></div>
        </div>
        <div id="divSourceCode" class="ParamLabeldAndControlWrapper" runat="server">
        
        <div class="ParamControlLabel">Source Code:</div>
        <div class="ParamControl"><cc1:DropDownReportSourceCode id="ddlSourceCode" Width="500px" runat="server" DefaultText="..."></cc1:DropDownReportSourceCode></div>
        </div>
        <div id="divOrganizationCoordinator" class="ParamLabeldAndControlWrapper" runat="server">

        <div class="ParamControlLabel">Coordinator:</div>
        <div class="ParamControl"><cc1:dropdownreportorganizationcoordinator id="ddlOrganizationCoordinator" Width="500px" runat="server" DefaultText="..."></cc1:dropdownreportorganizationcoordinator></div>
        </div>

    </igmisc:WebAsyncRefreshPanel>
    </div>

</div>

<div class="Section" id="divAgeGender" runat="server">
    <div class="SectionTitle">
        <asp:Label ID="Label6" runat="server" Text="Age & Gender" />
    </div>
    <div class="SectionControl">
        <div class="ParamLabeldAndControlWrapper"  >
           <div class="SubSectionControl">
                <div class="ParamControlLabel">Lower Age Limit:</div>
                <div class="ParamControl"><asp:TextBox EnableViewState="False" id="txtBoxLowerAge" runat="server" Width="110"></asp:TextBox></div>
                <div class="ParamControlLabel">Upper Age Limit:</div>
                <div class="ParamControl"><asp:TextBox EnableViewState="False" id="txtBoxUpperAge" runat="server" Width="110"></asp:TextBox></div>
            </div>
        </div>
        <div class="ParamLabeldAndControlWrapper" >
            <div class="SubSectionControl">
                <div class="ParamControlLabel">Gender:</div>
                <div class="ParamControl">						
                        <asp:DropDownList EnableViewState="False" id="ddlGender" runat="server">
							<asp:ListItem Value="..."></asp:ListItem>
							<asp:ListItem Value="F">Female</asp:ListItem>
							<asp:ListItem Value="M">Male</asp:ListItem>
						</asp:DropDownList>
                </div>
            </div>        
       </div>
    </div>              
</div>

<div id="divSortOptions" class="Section" runat="server" >
    <div class="SectionTitle">
        <asp:Label ID="Label7" runat="server" Text="Sort Options"></asp:Label>
    </div>
    <div class="sectionControl">
        <div class="ParamLabeldAndControlWrapper">
            <div class="ParamControlLabel">Sort By:
            </div>
            <div class="ParamControl">
                <cc1:DropDownSortOptions id="ddlSortOption1" runat="server" Width="300px" DefaultText="..."></cc1:DropDownSortOptions>
            </div>
        </div>
        <div class="ParamLabeldAndControlWrapper">       
            <div class="ParamControlLabel">Then By:
            </div>
            <div class="ParamControl">
                <cc1:DropDownSortOptions id="ddlSortOption2" runat="server" Width="300px" DefaultText="..."></cc1:DropDownSortOptions>
            </div>
        </div>
        <div class="ParamLabeldAndControlWrapper">       
            <div class="ParamControlLabel">Then By:
            </div>
            <div class="ParamControl">
                <cc1:DropDownSortOptions id="ddlSortOption3" runat="server" Width="300px" DefaultText="..."></cc1:DropDownSortOptions>
            </div>
        </div>
    </div>
</div>

<div class="SectionSeperator">
</div>
<div id="divDisplayOptions" class="Section" runat="server">
    <div class="SectionTitle">
        <asp:Label ID="Label8" runat="server" Text="Display Options"></asp:Label>
    </div>
    <div class="sectionControl">
        <div id="divDisplayReferralName" class="ParamCheckBox" runat="server">
            <asp:CheckBox EnableViewState="True" runat="server" ID="chkBoxDisplayReferralName" Text="Display Referral Name:"
							Checked="True" Visible="True" TextAlign="Left" ></asp:CheckBox>        
        </div>
        <div id="divDisplaySSN" class="ParamCheckBox" runat="server">
		    <asp:CheckBox EnableViewState="True" runat="server" ID="chkBoxDisplaySSN" Text="Display SSN:" Checked="True"
        	Visible="True" TextAlign="Left"></asp:CheckBox>
       </div>
       <div id="divDisplayMedicalRecord" class="ParamCheckBox" runat="server">
			<asp:CheckBox EnableViewState="True" runat="server" ID="chkBoxDisplayMedicalRecord" Text="Display Medical Record #:"
			Checked="True" Visible="True" TextAlign="Left"></asp:CheckBox>

        </div>

    </div>
</div>
<div id="divTimeZone" class="Section" runat="server">
    <div class="SectionTitle">
        <asp:Label ID="Label9" runat="server" Text="Time Zone"></asp:Label>
    </div>
    <div class="sectionControl">        
       <div class="ParamCheckBox">
<asp:RadioButton id="radionButtonTimeZoneMountain" runat="server" GroupName="TimeZone" Text="Mountain Time:" Checked="True" TextAlign="Left"></asp:RadioButton>					
       </div>
         <div class="ParamCheckBox">
        <asp:RadioButton id="radionButtonTimeZoneReferral" runat="server" GroupName="TimeZone" Text="Referral Facility:" TextAlign="Left"></asp:RadioButton>
        </div>

    </div>
</div>

<div class="SectionSeperator"/>
<div class="Section">
<div>
    <igmisc:WebAsyncRefreshPanel ID="ajaxPanelViewReport" runat="server" RefreshComplete="ajaxPanelViewReport_RefreshComplete" Height="20px"  Width="80px" >
    <cc1:linkbuttontexture EnableViewState="False" id="btnViewReport" runat="server">View Report</cc1:linkbuttontexture>
		
    </igmisc:WebAsyncRefreshPanel>
</div>
</div>

<igmisc:WebPageStyler ID="WebPageStyler1" runat="server" EnableAppStyling="True"
    EnableTheming="True" StyleSetName="StatlineReports" />

<igsch:WebCalendar ID="webCalendar" runat="server" >
</igsch:WebCalendar>
