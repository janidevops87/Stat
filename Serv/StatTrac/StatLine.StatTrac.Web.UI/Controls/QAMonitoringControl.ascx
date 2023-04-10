<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAMonitoringControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAMonitoringControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<stattrac:sectionheader id="sectionHeaderQAConfig" runat="server" text="Quality Monitoring Forms"
    width="100%"></stattrac:sectionheader>
<div id="divQAModuleVersion" runat="server" class="Section"></div>
<div style="position: relative; width: 1050px; height: 125px; left: 0px; top: 0px; z-index: 102;" id="divMain">
    <asp:Label ID="lblQualityMonitorForm" runat="server" Style="z-index: 100; left: 5px; position: absolute;
        top: 40px" Text="Quality Monitoring Form:"></asp:Label>
    <asp:Label ID="lblTrackingNumber" runat="server" Style="z-index: 101; left: 50px; position: absolute;
        top: 70px" Text="Tracking Number:"></asp:Label>
    <asp:Label ID="lblOrganization" runat="server" Style="z-index: 102; left: 79px; position: absolute;
        top: 13px" Text="Organization:"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Style="z-index: 103; left: 95px; position: absolute;
        top: 95px" Text="Employee:"></asp:Label>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
    <asp:TextBox ID="txtTrackingNumber" runat="server" Height="25px" Style="z-index: 104;
        left: 165px; position: absolute; top: 65px" Width="95px" TabIndex="3" MaxLength="20"></asp:TextBox>
    <asp:Button ID="btnAddTrackingNumber" runat="server" Style="z-index: 105; left: 270px;
        position: absolute; top: 65px" Text="Add Tracking #" Width="140px" OnClick="btnAddTrackingNumber_Click" Enabled="False" />
    <asp:Button ID="btnAddNewEmployee" runat="server" Style="z-index: 106; left: 415px;
        position: absolute; top: 95px" Text="..." OnClientClick="window.open('PersonData.aspx','_blank')" />
    <asp:Button ID="btnSearch" runat="server" Style="z-index: 107; left: 440px; position: absolute;
        top: 95px" Text="Search" OnClick="btnSearch_Click" TabIndex="5" />
    <igcmbo:WebCombo ID="ddlOrganization" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="245px"
        SelForeColor="White" Style="z-index: 108; left: 165px; position: absolute; top: 10px"
        Version="4.00" ComboTypeAhead="Suggest" DataSourceID="odsOrg" Editable="True" EnableXmlHTTP="True" OnInitializeLayout="ddlOrganization_InitializeLayout" DataTextField="OrganizationName" DataValueField="OrganizationID" EnableAppStyling="True" OnPreRender="ddlOrganization_PreRender" TabIndex="1" OnSelectedRowChanged="ddlOrganization_SelectedRowChanged">
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
        <DropDownLayout Version="4.00" ColWidthDefault="245px" DropdownWidth="245px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="245px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
    </igcmbo:WebCombo>
    <igcmbo:WebCombo ID="ddlEmployee" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
    SelForeColor="White" Style="z-index: 109; left: 165px; position: absolute; top: 95px"
    Version="4.00" ComboTypeAhead="Suggest" DataSourceID="odsEmployee" Editable="True" EnableXmlHTTP="True" OnInitializeLayout="ddlEmployee_InitializeLayout" DataTextField="PersonName" DataValueField="PersonID" EnableAppStyling="True" TabIndex="4" Width="245px">
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
    <DropDownLayout Version="4.00" ColWidthDefault="245px" DropdownWidth="245px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="245px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
<igcmbo:WebCombo ID="ddlQAFormType" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
    SelForeColor="White" Style="z-index: 110; left: 165px; position: absolute; top: 35px"
    Version="4.00" ComboTypeAhead="Suggest" DataSourceID="odsForms" Editable="True" EnableXmlHTTP="True" OnInitializeLayout="ddlQAFormType_InitializeLayout" DataTextField="QAMonitoringFormName" DataValueField="QAMonitoringFormID" EnableAppStyling="True" TabIndex="2" Width="245px">
    <Columns>
        <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormID" IsBound="True" Key="QAMonitoringFormID">
            <header caption="QAMonitoringFormID"></header>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormName" IsBound="True" Key="QAMonitoringFormName">
            <header caption="QAMonitoringFormName">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
            <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
        </igtbl:UltraGridColumn>
    </Columns>
    <ExpandEffects ShadowColor="LightGray" />
    <DropDownLayout Version="4.00" ColWidthDefault="245px" DropdownWidth="245px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="245px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
    <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Style="z-index: 111;
        left: 415px; position: absolute; top: 65px" Text="Reset" />
    &nbsp;
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" OnClientClick="var agree=confirm('Are you sure you wish to continue?');if (agree) return true ; else return false ; "
        Style="z-index: 113; left: 505px; position: absolute; top: 65px" Text="Button" Visible="False" />
</div>
<hr style=" position: relative;  height: 5px; width: 613px; top: -2px; left: -488px;" 
    color="#990000" />
<div style="z-index: 104; left: 10px; width: 315px; position: relative;
    height: 65px; top: -3px;">
    <asp:Label ID="lblExistingQualityMonitoringFroms" runat="server"  Text="Existing Quality Monitoring Forms" Font-Bold="True" style="z-index: 100; left: 10px; position: absolute; top: 5px;"></asp:Label>
<asp:Button ID="btnAdd" runat="server"  Text="Add" Width="61px" style="z-index: 101;  position: absolute; top: 35px; left: 15px;" OnClick="btnAdd_Click" Enabled="False" />
</div>
<igtbl:UltraWebGrid ID="gridForms" runat="server" Height="365px" style="z-index: 103; left: 10px; position: relative ;" Width="520px" DataSourceID="odsGrid" >
    <Bands>
        <igtbl:UltraGridBand AddButtonCaption="QAMonitoringForm" BaseTableName="QAMonitoringForm" Key="QAMonitoringForm" AllowDelete="No">
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormID" DataType="System.Int32"
                    IsBound="True" Key="QAMonitoringFormID" Hidden="True">
                    <Header Caption="QAMonitoringFormID">
                    </Header>
                </igtbl:UltraGridColumn>
                <igtbl:TemplatedColumn BaseColumnName="LastModifiedString"  IsBound="True"
                    Key="LastModifiedString" Width="150px" >
                    <CellTemplate>
                           <asp:HyperLink ID="ErrorType" Enabled="true" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LastModifiedString") %> '
                             NavigateUrl='<%# "~/QAAddEditError.aspx?TrackingNumber=" + txtTrackingNumber.Text + "&EmployeeName=" + ddlEmployee.DisplayValue + "&EmployeeID=" + ddlEmployee.SelectedRow.Cells[0].Value +  "&FormID=" + ddlQAFormType.SelectedRow.Cells[0].Value + "&TrackingFormID=" + DataBinder.Eval(Container.DataItem,"QATrackingFormID") + "&CompletedBy=" + DataBinder.Eval(Container.DataItem,"CompletedBy") + "&New=" + 2 + "&TrackingID=" + DataBinder.Eval(Container.DataItem,"QATrackingID") %>'/>
                        </CellTemplate>
                    <Header Caption="Date/Time Entered">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:TemplatedColumn>
                <igtbl:UltraGridColumn BaseColumnName="QATrackingFormPoints" 
                    IsBound="True" Key="QATrackingFormPoints" Format="#0.0%">
                    <CellStyle HorizontalAlign=Center>
                    </CellStyle>
                    <Header Caption="Score %">
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="QAProcessStepDescription" IsBound="True" Key="QAProcessStepDescription" Width=200px>
                    <Header Caption="Process Step">
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
               <igtbl:UltraGridColumn BaseColumnName="CompletedBy" IsBound="True" Key="CompletedBy" Hidden="true" >
                    <Header Caption="">
                        <RowLayoutColumnInfo OriginX="4" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
               
               
            </Columns>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowDeleteDefault="Yes"
        AllowSortingDefault="OnClient" BorderCollapseDefault="Separate"
        HeaderClickActionDefault="SortMulti" Name="ctl00xgridForms" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Extended" StationaryMargins="Header"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" ViewType="OutlookGroupBy">
        <FrameStyle BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="365px"
            Width="520px" Cursor="Default" ForeColor="#A37171">
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
        <GroupByBox Hidden="True">
        </GroupByBox>
    </DisplayLayout>
</igtbl:UltraWebGrid>
<asp:ObjectDataSource ID="odsEmployee" runat="server" SelectMethod="FillPersonList"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationId" Type="Int32" />
        <asp:Parameter DefaultValue="99999" Name="OrganizationID1" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
&nbsp; &nbsp;&nbsp; &nbsp;
<asp:Label ID="Label1" runat="server" Style="z-index: 105; left: 215px; position: absolute;
    top: 620px" Text="" Visible="False"></asp:Label>
<asp:ObjectDataSource ID="odsForms" runat="server" SelectMethod="FillQAForm" TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrgID" Type="Int32" />
        <asp:Parameter Name="ErrorTypeID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGrid" runat="server" SelectMethod="FillQAMonitoringForm"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager">
    <SelectParameters>
        <asp:Parameter Name="QAMonitoringFormID" Type="Int32" />
        <asp:Parameter Name="OrganizationID" Type="Int32" />
        <asp:ControlParameter ControlID="txtTrackingNumber" Name="TrackingNumber" PropertyName="Text"
            Type=string />
        <asp:Parameter Name="EmployeeID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<igmisc:WebPageStyler ID="WebPageStyler1" runat="server" EnableAppStyling="True"
    Style="z-index: 101; left: 0px; position: absolute; top: 0px" StyleSetName="StatlineReports" />
<asp:ObjectDataSource ID="odsOrg" runat="server" SelectMethod="FillOrganzationList"
    TypeName="Statline.StatTrac.Schedule.ScheduleManager" EnableCaching="True">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="userOrgID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>



