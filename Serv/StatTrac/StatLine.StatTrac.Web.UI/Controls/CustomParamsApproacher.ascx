<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsApproacher.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsApproacher" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
         <fieldset style="width:450px;">
            <legend>Approacher</legend>
             <div class="ParamControlLabel">
                Approacher Organization: </div>
             <div class="ParamControl">       
                <igcmbo:WebCombo ID="ddlApproacherOrganization" runat="server" BackColor="White" BorderColor="Silver"
                BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
                SelForeColor="White" Version="4.00" DataSourceID="odsApproacherOrganization" Width="293px" ComboTypeAhead="Suggest" DataTextField="OrganizationName" DataValueField="OrganizationID" OnSelectedRowChanged="ddlApproacherOrganization_SelectedRowChanged" Editable="True" EnableXmlHTTP="True" DisplayValue="..." OnInitializeLayout="ddlApproacherOrganization_InitializeLayout">
                <Columns >
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
                <DropDownLayout  BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" BaseTableName="" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" RowSelectors="No">
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
             <div class="ParamControlLabel">
                 Approacher: </div>
             <div class="ParamControl">
    <igmisc:WebAsyncRefreshPanel ID="ajaxPanelApproacher" runat="server" Height="20px" Width="100%" TriggerControlIDs="*$ddlApproacherOrganization,*$ddlApproacherOrganization$_Grid">
        <igcmbo:WebCombo ID="ddlApproachPerson" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" DataSourceID="odsApproachPerson"
            Editable="True" EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue"
            SelForeColor="White" Version="4.00" Width="293px" DataTextField="PersonName" DataValueField="PersonID" DisplayValue="..." OnInitializeLayout="ddlApproachPerson_InitializeLayout" OnDataBound="ddlApproachPerson_DataBound">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="PersonID" DataType="System.Int32" IsBound="True"
                    Key="PersonID">
                    <header caption="PersonID"></header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="PersonName" IsBound="True" Key="PersonName">
                    <header caption="PersonName">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="PersonTitle" IsBound="True" Key="PersonTitle">
                    <header caption="PersonTitle">
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="Checked" DataType="System.Boolean" IsBound="True"
                    Key="Checked" Type="CheckBox">
                    <header caption="Checked">
<RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
            </Columns>
            <ExpandEffects ShadowColor="LightGray" />
            <DropDownLayout BaseTableName="" BorderCollapse="Separate" RowHeightDefault="20px"
                Version="4.00" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" RowSelectors="No">
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
        
    </igmisc:WebAsyncRefreshPanel>       
    </div> 
        </fieldset>
            
<asp:ObjectDataSource ID="odsApproacherOrganization" runat="server" EnableCaching="True"
    SelectMethod="FillOrganzationList" TypeName="Statline.StatTrac.Report.ReportReferenceManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="reportGroupID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsApproachPerson" runat="server" OnSelecting="odsApproachPerson_Selecting"
    SelectMethod="FillFSConversionRateApproachPerson" TypeName="Statline.StatTrac.Report.ReportReferenceManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="organizationID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>