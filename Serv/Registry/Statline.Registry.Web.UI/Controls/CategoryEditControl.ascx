<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryEditControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.CategoryEditControl" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<div style="position: relative; width: 650px; height: 342px; font-size: 10pt; font-family: Arial; left: 0px; top: 0px;">
    <asp:Button ID="btnSubCategoryAdd" runat="server" Style="z-index: 100; left: 31px;
        position: absolute; top: 134px" Text="Add" OnClick="btnSubCategoryAdd_Click" />
    <asp:Button ID="btnCategoryCancel" runat="server" Style="z-index: 101; left: 386px;
        position: absolute; top: 93px" Text="Cancel" OnClick="btnCategoryCancel_Click" />
    <asp:Button ID="btnCategorySave" runat="server" Style="z-index: 102; left: 324px;
        position: absolute; top: 94px" Text="Save" OnClick="btnCategorySave_Click" />
    <asp:Label ID="lblCategory" runat="server" Font-Bold="True" Style="z-index: 103;
        left: 15px; position: absolute; top: 11px" Text="Category"></asp:Label>
    <asp:Label ID="lblCategoryName" runat="server" Style="z-index: 104; left: 31px; position: absolute;
        top: 60px" Text="Category Name:"></asp:Label>
    <asp:CheckBox ID="cbxCategoryActive" runat="server" Style="z-index: 105; left: 29px;
        position: absolute; top: 33px" Text="Active" />
    <asp:CheckBox ID="cbxCategoryAdditionalText" runat="server" Style="z-index: 106;
        left: 397px; position: absolute; top: 54px" Text="Provide text field to specify answer" />
    <asp:TextBox ID="txtCategoryName" runat="server" Style="z-index: 107; left: 135px;
        position: absolute; top: 54px" Width="225px"></asp:TextBox>
    &nbsp;
    <igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server" DataSourceID="odsSubCategory"
        Height="164px" Style="z-index: 109; left: 31px; position: absolute; top: 164px"
        Width="550px">
        <Bands>
            <igtbl:UltraGridBand AddButtonCaption="EventSubCategory" BaseTableName="EventSubCategory"
                Key="EventSubCategory">
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="EventSubCategoryActive" DataType="System.Boolean"
                        IsBound="True" Key="EventSubCategoryActive" Type="CheckBox" Width="65px">
                        <HeaderStyle BackColor="SlateGray" ForeColor="White" />
                        <Header Caption="Active">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:TemplatedColumn BaseColumnName="EventSubCategoryName" IsBound="True" Key="EventSubCategoryName"
                        Width="450px">
                        <CellTemplate>
                            <asp:HyperLink ID="Category" Enabled="true" runat="server" Text='<%# Eval("EventSubCategoryName")%>'
                                NavigateUrl='<%# "~/SubCategoryEdit.aspx?SubCategoryID=" + DataBinder.Eval(Container.DataItem, "EventSubCategoryID")%>' />                        
                        </CellTemplate>
                        <HeaderStyle BackColor="SlateGray" ForeColor="White" />
                        <Header Caption="SubCategory">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:TemplatedColumn>
                    <igtbl:UltraGridColumn BaseColumnName="EventSubCategoryID" DataType="System.Int32"
                        Hidden="True" IsBound="True" Key="EventSubCategoryID">
                        <Header Caption="EventSubCategoryID">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="EventCategoryID" DataType="System.Int32" Hidden="True"
                        IsBound="True" Key="EventCategoryID">
                        <Header Caption="EventCategoryID">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="EventSubCategorySourceCode" Hidden="True"
                        IsBound="True" Key="EventSubCategorySourceCode">
                        <Header Caption="EventSubCategorySourceCode">
                            <RowLayoutColumnInfo OriginX="4" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="4" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="EventSubCategorySpecifyText" DataType="System.Boolean"
                        Hidden="True" IsBound="True" Key="EventSubCategorySpecifyText" Type="CheckBox">
                        <Header Caption="EventSubCategorySpecifyText">
                            <RowLayoutColumnInfo OriginX="5" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="5" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="CreateDate" DataType="System.DateTime" Hidden="True"
                        IsBound="True" Key="CreateDate">
                        <Header Caption="CreateDate">
                            <RowLayoutColumnInfo OriginX="6" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="6" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="LastModified" DataType="System.DateTime" Hidden="True"
                        IsBound="True" Key="LastModified">
                        <Header Caption="LastModified">
                            <RowLayoutColumnInfo OriginX="7" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="7" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="LastStatEmployeeID" DataType="System.Int32"
                        Hidden="True" IsBound="True" Key="LastStatEmployeeID">
                        <Header Caption="LastStatEmployeeID">
                            <RowLayoutColumnInfo OriginX="8" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="8" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="AuditLogTypeID" DataType="System.Int32" Hidden="True"
                        IsBound="True" Key="AuditLogTypeID">
                        <Header Caption="AuditLogTypeID">
                            <RowLayoutColumnInfo OriginX="9" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="9" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                </Columns>
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowSortingDefault="OnClient"
            BorderCollapseDefault="Separate" HeaderClickActionDefault="SortMulti" Name="ctl00xUltraWebGrid1"
            RowHeightDefault="20px" RowSelectorsDefault="No" SelectTypeRowDefault="Extended"
            StationaryMargins="Header" StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed"
            Version="4.00">
            <FrameStyle BackColor="Window" BorderColor="InactiveCaption" BorderStyle="Solid"
                BorderWidth="1px" Font-Names="Microsoft Sans Serif" Font-Size="8.25pt" Height="164px"
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
&nbsp;&nbsp;
<asp:ObjectDataSource ID="odsCategory" runat="server" SelectMethod="FillEventCategory" TypeName="Statline.Registry.Common.RegistryCommonManager">
    <SelectParameters>
        <asp:Parameter Name="EventCategoryID" Type="Int32" DefaultValue="0" />
        <asp:Parameter DefaultValue="1" Name="RegistryOwnerID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="EventCategoryActive" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsSubCategory" runat="server"
    TypeName="Statline.Registry.Common.RegistryCommonManager" SelectMethod="FillEventSubCategory">
    <SelectParameters>
        <asp:Parameter Name="EventSubCategoryID" Type="Int32" DefaultValue="0" />
        <asp:Parameter DefaultValue="0" Name="EventCategoryID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="EventSubCategoryActive" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
