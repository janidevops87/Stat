<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsCompletedByControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsCompletedByControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
        
             <div class="ParamControlLabel">
                 Completed By:
             </div>
             <div class="ParamControl">
    <igmisc:WebAsyncRefreshPanel ID="ajaxPanelApproacher" runat="server" Height="20px" Width="100%" TriggerControlIDs="*$ddlApproacherOrganization,*$ddlApproacherOrganization$_Grid">
        <igcmbo:WebCombo ID="ddlCompletedBy" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" DataSourceID="odsCompletedBy"
            Editable="True" EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue"
            SelForeColor="White" Version="4.00" Width="200px" DataTextField="PersonName" DataValueField="PersonID" DisplayValue="..." OnInitializeLayout="ddlCompletedBy_InitializeLayout">
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
            </Columns>
            <ExpandEffects ShadowColor="LightGray" />
            <DropDownLayout Version="4.00" ColWidthDefault="200px" DropdownWidth="200px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="200px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
        </igcmbo:WebCombo>
        
    </igmisc:WebAsyncRefreshPanel>       
    </div> 
       
            
<asp:ObjectDataSource ID="odsCompletedBy" runat="server" SelectMethod="FillPersonList"
        TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelecting="odsCompletedBy_Selecting">
        <SelectParameters>
            <asp:Parameter DefaultValue="194" Name="OrganizationId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

