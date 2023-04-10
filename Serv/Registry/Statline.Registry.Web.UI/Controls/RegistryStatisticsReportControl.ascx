<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RegistryStatisticsReportControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.RegistryStatisticsReport" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<div style="width: 100%; height: 559px; font-size: 10pt; font-family: Arial; left: 0px; top: 0px; z-index: 100; padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px; position: relative;">
    <br />
    <br />
    <asp:Label ID="lblDonorRegistryStatistics" runat="server" Font-Bold="True" Font-Size="12pt"
        Text="Registry Statistics Report" style="z-index: 100; left: 6px; position: relative; top: -17px"></asp:Label>
    <igtbl:UltraWebGrid ID="gridRegistryStatisticsReport" runat="server" Height="395px" Width="450px" style="position: relative; z-index: 102; left: 104px; top: 112px;" DataSourceID="odsRegistryStatisticsReport"><Bands>
<igtbl:UltraGridBand AddButtonCaption="RegistryStatisticsReport" BaseTableName="RegistryStatisticsReport" Key="RegistryStatisticsReport">
<AddNewRow Visible="NotSet" View="NotSet"></AddNewRow>
    <Columns>
        <igtbl:UltraGridColumn BaseColumnName="StateDisplayName" IsBound="True" Key="StateDisplayName">
            <Header Caption="State">
            </Header>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="RegistrySource" IsBound="True" Key="RegistrySource">
            <Header Caption="Registry Source">
                <RowLayoutColumnInfo OriginX="1" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="1" />
            </Footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="Totals" DataType="System.Int32" Format="###,###,###"
            IsBound="True" Key="Totals">
            <HeaderStyle HorizontalAlign="Right" />
            <CellStyle HorizontalAlign="Right">
            </CellStyle>
            <Header Caption="Totals">
                <RowLayoutColumnInfo OriginX="2" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="2" />
            </Footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="TotalPercent" IsBound="True" Key="TotalPercent">
            <HeaderStyle HorizontalAlign="Right" />
            <CellStyle HorizontalAlign="Right">
            </CellStyle>
            <Header Caption="Percent of Total">
                <RowLayoutColumnInfo OriginX="3" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="3" />
            </Footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="GrandTotal" DataType="System.Int32" Hidden="True"
            IsBound="True" Key="GrandTotal">
            <HeaderStyle HorizontalAlign="Right" />
            <Header Caption="GrandTotal">
                <RowLayoutColumnInfo OriginX="4" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="4" />
            </Footer>
        </igtbl:UltraGridColumn>
    </Columns>
    <RowEditTemplate>
        <br />
        <p align="center">
            <input id="igtbl_reOkBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                type="button" value="OK" />&nbsp;
            <input id="igtbl_reCancelBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                type="button" value="Cancel" /></p>
    </RowEditTemplate>
    <RowTemplateStyle BackColor="Window" BorderColor="Window" BorderStyle="Ridge">
        <BorderDetails WidthBottom="3px" WidthLeft="3px" WidthRight="3px" WidthTop="3px" />
    </RowTemplateStyle>
</igtbl:UltraGridBand>
</Bands>

<DisplayLayout Version="4.00" SelectTypeRowDefault="Extended" Name="ctl00xgridRegistryStatisticsReport" AllowSortingDefault="OnClient" AllowColSizingDefault="Free" RowHeightDefault="20px" TableLayout="Fixed" RowSelectorsDefault="No" AllowColumnMovingDefault="OnServer" HeaderClickActionDefault="SortMulti" StationaryMargins="Header" BorderCollapseDefault="Separate" StationaryMarginsOutlookGroupBy="True" CellPaddingDefault="2" CellSpacingDefault="1">
<FrameStyle BackColor="Window" BorderColor="InactiveCaption" BorderWidth="1px" Font-Names="Microsoft Sans Serif" Font-Size="8.25pt" Height="395px" Width="450px"></FrameStyle>

<Pager MinimumPagesForDisplay="2">
<PagerStyle BackColor="LightGray" BorderWidth="1px" BorderStyle="Solid">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</PagerStyle>
</Pager>

<EditCellStyleDefault BorderWidth="0px" BorderStyle="None"></EditCellStyleDefault>

<FooterStyleDefault BackColor="LightGray" BorderWidth="1px" BorderStyle="Solid">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</FooterStyleDefault>

<HeaderStyleDefault HorizontalAlign="Left" BackColor="LightGray" BorderStyle="Solid">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</HeaderStyleDefault>

<RowStyleDefault BackColor="Window" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Font-Names="Microsoft Sans Serif" Font-Size="8.25pt">
<Padding Left="3px"></Padding>

<BorderDetails ColorLeft="Window" ColorTop="Window"></BorderDetails>
</RowStyleDefault>

<GroupByRowStyleDefault BackColor="Control" BorderColor="Window"></GroupByRowStyleDefault>

<GroupByBox Hidden="True">
<BoxStyle BackColor="ActiveBorder" BorderColor="Window"></BoxStyle>
</GroupByBox>

<AddNewBox Hidden="False">
<BoxStyle BackColor="Window" BorderColor="InactiveCaption" BorderWidth="1px" BorderStyle="Solid">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</BoxStyle>
</AddNewBox>

<ActivationObject BorderColor="" BorderWidth=""></ActivationObject>

<FilterOptionsDefault>
<FilterDropDownStyle CustomRules="overflow:auto;" BackColor="White" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Font-Names="Verdana,Arial,Helvetica,sans-serif" Font-Size="11px" Height="300px" Width="200px">
<Padding Left="2px"></Padding>
</FilterDropDownStyle>

<FilterHighlightRowStyle BackColor="#151C55" ForeColor="White"></FilterHighlightRowStyle>

<FilterOperandDropDownStyle CustomRules="overflow:auto;" BackColor="White" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Font-Names="Verdana,Arial,Helvetica,sans-serif" Font-Size="11px">
<Padding Left="2px"></Padding>
</FilterOperandDropDownStyle>
</FilterOptionsDefault>
</DisplayLayout>
</igtbl:UltraWebGrid>
<asp:ObjectDataSource ID="odsRegistryStatisticsReport" runat="server" OnSelecting="odsRegistryStatisticsReport_Selecting"
    SelectMethod="FillRegistryStatisticsReport" TypeName="Statline.Registry.Common.RegistryCommonManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="" Name="StateSelection" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
    <br />
    &nbsp;</div>
