<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsAgeRangeControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsAgeRangeControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
       
<div class="ParamLabeldAndControlWrapper">    
    <div class="ParamControlLabel">
        Age Range:
    </div>
    <div class="ParamControl">
        <igmisc:WebAsyncRefreshPanel ID="ajaxPanelAgeRange" runat="server" >
	        <igcmbo:WebCombo ID="ddlAgeRange" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" DataSourceID="odsAgeRange"
            Editable="True" EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue"
            SelForeColor="White" Version="4.00" Width="200px" DataTextField="Grouping" DataValueField="Switch" OnInitializeLayout="ddlAgeRange_InitializeLayout" >
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="ReferralTypeID" DataType="System.Int32" IsBound="True"
                    Key="ReferralTypeID">
                    <header caption="ReferralTypeID"></header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ReferralTypeName" IsBound="True" Key="ReferralTypeName">
                    <header caption="ReferralTypeName">
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
        <asp:ObjectDataSource ID="odsAgeRange" runat="server" SelectMethod="FillReportAgeRange"
            TypeName="Statline.StatTrac.Report.ReportReferenceManager" OnSelecting="odsAgeRange_Selecting">
        </asp:ObjectDataSource>
        
    </div>
</div>