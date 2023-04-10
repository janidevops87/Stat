<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsEmployeeControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsEmployeeControl" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>


<div class="SectionSeperator" >
    <div class="ParamControlLabel">
        <asp:RadioButtonList ID="radioButtonEmployeeOptions" runat="server" AutoPostBack="True"  TextAlign="Right" Width="110px" RepeatDirection="Horizontal" OnSelectedIndexChanged="radioButtonEmployeeOptions_SelectedIndexChanged">
           <asp:ListItem Value="1" Selected="True" Text="All"></asp:ListItem>
           <asp:ListItem Value="2" Text="Many"></asp:ListItem>
        </asp:RadioButtonList>
        <asp:CheckBox ID="CheckBox1" runat="server"  TextAlign="Right" Text="Hide Employee" Width="120px" Visible="False" />
    </div>
</div>
<div class="SectionSeperator" >
<div class="ParamControlLabel">
    <asp:Label ID="Label4" runat="server"  Text="Organization:" Visible="False"></asp:Label>
</div>
<div class="ParamControl">
<igcmbo:WebCombo ID="ddlOrganization" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" DataSourceID="odsOrgs"
            DataTextField="OrganizationName" DataValueField="OrganizationID" Editable="True"
            EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue"
            SelForeColor="White" Width="315px" OnSelectedRowChanged="ddlOrganization_SelectedRowChanged" Visible="False" OnInitializeLayout="ddlOrganization_InitializeLayout">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="Databound Col0" IsBound="True" Key="Databound Col0">
                    <header caption="Databound Col0"></header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="Databound Col1" DataType="System.Int32" IsBound="True"
                    Key="Databound Col1">
                    <header caption="Databound Col1">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="Databound Col2" IsBound="True" Key="Databound Col2">
                    <header caption="Databound Col2">
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
            </Columns>
            <ExpandEffects ShadowColor="LightGray" />
             <DropDownLayout BaseTableName="" ColHeadersVisible="No" ColWidthDefault="315px" DropdownWidth="315px"
            GridLines="None" RowSelectors="No" Version="4.00" XmlLoadOnDemandType="Accumulative">
            <FrameStyle Height="130px" Width="315px">
            </FrameStyle>
            <RowStyle BackColor="White" BorderColor="Gray" />
        </DropDownLayout>
        </igcmbo:WebCombo>
</div></div>
<div class="SectionSeperator" >
<div class="ParamControlLabel">
        <asp:Label ID="Label3" runat="server" Text="Title:" Visible="False"></asp:Label>&nbsp;<br />
</div>
<div class="ParamControl">
        <igcmbo:WebCombo ID="ddlPersonType" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" Editable="True"
            EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue"
            SelForeColor="White" Width="315px" OnSelectedRowChanged="ddlPersonType_SelectedRowChanged" Visible="False" DataSourceID="odsPersonType" DataTextField="PersonTypeName" DataValueField="PersonTypeId" OnInitializeLayout="ddlPersonType_InitializeLayout">
                <Columns>
                    <igtbl:UltraGridColumn Hidden=true BaseColumnName="PersonID" DataType="System.Int32" IsBound="True" 
                        Key="PersonID">
                        <header caption="PersonID"></header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="PersonName" IsBound="True" Key="PersonName">
                        <header caption="PersonName">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="PersonTypeID" DataType="System.Int32" IsBound="True"
                        Key="PersonTypeID">
                        <header caption="PersonTypeID">
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="PersonTitle" IsBound="True" Key="PersonTitle">
                        <header caption="PersonTitle">
<RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
</header>
                        <footer>
<RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
</footer>
                    </igtbl:UltraGridColumn>
                </Columns>
                <ExpandEffects ShadowColor="LightGray" />
                <DropDownLayout BaseTableName="" ColHeadersVisible="No" ColWidthDefault="315px" DropdownWidth="315px"
            GridLines="None" RowSelectors="No" Version="4.00" XmlLoadOnDemandType="Accumulative">
                    <FrameStyle Height="130px" Width="315px">
                    </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
            </igcmbo:WebCombo>  
</div>
</div>
<div class="SectionSeperator" >
         <fieldset id="EmployeeSelection" runat="server" visible="false" style="width:465px; position:relative; left:170px;">
            <legend>Employee Selection</legend>            
        <div class="ParamControlLabel" style="margin-left:5px; text-align:left">
            <asp:ListBox ID="lbSelectedPersons" runat="server" Height="124px" Width="439px">
            </asp:ListBox>
        </div>
        <div class="ParamControl">
              
                    <igtbl:ultrawebgrid id="gridEmployees" runat="server" Height="179px" Width="400px"  Browser="Xml" Visible="False" DataSourceID="odsEmployees" ><Bands>
        <igtbl:UltraGridBand AddButtonCaption="PersonTitleList" BaseTableName="PersonTitleList" Key="PersonTitleList" ColHeadersVisible="Yes" AllowDelete="No">
        <AddNewRow Visible="NotSet" View="NotSet"></AddNewRow>
            <Columns>
                <igtbl:UltraGridColumn AllowUpdate="Yes" BaseColumnName="checked" Width=30px
                    DataType="System.Boolean" IsBound="True" Key="checked" Type="CheckBox">
                    
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="PersonName" IsBound="True" Key="PersonName" Width=170px>
                    <Header Caption="PersonName">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="PersonTitle" IsBound="True" Key="PersonTitle" Width=170px>
                    <Header Caption="PersonTitle">
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="PersonID" IsBound="True" Key="PersonID" Width=170px Hidden="true">
                   
                </igtbl:UltraGridColumn>
            </Columns>
        </igtbl:UltraGridBand>
        </Bands>

        <DisplayLayout Version="4.00" SelectTypeRowDefault="Single" Name="ctl00xgridEmployees" RowHeightDefault="20px" TableLayout="Fixed" StationaryMarginsOutlookGroupBy="True" CellSpacingDefault="1" RowSelectorsDefault="No" AllowUpdateDefault="Yes" SelectTypeCellDefault="Extended" AllowColSizingDefault="Free" >
        <FrameStyle BorderWidth="1px" BorderStyle="None" Font-Names="Verdana" Font-Size="8pt" Cursor="Default" ForeColor="#A37171" Height="179px" Width="395px"></FrameStyle>

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

        
            <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
            </SelectedRowStyleDefault>
            
        </DisplayLayout>
        </igtbl:ultrawebgrid>
        <p>
                    <asp:Button ID="btnAddSelection" runat="server" onclick="btnAddSelection_Click" 
                        Text="Add to Selection" Visible="False" />
                    <asp:Button ID="btnReset" runat="server" onclick="btnReset_Click" 
                        Text="Reset" Visible="False" />
         </p>
        </div>
        </fieldset>
        <asp:ObjectDataSource ID="odsPersonType" runat="server" EnableViewState="False" SelectMethod="FillPersonTitleListQA" TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" OnSelecting="odsPersonType_Selecting">
            <SelectParameters>
                <asp:Parameter DefaultValue="194" Name="organizationID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsOrgs" runat="server" EnableCaching="True" SelectMethod="FillOrganzationList"
            TypeName="Statline.StatTrac.Schedule.ScheduleManager" OnSelecting="odsOrgs_Selecting">
            <SelectParameters>
                <asp:Parameter DefaultValue="194" Name="userOrgID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsEmployees" runat="server" SelectMethod="FillPersonTitleList"
        TypeName="Statline.StatTrac.Report.ReportReferenceManager" OnSelecting="odsEmployees_Selecting">
        <SelectParameters>
            <asp:Parameter DefaultValue="194" Name="organizationId" Type="Int32" />
            <asp:Parameter Name="personTypeID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </div>
