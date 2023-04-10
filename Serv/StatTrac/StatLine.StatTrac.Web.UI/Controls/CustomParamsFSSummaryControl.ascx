<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsFSSummaryControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsFSSummaryControl" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>

		<asp:Panel ID="panelApproach" CssClass="defaultPanel" runat="server" GroupingText="Approacher" EnableViewState="False" >
   <div class="SectionSeperator" >
       <div class="ParamControlLabel">
            Approacher Organization: 
        </div>
        <div class="ParamControl">
        <igcmbo:WebCombo ID="ddlApproacherOrganization" runat="server" BackColor="White" BorderColor="Silver"
                BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
                SelForeColor="White" Version="4.00" ComboTypeAhead="Suggest" DataSourceID="odsApproacherOrganization" DataTextField="OrganizationName" DataValueField="OrganizationID" Editable="True" EnableXmlHTTP="True" OnSelectedRowChanged="ddlApproacherOrganization_SelectedRowChanged">
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="OrganizationName" IsBound="True" Key="OrganizationName">
                        <header caption="OrganizationName"></header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="OrganizationID" DataType="System.Int32" IsBound="True"
                        Key="OrganizationID">
                        <header caption="OrganizationID">
    <RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
    </header>
                        <footer>
    <RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
    </footer>
                    </igtbl:UltraGridColumn>
                </Columns>
                <ExpandEffects ShadowColor="LightGray" />
                <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" BaseTableName="" XmlLoadOnDemandType="Accumulative">
                    <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                        Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="325px">
                    </FrameStyle>
                    <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                    </HeaderStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px">
                        <BorderDetails WidthLeft="0px" WidthTop="0px" />
                    </RowStyle>
                    <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
                </DropDownLayout>
            </igcmbo:WebCombo>
            </div>
    </div>    
    <div class="SectionSeperator">
        <div class="ParamControlLabel">       
        Approacher Title:</div>
        <div class="ParamControl">
        <igcmbo:WebCombo ID="ddlPersonType" runat="server" BackColor="White" BorderColor="Silver"
                    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
                    SelForeColor="White" Version="4.00" DataSourceID="odsPersonType" DataTextField="PersonTypeName" DataValueField="PersonTypeId" DisplayValue='...' Width="300px" EnableViewState="False">
                    <Columns>
                        <igtbl:UltraGridColumn BaseColumnName="PersonTypeId" DataType="System.Int32" IsBound="True"
                            Key="PersonTypeId">
                            <header caption="PersonTypeId"></header>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn BaseColumnName="PersonTypeName" IsBound="True" Key="PersonTypeName">
                            <header caption="PersonTypeName">
    <RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
    </header>
                            <footer>
    <RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
    </footer>
                        </igtbl:UltraGridColumn>
                    </Columns>
                    <ExpandEffects ShadowColor="LightGray" />
                    <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" BaseTableName="" ColHeadersVisible="No" RowSelectors="No">
                        <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                            Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="325px">
                        </FrameStyle>
                        <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                        </HeaderStyle>
                        <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px">
                            <BorderDetails WidthLeft="0px" WidthTop="0px" />
                        </RowStyle>
                        <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
                    </DropDownLayout>
                </igcmbo:WebCombo> </div>    
    </div>   
    <div class="SectionSeperator" >     
        <div class="ParamControlLabel">
        Approacher:</div>
        <div class="ParamControl">
            <igtbl:UltraWebGrid ID="gridApproachPerson" runat="server"  DataSource=<%# dsReportReferenceData %> DataMember="ApproachPersonList" DataKeyField="PersonID"
                OnUpdateRowBatch="gridApproachPerson_UpdateRowBatch" Width="300px" OnInitializeDataSource="gridApproachPerson_InitializeDataSource" Height="142px"  >
                <Bands>
                    <igtbl:UltraGridBand AddButtonCaption="ApproachPersonList" BaseTableName="ApproachPersonList"
                        Key="ApproachPersonList" DataKeyField="PersonID" AllowDelete="No">
                        <Columns>
                            <igtbl:UltraGridColumn BaseColumnName="Checked" DataType="System.Boolean" IsBound="True"
                                Key="Checked" Type="CheckBox" AllowUpdate="Yes" Width="25px">
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn BaseColumnName="PersonID" DataType="System.Int32" Hidden="True"
                                IsBound="True" Key="PersonID">
                                <Header Caption="PersonID">
                                    <RowLayoutColumnInfo OriginX="1" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="1" />
                                </Footer>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn BaseColumnName="PersonName" IsBound="True" Key="PersonName" Width="134px">
                                <Header Caption="Approacher Name">
                                    <RowLayoutColumnInfo OriginX="2" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="2" />
                                </Footer>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn BaseColumnName="PersonTitle" IsBound="True" Key="PersonTitle" Width="134px">
                                <Header Caption="Title">
                                    <RowLayoutColumnInfo OriginX="3" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="3" />
                                </Footer>
                            </igtbl:UltraGridColumn>
                        </Columns>
                        <AddNewRow View="NotSet" Visible="NotSet">
                        </AddNewRow>
                    </igtbl:UltraGridBand>
                </Bands>
                <DisplayLayout Name="ctl00xgridApproachPerson" RowHeightDefault="20px"
                    RowSelectorsDefault="No" SelectTypeRowDefault="Single"
                    StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" CellSpacingDefault="1">
                    <FrameStyle BorderStyle="None"
                        BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt"
                        Width="300px" Cursor="Default" ForeColor="#A37171" Height="142px">
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
            </igtbl:UltraWebGrid><br />
            &nbsp;&nbsp;
        </div>
    </div>
        </asp:Panel>	
    	
        <asp:Panel ID="panelConsentRate" runat="server"  CssClass="defaultPanel" GroupingText="Consent Rate" 
                EnableViewState="False" >
    <div class="SectionSeperator" >   
        <div class="ParamControl">
        <div class="ParamControlLabel"></div>
            <asp:RadioButtonList ID="radioButtonListConsentRate" runat="server">
                <asp:ListItem Selected="True" Value="1">Display Total Consent Rate</asp:ListItem>
                <asp:ListItem Value="0">Display Consent Rate (w/o Registry)</asp:ListItem>
            </asp:RadioButtonList>
         </div>   
    </div>         
        </asp:Panel>

<asp:ObjectDataSource ID="odsPersonType" runat="server" SelectMethod="FillPersonTypeList"
    TypeName="Statline.StatTrac.Admin.AdminReferenceManager" EnableViewState="False" OnSelected="odsPersonType_Selected" OnSelecting="odsPersonType_Selecting"></asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsApproacherOrganization" runat="server" OnSelected="odsApproacherOrganization_Selected"
    SelectMethod="FillOrganzationList" TypeName="Statline.StatTrac.Report.ReportReferenceManager" OnSelecting="odsApproacherOrganization_Selecting">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="reportGroupID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>