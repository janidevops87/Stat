<%@ Register TagPrefix="stattrac" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="RoleAdminControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.Admin.RoleAdminControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD colSpan="3"><STATTRAC:SECTIONHEADER id="addEditUser" runat="server" Text="Add/Edit Role" CssClass="SectionHeader" Width="100%"
				ButtonTwoConfirmationMessage="Are you sure?" ButtonOneSuppressConfirmation="False"></STATTRAC:SECTIONHEADER></TD>
	</TR>
	<tr>
	    <td style="WIDTH: 1px"> </td>
	    <td> </td>
	    <td> </td>
	</tr>
	<tr>
	    <td> </td>
            
	    <td><asp:Button ID="btnAddRole" runat="server" Text="Add" OnClick="btnAddRole_Click" Width="75px" /></td> 
	    <td> </td>
	</tr>
    <tr>
	    <td> </td>
	    <td> </td>
	    <td> </td>
	</tr>	
	<tr>
	    <td> </td>
	    <td> &nbsp;<igtbl:ultrawebgrid id="gridRoleList" runat="server" height="267px" width="475px" DataSourceID="odsRoles" OnActiveRowChange="gridRoleList_ActiveRowChange"><Bands>
<igtbl:UltraGridBand AddButtonCaption="Roles" BaseTableName="Roles" Key="Roles" AllowDelete="No">
<AddNewRow Visible="NotSet" View="NotSet"></AddNewRow>
    <Columns>
        <igtbl:UltraGridColumn BaseColumnName="RoleID" DataType="System.Int32" IsBound="True"
            Key="RoleID" Hidden="True">
            <Header Caption="RoleID">
            </Header>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="RoleName" IsBound="True" Key="RoleName" Width="150px">
            <Header Caption="Role Name">
                <RowLayoutColumnInfo OriginX="1" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="1" />
            </Footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="RoleDescription" IsBound="True" Key="RoleDescription" Width="225px">
            <Header Caption="Role Description">
                <RowLayoutColumnInfo OriginX="2" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="2" />
            </Footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="Inactive" DataType="System.Int16" IsBound="True"
            Key="Inactive" Type="CheckBox" Width="60px">
            <Header Caption="Inactive">
                <RowLayoutColumnInfo OriginX="3" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="3" />
            </Footer>
        </igtbl:UltraGridColumn>
    </Columns>
</igtbl:UltraGridBand>
</Bands>

<DisplayLayout Version="4.00" SelectTypeRowDefault="Single" Name="ctl00xgridRoleList" RowHeightDefault="20px" TableLayout="Fixed" RowSelectorsDefault="No" BorderCollapseDefault="Separate" StationaryMarginsOutlookGroupBy="True" CellSpacingDefault="1" UseFixedHeaders="True" AllowSortingDefault="Yes" HeaderClickActionDefault="SortMulti">
<FrameStyle BorderWidth="1px" BorderStyle="None" Font-Names="Verdana" Font-Size="8pt" Height="267px" Width="475px" Cursor="Default" ForeColor="#A37171"></FrameStyle>

<FooterStyleDefault BackColor="LightGray" BorderWidth="1px" BorderStyle="Solid">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</FooterStyleDefault>

<HeaderStyleDefault BackColor="#6E1515" BorderStyle="Solid" BorderColor="Black" ForeColor="White">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</HeaderStyleDefault>

<RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Font-Names="Verdana" Font-Size="8pt">
<Padding Left="3px"></Padding>

<BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202"></BorderDetails>
</RowStyleDefault>

<AddNewBox>
<BoxStyle BackColor="LightGray" BorderWidth="1px" BorderStyle="Solid">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</BoxStyle>
</AddNewBox>

<ActivationObject BorderColor="Black" BorderWidth=""></ActivationObject>

<FilterOptionsDefault AllowRowFiltering="OnClient" FilterUIType="FilterRow">
<FilterDropDownStyle CustomRules="overflow:auto;" BackColor="White" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Font-Names="Verdana,Arial,Helvetica,sans-serif" Font-Size="11px" Width="200px">
<Padding Left="2px"></Padding>
</FilterDropDownStyle>

<FilterHighlightRowStyle BackColor="#151C55" ForeColor="White"></FilterHighlightRowStyle>

<FilterOperandDropDownStyle CustomRules="overflow:auto;" BackColor="White" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Font-Names="Verdana,Arial,Helvetica,sans-serif" Font-Size="11px">
<Padding Left="2px"></Padding>
</FilterOperandDropDownStyle>
</FilterOptionsDefault>
    <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
    </SelectedRowStyleDefault>
</DisplayLayout>
</igtbl:ultrawebgrid>&nbsp;
            <asp:ObjectDataSource ID="odsRoles" runat="server" SelectMethod="GetRolesTable" TypeName="Statline.StatTrac.Security.RolesManager" OnSelecting="odsRoles_Selecting" OnSelected="odsRoles_Selected">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="webPersonID" Type="Int32" />
                </SelectParameters>
            
            </asp:ObjectDataSource>
        </td>
	    <td> </td>
	</tr>	
	
</TABLE>
