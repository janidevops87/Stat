<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAManageProcessStepsControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAManageProcessSteps" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>      
     
<stattrac:sectionheader id="sectionHeaderQAManageProcessSteps" runat="server" text="Manage Process Steps"
    width="100%"></stattrac:sectionheader><br />
 <div style="z-index: 100; left: 0px; width: 425px; position: relative; top: 0px;
    height: 65px">
    &nbsp;
    <asp:Button ID="btnSave" runat="server" OnClick="Button1_Click"  Text="Save" style="z-index: 100; left: 0px; position: absolute; top: 40px" />
    
    <asp:CheckBox ID="cbxDisplayAll" runat="server" Style="z-index: 102; left: 165px;
        position: absolute; top: 44px" Text="Display All" Width="100px" AutoPostBack="True" OnCheckedChanged="cbxDisplayAll_CheckedChanged" />
     &nbsp;
        <asp:Label ID="lblOrganization" runat="server" Style="z-index: 101; left: 5px; position: absolute;
        top: 5px" Text="Organization: " Width="80px"></asp:Label>
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
    
</div>  
<igtbl:UltraWebGrid ID="gridProcessSteps" runat="server" Height="365px" Style="z-index: 100;
    left: 35px; position: relative" Width="400px" DataSource="<%# dsQAUpdateData %>" DataMember="QAProcessStep" OnUpdateRowBatch="gridProcessSteps_UpdateRowBatch" EnableAppStyling="True"  >
    <Bands>
        <igtbl:UltraGridBand BaseTableName="QAProcessStep" Key="QAProcessStep" AllowDelete="No">
        <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="QAProcessStepID" Hidden="True" IsBound="True"
                        Key="QAProcessStepID">
                        <Header Caption="QAProcessStepID">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAProcessStepDescription" IsBound="True" Key="QAProcessStepDescription"
                        Width="295px" FieldLen="100">
                        <Header Caption="Process Step">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAProcessStepActive"  IsBound="True"
                        Key="QAProcessStepActive" Width="45px" Type="CheckBox">
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
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowDeleteDefault="Yes"
        AllowSortingDefault="OnClient" AllowUpdateDefault="Yes" BorderCollapseDefault="Separate"
        HeaderClickActionDefault="SortMulti" Name="ctl00xgridProcessSteps" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Extended" StationaryMargins="Header"
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
            <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px" Width="10px">
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
</igtbl:UltraWebGrid>&nbsp;&nbsp;
<asp:ObjectDataSource ID="odsOrgs" runat="server" EnableCaching="True" SelectMethod="FillOrganzationList"
    TypeName="Statline.StatTrac.Schedule.ScheduleManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="userOrgID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<igmisc:WebPageStyler ID="WebPageStyler1" runat="server" Style="z-index: 101; left: 0px;
    position: absolute; top: 0px" StyleSetName="StatlineReports" />
