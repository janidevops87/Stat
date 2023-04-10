<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsRegistryZipCode.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsRegistryZipCode" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Src="CustomParamsRegistryStateControl.ascx" TagName="CustomParamsRegistryStateControl"
    TagPrefix="uc1" %>
<script id="igClientScript" type="text/javascript">
<!--
function getgridSelectedZipCodeCityRegionId()
{
     return '<%= gridSelectedZipCodeCityRegion.ClientID %>';
}
function gridZipCodeCityRegion_ColumnHeaderClickHandler(gridName, columnId, button)
{
	    var column = igtbl_getColumnById(columnId);
	    if (column.Key != "checked")
	        return;
	    var grid = igtbl_getGridById(gridName);
	    var setCheckValue;
	    //get first row
	    var row = grid.Rows.getRow(0);
	    var rowGridSelected;
	    var firstRow = 0

	    while(row != null)
	    {
	        if(row.getHidden() != true)
	        {
	            if(firstRow == 0)
	            {
	                if(row.getCell(0).getValue() == true)
	                    setCheckValue = false;
	                else
	                    setCheckValue = true;
	                firstRow = 1;
	            }
	            row.setSelected(true);
	            row.getCell(0).setValue(setCheckValue);	            

                if(setCheckValue==true)
                {
                    gridAddNewRows(row);                    
                }
                row.setSelected(false);
	        }        
	        
	        row = row.getNextRow(false);
	    }	
	}


    function gridSelectedZipCodeCityRegion_ColumnHeaderClickHandler(gridName, columnId, button)
    {
	    var grid = igtbl_getGridById(gridName);
	
		var startRow = grid.Rows.rows[0];
		var endRow = grid.Rows.getRowById(grid.Rows.getLastRowId());
		if (endRow == null) endRow = startRow;
		if(startRow != null && endRow != null) grid.selectRowRegion(startRow, endRow );

	    for(var rowId in grid.SelectedRows)
		{
		    var row=igtbl_getRowById(rowId);
		    row.deleteRow();
		}	
	}
    function gridAddNewRows(row)
    {
	        var gridSelected = igtbl_getGridById(getgridSelectedZipCodeCityRegionId());
               
                      var rowGridSelected = igtbl_addNew(										
										    gridSelected.Id, //grid id string
                                            row.Band.Index, //bandNo
										    true, 
										    true);
				    //rowGridSelected.setSelected(true);							
				    //rowGridSelected.getCell(0).setEditable(true);		            
	                rowGridSelected.getCell(0).setValue(row.getCell(0).getValue());
	                //rowGridSelected.getCell(1).setEditable(true);	
	                rowGridSelected.getCell(1).setValue(row.getCell(1).getValue());
	                rowGridSelected.getCell(2).setValue(row.getCell(2).getValue());
                    rowGridSelected.getCell(3).setValue(row.getCell(3).getValue());
                    //rowGridSelected.setSelected(false);
     
    }
	


function gridZipCodeCityRegion_CellClickHandler(gridName, cellId, button){
	var grid = igtbl_getGridById(gridName);
	var cell = igtbl_getCellById(cellId);
	var changedRow;
	if(cell.Index == 0)
	{
	        changedRow = grid.Rows.getRow(cell.Row.getIndex());
	        //igtbl_getRowById(cell.Row.Id);	        
	        changedRow.setSelected(true);	    
	        changedRow.getCell(0).setValue(true);	 
	        gridAddNewRows(changedRow);
	        
	        changedRow.setSelected(false);
	}
}

function gridSelectedZipCodeCityRegion_CellChangeHandler(gridName, cellId){
	var grid = igtbl_getGridById(gridName);
	var cell = igtbl_getCellById(cellId);
	var changedRow;
	if(cell.Index == 0)
	{    
	        cell.Row.deleteRow();
	}
}
// -->
</script>
<div class="SectionSeperator">

    <uc1:CustomParamsRegistryStateControl  ID="customParamsRegistryStateControZC" runat="server" />
</div>
<div class="SectionSeperator" >

    <div class="ParamControlLabel">
        <asp:Label ID="Label1" runat="server" Text="Zip Code Options:"></asp:Label>
    </div>
    <div class="ParamControl">
        <asp:RadioButtonList ID="radioButtonZipCodeOptions" runat="server" AutoPostBack="True" OnTextChanged="radioButtonZipCodeOptions_TextChanged" TextAlign="Right">
           <asp:ListItem Value="1" Selected="True" Text="Top 10 Highest and Lowest Producing Zip Codes"></asp:ListItem>
           <asp:ListItem Value="3" Text="All Zip Codes"></asp:ListItem>
           <asp:ListItem Value="2" Text="Many Zip Codes"></asp:ListItem>
        </asp:RadioButtonList>&nbsp;
    </div>
</div>
<div ID="PnlZipCodeCityRegion" runat="server">
    <div class="SectionSeperator" >
    
        <div class="ParamControlLabel">
        Selected Zip Codes:
        </div>        
        <div class="ParamControl">

    <%--        <asp:Panel ID="PnlZipCodeCityRegion" runat="server" Height="225px" Width="125px" Visible="False">                     
                <asp:Panel ID="pnlInnerZipCodeRegion" runat="server" Height="61px" Width="188px" Visible="True" GroupingText="Selected Zip Codes">
    --%>
                            <igtbl:UltraWebGrid ID="gridSelectedZipCodeCityRegion" runat="server"  DataSource="<%# dsSelectedRegData %>"  DataMember="ZipCodeCityRegion"
                                Height="112px" OnInitializeDataSource="gridSelectedZipCodeCityRegion_InitializeDataSource"
                                Width="438px">
                                <Bands>
                                    <igtbl:UltraGridBand AddButtonCaption="ZipCodeCityRegion" BaseTableName="ZipCodeCityRegion"
                                        Key="ZipCodeCityRegion" AllowUpdate="Yes" AllowDelete="No">
                                        <Columns>
                                            <igtbl:UltraGridColumn BaseColumnName="checked" DataType="System.Boolean" IsBound="True"
                                                Key="checked" Type="CheckBox" AllowUpdate="Yes">
                                                <Header Caption="Checked">
                                                </Header>
                                            </igtbl:UltraGridColumn>
                                            <igtbl:UltraGridColumn BaseColumnName="ZipCode" IsBound="True" Key="ZipCode">
                                                <Header Caption="Zip Code">
                                                    <RowLayoutColumnInfo OriginX="1" />
                                                </Header>
                                                <Footer>
                                                    <RowLayoutColumnInfo OriginX="1" />
                                                </Footer>
                                            </igtbl:UltraGridColumn>
                                            <igtbl:UltraGridColumn BaseColumnName="City" IsBound="True" Key="City">
                                                <Header Caption="City">
                                                    <RowLayoutColumnInfo OriginX="2" />
                                                </Header>
                                                <Footer>
                                                    <RowLayoutColumnInfo OriginX="2" />
                                                </Footer>
                                            </igtbl:UltraGridColumn>
                                            <igtbl:UltraGridColumn BaseColumnName="State" IsBound="True" Key="State">
                                                <Header Caption="State">
                                                    <RowLayoutColumnInfo OriginX="3" />
                                                </Header>
                                                <Footer>
                                                    <RowLayoutColumnInfo OriginX="3" />
                                                </Footer>
                                            </igtbl:UltraGridColumn>
                                        </Columns>
                                        <AddNewRow View="NotSet" Visible="NotSet">
                                        </AddNewRow>
                                    </igtbl:UltraGridBand>
                                </Bands>
                                <DisplayLayout CellSpacingDefault="1" Name="ctl00xgridSelectedZipCodeCityRegion" RowHeightDefault="20px"
                                    RowSelectorsDefault="No" SelectTypeRowDefault="Single" StationaryMarginsOutlookGroupBy="True"
                                    TableLayout="Fixed" Version="4.00" AllowAddNewDefault="Yes" AllowUpdateDefault="Yes" AllowDeleteDefault="Yes">
                                    <FrameStyle BorderStyle="None" BorderWidth="1px" Cursor="Default" Font-Names="Verdana"
                                        Font-Size="8pt" ForeColor="#A37171" Height="112px" Width="438px">
                                    </FrameStyle>
                                    <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                    </FooterStyleDefault>
                                    <HeaderStyleDefault BackColor="#6E1515" BorderColor="Black" BorderStyle="Solid" ForeColor="White">
                                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                                    </HeaderStyleDefault>
                                    <RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        Font-Names="Verdana" Font-Size="8pt">
                                        <Padding Left="3px" />
                                        <BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202" />
                                    </RowStyleDefault>
                                    <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
                                    </SelectedRowStyleDefault>
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
                                    <ClientSideEvents CellChangeHandler="gridSelectedZipCodeCityRegion_CellChangeHandler" ColumnHeaderClickHandler="gridSelectedZipCodeCityRegion_ColumnHeaderClickHandler" />
                                </DisplayLayout>
                            </igtbl:UltraWebGrid>
        </div>  
    </div>
                              
    <%--            </asp:Panel>                             
                <asp:Panel ID="Panel1" runat="server" Height="98px" Width="125px" Visible="True" GroupingText="Zip Code List">
    --%> 
    <div class="SectionSeperator" >
        <div class="ParamControlLabel">
        Zip Code List:
        </div>
        <div class="ParamControl">
                
                    <igtbl:ultrawebgrid id="gridZipCodeCityRegion" runat="server" Height="179px" 
                        Width="438px"  Browser="Xml" 
                        OnInitializeDataSource="gridZipCodeCityRegion_InitializeDataSource" 
                        DataSource="<%# dsRegData %>"  DataMember="ZipCodeCityRegion" 
                        oninitializelayout="gridZipCodeCityRegion_InitializeLayout"><Bands>
        <igtbl:UltraGridBand AddButtonCaption="ZipCodeCityRegion" BaseTableName="ZipCodeCityRegion" Key="ZipCodeCityRegion" ColHeadersVisible="Yes" AllowDelete="No">
        <AddNewRow Visible="NotSet" View="NotSet"></AddNewRow>
            <Columns>
                <igtbl:UltraGridColumn AllowRowFiltering="False" AllowUpdate="Yes" BaseColumnName="checked"
                    DataType="System.Boolean" IsBound="True" Key="checked" Type="CheckBox">
                    <Header Caption="Checked">
                    </Header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ZipCode" IsBound="True" Key="ZipCode">
                    <Header Caption="Zip Code">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="City" IsBound="True" Key="City">
                    <Header Caption="City">
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="State" IsBound="True" Key="State">
                    <Header Caption="State">
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
            </Columns>
        </igtbl:UltraGridBand>
        </Bands>

        <DisplayLayout Version="4.00" SelectTypeRowDefault="Single" Name="ctl00xgridZipCodeCityRegion" RowHeightDefault="20px" TableLayout="Fixed" StationaryMarginsOutlookGroupBy="True" CellSpacingDefault="1" RowSelectorsDefault="No" AllowUpdateDefault="Yes" SelectTypeCellDefault="Extended" LoadOnDemand="Xml">
        <FrameStyle BorderWidth="1px" BorderStyle="None" Font-Names="Verdana" Font-Size="8pt" Cursor="Default" ForeColor="#A37171" Height="179px" Width="438px"></FrameStyle>

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

        <FilterOptionsDefault AllowRowFiltering="OnServer" FilterUIType="FilterRow">
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
            <ClientSideEvents ColumnHeaderClickHandler="gridZipCodeCityRegion_ColumnHeaderClickHandler" CellChangeHandler="gridZipCodeCityRegion_CellClickHandler" />
        </DisplayLayout>
        </igtbl:ultrawebgrid>
        </div>
    </div>
</div>

<%--            </asp:Panel>
        </asp:Panel>             --%>                          
          <asp:ObjectDataSource ID="odsZipCodeCityRegion" runat="server"
              SelectMethod="FillRegistryZipCodeCityRegion" TypeName="Statline.Registry.Reports.RegistryReferenceManager" CacheExpirationPolicy="Sliding" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}" EnableCaching="True" OnSelecting="odsZipCodeCityRegion_Selecting">
              <SelectParameters>
                  <asp:Parameter Name="state" Type="String" />
              </SelectParameters>
          </asp:ObjectDataSource>
          <asp:TextBox ID="txtBoxZipCode" runat="server" Visible="False"></asp:TextBox>

