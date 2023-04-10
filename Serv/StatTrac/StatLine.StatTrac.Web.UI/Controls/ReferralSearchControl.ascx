<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReferralSearchControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.ReferralSearchControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<asp:ScriptManager ID="scmReferralSearch" runat="server" />
<!--use two webCalendar templates and move to top of html to prevent javascript error -->
<script language="javascript" type="text/javascript">
    
    function ClickSubWeek()
	{
	    //alert("hello");
	    var startDateTimeCtlID = igedit_getById('<%= startDateTime.ClientID %>');
	    var endDateTimeCtlID = igedit_getById('<%= endDateTime.ClientID %>');
	    
	    var dateArr1 = new Date(startDateTimeCtlID.getValue());
        dateArr1.setDate(dateArr1.getDate() - 7);	    
        startDateTimeCtlID.setValue(dateArr1);
        
		var dateArr2 = new Date(endDateTimeCtlID.getValue());
        dateArr2.setDate(dateArr2.getDate() - 7)
        endDateTimeCtlID.setValue(dateArr2);
	}
	
	 function ClickAddWeek()
	{
	    var startDateTimeCtlID = igedit_getById('<%= startDateTime.ClientID %>');
	    var endDateTimeCtlID = igedit_getById('<%= endDateTime.ClientID %>');
	    
	    var dateArr1 = new Date(startDateTimeCtlID.getValue());
        dateArr1.setDate(dateArr1.getDate() + 7);	    
        startDateTimeCtlID.setValue(dateArr1);
        
		var dateArr2 = new Date(endDateTimeCtlID.getValue());
        dateArr2.setDate(dateArr2.getDate() + 7)
        endDateTimeCtlID.setValue(dateArr2);

	}
</script>   
<stattrac:sectionheader id="sectionHeaderReferralSearch" runat="server" text="Search for Referrals"
    width="100%" ></stattrac:sectionheader>
<div style="position: relative; width: 225px; height: 155px; z-index: 102; left: -8px; top: 590px;">
<asp:ObjectDataSource ID="odsRefList" runat="server" SelectMethod="FillReferralList" TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsRefList_Selected" CacheDuration="30" EnableCaching="True" OnSelecting="odsRefList_Selecting">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCallNumber" DefaultValue="0" Name="CallNumber"
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txtPatientFirstName"  Name="PatientFirstName"
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txtPatientLastName"  Name="PatientLastName"
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="startDateTime"  Name="startDateTime" Type="DateTime" PropertyName="Text" />
        <asp:ControlParameter ControlID="endDateTime"  Name="endDateTime" Type="DateTime" PropertyName="Text"/>
        <asp:Parameter DefaultValue="0" Name="OrganizationID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="ReportGroupID" Type="Int32" />
        <asp:Parameter DefaultValue="" Name="SpecialSearchCriteria" Type="Int32" />
        <asp:Parameter DefaultValue="Referral" Name="BasedOnDT" Type="String" />
        <asp:Parameter DefaultValue="MT" Name="timeZone" Type="String" />
        
        
    </SelectParameters >
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsWebReportGroup" runat="server" SelectMethod="FillReportGroupList1" TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsReportGroup_Selected">
    <SelectParameters>
        <asp:Parameter DefaultValue="" Name="userOrgID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsRefFacility" runat="server" SelectMethod="FillOrganzationList"
        TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsRefFacility_Selected" OnSelecting="odsRefFacility_Selecting" CacheDuration="15" EnableCaching="True">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="reportGroupID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <igmisc:WebPageStyler ID="webPageStyler" runat="server" StyleSetName="StatlineReports" EnableAppStyling="True" />
    </div>
<StatTrac:SectionHeader ID="SectionHeader1" runat="server" style="" Text="Referral List" Width="100%" />
<igtbl:UltraWebGrid ID="gridReferralList" runat="server" Height="365px"
    Width="1050px" style="" DataSourceID="odsRefList" OnInitializeLayout="gridReferralList_InitializeLayout">
    <Bands>
        <igtbl:UltraGridBand AddButtonCaption="ReferralList" BaseTableName="ReferralList"
            Expandable="Yes" Key="ReferralList" AllowDelete="No">
            <Columns>
                <igtbl:TemplatedColumn BaseColumnName="CallNumber" IsBound="True" Key="CallNumber"
                    Type="HyperLink" Width="90px">
                    <CellTemplate>
                       <asp:HyperLink runat="server" Target="blank" Text='<%# DataBinder.Eval(Container.DataItem,"CallNumber") %> '
                            NavigateUrl='<%# "~/ReferralUpdate.aspx?CallNumber=" + DataBinder.Eval(Container.DataItem,"CallNumber") + "&OrganizationID=" + DataBinder.Eval(Container.DataItem,"OrganizationID") + "&CallID=" + DataBinder.Eval(Container.DataItem,"CallID") + "&OrganizationName=" + DataBinder.Eval(Container.DataItem,"OrganizationName") 
                            +"&ReferralDonorName=" + DataBinder.Eval(Container.DataItem,"ReferralDonorName") + "&A/S/R=" + DataBinder.Eval(Container.DataItem,"A/S/R") + "&RefCallerOrgID=" + DataBinder.Eval(Container.DataItem,"ReferralCallerOrganizationID") + "&SourceCodeName=" + DataBinder.Eval(Container.DataItem,"SourceCodeName") + "&OrganizationTimeZone=" + DataBinder.Eval(Container.DataItem,"OrganizationTimeZone") %>' />
                    </CellTemplate>
                    <Header Caption="Call Number">
                    </Header>
                </igtbl:TemplatedColumn>
                <igtbl:UltraGridColumn BaseColumnName="BasedOnDT" IsBound="True" Key="BasedOnDT"
                    Width="125px" DataType="System.DateTime" Format="MM/dd/yyyy HH:mm">
                    <Header Caption="Call Date Time">
                        <RowLayoutColumnInfo originx="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo originx="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ReferralDonorName" IsBound="True" Key="ReferralDonorName"
                    Width="140px">
                    <Header Caption="Patient Name">
                        <RowLayoutColumnInfo originx="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo originx="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn AllowResize="Free" BaseColumnName="MedicalRecordNumber" IsBound="True"
                    Key="MedicalRecordNumber" Width="145px">
                    <Header Caption="Medical Record Number">
                        <RowLayoutColumnInfo originx="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo originx="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="OrganizationName" IsBound="True" Key="OrganizationName"
                    Width="150px">
                    <Header Caption="Referral Facility Name">
                        <RowLayoutColumnInfo originx="4" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo originx="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn AllowNull="False" BaseColumnName="A/S/R" IsBound="True" Key="A/S/R"
                    Width="85px">
                    <Header Caption="A/S/R">
                        <RowLayoutColumnInfo originx="5" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo originx="5" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="PreliminaryRefType" IsBound="True" Key="PreliminaryRefType"
                    Width="140px">
                    <Header Caption="Preliminary Ref Type">
                        <RowLayoutColumnInfo originx="6" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo originx="6" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="CurrentRefType" IsBound="True" Key="CurrentRefType"
                    Width="140px">
                    <Header Caption="Current Ref Type">
                        <RowLayoutColumnInfo originx="7" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo originx="7" />
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
    <DisplayLayout Name="ctl00xgridReferralList" RowHeightDefault="20px" SelectTypeRowDefault="Single"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" CellSpacingDefault="1" AllowColSizingDefault="Free" AllowSortingDefault="Yes" BorderCollapseDefault="Separate" HeaderClickActionDefault="SortMulti" StationaryMargins="Header">
        <FrameStyle BorderStyle="None"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="365px"
            Width="1050px" Cursor="Default" ForeColor="#A37171">
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
    </DisplayLayout>
</igtbl:UltraWebGrid>

    <div style="position: relative; width: 1050px; height: 155px; left: 0px; top: -543px; z-index: 103;" id="divMain">    

        <asp:Label ID="lblReportGroup" runat="server" Style="z-index: 100; top: 5px; position: absolute; left: 10px;"
                 Text="Report Group" Width="100px"></asp:Label>

        <asp:Label ID="lblRefFacility" runat="server" Style="z-index: 101; top: 5px; position: absolute; left: 385px;"
                 Text="Referral Facility" Width="115px"></asp:Label>

        <asp:Label ID="lblSpecialSearch" runat="server" Style="z-index: 102; top: 5px; position: absolute; left: 710px;"
                 Text="Special Search Criteria" Width="145px"></asp:Label>
        
        <igcmbo:WebCombo ID="ddlReportGroup" runat="server" BackColor="White" BorderColor="Silver"                
                BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="360px"
                SelForeColor="White" Style="z-index: 103;  position: absolute; top: 35px; left: 10px;" DataTextField="ReportGroupName" DataValueField="WebReportGroupID"
                Version="4.00" DataSourceID="odsWebReportGroup" OnSelectedRowChanged="ddlReportGroup_SelectedRowChanged" ComboTypeAhead="Suggest" Editable="True" EnableAppStyling="True" EnableXmlHTTP="True" OnInitializeLayout="ddlReportGroup_InitializeLayout" OnDataBound="ddlReportGroup_DataBound">
                 
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="Databound Col0" IsBound="True" Key="Databound Col0">
                        <header caption="Databound Col0"></header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="Databound Col1" DataType="System.Int32" IsBound="True"
                        Key="Databound Col1">
                        <header caption="Databound Col1">
<RowLayoutColumnInfo originx="1"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo originx="1"></RowLayoutColumnInfo>
</footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="Databound Col2" IsBound="True" Key="Databound Col2">
                        <header caption="Databound Col2">
<RowLayoutColumnInfo originx="2"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo originx="2"></RowLayoutColumnInfo>
</footer>
                    </igtbl:UltraGridColumn>
                    
                </Columns>
                <ExpandEffects ShadowColor="LightGray" />
                <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" DropdownWidth="360px" ColWidthDefault="360px" BaseTableName="" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" >
                    <FrameStyle Height="130px" Width="360px">
                    </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
            </igcmbo:WebCombo>
        
         <igcmbo:WebCombo ID="ddlRefFacility" runat="server" BackColor="White" BorderColor="Silver" DataTextField="OrganizationName" DataValueField="OrganizationID"
                BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" Editable="True" EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue"
                SelForeColor="White" Style="z-index: 104;  position: absolute; top: 35px; left: 385px;" Width="290px"
                Version="4.00" EnableAppStyling="True" OnInitializeLayout="ddlRefFacility_InitializeLayout" DataSourceID="odsRefFacility" > 
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="OrganizationName" IsBound="True" Key="OrganizationName">
                        <header caption="OrganizationName"></header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="OrganizationID" DataType="System.Int32" IsBound="True"
                        Key="OrganizationID">
                        <header caption="OrganizationID">
<RowLayoutColumnInfo originx="1"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo originx="1"></RowLayoutColumnInfo>
</footer>
                    </igtbl:UltraGridColumn>
                    
                </Columns>
                <ExpandEffects ShadowColor="LightGray" />
                <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" DropdownWidth="290px" ColWidthDefault="290px" XmlLoadOnDemandType="Accumulative" BaseTableName="" ColHeadersVisible="No" GridLines="None" RowSelectors="No" >
                    <FrameStyle Height="130px" Width="290px">
                    </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
            </igcmbo:WebCombo>
        
        <igcmbo:WebCombo ID="ddlSpecCriteria" runat="server" BackColor="White" BorderColor="Silver"
                        ColHeadersVisible="No" GridLines="None" RowSelectors="No"             

                BorderStyle="Solid" BorderWidth="1px"  ForeColor="Black" SelBackColor="DarkBlue" Width="205px"
                SelForeColor="White" Style="z-index: 105; position: absolute; top: 35px; left: 710px;"
                Version="4.00" EnableAppStyling="True" DisplayValue="Pending Referrals" >
                <Columns>
                    <igtbl:UltraGridColumn>
                        
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn Hidden="True">
                        <header>
<RowLayoutColumnInfo originx="1"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo originx="1"></RowLayoutColumnInfo>
</footer>
                        
                    </igtbl:UltraGridColumn>
                </Columns>
                <ExpandEffects ShadowColor="LightGray" />
               <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" DropdownWidth="205px" ColWidthDefault="290px" XmlLoadOnDemandType="Accumulative" BaseTableName="" ColHeadersVisible="No" GridLines="None" RowSelectors="No" >
                    <FrameStyle Height="30px" Width="205px">
                    </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
                <Rows>
                    <igtbl:UltraGridRow Height="">
                    <cells>
                        <igtbl:UltraGridCell Text="Pending Referrals"></igtbl:UltraGridCell>
                        <igtbl:UltraGridCell Text="1"></igtbl:UltraGridCell>
                    </cells>
                    </igtbl:UltraGridRow>
                </Rows>
                <Rows>
                    <igtbl:UltraGridRow Height="">
                    <cells>
                        <igtbl:UltraGridCell Text="All"></igtbl:UltraGridCell>
                        <igtbl:UltraGridCell Text="0"></igtbl:UltraGridCell>
                    </cells>
                    </igtbl:UltraGridRow>
                </Rows>
        </igcmbo:WebCombo>
        <asp:Label ID="lblCallNo" runat="server" Style="z-index: 106; position: absolute;
                top: 70px; left: 15px;" Text="Call #" Width="120px"></asp:Label>

        <asp:Label ID="lblBasedOnDT" runat="server" Style="z-index: 107;  position: absolute;
                top: 70px; left: 190px;" Text="Based On D/T" Width="120px"></asp:Label>

        <asp:Label ID="lblStartDate" runat="server" Style="z-index: 108;  position: absolute;
                top: 70px; left: 385px;" Text="Start Date/Time" Width="120px"></asp:Label>

        <asp:Label ID="lblEndDate" runat="server" Style="z-index: 109; position: absolute;
                top: 70px; left: 520px;" Text="End Date/Time" Width="120px"></asp:Label>

        <asp:Label ID="lblPatientFirstName" runat="server" Style="z-index: 110;  position: absolute;
                top: 70px; left: 710px;" Text="Patient First Name" Width="120px"></asp:Label>

        <asp:Label ID="lblPatientLastName" runat="server" Style="z-index: 111;  position: absolute;
                top: 70px; left: 880px;" Text="Patient Last Name" Width="120px"></asp:Label>

            <asp:TextBox ID="txtCallNumber" runat="server" Style="z-index: 112;  position: absolute;
                top: 95px; left: 15px;"></asp:TextBox>

            <igcmbo:WebCombo ID="ddlBasedOnDT" runat="server" BackColor="White" BorderColor="Silver" 
                BorderStyle="Solid" BorderWidth="1px"  ForeColor="Black" SelBackColor="DarkBlue"
                SelForeColor="White" Style="z-index: 113;  position: absolute; top: 95px; left: 190px;"
                Version="4.00" Width="150px" EnableAppStyling="True" DisplayValue="Referral">
                <Columns>
                    <igtbl:UltraGridColumn Width="370px">
                        
                    </igtbl:UltraGridColumn>
                     
                </Columns>
                <ExpandEffects ShadowColor="LightGray" />
                <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" ColWidthDefault="150px" DropdownWidth="150px" ColHeadersVisible="No" GridLines="None" RowSelectors="No"             >
                    <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                        Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="150px">
                    </FrameStyle>
                    <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                    </HeaderStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px">
                        <BorderDetails WidthLeft="0px" WidthTop="0px" />
                    </RowStyle>
                    <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
                </DropDownLayout>
                <Rows>
                    <igtbl:UltraGridRow Height="">
                    <cells>
<igtbl:UltraGridCell Text="Cardiac Death"></igtbl:UltraGridCell>
</cells>
                    </igtbl:UltraGridRow>
                    <igtbl:UltraGridRow Height="">
                    <cells>
<igtbl:UltraGridCell Text="Referral"></igtbl:UltraGridCell>
</cells>
                    </igtbl:UltraGridRow>
                </Rows>
            </igcmbo:WebCombo>
<StatTrac:WebDateTime ID="startDateTime" runat="server" WebCalendarID="webCalendar" Width="130px" style="z-index: 118; left: 385px; position: absolute; top: 97px">
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>
      
        <StatTrac:WebDateTime ID="endDateTime" runat="server" WebCalendarID="webCalendar" Width="130px" EditModeFormat="g" EnableAppStyling="True" style="z-index: 117; left: 520px; position: absolute; top: 97px">
    <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
    </ButtonsAppearance>
    <SpinButtons Display="OnRight" />
</StatTrac:WebDateTime>
        
             <input type="button" id="btnStartDTBack" runat="server" Style="z-index: 122; top: 95px; position: absolute;
                 left: 655px; width: 25px;" value="<<" OnClick="ClickSubWeek();" />
            
            <input type="button"  id="btnStartDTForward" runat="server" Style="z-index: 123; top: 95px; position: absolute;
               left: 680px;" value=">>" OnClick="ClickAddWeek();" />    
       
        <asp:TextBox ID="txtPatientFirstName" runat="server" Style="z-index: 114;  position: absolute;
                top: 95px; left: 710px;"></asp:TextBox>
       
        <asp:TextBox ID="txtPatientLastName" runat="server" Style="z-index: 115;  position: absolute;
                top: 95px; left: 880px;" Width="160px"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Style="z-index: 116;
             position: absolute; top: 125px; left: 880px;" Text="Search" />  
</div>
<igsch:WebCalendar ID="webCalendar" runat="server" style="z-index: 109; left: 10px; position: absolute; top: 550px" />