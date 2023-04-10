<%@ Register TagPrefix="stattrac" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="RoleAdminEditControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.Admin.RoleAdminEditControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<script language="javascript">
<!--
    function GetGridAvailableReportsClientID()
    {
        return '<%=  gridAvailableReports.ClientID %>';
    }   
    function GetGridSelectedReportsClientID()
    {
        return '<%=  gridSelectedReports.ClientID %>';
    }   
    function GetTxtHiddenRoleIDClientID()
    {
        return '<%=  txtHiddenFieldRoleId.ClientID %>';
    }
    
	function SetSelected(grid, includeAll)
	{
		if(includeAll)
		{		    
			var startRow = grid.Rows.rows[0];
			var endRow = grid.Rows.getRowById(grid.Rows.getLastRowId());
			if (endRow == null) endRow = startRow;
			if(startRow != null && endRow != null) grid.selectRowRegion(startRow, endRow );
		
		    for(var loopCount = 0; loopCount < grid.Rows.rows.length; loopCount++)
		    {
		        var row = grid.Rows.rows[loopCount];
			    if(row != null)
			    {
			        row.setSelected();
			    }
            }			
		}	
	}	
	// create a function to move rows from available to assigned
	function AssignReports(includeAll)
	{
		//first get the ClientID
		var gridAvailableRoleClientID; 
		var gridAssignedRoleClientID;
        gridAvailableRoleClientID = GetGridAvailableReportsClientID();	
        gridAssignedRoleClientID = GetGridSelectedReportsClientID();
        	                                          
		//Now get the reference to the grid
		var gridAvailableRole = igtbl_getGridById(gridAvailableRoleClientID);
		var gridAssignedRole = igtbl_getGridById(gridAssignedRoleClientID);
	
		SetSelected(gridAvailableRole, includeAll);	
		
        for(var rowId in gridAvailableRole.SelectedRows)
		{
		    var availableRow=igtbl_getRowById(rowId);
		    if(availableRow != null)
			    {
				    if(availableRow.getSelected())
				    {
        			    var newRow = igtbl_addNew(										
										    gridAssignedRole.Id, //grid id string
										    availableRow.Band.Index, //bandNo
										    true, 
										    true);	
                        // column 0 ReportDisplayName is set by the data table
					    newRow.getCell(0).setValue(availableRow.getCell(0).getValue());
    					
					    //column 1 ReportVirtualURL ReportID
					    newRow.getCell(1).setValue(availableRow.getCell(1).getValue());

                        // column 2 ReportID
                        newRow.getCell(2).setValue(availableRow.getCell(2).getValue());
                        
                        // colum 3 RoleID
                        var roleIDClientId = GetTxtHiddenRoleIDClientID();
					    var roleID = document.getElementById(roleIDClientId);
					    newRow.getCell(3).setValue(roleID.value);
    					
					    //column 4 ReportRuleID
                        
					    //column 5 LastStatEmployeeID
					    newRow.getCell(5).setValue(-1);
    					
					    //column 6 AuditLogTypeID					
				        newRow.getCell(6).setValue(1);
        					
		                availableRow.deleteRow();
				    }				
			    }		
		}				
	}
	// create a function to remove rows from assigned and add available
	function RemoveReports(includeAll)
	{
		
		//first get the ClientID
		//first get the ClientID
		var gridAvailableRoleClientID; 
		var gridAssignedRoleClientID;
        gridAvailableRoleClientID = GetGridAvailableReportsClientID();	
        gridAssignedRoleClientID = GetGridSelectedReportsClientID();
        	                                          
		//Now get the reference to the grid
		var gridAvailableRole = igtbl_getGridById(gridAvailableRoleClientID);
		var gridAssignedRole = igtbl_getGridById(gridAssignedRoleClientID);

        SetSelected(gridAssignedRole, includeAll);					
        for(var rowId in gridAssignedRole.SelectedRows)
		{
		    var assignedRow=igtbl_getRowById(rowId);
		    if(assignedRow != null)
			    {
				    if(assignedRow.getSelected())
				    {
    		
					    var newRow = igtbl_addNew(										
										    gridAvailableRole.Id, //grid id string
										    assignedRow.Band.Index, //bandNo
										    true, 
										    true);	
    					
					    //column 0 Display Name
					    newRow.getCell(0).setValue(assignedRow.getCell(0).getValue());

					    //column 1 Folder
					    newRow.getCell(1).setValue(assignedRow.getCell(1).getValue());

					    //column 0 ReportID
					    newRow.getCell(2).setValue(assignedRow.getCell(2).getValue());
    					
		                assignedRow.deleteRow();
				    }				
			    }	
		
		}	
	}

	// function to remove rows
	function RemoveSelected(grid)
	{
		for(var rowId in grid.SelectedRows)
		{
		var row=igtbl_getRowById(rowId);
		row.deleteRow();
		}	
	}
	
	//4 button functions 
	// btnAssignSelectedReports
	function btnAssignSelectedReports_Click()
	{
		AssignReports(false);

	
	}
	
	//btnAssignAllReports
	function btnAssignAllReports_Click()
	{
		//set includeAll to true because all rows should assigned
		AssignReports(true);
	}
	
	//btnRemoveSelectedReports
	function btnRemoveAllReports_Click()
	{
		RemoveReports(true);
	}
	
	//btnRemoveAllReports
	function btnRemoveSelectedReports_Click()
	{
		RemoveReports(false);
	}
	
	
	

// -->
</script>

<table id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
	<tr>
		<td colSpan="3"><STATTRAC:SECTIONHEADER id="addEditUser" runat="server" Text="Add/Edit Role" CssClass="SectionHeader" Width="100%"
				ButtonTwoConfirmationMessage="Are you sure?" ButtonOneSuppressConfirmation="False"></STATTRAC:SECTIONHEADER>
		</td>
	</tr>
	<tr>
		<td style="width: 1033px">
			<table style="WIDTH: 1016px; HEIGHT: 420px">
				<tr>
					<td style="WIDTH: 7px; height: 45px;" align="left"></td>
					<td style="WIDTH: 152px; height: 45px;">
                        <asp:CheckBox ID="chkBoxInactive" runat="server" Text="Inactive" /></td>
					<td style="width: 41px; height: 45px;"></td>
					<td style="WIDTH: 110px; height: 45px;"></td>
					<td style="WIDTH: 66px; height: 45px;"></td>
					<td style="width: 169px; height: 45px;">
                        <asp:ObjectDataSource ID="odsAssociatedUsers" runat="server" SelectMethod="FillRoleUsers"
                            TypeName="Statline.StatTrac.Security.RolesManager">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="webPersonId" Type="Int32" />
                                <asp:Parameter DefaultValue="0" Name="roleId" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        </td>
				</tr>
				<tr>
				    <td style="width: 7px; height: 42px;"></td>
				    <td style="height: 42px;" colspan="3">
                        <asp:Label ID="lblRoleName" runat="server" Text="Role Name:" Width="110px" style="text-align: right" ></asp:Label>
                        <asp:RequiredFieldValidator ID="validatorRoleNameRequired" runat="server" ErrorMessage="The field Role Name is required." ControlToValidate="txtBoxRoleName" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtBoxRoleName" runat="server" MaxLength="50" Width="330px"></asp:TextBox></td>
				    <td style="width: 66px; height: 42px"></td>
				    <td rowspan="4">
                        <asp:Label ID="lblAssociatedUsers" runat="server" Text="Associated Users" CssClass="TableLabel" Width="230px"></asp:Label>
                        <igtbl:UltraWebGrid ID="gridAssociatedUsers" runat="server" Height="375px" Width="230px" DataMember="UserList" DataSource="<%# dsSecurityData %>" ><Bands>
<igtbl:UltraGridBand AddButtonCaption="UserList" BaseTableName="UserList" Key="UserList" AllowDelete="No">
<AddNewRow Visible="NotSet" View="NotSet"></AddNewRow>
    <Columns>
        <igtbl:UltraGridColumn BaseColumnName="WebPersonID" DataType="System.Int32" Hidden="True"
            IsBound="True" Key="WebPersonID">
            <Header Caption="WebPersonID">
            </Header>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="WebPersonUserName" IsBound="True" Key="WebPersonUserName"
            Width="140px">
            <Header Caption="WebPersonUserName">
                <RowLayoutColumnInfo OriginX="1" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="1" />
            </Footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="PersonName" IsBound="True" Key="PersonName"
            Width="160px">
            <Header Caption="PersonName">
                <RowLayoutColumnInfo OriginX="2" />
            </Header>
            <Footer>
                <RowLayoutColumnInfo OriginX="2" />
            </Footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="Inactive" DataType="System.Int16" IsBound="True"
            Key="Inactive" Type="CheckBox">
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

<DisplayLayout Version="4.00" Name="ctl00xUltraWebGrid1" RowHeightDefault="20px" TableLayout="Fixed" RowSelectorsDefault="No" BorderCollapseDefault="Separate" StationaryMarginsOutlookGroupBy="True" CellSpacingDefault="1" UseFixedHeaders="True">
<FrameStyle BorderWidth="1px" BorderStyle="None" Font-Names="Verdana" Font-Size="8pt" Height="375px" Width="230px" Cursor="Default" ForeColor="#A37171"></FrameStyle>

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

<FilterOptionsDefault>
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
</igtbl:UltraWebGrid></td>
				</tr>
				<tr>
				    <td style="width: 7px; height: 60px;"></td>
				    <td colspan="3" valign="top" style="height: 60px">
                        <asp:Label ID="lblRoleDescription" runat="server" Text="Role Description:" Width="110px" Height="60px" style="text-align: right"></asp:Label><asp:RegularExpressionValidator ID="validatorRoleDescriptionMaxLength" runat="server"
                            ControlToValidate="txtBoxRoleDescription" ErrorMessage="The field Role Description can only contain 250 characters."
                            ValidationExpression="^.{1,250}$">*</asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="validatorRoleDescriptionRequired" runat="server"
                            ControlToValidate="txtBoxRoleDescription" ErrorMessage="The field Role Description is required.">*</asp:RequiredFieldValidator><asp:TextBox ID="txtBoxRoleDescription" runat="server" Height="60px" MaxLength="250" TextMode="MultiLine" Width="329px" style="VERTICAL-ALIGN: top" CausesValidation="True"></asp:TextBox></td>
				    <td style="width: 66px; height: 60px"></td>
				</tr>
				<tr>
				    <td style="width: 7px; height: 20px"></td>
				    <td style="width: 152px; height: 20px">
                        &nbsp;<asp:ObjectDataSource ID="odsAvailableReports" runat="server" SelectMethod="FillAvailableReports"
                            TypeName="Statline.StatTrac.Security.RolesManager">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="webPersonId" Type="Int32" />
                                <asp:Parameter DefaultValue="0" Name="roleId" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
				    <td style="width: 41px; height: 20px"></td>
				    <td style="height: 20px; width: 110px;">
                        &nbsp;<asp:ObjectDataSource ID="odsSelectedReports" runat="server" SelectMethod="FillSelectReports"
                            TypeName="Statline.StatTrac.Security.RolesManager">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="webPersonId" Type="Int32" />
                                <asp:Parameter DefaultValue="0" Name="roleId" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
				    <td style="height: 20px; width: 66px;">
                        &nbsp;&nbsp;
                    </td>
				</tr>
				<tr>
				    <td style="width: 7px"></td>
				    <td style="width: 152px" class=".TableLabel">
                        <igtbl:UltraWebGrid ID="gridAvailableReports" DataSource="<%# dsSecurityData %>" runat="server" Height="230px" Width="230px" OnInitializeLayout="gridAvailableReports_InitializeLayout" DataMember="Reports">
                            <Bands>
                                <igtbl:UltraGridBand CellClickAction="RowSelect" AddButtonCaption="Reports" BaseTableName="Reports" Key="Reports" ColHeadersVisible="Yes" HeaderClickAction="SortSingle" AllowDelete="No">
                                    <AddNewRow View="NotSet" Visible="NotSet">
                                    </AddNewRow>
                                    <Columns>
                                        <igtbl:UltraGridColumn BaseColumnName="ReportDisplayName" IsBound="True" Key="ReportDisplayName"
                                            Width="230px" AllowRowFiltering="False" SortCaseSensitive="False">
                                            <Header Caption="Available Reports" Fixed="True" FixedHeaderIndicator="None">
                                            </Header>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="ReportVirtualURL" IsBound="True" Key="ReportVirtualURL"
                                            Width="230px">
                                            <Header Caption="ReportVirtualURL">
                                                <RowLayoutColumnInfo OriginX="1" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="1" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="ReportID" DataType="System.Int32" Hidden="True"
                                            IsBound="True" Key="ReportID">
                                            <Header Caption="ReportID">
                                                <RowLayoutColumnInfo OriginX="2" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="2" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                    </Columns>
                                </igtbl:UltraGridBand>
                            </Bands>
                            <DisplayLayout BorderCollapseDefault="Separate" Name="ctl00xgridAvailableReports" RowHeightDefault="20px"
                                RowSelectorsDefault="No" SelectTypeRowDefault="Extended"
                                StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" UseFixedHeaders="True" ColHeadersVisibleDefault="No" CellSpacingDefault="1" AllowAddNewDefault="Yes" AllowDeleteDefault="Yes" AllowSortingDefault="OnClient">
                                <FrameStyle BorderStyle="None"
                                    BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="230px"
                                    Width="230px" Cursor="Default" ForeColor="#A37171">
                                </FrameStyle>
                                <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                </FooterStyleDefault>
                                <HeaderStyleDefault BackColor="#6E1515" BorderStyle="Solid" BorderColor="Black" ForeColor="White">
                                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                </HeaderStyleDefault>
                                <RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                    Font-Names="Verdana" Font-Size="8pt">
                                    <Padding Left="3px" />
                                    <BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202" />
                                </RowStyleDefault>
                                <AddNewBox>
                                    <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                    </BoxStyle>
                                </AddNewBox>
                                <ActivationObject BorderColor="Black" BorderWidth="">
                                </ActivationObject>
                                <FilterOptionsDefault>
                                    <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                                        Font-Size="11px" Width="200px">
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
                                <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
                                </SelectedRowStyleDefault>
                            </DisplayLayout>
                        </igtbl:UltraWebGrid>
                        </td>
				    <td style="width: 41px" align="center">
                        <P align="center"><input id="btnAssignSelectedReports" type="button" value=">" style="width: 30px; height: 24px" onclick="javascript:btnAssignSelectedReports_Click();" /></P>
                        <P align="center"><input id="btnAssignAllReports" type="button" value=">>" style="width: 30px; height: 24px"  onclick="javascript:btnAssignAllReports_Click();"  /></P>
                        <P align="center"><input id="btnRemoveAllReports" type="button" value="<<" style="width: 30px; height: 24px" onclick="javascript:btnRemoveAllReports_Click();" /></P>
                        <P align="center"><input id="btnRemoveSelectedReports" type="button" value="<" style="width: 30px; height: 24px" onclick="javascript:btnRemoveSelectedReports_Click();" /></P></td>
				    <td style="width: 110px">
                        <igtbl:UltraWebGrid ID="gridSelectedReports" runat="server" Height="230px" Width="230px" DataSource="<%# dsSecurityData %>" DataMember="ReportRule" OnUpdateRowBatch="gridSelectedReports_UpdateRowBatch" OnDeleteRowBatch="gridSelectedReports_DeleteRowBatch" >
                            <Bands>
                                <igtbl:UltraGridBand AddButtonCaption="ReportRule" BaseTableName="ReportRule" CellClickAction="RowSelect"
                                    Key="ReportRule" ColHeadersVisible="Yes" HeaderClickAction="SortSingle" AllowDelete="No">
                                    <Columns>
                                        <igtbl:UltraGridColumn BaseColumnName="ReportDisplayName" IsBound="True" Key="ReportDisplayName" Width="230px" HeaderClickAction="SortSingle">
                                            <Header Caption="Selected Reports" ClickAction="SortSingle">
                                            </Header>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="ReportVirtualURL" IsBound="True" Key="ReportVirtualURL" Width="230px">
                                            <Header Caption="ReportVirtualURL">
                                                <RowLayoutColumnInfo OriginX="1" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="1" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="ReportID" DataType="System.Int32" Hidden="True"
                                            IsBound="True" Key="ReportID">
                                            <Header Caption="ReportID">
                                                <RowLayoutColumnInfo OriginX="2" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="2" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="RoleID" DataType="System.Int32" Hidden="True"
                                            IsBound="True" Key="RoleID">
                                            <Header Caption="RoleID">
                                                <RowLayoutColumnInfo OriginX="3" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="3" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="ReportRuleID" DataType="System.Int32" Hidden="True"
                                            IsBound="True" Key="ReportRuleID">
                                            <Header Caption="ReportRuleID">
                                                <RowLayoutColumnInfo OriginX="4" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="4" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="LastStatEmployeeID" DataType="System.Int32"
                                            Hidden="True" IsBound="True" Key="LastStatEmployeeID">
                                            <Header Caption="LastStatEmployeeID">
                                                <RowLayoutColumnInfo OriginX="5" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="5" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="AuditLogTypeID" DataType="System.Int32" Hidden="True"
                                            IsBound="True" Key="AuditLogTypeID">
                                            <Header Caption="AuditLogTypeID">
                                                <RowLayoutColumnInfo OriginX="6" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="6" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                    </Columns>
                                    <AddNewRow View="NotSet" Visible="NotSet">
                                    </AddNewRow>
                                </igtbl:UltraGridBand>
                            </Bands>
                            <DisplayLayout Name="ctl00xgridSelectedReports" RowHeightDefault="20px"
                                RowSelectorsDefault="No" SelectTypeRowDefault="Extended"
                                StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" CellSpacingDefault="1" ColHeadersVisibleDefault="No" AllowAddNewDefault="Yes" AllowDeleteDefault="Yes" AllowSortingDefault="OnClient">
                                <FrameStyle BorderStyle="None"
                                    BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="230px"
                                    Width="230px" Cursor="Default" ForeColor="#A37171">
                                </FrameStyle>
                                <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                </FooterStyleDefault>
                                <HeaderStyleDefault BackColor="#6E1515" BorderStyle="Solid" BorderColor="Black" ForeColor="White">
                                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                </HeaderStyleDefault>
                                <RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                    Font-Names="Verdana" Font-Size="8pt">
                                    <Padding Left="3px" />
                                    <BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202" />
                                </RowStyleDefault>
                                <AddNewBox>
                                    <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                    </BoxStyle>
                                </AddNewBox>
                                <ActivationObject BorderColor="Black" BorderWidth="">
                                </ActivationObject>
                                <FilterOptionsDefault>
                                    <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                                        Font-Size="11px" Width="200px">
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
                                <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
                                </SelectedRowStyleDefault>
                            </DisplayLayout>
                        </igtbl:UltraWebGrid></td>
				    <td style="width: 66px"></td>
				</tr>
                <tr>
				    <td style="width: 7px"></td>
				    <td style="width: 152px">
                        <INPUT id="txtHiddenFieldRoleId" style="WIDTH: 72px; HEIGHT: 22px" type="hidden" 
							runat="server">
                    </td>
				    <td style="width: 41px"></td>
				    <td style="width: 110px; text-align: right;" align="right" colspan="2">
                        <asp:Button ID="btnSave" runat="server" Text="Save" Width="65px" OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="65px" OnClick="btnCancel_Click" CausesValidation="False" /></td>
				    <td style="width: 60px">
                        &nbsp;
                    </td>
				    <td></td>
				</tr>			
			</table>
		</td>		
	</tr>			
</table>
