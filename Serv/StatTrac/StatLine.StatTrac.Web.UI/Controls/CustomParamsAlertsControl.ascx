<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsAlertsControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsAlertsControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
    <div  class="SectionSeperator">
        <div class="ParamControlLabel" >
        Alert Type: 
        </div>
        <div  class="ParamControl" >
            <asp:DropDownList ID="ddlAlertType" runat="server" Width="300px" AutoPostBack="True" OnSelectedIndexChanged="ddlAlertType_SelectedIndexChanged">
                <asp:ListItem Value="1">Referrals</asp:ListItem>
                <asp:ListItem Value="2">Messages</asp:ListItem>
                <asp:ListItem Value="4">Import Offers</asp:ListItem>
                <asp:ListItem Selected="True" Value="0">...</asp:ListItem>            
            </asp:DropDownList>
        </div>
    </div>        
    <div class="SectionSeperator" id="divAlertGroup"  runat="server" >
        <div class="ParamControlLabel" >          
        Alert Group:
        </div>
        <div class="ParamControl">
            <igmisc:WebAsyncRefreshPanel ID="ajaxPanelAlert" runat="server" Height="20px" Width="307px" >            
               <igcmbo:WebCombo ID="ddlAlertGroup" runat="server" ComboTypeAhead="Suggest" DataSourceID="odsAlertGroup"
                DataTextField="AlertGroupName" DataValueField="AlertID" DisplayValue="..." DropImageXP1="/ig_common/images/ig_cmboDown1.bmp"
                DropImageXP2="/ig_common/images/ig_cmboDown2.bmp" Editable="True" EnableXmlHTTP="True"
                Font-Bold="True" ForeColor="Black" Height="5px" SelBackColor="10, 36, 106" SelForeColor="White"
                Version="3.00" Width="300px">
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="AlertID" DataType="System.Int32" Hidden="True"
                        IsBound="True" Key="AlertID">
                        <header caption="AlertID"></header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="AlertGroupName" IsBound="True" Key="AlertGroupName">
                        <header caption="AlertGroupName">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                    </igtbl:UltraGridColumn>
                </Columns>
                <ExpandEffects ShadowColor="LightGray" />                
                <DropDownLayout AllowSorting="NotSet" BorderCollapse="Separate"
                    ColHeadersVisible="No" GridLines="None" RowHeightDefault="20px" RowSelectors="No"
                    Version="3.00" XmlLoadOnDemandType="Accumulative" BaseTableName="AlertList">
                    <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                        Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="325px">
                    </FrameStyle>
                    <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                    </HeaderStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="0px"
                        VerticalAlign="Middle">
                        <BorderDetails StyleBottom="Dotted" WidthLeft="0px" WidthTop="0px" />
                    </RowStyle>
                    <SelectedRowStyle BackColor="#0A246A" ForeColor="White" />
                </DropDownLayout>
            </igcmbo:WebCombo>
            </igmisc:WebAsyncRefreshPanel>
        </div>
    </div>  
<asp:ObjectDataSource ID="odsAlertGroup" runat="server" OnSelected="odsAlertGroup_Selected"
    OnSelecting="odsAlertGroup_Selecting" SelectMethod="FillAlertList" TypeName="Statline.StatTrac.Report.ReportReferenceManager" EnableCaching="True">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlAlertType" DefaultValue="0" Name="alertTypeId"
            PropertyName="SelectedValue" Type="Int32" />
        <asp:Parameter DefaultValue="..." Name="sourceCodeName" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
<igmisc:WebPageStyler ID="WebPageStyler1" runat="server" EnableAppStyling="True"
    StyleSetName="StatlineReports" />