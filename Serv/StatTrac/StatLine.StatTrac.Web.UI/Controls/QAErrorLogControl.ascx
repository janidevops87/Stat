<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAErrorLogControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAErrorLogControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<stattrac:sectionheader id="sectionHeaderErrorLog" runat="server" text="Error Type Log"
    width="100%"></stattrac:sectionheader>
<div style="z-index: 100; left: 15px; width: 590px; position: relative; 
    height: 75px; top: 0px;">
    <asp:Button ID="btnAddPerson" runat="server" Style="z-index: 100; left: 315px; position: absolute;
        top: 5px" Text="..." OnClick="btnAddPerson_Click" OnClientClick="window.open('PersonData.aspx','_blank')" />
    <asp:CheckBox ID="cbxNoErrors" runat="server" Style="z-index: 101; left: 315px; position: absolute;
        top: 40px" Text="No Errors"/>
    <asp:Label ID="lblEmployee" runat="server" Style="z-index: 102; left: 30px; position: absolute;
        top: 5px" Text="Employee:"></asp:Label>
    <asp:Label ID="lblErrorLocation" runat="server" Style="z-index: 103; left: 5px; position: absolute;
        top: 40px" Text="Error Location:"></asp:Label>
    <igcmbo:WebCombo ID="ddlEmployee" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" 
        SelForeColor="White" Style="z-index: 104; left: 100px; position: absolute; top: 5px"
        Version="4.00" DataSourceID="odsEmployee" Editable="True" DataTextField="PersonName" DataValueField="PersonID" Width="205px" Height="20px" OnSelectedRowChanged="ddlEmployee_SelectedRowChanged" OnInitializeLayout="ddlEmployee_InitializeLayout" OnPreRender="ddlEmployee_PreRender" ComboTypeAhead="Suggest" EnableXmlHTTP="True" EnableAppStyling="True">
        <Columns>
            <igtbl:UltraGridColumn BaseColumnName="Databound Col0" IsBound="True" Key="Databound Col0">
                <header caption="Databound Col0"></header>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="Databound Col1" DataType="System.Int32" IsBound="True"
                Key="Databound Col1">
                <header caption="Databound Col1">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="Databound Col2" IsBound="True" Key="Databound Col2">
                <header caption="Databound Col2">
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
        </Columns>
        <ExpandEffects ShadowColor="LightGray" />
        <DropDownLayout Version="4.00" ColWidthDefault="205px" DropdownWidth="205px"  BaseTableName="" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No">
                    <FrameStyle Height="130px" Width="205px" > </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
        
    </igcmbo:WebCombo>
    <igcmbo:WebCombo ID="ddlErrorLocation" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 106; left: 100px; position: absolute; top: 40px"
        Version="4.00" Width="205px" DataSourceID="odsErrorLocation" Editable="True" DataTextField="QAErrorLocationDescription" DataValueField="QAErrorLocationID" Height="20px" OnSelectedRowChanged="ddlErrorLocation_SelectedRowChanged" OnInitializeLayout="ddlErrorLocation_InitializeLayout" OnPreRender="ddlErrorLocation_PreRender" ComboTypeAhead="Suggest" EnableXmlHTTP="True" EnableAppStyling="True">
        <Columns>
            <igtbl:UltraGridColumn BaseColumnName="Databound Col0" IsBound="True" Key="Databound Col0">
                <header caption="Databound Col0"></header>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="Databound Col1" DataType="System.Int32" IsBound="True"
                Key="Databound Col1">
                <header caption="Databound Col1">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="Databound Col2" IsBound="True" Key="Databound Col2">
                <header caption="Databound Col2">
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
        </Columns>
        <ExpandEffects ShadowColor="LightGray" />
       <DropDownLayout Version="4.00" ColWidthDefault="205px" DropdownWidth="205px"  BaseTableName="" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No">
                    <FrameStyle Height="130px" Width="205px" > </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
    </igcmbo:WebCombo>
</div>
<fieldset ID="Panel1" runat="server"  Style="z-index: 101; left: 0px;
    position: relative;  height: 370px; width: 1015px; top: 10px;" >
    <legend accesskey="I" style="font-weight: bold; z-index: 107; left: 10px; position: absolute; top: 0px;">Errors</legend>
    <asp:Button ID="btnSave" runat="server" Style="z-index: 100; left: 855px; position: absolute;
        top: 340px" Text="Save" Height="24px" Width="70px" OnClick="btnSave_Click" />
    <igtbl:UltraWebGrid ID="gridErrorLog" runat="server" Height="280px" Style="z-index: 101;
        left: 10px; position: absolute; top: 55px" Width="995px" DataSourceID="odsGrid" EnableAppStyling="True" OnDataBound="gridErrorLog_DataBound">
        <Bands>
            <igtbl:UltraGridBand AddButtonCaption="GridErrorTypeLog" BaseTableName="GridErrorTypeLog" Key="GridErrorTypeLog" AllowDelete="No">
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogID" DataType="System.Int32" IsBound="True"
                        Key="QAErrorLogID" Hidden="True">
                        <Header Caption="QAErrorLogID">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorTypeID" DataType="System.Int32" IsBound="True"
                        Key="QAErrorTypeID" Hidden="True">
                        <Header Caption="QAErrorTypeID">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorTypeDescription" IsBound="True" Key="QAErrorTypeDescription" Width=350px Type=HyperLink> 
                        
                        <Header Caption="Error Type">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="TrackingTypeDesc" IsBound="True" Key="TrackingTypeDesc" Width=125px > 
                        
                        <Header Caption="Tracking Type">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAProcessStepID" DataType="System.Int32" IsBound="True"
                        Key="QAProcessStepID" Hidden="True">
                        <Header Caption="QAProcessStepID">
                            <RowLayoutColumnInfo OriginX="4" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="4" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAProcessStepDescription" IsBound="True" Key="QAProcessStepDescription">
                        <Header Caption="Process Step">
                            <RowLayoutColumnInfo OriginX="5" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="5" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn  BaseColumnName="QAErrorLogNumberOfErrors" IsBound="True" Key="QAErrorLogNumberOfErrors" Width="125px">
                        <Header Caption="# of Error Types">
                            <RowLayoutColumnInfo OriginX="6" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="6" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogDateTimeString" 
                        IsBound="True" Key="QAErrorLogDateTimeString" Width="145px">
                        <Header Caption="Error Type D/T">
                            <RowLayoutColumnInfo OriginX="7" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="7" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogHowIdentifiedID" DataType="System.Int32"
                        IsBound="True" Key="QAErrorLogHowIdentifiedID" Hidden="True">
                        <Header Caption="QAErrorLogHowIdentifiedID">
                            <RowLayoutColumnInfo OriginX="8" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="8" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogHowIdentifiedDescription" IsBound="True"
                        Key="QAErrorLogHowIdentifiedDescription" >
                        <Header Caption="How Identified">
                            <RowLayoutColumnInfo OriginX="9" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="9" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogTicketNumber" IsBound="True" Key="QAErrorLogTicketNumber" Width="75px">
                        <Header Caption="Ticket #">
                            <RowLayoutColumnInfo OriginX="10" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="10" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogComments" IsBound="True" Key="QAErrorLogComments" Width="195px">
                        <Header Caption="Comment">
                            <RowLayoutColumnInfo OriginX="11" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="11" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorStatusID" DataType="System.Int32" IsBound="True"
                        Key="QAErrorStatusID" Hidden="True">
                        <Header Caption="QAErrorStatusID">
                            <RowLayoutColumnInfo OriginX="12" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="12" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorStatusDescription" IsBound="True" Key="QAErrorStatusDescription">
                        <Header Caption="Status">
                            <RowLayoutColumnInfo OriginX="13" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="13" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogCorrection" IsBound="True" Key="QAErrorLogCorrection" >
                        <Header Caption="Correction">
                            <RowLayoutColumnInfo OriginX="14" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="14" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogCorrectionLog" IsBound="True" Key="QAErrorLogCorrectionLog" Width="165px">
                        <Header Caption="CorrectionLog">
                            <RowLayoutColumnInfo OriginX="15" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="15" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLocationID" IsBound="True" Hidden="true" Key="QAErrorLocationID" >
                        <Header Caption="QAErrorLocationID">
                            <RowLayoutColumnInfo OriginX="16" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="16" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="LocationDesc" IsBound="True" Hidden="true" Key="LocationDesc" >
                        <Header Caption="LocationDesc">
                            <RowLayoutColumnInfo OriginX="17" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="17" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="TrackingTypeDesc" IsBound="True" Hidden="true" Key="TrackingTypeDesc" >
                        <Header Caption="TrackingDesc">
                            <RowLayoutColumnInfo OriginX="18" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="18" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QATrackingFormID" IsBound="True" Hidden="true" Key="QATrackingFormID" >
                        <Header Caption="QATrackingFormID">
                            <RowLayoutColumnInfo OriginX="19" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="19" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                </Columns>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowDeleteDefault="Yes"
        AllowSortingDefault="OnClient" AllowUpdateDefault="Yes" BorderCollapseDefault="Separate"
        HeaderClickActionDefault="SortMulti" Name="ctl00xgridErrorLog" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Extended" StationaryMargins="Header"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" ViewType="OutlookGroupBy">
        <FrameStyle BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="280px"
            Width="995px" Cursor="Default" ForeColor="#A37171">
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
            <GroupByBox Hidden="True">
            </GroupByBox>
    </DisplayLayout>
    </igtbl:UltraWebGrid>
    <asp:Button ID="btnAddError" runat="server" Style="z-index: 102; left: 10px; position: absolute;
        top: 20px" Text="Add" Width="70px" OnClick="btnAddError_Click" Enabled="False" />
    <asp:Button ID="btnCancel" runat="server" Height="24px" Style="z-index: 103; left: 935px;
        position: absolute; top: 340px" Text="Cancel" Width="70px" OnClick="btnCancel_Click" />
    <asp:Button ID="btnDelete" runat="server" Height="24px" Style="z-index: 104; left: 775px;
        position: absolute; top: 340px" Text="Delete" Width="70px" OnClick="btnDelete_Click" OnClientClick="var agree=confirm('Are you sure you wish to continue?');if (agree) return true ; else return false ; " Visible="False" />
    &nbsp;&nbsp;
    <asp:Label ID="lblTrackingNumberData" runat="server" Style="z-index: 105; left: 195px;
        position: absolute; top: 25px" Width="155px"></asp:Label>
    <asp:Label ID="lblTrackingNumber" runat="server" Style="z-index: 108; left: 114px;
        position: absolute; top: 25px" Text="Tracking #:" Width="75px"></asp:Label>
</fieldset>
<asp:ObjectDataSource ID="odsEmployee" runat="server" 
    SelectMethod="FillPersonList" 
    TypeName="Statline.StatTrac.Referral.ReferralManager" EnableCaching="True" 
    OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationId" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsErrorLocation" runat="server" 
    SelectMethod="FillQAErrorLocation" 
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
    OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="QAErrorLocationActive" Type="Int16" />
        <asp:Parameter DefaultValue="0" Name="QATrackingTypeID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGrid" runat="server" SelectMethod="FillQAGridErrorTypeLog"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
    OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter Name="QATrackingID" Type="Int32" />
        <asp:Parameter Name="QAErrorLocationID" Type="Int32" />
        <asp:Parameter Name="PersonID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<igmisc:WebPageStyler ID="WebPageStyler1" runat="server" EnableAppStyling="True"
    Style="z-index: 102; left: 0px; position: absolute; top: 0px" StyleSetName="StatlineReports" />
