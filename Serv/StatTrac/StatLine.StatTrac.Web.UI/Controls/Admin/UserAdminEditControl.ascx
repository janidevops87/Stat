<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserAdminEditControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.Admin.UserAdminEditControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<!-- <%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>-->
<%@ Register TagPrefix="stattrac" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %> 
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<meta content="True" name="vs_snapToGrid">
<script language="javascript">
<!--
    function GetGridAvailableRolesClientID()
    {
        return '<%=  gridAvailableRoles.ClientID %>';
    }   
    function GetGridSelectedRolesClientID(gridID)
    {
        return '<%=  gridSelectedRoles.ClientID %>';
    }   
    function GettxtHiddenWebPersonIDClientID(webPersonID)
    {
        return '<%=  txtHiddenWebPersonID.ClientID %>';
    }
	function SetSelected(grid, includeAll)
	{
		if(includeAll)
		{
			//gridAvailableRole.clearSelectionAll();			
			var startRow = grid.Rows.rows[0];
			var endRow = grid.Rows.getRowById(grid.Rows.getLastRowId());
			if (endRow == null) endRow = startRow;
			if(startRow != null && endRow != null) grid.selectRowRegion(startRow, endRow );
		}			 

	
	}	
	// create a function to move rows from available to assigned
	function AssignRoles(includeAll)
	{
		//first get the ClientID
		var gridAvailableRoleClientID; 
		var gridAssignedRoleClientID;
        gridAvailableRoleClientID = GetGridAvailableRolesClientID();	
        gridAssignedRoleClientID = GetGridSelectedRolesClientID();
        	                                          
		//Now get the reference to the grid
		var gridAvailableRole = igtbl_getGridById(gridAvailableRoleClientID);
		var gridAssignedRole = igtbl_getGridById(gridAssignedRoleClientID);

	
		SetSelected(gridAvailableRole, includeAll);	
		
		for(var loopCount = 0; loopCount < gridAvailableRole.Rows.rows.length; loopCount++)
		{
			//if(includeAll) gridAvailableRole.Rows.rows[loopCount].setSelected(true);
			var availableRow = gridAvailableRole.Rows.rows[loopCount];
			
			
			if(availableRow != null)
			{
				if(availableRow.getSelected())
				{
					var newRow = igtbl_addNew(										
										gridAssignedRole.Id, //grid id string
										availableRow.Band.Index, //bandNo
										true, 
										true);	
					
					//set the first column RoleName
					newRow.getCell(2).setValue(availableRow.getCell(1).getValue());
					
					//set the second column Role ID
					newRow.getCell(1).setValue(availableRow.getCell(0).getValue());
					
					//set the second column WebPersonID
					var webPersonIDClientID;
					webPersonIDClientID = GettxtHiddenWebPersonIDClientID();

					var webPersonID = document.getElementById(webPersonIDClientID);
					newRow.getCell(0).setValue(webPersonID.value);
				
				}				
			}
			
		}
		//call the function to remove/delete the rows
		RemoveSelected(gridAvailableRole);
			
	}
	// create a function to remove rows from assigned and add available
	function RemoveRoles(includeAll)
	{
		
		//first get the ClientID
		//first get the ClientID
		var gridAvailableRoleClientID; 
		var gridAssignedRoleClientID;
        gridAvailableRoleClientID = GetGridAvailableRolesClientID();	
        gridAssignedRoleClientID = GetGridSelectedRolesClientID();
        	                                          
		//Now get the reference to the grid
		var gridAvailableRole = igtbl_getGridById(gridAvailableRoleClientID);
		var gridAssignedRole = igtbl_getGridById(gridAssignedRoleClientID);

        SetSelected(gridAssignedRole, includeAll);					
        
		for(var loopCount = 0; loopCount < gridAssignedRole.Rows.rows.length; loopCount++)
		{
			var assignedRow = gridAssignedRole.Rows.rows[loopCount];
			
			
			if(assignedRow != null)
			{
				if(assignedRow.getSelected())
				{
					var newRow = igtbl_addNew(										
										gridAvailableRole.Id, //grid id string
										assignedRow.Band.Index, //bandNo
										true, 
										true);	
					
					//set the first column Role ID
					newRow.getCell(0).setValue(assignedRow.getCell(1).getValue());
					
					
					//set the second column RoleName
					newRow.getCell(1).setValue(assignedRow.getCell(2).getValue());
					
					//set the second column WebPersonID					
					newRow.getCell(2).setValue(0);
					
					//remove the role from the available list.
					//availableRow.remove();
				}				
			}
			
		}
		//call the function to remove/delete the rows
		RemoveSelected(gridAssignedRole);
			
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
	// btnAssignSelectedRoles
	function btnAssignSelectedRoles_Click()
	{
		AssignRoles(false);

	
	}
	
	//btnAssignAllRoles
	function btnAssignAllRoles_Click()
	{
		//set includeAll to true because all rows should assigned
		AssignRoles(true);
	}
	
	//btnRemoveSelectedRoles
	function btnRemoveAllRoles_Click()
	{
		RemoveRoles(true);
	}
	
	//btnRemoveAllRoles
	function btnRemoveSelectedRoles_Click()
	{
		RemoveRoles(false);
	}
	
	
	

// -->
</script>
<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD colSpan="3">
		    <STATTRAC:SECTIONHEADER id="addEditUserDetail" ButtonOneSuppressConfirmation="False" ButtonTwoConfirmationMessage="Are you sure?"
				Width="100%" CssClass="SectionHeader" Text="Add/Edit User Detail" runat="server"></STATTRAC:SECTIONHEADER></TD>
	</TR>
	<tr>
		<td style="width: 1033px">
			<table style="WIDTH: 1016px; HEIGHT: 420px">
				<tr>
					<td style="WIDTH: 206px" align="left"><asp:checkbox id="chkBoxInactive" Text="Inactive" runat="server" OnCheckedChanged="chkBoxInactive_CheckedChanged"></asp:checkbox></td>
					<td style="WIDTH: 210px"></td>
					<td></td>
					<td style="WIDTH: 142px"></td>
					<td style="WIDTH: 234px"></td>
					<td style="width: 169px"></td>
				</tr>
				<tr>
					<td style="WIDTH: 206px" align="right">User Name:
						<asp:RequiredFieldValidator id="validatorUserNameRequired" runat="server" ErrorMessage="User Name is a required field"
							ControlToValidate="txtBoxUserName">*</asp:RequiredFieldValidator></td>
					<td style="WIDTH: 210px"><asp:textbox id="txtBoxUserName" Width="200px" runat="server" MaxLength="15"></asp:textbox></td>
					<td></td>
					<td style="WIDTH: 142px" align="right">First Name:
						<asp:RequiredFieldValidator id="validatorFirstNameRequired" runat="server" ErrorMessage="First Name is a required field"
							ControlToValidate="txtBoxFirstName">*</asp:RequiredFieldValidator>
					</td>
					<td style="WIDTH: 234px"><asp:textbox id="txtBoxFirstName" Width="200px" runat="server" MaxLength="50"></asp:textbox></td>
					<td style="width: 169px"></td>
				</tr>
				<tr>
					<td style="WIDTH: 206px" align="right">Password:
						<asp:RegularExpressionValidator id="validatorPasswordLength" runat="server" ErrorMessage="Password must be between 8 and 20 Characters"
							ControlToValidate="txtBoxPassword" ValidationExpression=".{8,20}">*</asp:RegularExpressionValidator></td>
					<TD style="WIDTH: 210px">
						<asp:textbox id="txtBoxPassword" Width="200px" runat="server" TextMode="Password" CausesValidation="True"></asp:textbox></TD>
					<TD></TD>
					<TD style="WIDTH: 142px" align="right">Last Name:
						<asp:RequiredFieldValidator id="validatorLastNameRequired" runat="server" ErrorMessage="Last Name is a required field"
							ControlToValidate="txtBoxLastName">*</asp:RequiredFieldValidator></TD>
					<TD style="WIDTH: 234px">
						<asp:textbox id="txtBoxLastName" Width="200px" runat="server" MaxLength="50"></asp:textbox></TD>
					<TD style="width: 169px"></TD>
				</tr>
				<TR>
					<TD style="WIDTH: 206px; HEIGHT: 25px" align="right">Confirm Password:
						<asp:CompareValidator id="validatorPasswordMatch" runat="server" ErrorMessage="Password Confirm must match Password"
							ControlToValidate="txtBoxPasswordConfirm" ControlToCompare="txtBoxPassword">*</asp:CompareValidator></TD>
					<TD style="WIDTH: 210px; HEIGHT: 25px"><asp:textbox id="txtBoxPasswordConfirm" Width="200px" runat="server" TextMode="Password" CausesValidation="True"></asp:textbox></TD>
					<td style="HEIGHT: 25px"></td>
					<td style="WIDTH: 142px; HEIGHT: 25px" align="right">Title:
						<asp:RangeValidator id="validatorTitleRequired" runat="server" ErrorMessage="Title is a required field"
							ControlToValidate="ddlPersonType" MinimumValue="1" MaximumValue="integer.MaxValue()">*</asp:RangeValidator></td>
					<td style="WIDTH: 234px; HEIGHT: 25px">
                        
                        <stattrac:dropdownpersontype id="ddlPersonType" Width="232px" runat="server" DefaultText="..."></stattrac:dropdownpersontype></td>
					<td style="width: 169px"></td>
				</TR>
				<tr>
					<td style="WIDTH: 206px; HEIGHT: 20px"></td>
					<td style="WIDTH: 210px; HEIGHT: 20px"></td>
					<td style="HEIGHT: 20px"></td>
					<td style="WIDTH: 142px; HEIGHT: 20px" align="right">Organization:
						<asp:RangeValidator id="validatorOrganizationRequired" runat="server" ErrorMessage="Organization is a required Field"
							ControlToValidate="ddlOrganization" MinimumValue="1" MaximumValue="integer.MaxValue()">*</asp:RangeValidator></td>
					<td style="HEIGHT: 20px" colSpan="2"><stattrac:dropdownreportorganization id="ddlOrganization" Width="400px" runat="server" DefaultText="..."></stattrac:dropdownreportorganization></td>
				</tr>
				<tr>
					<td style="WIDTH: 206px"></td>
					<td style="WIDTH: 210px" vAlign="bottom"><igtbl:ultrawebgrid id=gridAvailableRoles Width="230px" runat="server" Height="230px" DataSource="<%# dsUserData %>" DataMember="Roles">
							<Bands>
								<igtbl:UltraGridBand SelectTypeCell="Extended" AddButtonCaption="Roles" BaseTableName="Roles" SelectTypeRow="Extended"
									Key="Roles" CellClickAction="RowSelect" AllowDelete="Yes">
									<Columns>
                                        <igtbl:UltraGridColumn BaseColumnName="RoleID" DataType="System.Int32" Hidden="True"
                                            IsBound="True" Key="RoleID">
                                            <Header Caption="RoleID">
                                            </Header>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="RoleName" IsBound="True" Key="RoleName" Width="225px">
                                            <Header Caption="Available Roles">
                                                <RowLayoutColumnInfo OriginX="1" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="1" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="Inactive" DataType="System.Int16" Hidden="True"
                                            IsBound="True" Key="Inactive">
                                            <Header Caption="Inactive">
                                                <RowLayoutColumnInfo OriginX="2" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="2" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
									</Columns>
									<SelectedRowStyle BorderColor="Firebrick"></SelectedRowStyle>
                                    <AddNewRow View="NotSet" Visible="NotSet">
                                    </AddNewRow>
								</igtbl:UltraGridBand>
							</Bands>
							<DisplayLayout AllowDeleteDefault="Yes" StationaryMarginsOutlookGroupBy="True" AllowAddNewDefault="Yes"
								RowHeightDefault="20px" Version="4.00" SelectTypeRowDefault="Single" CellSpacingDefault="1"
								RowSelectorsDefault="No" Name="ctl00xgridAvailableRoles" TableLayout="Fixed">
								<AddNewBox>
                                    <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                    </BoxStyle>
								</AddNewBox>
								<Pager>
                                    <PagerStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                    </PagerStyle>
								</Pager>
								<HeaderStyleDefault BorderColor="Black" BorderStyle="Solid" ForeColor="White" BackColor="#6E1515">
									<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
								</HeaderStyleDefault>
								<FrameStyle Width="230px" Cursor="Default" BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana"
									BorderStyle="None" ForeColor="#A37171" Height="230px"></FrameStyle>
								<FilterOptionsDefault>
									<FilterDropDownStyle Width="200px" BorderWidth="1px" Font-Size="11px" Font-Names="Verdana,Arial,Helvetica,sans-serif"
										BorderColor="Silver" BorderStyle="Solid" BackColor="White" CustomRules="overflow:auto;">
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
								<SelectedRowStyleDefault ForeColor="White" BackColor="#A10B0B"></SelectedRowStyleDefault>
								<RowStyleDefault BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana" BorderColor="Silver" BorderStyle="Solid"
									BackColor="#DBCACA">
									<Padding Left="3px"></Padding>
									<BorderDetails ColorTop="219, 202, 202" ColorLeft="219, 202, 202"></BorderDetails>
								</RowStyleDefault>
							</DisplayLayout>
						</igtbl:ultrawebgrid></td>
					<td vAlign="bottom"></td>
					<td style="WIDTH: 142px" vAlign="middle">
						<P align="center"><INPUT id="btnAssignSelectedRoles" style="WIDTH: 30px; HEIGHT: 24px" onclick="javascript:btnAssignSelectedRoles_Click();"
								type="button" value=">"></P>
						<P align="center"><INPUT id="btnAssignAllRoles" style="WIDTH: 30px; HEIGHT: 24px" onclick="javascript:btnAssignAllRoles_Click();"
								type="button" value=">>"></P>
						<P align="center"><INPUT id="btnRemoveAllRoles" style="WIDTH: 30px; HEIGHT: 24px" onclick="javascript:btnRemoveAllRoles_Click();"
								type="button" value="<<"></P>
						<P align="center"><INPUT id="btnRemoveSelectedRoles" style="WIDTH: 30px; HEIGHT: 24px" onclick="javascript:btnRemoveSelectedRoles_Click();"
								type="button" value="<"></P>
					</td>
					<td style="WIDTH: 234px" vAlign="bottom"><igtbl:ultrawebgrid id=gridSelectedRoles Width="230px" runat="server" Height="230px" DataSource="<%# dsUserData %>" DataMember="UserRoles">
							<Bands>
								<igtbl:UltraGridBand SelectTypeCell="Extended" AddButtonCaption="UserRoles" BaseTableName="UserRoles"
									SelectTypeRow="Extended" Key="UserRoles" CellClickAction="RowSelect" AllowDelete="Yes">
									<Columns>
                                        <igtbl:UltraGridColumn BaseColumnName="WebPersonID" DataType="System.Int32" Hidden="True"
                                            IsBound="True" Key="WebPersonID">
                                            <Header Caption="WebPersonID">
                                            </Header>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="RoleID" DataType="System.Int32" Hidden="True"
                                            IsBound="True" Key="RoleID">
                                            <Header Caption="RoleID">
                                                <RowLayoutColumnInfo OriginX="1" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="1" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
                                        <igtbl:UltraGridColumn BaseColumnName="RoleName" IsBound="True" Key="RoleName" Width="225px">
                                            <Header Caption="Selected Roles">
                                                <RowLayoutColumnInfo OriginX="2" />
                                            </Header>
                                            <Footer>
                                                <RowLayoutColumnInfo OriginX="2" />
                                            </Footer>
                                        </igtbl:UltraGridColumn>
									</Columns>
									<SelectedRowStyle BorderColor="Firebrick"></SelectedRowStyle>
                                    <AddNewRow View="NotSet" Visible="NotSet">
                                    </AddNewRow>
								</igtbl:UltraGridBand>
							</Bands>
							<DisplayLayout AllowDeleteDefault="Yes" StationaryMarginsOutlookGroupBy="True" AllowAddNewDefault="Yes"
								RowHeightDefault="20px" Version="4.00" SelectTypeRowDefault="Single" CellSpacingDefault="1"
								RowSelectorsDefault="No" Name="ctl00xgridSelectedRoles" TableLayout="Fixed">
								<AddNewBox>
                                    <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                    </BoxStyle>
								</AddNewBox>
								<Pager>
                                    <PagerStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                    </PagerStyle>
								</Pager>
								<HeaderStyleDefault BorderColor="Black" BorderStyle="Solid" ForeColor="White" BackColor="#6E1515">
									<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
								</HeaderStyleDefault>
								<FrameStyle Width="230px" Cursor="Default" BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana"
									BorderStyle="None" ForeColor="#A37171" Height="230px"></FrameStyle>
								<FilterOptionsDefault>
									<FilterDropDownStyle Width="200px" BorderWidth="1px" Font-Size="11px" Font-Names="Verdana,Arial,Helvetica,sans-serif"
										BorderColor="Silver" BorderStyle="Solid" BackColor="White" CustomRules="overflow:auto;">
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
								<SelectedRowStyleDefault ForeColor="White" BackColor="#A10B0B"></SelectedRowStyleDefault>
								<RowStyleDefault BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana" BorderColor="Silver" BorderStyle="Solid"
									BackColor="#DBCACA">
									<Padding Left="3px"></Padding>
									<BorderDetails ColorTop="219, 202, 202" ColorLeft="219, 202, 202"></BorderDetails>
								</RowStyleDefault>
							</DisplayLayout>
						</igtbl:ultrawebgrid></td>
					<td vAlign="bottom" style="width: 169px"><asp:button id="btnSave" Width="65px" Text="Save" runat="server" onclick="btnSave_Click"></asp:button><asp:button id="btnCancel" Width="65px" Text="Cancel" runat="server" onclick="btnCancel_Click" CausesValidation="false"></asp:button></td>
				</tr>
				<tr>
					<td style="WIDTH: 206px"><INPUT id="txtHiddenWebPersonID" style="WIDTH: 72px; HEIGHT: 22px" type="hidden" 
							runat="server"></td>
					<td style="WIDTH: 210px"></td>
					<td></td>
					<td style="WIDTH: 142px"></td>
					<td style="WIDTH: 234px"></td>
					<td style="width: 169px"></td>
				</tr>
			</table>
			<P>&nbsp;</P>
		</td>
	</tr>
</TABLE>
