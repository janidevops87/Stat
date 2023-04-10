
<%@ Register TagPrefix="stattrac" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserAdminControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.Admin.UserAdminControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<TABLE id="Table1" style="WIDTH: 616px; HEIGHT: 586px" cellSpacing="1" cellPadding="1"
	width="616" border="0">
	<TR>
		<TD colSpan="3"><STATTRAC:SECTIONHEADER id="addEditUser" runat="server" Text="Add/Edit User" CssClass="SectionHeader" Width="100%"
				ButtonTwoConfirmationMessage="Are you sure?" ButtonOneSuppressConfirmation="False"></STATTRAC:SECTIONHEADER></TD>
	</TR>
	<tr>
		<td style="WIDTH: 110px">Organization:</td>
		<td><igcmbo:webcombo id=ddlOrganization runat="server" Width="408px" DataMember="OrganizationList" DataSource="<%# dsReportReferenceData %>" ForeColor="Black" Version="4.00" BackColor="White" BorderStyle="Solid" BorderColor="Silver" BorderWidth="1px" SelBackColor="DarkBlue" SelForeColor="White" DataTextField="OrganizationName" DataValueField="OrganizationID" EnableXmlHTTP="True" Editable="True" ComboTypeAhead="Suggest">
				<ExpandEffects ShadowColor="LightGray"></ExpandEffects>
				<Columns>
					<igtbl:UltraGridColumn HeaderText="OrganizationName" Key="OrganizationName" IsBound="True" BaseColumnName="OrganizationName">
						<Footer Key="OrganizationName"></Footer>
						<Header Key="OrganizationName" Caption="OrganizationName"></Header>
					</igtbl:UltraGridColumn>
					<igtbl:UltraGridColumn HeaderText="OrganizationID" Key="OrganizationID" IsBound="True" Hidden="True" DataType="System.Int32"
						BaseColumnName="OrganizationID">
						<Footer Key="OrganizationID">
							<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
						</Footer>
						<Header Key="OrganizationID" Caption="OrganizationID">
							<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
						</Header>
					</igtbl:UltraGridColumn>
				</Columns>
				<DropDownLayout BaseTableName="OrganizationList" BorderCollapse="Separate" RowHeightDefault="20px"
					Version="4.00" ColHeadersVisible="No" RowSelectors="No">
					<RowStyle BorderWidth="1px" BorderColor="Gray" BorderStyle="Solid" BackColor="White">
						<BorderDetails WidthLeft="0px" WidthTop="0px"></BorderDetails>
					</RowStyle>
					<Images>
						<FilterGreaterThanImage Url="ig_tblFilterGreaterThan.png" AlternateText="Greater Than"></FilterGreaterThanImage>
						<FilterEndsWithImage Url="ig_tblFilterEndsWith.png" AlternateText="Ends With"></FilterEndsWithImage>
						<FilterDoesNotContainImage Url="ig_tblFilterDoesNotContain.png" AlternateText="Does Not Contain"></FilterDoesNotContainImage>
						<FilterDoesNotEndWithImage Url="ig_tblFilterDoesNotEndWith.png" AlternateText="Does Not End With"></FilterDoesNotEndWithImage>
						<RowLabelBlankImage Url="ig_tblBlank.gif"></RowLabelBlankImage>
						<CurrentEditRowImage Url="ig_tblTriEdit.gif" AlternateText="Editable Row"></CurrentEditRowImage>
						<GridCornerImage Url="ig_tblBlank.gif"></GridCornerImage>
						<FixedHeaderOnImage Url="ig_tblFixedOn.gif" AlternateText="Unfreeze column"></FixedHeaderOnImage>
						<FilterNotEqualsImage Url="ig_tblFilterNotEqual.png" AlternateText="Not Equal"></FilterNotEqualsImage>
						<UnGroupByImage Url="ig_tblUnGroupBy.gif" AlternateText="Undo group by"></UnGroupByImage>
						<FilterLessThanEqualsImage Url="ig_tblFilterLessThanOrEqualTo.png" AlternateText="Less Than Or Equals To"></FilterLessThanEqualsImage>
						<FilterEqualsImage Url="ig_tblFilterEqual.png" AlternateText="Filter Equals"></FilterEqualsImage>
						<FixedHeaderOffImage Url="ig_tblFixedOff.gif" AlternateText="Freeze column"></FixedHeaderOffImage>
						<FilterGreaterThanEqualsImage Url="ig_tblFilterGreaterThanOrEqualTo.png" AlternateText="Greater Than Or Equals To"></FilterGreaterThanEqualsImage>
						<FilterDoesNotStartWithImage Url="ig_tblFilterDoesNotStartWith.png" AlternateText="Does Not Start With"></FilterDoesNotStartWithImage>
						<NewRowImage Url="ig_tblNewrow.gif" AlternateText="New Row"></NewRowImage>
						<FilterStartsWithImage Url="ig_tblFilterStartsWith.png" AlternateText="Starts With"></FilterStartsWithImage>
						<SortAscendingImage Url="ig_tblSortAsc.gif" AlternateText="Sorted ascending"></SortAscendingImage>
						<GroupDownArrowImage Url="ig_tblPimgDn.gif" AlternateText="Grouped descending"></GroupDownArrowImage>
						<FilterLikeImage Url="ig_tblFilterLike.png" AlternateText="Like"></FilterLikeImage>
						<FilterImage Url="ig_tblFilter.gif" AlternateText="Filterable"></FilterImage>
						<FilterAppliedImage Url="ig_tblFilterApplied.gif" AlternateText="Filtered"></FilterAppliedImage>
						<SortDescendingImage Url="ig_tblSortDesc.gif" AlternateText="Sorted descending"></SortDescendingImage>
						<FilterNotLikeImage Url="ig_tblFilterNotLike.png" AlternateText="Not Like"></FilterNotLikeImage>
						<CollapseImage Url="ig_tblMinus.gif" AlternateText="Expanded"></CollapseImage>
						<GroupUpArrowImage Url="ig_tblPimgUp.gif" AlternateText="Grouped ascending"></GroupUpArrowImage>
						<CurrentRowImage Url="ig_tblTri.gif" AlternateText="Active Row"></CurrentRowImage>
						<FilterContainsImage Url="ig_tblFilterContains.png" AlternateText="Contains"></FilterContainsImage>
						<ExpandImage Url="ig_tblPlus.gif" AlternateText="Collapsed"></ExpandImage>
						<FilterLessThanImage Url="ig_tblFilterLessThan.png" AlternateText="Less Than"></FilterLessThanImage>
						<GroupByImage Url="ig_tblGroupBy.gif" AlternateText="Group by"></GroupByImage>
						<BlankImage Url="ig_tblBlank.gif"></BlankImage>
					</Images>
					<FrameStyle Width="325px" Cursor="Default" BorderWidth="2px" Font-Size="10pt" Font-Names="Verdana"
						BorderStyle="Ridge" BackColor="Silver" Height="130px"></FrameStyle>
					<HeaderStyle BorderStyle="Solid" BackColor="LightGray">
						<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
					</HeaderStyle>
					<SelectedRowStyle ForeColor="White" BackColor="DarkBlue"></SelectedRowStyle>
					<ImageUrls FilterEquals="ig_tblFilterEqual.png" ImageDirectory="/ig_common/Images/"></ImageUrls>
				</DropDownLayout>
			</igcmbo:webcombo></td>
	</tr>
	<tr>
		<td colSpan="2">
			<table style="WIDTH: 488px; HEIGHT: 45px" width="488" border="0">
				<tr>
					<td style="WIDTH: 200px" width="200"><asp:checkbox id="chkBoxInactive" runat="server" Text="Display All Accounts" AutoPostBack="True" oncheckedchanged="chkBoxInactive_CheckedChanged"></asp:checkbox></td>
					<td style="WIDTH: 212px" width="212"><INPUT id="txtHiddenOrganizationID" type="hidden" runat="server"></td>
					<td align="right" width="10%"><asp:button id="btnAddUser" runat="server" Text="Add" Width="75px" onclick="btnAddUser_Click"></asp:button></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colSpan="2"><igtbl:ultrawebgrid id=gridPersonList runat="server" Width="488px" Height="486px" DataMember="UserList" DataSource="<%# dsUserData %>">
				<Bands>
                    <igtbl:UltraGridBand AddButtonCaption="UserList" BaseTableName="UserList" Key="UserList" AllowDelete="No">
                        <Columns>
                            <igtbl:UltraGridColumn BaseColumnName="WebPersonID" DataType="System.Int32" Hidden="True"
                                IsBound="True" Key="WebPersonID">
                                <Header Caption="WebPersonID">
                                </Header>
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
                            <igtbl:UltraGridColumn BaseColumnName="WebPersonUserName" IsBound="True" Key="WebPersonUserName"
                                Width="140px">
                                <CellStyle Font-Underline="True" ForeColor="Blue">
                                </CellStyle>
                                <Header Caption="User Name">
                                    <RowLayoutColumnInfo OriginX="2" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="2" />
                                </Footer>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn BaseColumnName="PersonName" IsBound="True" Key="PersonName"
                                Width="160px">
                                <Header Caption="Name">
                                    <RowLayoutColumnInfo OriginX="3" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="3" />
                                </Footer>
                            </igtbl:UltraGridColumn>
                            <igtbl:UltraGridColumn AllowRowFiltering="False" BaseColumnName="Inactive" DataType="System.Int16"
                                FilterIcon="False" GatherFilterData="False" IsBound="True" Key="Inactive" Type="CheckBox"
                                Width="140px">
                                <Header Caption="InActive">
                                    <RowLayoutColumnInfo OriginX="4" />
                                </Header>
                                <Footer>
                                    <RowLayoutColumnInfo OriginX="4" />
                                </Footer>
                            </igtbl:UltraGridColumn>
                        </Columns>
                        <AddNewRow View="NotSet" Visible="NotSet">
                        </AddNewRow>
                    </igtbl:UltraGridBand>
				</Bands>
				<DisplayLayout AllowDeleteDefault="Yes" StationaryMargins="Header" StationaryMarginsOutlookGroupBy="True"
					AllowSortingDefault="OnClient" RowHeightDefault="20px" Version="4.00" SelectTypeRowDefault="Single"
					AllowColumnMovingDefault="OnServer" HeaderClickActionDefault="SortSingle" BorderCollapseDefault="Separate"
					AllowColSizingDefault="Free" CellSpacingDefault="1" RowSelectorsDefault="No" Name="ctl00xgridPersonList"
					TableLayout="Fixed" AllowUpdateDefault="Yes">
					<AddNewBox Hidden="False">
                        <BoxStyle BackColor="LightGray" BorderColor="InactiveCaption" BorderStyle="Solid"
                            BorderWidth="1px">
                            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                        </BoxStyle>
					</AddNewBox>
					<Pager MinimumPagesForDisplay="2">
                        <PagerStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                        </PagerStyle>
					</Pager>
					<HeaderStyleDefault BorderColor="Black" BorderStyle="Solid" HorizontalAlign="Left" ForeColor="White"
						BackColor="#6E1515">
						<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
					</HeaderStyleDefault>
					<GroupByRowStyleDefault BorderColor="Window" BackColor="Control"></GroupByRowStyleDefault>
					<FrameStyle Width="488px" Cursor="Default" BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana"
						BorderColor="InactiveCaption" BorderStyle="None" ForeColor="#A37171" BackColor="Window"
						Height="486px"></FrameStyle>
					<FilterOptionsDefault AllowRowFiltering="OnClient" FilterUIType="FilterRow">
						<FilterDropDownStyle Width="200px" BorderWidth="1px" Font-Size="11px" Font-Names="Verdana,Arial,Helvetica,sans-serif"
							BorderColor="Silver" BorderStyle="Solid" BackColor="White" Height="300px" CustomRules="overflow:auto;">
							<Padding Left="2px"></Padding>
						</FilterDropDownStyle>
						<FilterHighlightRowStyle ForeColor="White" BackColor="#151C55"></FilterHighlightRowStyle>
						<FilterOperandDropDownStyle BorderWidth="1px" Font-Size="11px" Font-Names="Verdana,Arial,Helvetica,sans-serif"
							BorderColor="Silver" BorderStyle="Solid" BackColor="White" CustomRules="overflow:auto;">
							<Padding Left="2px"></Padding>
						</FilterOperandDropDownStyle>
					</FilterOptionsDefault>
					<FooterStyleDefault BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">
						<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
					</FooterStyleDefault>
					<ActivationObject BorderWidth="" BorderColor="Black"></ActivationObject>
					<GroupByBox Hidden="True">
                        <BoxStyle BackColor="ActiveBorder" BorderColor="Window">
                        </BoxStyle>
					</GroupByBox>
					<EditCellStyleDefault BorderWidth="0px" BorderStyle="None"></EditCellStyleDefault>
					<SelectedRowStyleDefault ForeColor="White" BackColor="#A10B0B"></SelectedRowStyleDefault>
					<RowStyleDefault BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana" BorderColor="Silver" BorderStyle="Solid"
						BackColor="#DBCACA">
						<Padding Left="3px"></Padding>
						<BorderDetails ColorTop="219, 202, 202" ColorLeft="219, 202, 202"></BorderDetails>
					</RowStyleDefault>
				</DisplayLayout>
			</igtbl:ultrawebgrid></td>
	</tr>
</TABLE>
