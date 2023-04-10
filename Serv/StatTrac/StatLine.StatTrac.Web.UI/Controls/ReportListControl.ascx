<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ReportListControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.ReportList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" enableViewState="False"%>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.Web.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.Web.UI.GridControls" TagPrefix="ig" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<asp:ScriptManager ID="scmReportList" runat="server" EnablePageMethods="True">
</asp:ScriptManager>

<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR align="left">
		<TD style="width: 542px">
		<igtbl:ultrawebgrid id=gridReportList Browser="Xml" runat="server" DataSource="<%# reportReference %>" Width="537px" Height="600px" DataMember="UserReportList">
				<Bands>
					<igtbl:UltraGridBand AddButtonCaption="UserReportList" BaseTableName="UserReportList" Key="UserReportList"
						AllowColSizing="Free" DefaultColWidth="150px" AllowDelete="No">
						<Columns>
                            <igtbl:UltraGridColumn AllowResize="Free" BaseColumnName="ReportID" DataType="System.Int32"
                                Hidden="True" IsBound="True" Key="ReportID">
                                <Header Caption="ReportID">
                                </Header>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn AllowResize="Free" BaseColumnName="ReportVirtualURL" Hidden="True"
                                IsBound="True" Key="ReportVirtualURL">
                                <Header Caption="ReportVirtualURL">
                                    <RowLayoutColumnInfo OriginX="1" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="1" />
                                </Footer>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn AllowResize="Free" BaseColumnName="ReportDisplayName" IsBound="True"
                                Key="ReportDisplayName" Width="350px">
                                <Header Caption="Report Name">
                                    <RowLayoutColumnInfo OriginX="2" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="2" />
                                </Footer>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn AllowResize="Free" BaseColumnName="REPORTTYPENAME" IsBound="True"
                                Key="REPORTTYPENAME" Width="175px">
                                <Header Caption="Report Type">
                                    <RowLayoutColumnInfo OriginX="3" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="3" />
                                </Footer>
                            </igtbl:UltraGridColumn>
						</Columns>
						<RowEditTemplate>
							<P align="right">Report Name&nbsp;<INPUT id="igtbl_TextBox_0_2" style="WIDTH: 150px" type="text" columnKey="ReportDisplayName"><BR>
								Report Type&nbsp;<INPUT id="igtbl_TextBox_0_3" style="WIDTH: 150px" type="text" columnKey="REPORTTYPENAME"><BR>
							</P>
							<BR>
							<P align="center"><INPUT id="igtbl_reOkBtn" style="WIDTH: 50px" onclick="igtbl_gRowEditButtonClick(event);"
									type="button" value="OK">&nbsp; <INPUT id="igtbl_reCancelBtn" style="WIDTH: 50px" onclick="igtbl_gRowEditButtonClick(event);"
									type="button" value="Cancel"></P>
						</RowEditTemplate>
						<RowTemplateStyle BorderColor="Window" BorderStyle="Ridge" BackColor="Window">
							<BorderDetails WidthLeft="3px" WidthTop="3px" WidthRight="3px" WidthBottom="3px"></BorderDetails>
						</RowTemplateStyle>
                        <AddNewRow View="NotSet" Visible="NotSet">
                        </AddNewRow>
					</igtbl:UltraGridBand>
				</Bands>
				<DisplayLayout StationaryMargins="Header" StationaryMarginsOutlookGroupBy="True" AllowSortingDefault="OnClient"
					RowHeightDefault="20px" Version="4.00" ViewType="OutlookGroupBy" SelectTypeRowDefault="Single"
					AllowColumnMovingDefault="OnServer" SelectTypeCellDefault="Extended" HeaderClickActionDefault="SortMulti"
					BorderCollapseDefault="Separate" AllowColSizingDefault="Free" CellSpacingDefault="1" RowSelectorsDefault="No"
					LoadOnDemand="Xml" Name="ctl00xgridReportList" TableLayout="Fixed">
					<AddNewBox>
                        <BoxStyle BackColor="LightGray" BorderColor="InactiveCaption" BorderStyle="Solid"
                            BorderWidth="1px">
                        </BoxStyle>
					</AddNewBox>
					<Pager MinimumPagesForDisplay="2">
                        <PagerStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px" />
					</Pager>
					<HeaderStyleDefault BorderColor="Black" BorderStyle="Solid" HorizontalAlign="Left" ForeColor="WhiteSmoke"
						BackColor="#6E1515" CssClass="HeaderStyleDefault">
						<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
					</HeaderStyleDefault>
					<GroupByRowStyleDefault BorderColor="Window" BackColor="Control"></GroupByRowStyleDefault>
					<FrameStyle Width="537px" Cursor="Default" BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana"
						BorderColor="InactiveCaption" BorderStyle="None" ForeColor="#A37171" BackColor="Window"
						Height="600px"></FrameStyle>
					<FilterOptionsDefault AllowRowFiltering="OnClient">
						<FilterDropDownStyle Width="200px" BorderWidth="1px" Font-Size="11px" Font-Names="Verdana,Arial,Helvetica,sans-serif"
							BorderColor="Silver" BorderStyle="Solid" BackColor="White" Height="300px" CustomRules="overflow:auto;">
							<Padding Left="2px"></Padding>
						</FilterDropDownStyle>
						<FilterHighlightRowStyle ForeColor="White" BackColor="#151C55"></FilterHighlightRowStyle>
					</FilterOptionsDefault>
					<FooterStyleDefault BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">
						<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
					</FooterStyleDefault>
					<ActivationObject BorderWidth="" BorderColor=""></ActivationObject>
					<GroupByBox>
                        <BoxStyle BackColor="ActiveBorder" BorderColor="Window">
                        </BoxStyle>
					</GroupByBox>
					<EditCellStyleDefault BorderWidth="0px" BorderStyle="None"></EditCellStyleDefault>
					<SelectedRowStyleDefault ForeColor="White" BackColor="#A10B0B"></SelectedRowStyleDefault>
					<RowStyleDefault BorderWidth="1px" BorderColor="Black" BorderStyle="Solid" ForeColor="Black" BackColor="#DBCACA">
						<Padding Left="3px"></Padding>
						<BorderDetails ColorTop="219, 202, 202" ColorLeft="219, 202, 202"></BorderDetails>
					</RowStyleDefault>
				</DisplayLayout>
			</igtbl:ultrawebgrid></TD>
		<TD style="WIDTH: 168px">
            &nbsp;&nbsp;
        </TD>
		<TD></TD>
	</TR>
</TABLE>
