<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReferralFacilityComplianceControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.ReferralFacilityComplianceControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls" TagPrefix="StatTrac" %>
<asp:ScriptManager ID="referralFacilityScriptManager" runat="server" />

<script language="javascript" type="text/javascript">
function ClickFindMonth(fieldObj)
	{
	var test = new Object(fieldObj);
	test.valueOf;
	alert(test.toString());
	}
    function ClickSubMonth()
	{
	    var startDateTimeCtlID = igedit_getById('<%= startDateTime.ClientID %>');
	    
	    var dateArr1 = new Date(startDateTimeCtlID.getValue());
        dateArr1.setMonth(dateArr1.getMonth() - 1);	    
        
		var dateArr2 = new Date(dateArr1);
        dateArr2.setDate(daysInMonth(dateArr1.getMonth(), dateArr1.getYear())); 

        startDateTimeCtlID.setValue(dateArr1);
	}
	
	 function ClickAddMonth()
	 {
	    var startDateTimeCtlID = igedit_getById('<%= startDateTime.ClientID %>');
    
	    var dateArr1 = new Date(startDateTimeCtlID.getValue());
        dateArr1.setMonth(dateArr1.getMonth() + 1);	    
        
        startDateTimeCtlID.setValue(dateArr1);
        
     }

    function daysInMonth(iMonth, iYear)
    {
         return 32 - new Date(iYear, iMonth, 32).getDate();
    }

</script> 

<script id="igClientScript" type="text/javascript">
<!--

function gridReferralFacilityList_AfterCellUpdateHandler(gridName, cellId)
{ 
//var oGrid = igtbl_getGridById(gridName);
// Obtain a reference to the cell that was double clicked
//var oCell = igtbl_getCellById(cellId);
// Obtain a reference to the row in which the cell was double clicked
var oRow = igtbl_getRowById(cellId);
oCell1 = oRow.getCell(7);
oCell3 = oRow.getCell(4).getValue(); //Total Referrals
oCell2 = oRow.getCell(5).getValue(); //Client Reported Deaths

    if (oCell2 == null)
        {
        oCell2 = 0;
        }

    if (oCell2 > oCell3)
    {
        var reportedDeaths = (oCell3/oCell2)*100;
    }
    else
    {   // max allowed is 100 percent
        var reportedDeaths = 100.0;
    }
var reportedDeathsPercent = reportedDeaths.toFixed(0);

    if (oCell2 != 0)
    {
        var displayValue = reportedDeathsPercent + " %";
    }
    else
    {   //infinity not allowed; must show '-'
        var displayValue = "-";
    }   
//Update data grid
oCell1.setValue(displayValue);
}
// -->
</script>

<igmisc:WebPageStyler id="webPageStyler" runat="server" EnableAppStyling="True" StyleSetName="StatlineReports"></igmisc:WebPageStyler>

<StatTrac:SectionHeader id="sectionHeaderSearchParameters" runat="server" text="Search Parameters" width="100%"/>
<igmisc:WebAsyncRefreshPanel ID="ajaxPanelOrganizationSource" runat="server" Width="100%" TriggerPostBackIDs="*$btnSearch" >       
<div id="divRow1" style="height: 50px">
<div style="display: inline; width: 370px;">
    <asp:Label id="lblReportGroup" runat="server" Text="Report Group" Width="360"></asp:Label>
    <igcmbo:WebCombo ID="ddlReportGroup" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px"
            EnableAppStyling="True" ForeColor="Black"
            SelBackColor="DarkBlue" SelForeColor="White" Version="4.00" Width="360px" ComboTypeAhead="Suggest" DataSourceID="odsReportGroup" Editable="True" EnableXmlHTTP="True" OnSelectedRowChanged="ddlReportGroup_SelectedRowChanged" DataTextField="ReportGroupName" DataValueField="WebReportGroupID" OnInitializeLayout="ddlReportGroup_InitializeLayout" DisplayValue="..." OnDataBound="ddlReportGroup_DataBound">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="ReportGroupName" IsBound="True" Key="ReportGroupName">
                    <header caption="ReportGroupName"></header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="WebReportGroupID" DataType="System.Int32"
                    IsBound="True" Key="WebReportGroupID">
                    <header caption="WebReportGroupID">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
                        </Columns>
                        <ExpandEffects ShadowColor="LightGray" />
                        <DropDownLayout BaseTableName="" BorderCollapse="Separate" ColWidthDefault="360px"
                            DropdownWidth="360px" RowHeightDefault="20px" Version="4.00" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No">
                            <FrameStyle Height="130px" Width="360px">
                            </FrameStyle>
                            <RowStyle BackColor="White" BorderColor="Gray" />
                        </DropDownLayout>
    </igcmbo:WebCombo>
    
</div>
<div style="display: inline; width:600px;">
  
        <div style="display: inline; width: 300px;">
            <asp:Label ID="lblRefFacility" runat="server" Text="Referral Facility" Width="290px"></asp:Label>&nbsp;

            <igcmbo:WebCombo ID="ddlRefFacility" runat="server" BackColor="White" BorderColor="Silver"
                BorderStyle="Solid" BorderWidth="1px"
                EnableAppStyling="True" ForeColor="Black" SelBackColor="DarkBlue"
                SelForeColor="White" Version="4.00" Width="290px" ComboTypeAhead="Suggest" DataSourceID="odsOrganization" Editable="True" 
                EnableXmlHTTP="True" DataTextField="OrganizationName" DataValueField="OrganizationID" DisplayValue="..." OnInitializeLayout="ddlRefFacility_InitializeLayout" >
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="OrganizationName" IsBound="True" Key="OrganizationName">
                        <header caption="OrganizationName"></header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="OrganizationID" DataType="System.Int32" IsBound="True"
                        Key="OrganizationID" Hidden="true" >
                        <header caption="OrganizationID">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                    </igtbl:UltraGridColumn>
                </Columns>
                <ExpandEffects ShadowColor="LightGray" />
                <DropDownLayout BaseTableName="" BorderCollapse="Separate" ColWidthDefault="290px"
                    DropdownWidth="290px" RowHeightDefault="20px" Version="4.00" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" >
                    <FrameStyle Height="130px" Width="290px">
                    </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
            </igcmbo:WebCombo>
            
    </div>
        <div style="display: inline; width: 155px;">
        
        <asp:Label ID="lblSourceCode" runat="server" Text="Source Code" Width="145px"></asp:Label>&nbsp;
        <igcmbo:WebCombo
            ID="ddlSourceCode" runat="server" Version="4.00" DataSourceID="odsSourceCode" DataTextField="SourceCodeName" DataValueField="SourceCodeName" DisplayValue="..." Editable="True" EnableXmlHTTP="True" SelBackColor="" SelForeColor="" OnInitializeLayout="ddlSourceCode_InitializeLayout" EnableAppStyling="True"
            
            >
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="SourceCodeID" DataType="System.Int32" IsBound="True"
                    Key="SourceCodeID">
                    <header caption="SourceCodeID"></header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="SourceCodeName" IsBound="True" Key="SourceCodeName">
                    <header caption="SourceCodeName">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
            </Columns>
            <ExpandEffects ShadowColor="LightGray" />
            <DropDownLayout Version="4.00" ColHeadersVisible="No" RowSelectors="No" XmlLoadOnDemandType="Accumulative" RowHeightDefault="20px" BaseTableName="">
                <FrameStyle Height="130px" Width="325px">
                </FrameStyle>
            </DropDownLayout>
        </igcmbo:WebCombo>
    </div>
   
</div>
</div>

<div id="divRow2" style="height: 50px">
    <div style="display: inline; width: 180px;">
        <asp:Label ID="lblBasedOnDT" runat="server" Text="Based On D/T" Width="150px"></asp:Label>
        <igcmbo:WebCombo
            ID="ddlBasedOnDT" runat="server" DisplayValue="Referral" EnableAppStyling="True"
            SelBackColor="" SelForeColor="" Version="4.00" Width="152px">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="DateType" Key="DateType">
                    <header caption="DisplayType"></header>
                </igtbl:UltraGridColumn>
            </Columns>
            <ExpandEffects ShadowColor="LightGray" />
            <DropDownLayout ColHeadersVisible="No" ColWidthDefault="152px" DropdownHeight="22px"
                DropdownWidth="152px" RowSelectors="No" Version="4.00">
                <FrameStyle Height="22px" Width="152px">
                </FrameStyle>
            </DropDownLayout>
            <Rows>
                <igtbl:UltraGridRow Height="">
                    <cells>
    <igtbl:UltraGridCell Text="Referral" Key="DateType"></igtbl:UltraGridCell>
    </cells>
                </igtbl:UltraGridRow>
            </Rows>
        </igcmbo:WebCombo>
    </div>
    <div style="display: inline; width: 125px;">
        <asp:Label ID="lblStartDate" runat="server" Text="Month/Year" Width="100px"></asp:Label>
        <StatTrac:WebDateTime ID="startDateTime" runat="server" WebCalendarID="webCalendar"
            Width="141px" DisplayModeFormat="MMMM yyyy " EditModeFormat="MM/dd/yyyy HH:mm"  EnableAppStyling="True" >
            <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
            </ButtonsAppearance>
            <SpinButtons Display="OnRight" Delta="28" />
            
        </StatTrac:WebDateTime>
    </div>
    <div style="display: inline; width: 93px;" id="DIV1" >
        <input id="btnStartDTBack" runat="server" onclick="ClickSubMonth();" style="margin-left: 5px" type="button" value="<<" />
        <input id="btnStartDTForward" runat="server" onclick="ClickAddMonth();" type="button" value=">>" />
    </div>

    <div style="display: inline; width: 75px;">
            <asp:Button ID="btnSearch" runat="server" Enabled="False"  Text="Search" OnClick="btnSearch_Click" />
    </div>
</div>
</igmisc:WebAsyncRefreshPanel> 
<br />
<StatTrac:SectionHeader id="sectoinHeaderReferralFacilityCompliance" runat="server" text="Referral Facility Compliance" EnableAppStyling="True"
    width="100%"/>
    <div style="display: inline; width: 100%; height: 41%;">
        <igtbl:UltraWebGrid ID="gridReferralFacilityList" runat="server" 
        Height="365px" Style="left: 20px;" Width="1060px"  EnableAppStyling="True" OnUpdateRow="gridReferralFacilityList_UpdateRow"
        DataMember="ReferralFacilityCompliance" DataSource="<%# dsReferralData %>" OnUpdateCell="gridReferralFacilityList_UpdateCell" > 
        <Bands>
            <igtbl:UltraGridBand AddButtonCaption="ReferralFacilityCompliance" BaseTableName="ReferralFacilityCompliance"
                Expandable="Yes" Key="ReferralFacilityCompliance" AllowDelete="No">
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="OrganizationID" Hidden="True" IsBound="True"
                        Key="OrganizationID">
                        <Header Caption="OrganizationID">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="OrganizationName" IsBound="True" Key="OrganizationName"
                        Width="395px">
                        <Header Caption="Referral Facility">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="TotalReferrals" DataType="System.Int32" IsBound="True"
                        Key="TotalReferrals" Width="108px">
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Header Caption="Total Referrals">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="TotalRegistered" DataType="System.Int32" IsBound="True"
                        Key="TotalRegistered" Width="113px">
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Header Caption="Total Registered">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="TotalCTOD" DataType="System.Int32" IsBound="True"
                        Key="TotalCTOD" Width="162px">
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Header Caption="Total Referrals w/ CTOD Reported">
                            <RowLayoutColumnInfo OriginX="4" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="4" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn AllowUpdate="Yes" BaseColumnName="ClientReportedDeaths" DataType="System.Int32"
                        IsBound="True" Key="ClientReportedDeaths" Width="154px">
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Header Caption="Client Reported Deaths">
                            <RowLayoutColumnInfo OriginX="5" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="5" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="SourceCodeList" Hidden="True" IsBound="True"
                        Key="SourceCodeList">
                        <Header Caption="SourceCodeList">
                            <RowLayoutColumnInfo OriginX="6" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="6" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="%_Compliance" IsBound="True" Key="%_Compliance"
                        Width="108px">
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Header Caption="%_Compliance">
                            <RowLayoutColumnInfo OriginX="7" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="7" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                </Columns>
                <RowEditTemplate>
                    <br />
                    <p align="center">
                        <input id="igtbl_reOkBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                            type="button" value="OK" />&nbsp;
                        <input id="igtbl_reCancelBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                            type="button" value="Cancel" /></p>
                </RowEditTemplate>
                <RowTemplateStyle BackColor="Window" BorderColor="Window" BorderStyle="Ridge">
                    <BorderDetails WidthBottom="3px" WidthLeft="3px" WidthRight="3px" WidthTop="3px" />
                </RowTemplateStyle>
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout Name="ctl00xgridReferralFacilityList" RowHeightDefault="20px" SelectTypeRowDefault="Single"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" CellSpacingDefault="1" AllowColSizingDefault="Free" AllowSortingDefault="Yes" BorderCollapseDefault="Separate" HeaderClickActionDefault="SortMulti" StationaryMargins="Header">
        <FrameStyle BorderStyle="None"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="365px"
            Width="1060px" Cursor="Default" ForeColor="#A37171">
        </FrameStyle>
        <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </FooterStyleDefault>
        <HeaderStyleDefault BackColor="#6E1515" BorderStyle="Solid" BorderColor="Black" ForeColor="White">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </HeaderStyleDefault>
        <RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
            Font-Names="Verdana" Font-Size="8pt">
            <Padding Left="3px" />
            <BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202" />
        </RowStyleDefault>
        <AddNewBox>
            <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </BoxStyle>
        </AddNewBox>
        <ActivationObject BorderColor="Black" BorderWidth="">
        </ActivationObject>
        <FilterOptionsDefault>
            <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px" Width="200px">
                <Padding Left="2px" />
            </FilterDropDownStyle>
            <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
            </FilterHighlightRowStyle>
            <FilterOperandDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid"
                BorderWidth="1px" CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px">
                <Padding Left="2px" />
            </FilterOperandDropDownStyle>
        </FilterOptionsDefault>
        <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
        </SelectedRowStyleDefault>
        <ClientSideEvents AfterCellUpdateHandler="gridReferralFacilityList_AfterCellUpdateHandler" />
            <EditCellStyleDefault BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Top"  >
                
            </EditCellStyleDefault>
    </DisplayLayout>
        
    </igtbl:UltraWebGrid>
    </div>    
   
<asp:ObjectDataSource ID="odsReportGroup" runat="server"
    SelectMethod="FillReportGroupList1" TypeName="Statline.StatTrac.Referral.ReferralManager" EnableCaching="True" OnSelected="odsReportGroup_Selected">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="userOrgID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsOrganization" runat="server"
    SelectMethod="FillOrganzationList" TypeName="Statline.StatTrac.Referral.ReferralManager" EnableCaching="True" OnSelected="odsOrganization_Selected">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="reportGroupID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
&nbsp;
<asp:ObjectDataSource ID="odsSourceCode" runat="server" OnSelecting="odsSourceCode_Selecting" SelectMethod="FillReportSourceCodeList" TypeName="Statline.StatTrac.Report.ReportReferenceManager" EnableCaching="True" CacheDuration="30" OnSelected="odsSourceCode_Selected">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="reportGroupID" Type="Int32" />
        <asp:Parameter DefaultValue="1" Name="sourceCodeTypeID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<igsch:WebCalendar ID="webCalendar" runat="server" style="z-index: 109; left: 10px; position: absolute; top: 550px" />
  
    
    
