<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsTrackingTypeControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsTrackingTypeControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
        
             <div class="ParamControlLabel">
                 Tracking Type:
             </div>
             <div class="ParamControl">
    
        <igcmbo:WebCombo ID="ddlTrackingType" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" DataSourceID="odsTrackingType"
            Editable="True" EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue"
            SelForeColor="White" Version="4.00" Width="200px" DataTextField="QATrackingTypeDescription" DataValueField="QATrackingTypeID" DisplayValue="..." OnInitializeLayout="ddlTrackingType_InitializeLayout">
           
            <ExpandEffects ShadowColor="LightGray" />
            <DropDownLayout Version="4.00" ColWidthDefault="200px" DropdownWidth="200px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="200px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="QATrackingTypeID" DataType="System.Int32"
                    IsBound="True" Key="QATrackingTypeID">
                    <header caption="QATrackingTypeID"></header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="QATrackingTypeDescription" IsBound="True"
                    Key="QATrackingTypeDescription">
                    <header caption="QATrackingTypeDescription">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
            </Columns>
        </igcmbo:WebCombo>
        
    
                 <asp:ObjectDataSource ID="odsTrackingType" runat="server" SelectMethod="FillTrackingType"
                     TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" OnSelecting="odsTrackingType_Selecting">
                     <SelectParameters>
                         <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
                     </SelectParameters>
                 </asp:ObjectDataSource>
    </div> 
<igmisc:WebPageStyler ID="webPageStyler" runat="server" EnableAppStyling="True" Style="z-index: 100;
    left: 0px; position: absolute; top: 0px" StyleSetName="StatlineReports" /> 