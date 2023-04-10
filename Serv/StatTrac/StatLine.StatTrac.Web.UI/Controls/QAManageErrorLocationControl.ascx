<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAManageErrorLocationControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAManageErrorLocation" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>    
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>

<stattrac:sectionheader id="sectionHeaderQAManageErrorLocation" runat="server" text="Manage Error Location"
    width="100%"></stattrac:sectionheader>

<div style="z-index: 100; left: 0px; width: 425px; position: relative; top: 0px;
    height: 65px">
    &nbsp;
    <asp:Button ID="btnSave" runat="server" OnClick="Button1_Click"  Text="Save" style="z-index: 100; left: 0px; position: absolute; top: 40px" />
    <asp:Label ID="lblOrganization" runat="server" Style="z-index: 101; left: 5px; position: absolute;
        top: 5px" Text="Organization: " Width="80px"></asp:Label>
    <asp:CheckBox ID="cbxDisplayAll" runat="server" Style="z-index: 102; left: 165px;
        position: absolute; top: 44px" AutoPostBack="true" Text="Display All" Width="100px" OnCheckedChanged="cbxDisplayAll_CheckedChanged" />
    <igcmbo:WebCombo ID="ddlOrganization" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" DataSourceID="odsOrgs"
        DataTextField="OrganizationName" DataValueField="OrganizationID" Editable="True"
        EnableXmlHTTP="True" ForeColor="Black" OnInitializeLayout="ddlOrganization_InitializeLayout"
        OnSelectedRowChanged="ddlOrganization_SelectedRowChanged" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 103; left: 95px; position: absolute; top: 5px"
        Version="4.00" Width="315px" EnableAppStyling="True" OnPreRender="ddlOrganization_PreRender">
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
        <DropDownLayout BaseTableName="" ColHeadersVisible="No" ColWidthDefault="315px" DropdownWidth="315px"
            GridLines="None" RowSelectors="No" Version="4.00" XmlLoadOnDemandType="Accumulative">
            <FrameStyle Height="130px" Width="315px">
            </FrameStyle>
            <RowStyle BackColor="White" BorderColor="Gray" />
        </DropDownLayout>
    </igcmbo:WebCombo>
    &nbsp;
</div>
<igtbl:UltraWebGrid ID="gridErrorLocations" runat="server" Height="365px" Style="z-index: 101;
    left: 10px; position: relative; " Width="400px" DataSource="<%# dsQAUpdateData %>" DataMember="QAErrorLocation" OnUpdateRowBatch="gridErrorLocations_UpdateRowBatch" OnInitializeLayout="gridErrorLocations_InitializeLayout1" EnableAppStyling="True" >
    <Bands >
        <igtbl:UltraGridBand BaseTableName="QAErrorLocation" Key="QAErrorLocation" AllowDelete="No">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="QAErrorLocationID" Hidden="True" IsBound="True"
                    Key="QAErrorLocationID">
                    <Header Caption="QAErrorLocationID">
                    </Header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn AllowUpdate="Yes" BaseColumnName="QAErrorLocationDescription"
                    IsBound="True" Key="QAErrorLocationDescription" Width="295px" FieldLen="100">
                    <Header Caption="Error Location">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn AllowUpdate="Yes" BaseColumnName="QAErrorLocationActive" IsBound="True"
                    Key="QAErrorLocationActive" Type="CheckBox" Width="45px">
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                    <Header Caption="Active">
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
            </Columns>
            <AddNewRow View="NotSet"  Visible="NotSet">
            </AddNewRow>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowDeleteDefault="Yes"
        AllowSortingDefault="OnClient" AllowUpdateDefault="Yes" BorderCollapseDefault="Separate"
        HeaderClickActionDefault="SortMulti" Name="ctl00xgridErrorLocations" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Single" StationaryMargins="Header"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" ViewType="OutlookGroupBy" AllowAddNewDefault="Yes">
        <FrameStyle BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="365px"
            Width="400px" Cursor="Default" ForeColor="#A37171">
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
        <AddNewBox Hidden="False" Location="Top">
            <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </BoxStyle>
            <ButtonStyle Width="30px">
            </ButtonStyle>
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

<asp:ObjectDataSource ID="odsOrgs" runat="server" EnableCaching="True" SelectMethod="FillOrganzationList"
    TypeName="Statline.StatTrac.Schedule.ScheduleManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="userOrgID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<igmisc:WebPageStyler ID="WebPageStyler1" runat="server" EnableAppStyling="True"
    Style="z-index: 101; left: 0px; position: absolute; top: 0px" StyleSetName="StatlineReports" />




