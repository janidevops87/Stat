<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAAddEditErrorTypeControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAAddEditErrorTypeControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<stattrac:sectionheader id="sectionHeaderErrorList" runat="server" text="Add/Edit Error Type"
    width="100%"></stattrac:sectionheader>
<div style="z-index: 100; left: 15px; width: 585px; position: relative;
    height: 145px; top: 0px;">
    <asp:CheckBox ID="cbxActive" runat="server" Style="z-index: 100; left: 115px; position: absolute;
        top: 5px" Text="Active" Checked="True" />
    &nbsp;
    <asp:Label ID="lblTrackingType" runat="server" Style="z-index: 101; left: 15px; position: absolute;
        top: 30px" Text="Tracking Type:"></asp:Label>
    <asp:Label ID="lblErrorLocation" runat="server" Style="z-index: 102; left: 15px;
        position: absolute; top: 60px" Text="Error Location:"></asp:Label>
    <asp:CheckBox ID="cbxRequireReview" runat="server" Style="z-index: 103; left: 105px;
        position: absolute; top: 120px" Text="Require Review?" TabIndex="2" />
    <igcmbo:WebCombo ID="ddlTrackingType" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 104; left: 110px; position: absolute; top: 30px"
        Version="4.00" DataSourceID="odsTrackingTypes" OnInitializeLayout="ddlTrackingType_InitializeLayout" DataTextField="QATrackingTypeDescription" DataValueField="QATrackingTypeID" Editable="True" ComboTypeAhead="Suggest" EnableXmlHTTP="True" EnableAppStyling="True" DisplayValue="" OnPreRender="ddlTrackingType_PreRender">
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
        <DropDownLayout Version="4.00" ColWidthDefault="200px" DropdownWidth="200px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="" >
                    <FrameStyle Height="130px" Width="200px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
    </igcmbo:WebCombo>
    <igcmbo:WebCombo ID="ddlErrorLocation" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 104; left: 110px; position: absolute; top: 60px"
        Version="4.00" DataSourceID="odsErrorLocation" OnInitializeLayout="ddlErrorLocation_InitializeLayout" DataTextField="QAErrorLocationDescription" DataValueField="QAErrorLocationID" Editable="True" OnPreRender="ddlErrorLocation_PreRender" EnableAppStyling="True">
        <Columns>
            <igtbl:UltraGridColumn BaseColumnName="Databound Col0" IsBound="True" Key="Databound Col0">
                <header caption="Databound Col0"></header>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="Databound Col1"  DataType="System.Int32" IsBound="True"
                Key="Databound Col1" Hidden=True>
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
        <DropDownLayout Version="4.00" ColWidthDefault="200px" DropdownWidth="200px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="200px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
    </igcmbo:WebCombo>
    <asp:Label ID="lblErrorType" runat="server" Style="z-index: 105; left: 40px; position: absolute;
        top: 90px" Text="ErrorType:"></asp:Label>
    <asp:TextBox ID="txtError" runat="server" Style="z-index: 106; left: 110px; position: absolute;
        top: 90px" Width="435px" MaxLength="100" TabIndex="1"></asp:TextBox>
    <asp:Label ID="lblReason" runat="server" Style="z-index: 107; left: 210px; position: absolute;
        top: 5px" Text="Reason:" Width="15px"></asp:Label>
    <asp:TextBox ID="txtReason" runat="server" MaxLength="1000" Style="z-index: 109;
        left: 260px; position: absolute; top: 5px" TabIndex="1" Width="305px"></asp:TextBox>
</div>
<div style="z-index: 101; left: 20px; width: 590px; position: relative;
    height: 212px; top: 0px;">
    <fieldset ID="Panel1" runat="server"  Style="z-index: 100; left: 10px;
        position: relative; width: 565px; height: 375px; border-right: thin solid; border-top: thin solid; border-left: thin solid; border-bottom: thin solid; top: 0px;" >
        <legend accesskey="I" style="font-weight: bold; z-index: 110; left: 10px; position: relative;">
        Quality Monitoring Form Setup</legend>
       
       <asp:Label ID="Label1" runat="server" Style="z-index: 100; left: 85px; position: absolute;
            top: 30px" Text="Assigned Points:"></asp:Label>
        <asp:DropDownList ID="ddlAssignPts1" runat="server" style="z-index: 102; left: 190px; position: absolute; top: 30px" Width="110px" TabIndex="4">
                            <asp:ListItem Value="0">N/A</asp:ListItem>
                            <asp:ListItem Value="1">1</asp:ListItem>
							<asp:ListItem Value="2">2</asp:ListItem>
							<asp:ListItem Value="3">3</asp:ListItem>
							<asp:ListItem Value="4">4</asp:ListItem>
							<asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="-1">-1</asp:ListItem>
                            <asp:ListItem Value="-2">-2</asp:ListItem>
                            <asp:ListItem Value="-3">-3</asp:ListItem>
                            <asp:ListItem Value="-4">-4</asp:ListItem>
                            <asp:ListItem Value="-5">-5</asp:ListItem>
                                
        </asp:DropDownList>
         <asp:CheckBox ID="cbxAutoZeroScore" runat="server" Style="z-index: 103; left: 315px; position: absolute;
            top: 30px" Text="If answer No, automatic 0% score" TabIndex="5" />
        <asp:CheckBox ID="cbxDisplayNA" runat="server" Style="z-index: 104; left: 125px; position: absolute;
            top: 60px" Text="Display NA:" TextAlign="Left" Width="95px" TabIndex="6" />
        <asp:CheckBox ID="cbxDisplayComments" runat="server" Style="z-index: 105; left: 90px; position: absolute;
            top: 80px" Text="Display Comments:" TextAlign="Left" Width="137px" TabIndex="7" />
        <asp:CheckBox ID="cbxGenerateErrorLog" runat="server" Style="z-index: 106; left: 60px; position: absolute;
            top: 115px" Text="Generate Error Log if No:" TextAlign="Left" TabIndex="8" AutoPostBack="true" OnCheckedChanged="cbxGenerateErrorLog_CheckedChanged" />
        <asp:CheckBox ID="cbxGenerateErrorLogYes" runat="server" Style="z-index: 106; left: 55px; position: absolute;
            top: 140px" Text="Generate Error Log if Yes:" TextAlign="Left" TabIndex="9" AutoPostBack="true" OnCheckedChanged="cbxGenerateErrorLogYes_CheckedChanged" />
        <asp:Button ID="btnCancel" runat="server" Style="z-index: 107; left: 485px; position: absolute;
            top: 135px" Text="Cancel" OnClick="btnCancel_Click" />
        <asp:Button ID="btnSave" runat="server" Style="z-index: 108; left: 410px; position: absolute;
            top: 135px" Text="Save" Width="60px" OnClick="btnSave_Click" TabIndex="9" />
    <igtbl:UltraWebGrid ID="gridForms" runat="server" Height="190px" Style="z-index: 100;
    left: 15px; top: 175px; position: absolute" Width="535px"  
            EnableAppStyling="True" OnUpdateRowBatch="gridForms_UpdateRowBatch" ondatabound="gridForms_DataBound">
    <Bands>
        <igtbl:UltraGridBand AllowDelete="No">
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormID" Key="QAMonitoringFormID" Hidden="True">
                    <Header Caption="QAMonitoringFormID">
                    </Header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormName" Key="QAMonitoringFormName" AllowUpdate="No" Width="460px">
                    <Header Caption="Monitoring Form Name">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormTemplateActive"
                        Key="QAMonitoringFormTemplateActive" Width="55px" Type="CheckBox" DataType="System.Int16">
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Header Caption="Include">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormTemplateID"
                        Key="QAMonitoringFormTemplateID" Width="195px" Hidden=True>
                       
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                        <Header>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                    </igtbl:UltraGridColumn>      
            </Columns>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer"
        AllowSortingDefault="OnClient" BorderCollapseDefault="Separate"
        HeaderClickActionDefault="SortMulti" Name="ctl00xgridForms" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Extended" StationaryMargins="Header"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" ViewType="OutlookGroupBy" AutoGenerateColumns="False" AllowUpdateDefault="Yes">
        <FrameStyle BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="190px"
            Width="535px" Cursor="Default" ForeColor="#A37171">
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
    </fieldset>
</div>
<!--div style="z-index: 101; left: 20px; width: 590px; position: relative;
    height: 212px; top: 0px;">
    
</div-->    
<asp:ObjectDataSource ID="odsErrorLocation" runat="server" SelectMethod="FillQAErrorLocation"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
    OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="QAErrorLocationActive" Type="Int16" />
        <asp:Parameter DefaultValue="0" Name="QATrackingTypeID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsTrackingTypes" runat="server" SelectMethod="FillTrackingType"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
&nbsp;
<igmisc:WebPageStyler ID="WebPageStyler1" runat="server" Style="z-index: 102; left: 0px;
    position: absolute; top: 0px" StyleSetName="StatlineReports" />
