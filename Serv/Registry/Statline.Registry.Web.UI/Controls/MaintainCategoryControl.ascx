<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MaintainCategoryControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.MaintainCategoryControl" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<div style="position: relative; width: 650px; height: 297px; font-size: 10pt; font-family: Arial; left: 0px; top: 0px;">
    <asp:Label ID="lblMaintainCategoryLists" runat="server" Font-Bold="True" Style="z-index: 100;
        left: 17px; position: absolute; top: 14px" Text="Maintain Category Lists"></asp:Label>
    <asp:Button ID="btnCategoryAdd" runat="server" Style="z-index: 101; left: 44px; position: absolute;
        top: 50px" Text="Add" OnClick="btnCategoryAdd_Click" />
    &nbsp;
    <igtbl:UltraWebGrid ID="gridMaintainSubCategoryLists" runat="server" Height="200px" Style="z-index: 103;
        left: 48px; position: absolute; top: 82px" Width="550px" DataSourceID="odsCategory">
        <Bands>
            <igtbl:UltraGridBand AddButtonCaption="EventCategory" BaseTableName="EventCategory" Key="EventCategory">
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="EventCategoryID" DataType="System.Int32" Hidden="True"
                        IsBound="True" Key="EventCategoryID">
                        <Header Caption="EventCategoryID">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerID" DataType="System.Int32" Hidden="True"
                        IsBound="True" Key="RegistryOwnerID">
                        <Header Caption="RegistryOwnerID">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="EventCategoryActive" DataType="System.Boolean"
                        IsBound="True" Key="EventCategoryActive" Type="CheckBox">
                        <HeaderStyle BackColor="SlateGray" ForeColor="White" />
                        <Header Caption="Active">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:TemplatedColumn BaseColumnName="EventCategoryName" ChangeLinksColor="True"
                        FooterText="" IsBound="True" Key="EventCategoryName" Width="450px">
                        <CellTemplate>
                            <asp:HyperLink ID="Category" Enabled="true" runat="server" Text='<%# Eval("EventCategoryName")%>'
                                NavigateUrl='<%# "~/CategoryEdit.aspx?CategoryID=" + DataBinder.Eval(Container.DataItem, "EventCategoryID")%>' />                        
                        </CellTemplate>
                        <HeaderStyle BackColor="SlateGray" ForeColor="White" />
                        <Header Caption="Category">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <Footer Caption="">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                    </igtbl:TemplatedColumn>
                    <igtbl:UltraGridColumn BaseColumnName="EventCategorySpecifyText" DataType="System.Boolean"
                        Hidden="True" IsBound="True" Key="EventCategorySpecifyText" Type="CheckBox">
                        <Header Caption="EventCategorySpecifyText">
                            <RowLayoutColumnInfo OriginX="4" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="4" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="CreateDate" DataType="System.DateTime" Hidden="True"
                        IsBound="True" Key="CreateDate">
                        <Header Caption="CreateDate">
                            <RowLayoutColumnInfo OriginX="5" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="5" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="LastModified" DataType="System.DateTime" Hidden="True"
                        IsBound="True" Key="LastModified">
                        <Header Caption="LastModified">
                            <RowLayoutColumnInfo OriginX="6" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="6" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="LastStatEmployeeID" DataType="System.Int32"
                        Hidden="True" IsBound="True" Key="LastStatEmployeeID">
                        <Header Caption="LastStatEmployeeID">
                            <RowLayoutColumnInfo OriginX="7" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="7" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="AuditLogTypeID" DataType="System.Int32" Hidden="True"
                        IsBound="True" Key="AuditLogTypeID">
                        <Header Caption="AuditLogTypeID">
                            <RowLayoutColumnInfo OriginX="8" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="8" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                </Columns>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer"
            AllowSortingDefault="OnClient" BorderCollapseDefault="Separate"
            HeaderClickActionDefault="SortMulti" Name="ctl00xgridMaintainSubCategoryLists" RowHeightDefault="20px"
            RowSelectorsDefault="No" SelectTypeRowDefault="Extended" StationaryMargins="Header"
            StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" RowSizingDefault="Free">
            <FrameStyle BackColor="Window" BorderColor="InactiveCaption" BorderStyle="Solid"
                BorderWidth="1px" Font-Names="Microsoft Sans Serif" Font-Size="8.25pt" Height="200px"
                Width="550px">
            </FrameStyle>
            <Pager MinimumPagesForDisplay="2">
                <PagerStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                </PagerStyle>
            </Pager>
            <EditCellStyleDefault BorderStyle="None" BorderWidth="0px">
            </EditCellStyleDefault>
            <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </FooterStyleDefault>
            <HeaderStyleDefault BackColor="LightGray" BorderStyle="Solid" HorizontalAlign="Left">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </HeaderStyleDefault>
            <RowStyleDefault BackColor="Window" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                Font-Names="Microsoft Sans Serif" Font-Size="8.25pt">
                <Padding Left="3px" />
                <BorderDetails ColorLeft="Window" ColorTop="Window" />
            </RowStyleDefault>
            <GroupByRowStyleDefault BackColor="Control" BorderColor="Window">
            </GroupByRowStyleDefault>
            <GroupByBox Hidden="True">
                <BoxStyle BackColor="ActiveBorder" BorderColor="Window">
                </BoxStyle>
            </GroupByBox>
            <AddNewBox Hidden="False">
                <BoxStyle BackColor="Window" BorderColor="InactiveCaption" BorderStyle="Solid" BorderWidth="1px">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                </BoxStyle>
            </AddNewBox>
            <ActivationObject BorderColor="" BorderWidth="">
            </ActivationObject>
            <FilterOptionsDefault>
                <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                    CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                    Font-Size="11px" Height="300px" Width="200px">
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
        </DisplayLayout>
    </igtbl:UltraWebGrid>
</div>
<asp:ObjectDataSource ID="odsCategory" runat="server" SelectMethod="FillEventCategory" TypeName="Statline.Registry.Common.RegistryCommonManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="EventCategoryID" Type="Int32" />
        <asp:SessionParameter DefaultValue="RegistryOwnerID" Name="RegistryOwnerID" SessionField="RegistryOwnerID"
            Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="EventCategoryActive" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
