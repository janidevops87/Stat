<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ScheduleSearchControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.ScheduleSearchControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<asp:ScriptManager ID="scheduleSearchScriptManager" runat="server" />
<StatTrac:SectionHeader ID="sectionHeaderScheduleSearch" runat="server" Text="Search for a Schedule" Width="100%" />
 <div style="width: 215px; height: 15px; z-index: 103; left: 235px; position: absolute; top: 555px;">
            <asp:ObjectDataSource ID="odsSchedOrgs" runat="server" SelectMethod="FillOrganzationList"
                TypeName="Statline.StatTrac.Schedule.ScheduleManager" OnSelected="odsSchedOrgs_Selected" EnableCaching="True" OnSelecting="odsSchedOrgs_Selecting">
                <SelectParameters>
                    <asp:Parameter DefaultValue="" Name="userOrgID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsSchedOrgGroups" runat="server" SelectMethod="FillScheduleGroupList"
                TypeName="Statline.StatTrac.Schedule.ScheduleManager" OnSelected="odsSchedOrgGroups_Selected" EnableCaching="True">
                <SelectParameters>
                    <asp:Parameter Name="OrgID" Type="Int32" DefaultValue="0" />
                </SelectParameters>
            </asp:ObjectDataSource>
            &nbsp;
            <asp:ObjectDataSource ID="odsSchedList" runat="server" OnSelected="odsSchedList_Selected"
                SelectMethod="FillScheduleList" TypeName="Statline.StatTrac.Schedule.ScheduleManager" OnSelecting="odsSchedList_Selecting">
                <SelectParameters>
                    <asp:ControlParameter ControlID="startDateTime" Name="startTime" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="endDateTime" Name="endTime" PropertyName="Text" Type="DateTime" />
                    <asp:Parameter Name="scheduleGroupID" Type="Int32" />
                    <asp:ControlParameter ControlID="lblTZ" DefaultValue="" Name="TZ" PropertyName="Text"
                        Type="String" />
                    <asp:Parameter Name="userOrgID" Type="Int32" />
                    
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsPerson" runat="server" OnSelected="odsPerson_Selected" SelectMethod="FillSchedPersonList" TypeName="Statline.StatTrac.Schedule.ScheduleManager" EnableCaching="True">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="OrganizationId" Type="Int32" />
                    <asp:Parameter DefaultValue="" Name="ScheduleGroupID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <igmisc:WebPageStyler ID="webPageStyler" runat="server" StyleSetName="StatlineReports" EnableAppStyling="True" EnableTheming="True" />
     &nbsp;
            </div>     
<div style="position: relative; width: 1030px; height: 125px; left: 0px; top: 0px; z-index: 101;" id="divMain">

            <asp:Label ID="lblStartDate" runat="server" Style="z-index: 100; position: absolute;
                top: 10px; left: 5px;" Text="Start Date/Time" Width="115px"></asp:Label><asp:Label ID="lblEndDate" runat="server" Style="z-index: 101; position: absolute;
                top: 0px; left: 230px;" Text="End Date/Time" Width="120px"></asp:Label>
     
            <asp:Label ID="lblScheduleOrgs" runat="server" Style="z-index: 102; position: absolute;
                top: 10px; left: 455px;" Text="Schedule Organizations" Width="170px"></asp:Label>
       
            <asp:Label ID="lblScheduleGroup" runat="server" Style="z-index: 103; position: absolute;
                top: 5px; left: 780px;" Text="Schedule Group" Width="120px"></asp:Label>
    &nbsp;
            <asp:Label ID="lblTZ" runat="server" Style="z-index: 104; left: 380px; position: absolute;
                top: 35px"></asp:Label>
                
           
            <asp:Label ID="lblTZ1" runat="server" Style="z-index: 105; left: 150px; position: absolute;
                top: 35px"></asp:Label>
     
           
                &nbsp;&nbsp;
           
            <igcmbo:webcombo id="ddlScheduleOrgs" runat="server" backcolor="White" bordercolor="Silver"
                borderstyle="Solid" borderwidth="1px" forecolor="Black" selbackcolor="DarkBlue"
                selforecolor="White" style="z-index: 106;  position: absolute; top: 35px; left: 450px;"
                version="4.00" width="290px" OnSelectedRowChanged="ddlScheduleOrgs_SelectedRowChanged" DataSourceID="odsSchedOrgs" DataTextField="OrganizationName" DataValueField="OrganizationID" ComboTypeAhead="Suggest" EnableXmlHTTP="True" EnableAppStyling="True" Editable="True" OnInitializeLayout="ddlScheduleOrgs_InitializeLayout">
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
                <DropDownLayout Version="4.00" ColWidthDefault="315px" DropdownWidth="315px" BaseTableName="" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No">
                    <FrameStyle Height="130px" Width="315px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
                </igcmbo:webcombo>
       
            &nbsp; &nbsp;&nbsp;
       
            &nbsp; &nbsp;&nbsp;
       
            <igcmbo:webcombo id="ddlScheduleGroup" runat="server" backcolor="White" bordercolor="Silver"
                borderstyle="Solid" borderwidth="1px" forecolor="Black" selbackcolor="DarkBlue"
                selforecolor="White" style="z-index: 107;  position: absolute; top: 35px; left: 775px;"
                version="4.00" width="230px" DataSourceID="odsSchedOrgGroups" DataTextField="ScheduleGroupName" DataValueField="ScheduleGroupID" ComboTypeAhead="None" Editable="True" EnableXmlHTTP="True" EnableAppStyling="True" OnSelectedRowChanged="ddlScheduleGroup_SelectedRowChanged" OnInitializeLayout="ddlScheduleGroup_InitializeLayout">
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
                <DropDownLayout Version="4.00" ColWidthDefault="230px" DropdownWidth="230px" XmlLoadOnDemandType="Accumulative" BaseTableName="" ColHeadersVisible="No" GridLines="None" RowSelectors="No">
                    <FrameStyle Width="230px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray"  />
                </DropDownLayout>
                </igcmbo:webcombo>
  <asp:Label ID="lblSchedOrg" runat="server" Style="z-index: 108; left: 10px; position: absolute;
                top: 100px" Text="Schedule Organization:" Width="155px" Font-Bold="True"></asp:Label>
      
            <asp:Label ID="lblSchedOrg1" runat="server" Style="z-index: 110; left: 170px; position: absolute;
                top: 100px" Width="250px"></asp:Label>
     
            <asp:Label ID="lblSchedGroup" runat="server" Style="z-index: 111; left: 430px; position: absolute;
                top: 100px" Text="Schedule Group:" Width="115px" Font-Bold="True"></asp:Label>
     
            <asp:Label ID="lblSchedGroup1" runat="server" Style="z-index: 112; left: 550px; position: absolute;
                top: 100px" Width="185px"></asp:Label>
      
<asp:Button ID="btnCreateShift" runat="server" Style="z-index: 113; left: 775px;
    position: absolute; top: 95px" Text="Create Shift" OnClick="btnCreateShift_Click" Enabled="False"  />
<asp:Button ID="btnSave" runat="server" Style="z-index: 114; left: 895px; position: absolute;
    top: 95px" Text="Save Changes" OnClick="btnSave_Click" Enabled="False" Width="105px" />       
<asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Style="z-index: 115;
    left: 940px; position: absolute; top: 65px" TabIndex="10" Text="Search" Enabled="False" />

     
            
            <StatTrac:WebDateTime ID="startDateTime" runat="server" Width="136px" WebCalendarID="webCalendar" style="z-index: 117; left: 5px; position: absolute; top: 35px">
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>
            <StatTrac:WebDateTime ID="endDateTime" runat="server" Width="135px" WebCalendarID="webCalendar" style="z-index: 119; left: 230px; position: absolute; top: 35px">
                    <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                    </ButtonsAppearance>
                    <SpinButtons Display="OnRight" />
                </StatTrac:WebDateTime>
</div>            
  
<StatTrac:SectionHeader ID="SectionHeader1" runat="server" Style="" Text="Schedule" Width="100%" />  
<igtbl:UltraWebGrid ID="gridSchedule" runat="server" DataSourceID="odsSchedList" Style=""  DisplayLayout-TableLayout="Auto" Width="1055px" OnDataBound="gridSchedule_DataBound" >
    <Bands>
        <igtbl:UltraGridBand AddButtonCaption="ScheduleList" BaseTableName="ScheduleList" 
            Key="ScheduleList" AllowDelete="No">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="ScheduleItemID" Hidden="True" IsBound="True"
                    Key="ScheduleItemID">
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ScheduleGroupID" Hidden="True" IsBound="True"
                    Key="ScheduleGroupID">
                    <Header>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:TemplatedColumn BaseColumnName="ScheduleItemName" IsBound="True" Key="ScheduleItemName"
                    Type="NotSet" Width="85px">
                    <CellTemplate>
                       <asp:HyperLink Enabled="true" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ScheduleItemName") %> '
                       NavigateUrl='<%# "~/ScheduleCreateUpdateShift.aspx?ScheduleItemID=" + DataBinder.Eval(Container.DataItem,"ScheduleItemID")+  "&OrgGroup=" + lblSchedGroup1.Text +  "&SchedGroupID=" + DataBinder.Eval(Container.DataItem,"ScheduleGroupID") +  "&ShowCreate=" + 0 %>'/>
                    </CellTemplate>
                    <Header Caption="Name">
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:TemplatedColumn>
                <igtbl:UltraGridColumn BaseColumnName="ShiftStart" DataType="System.DateTime" Format="MM/dd/yyyy HH:mm"
                    IsBound="True" Key="ShiftStart" Width="140px">
                    <Header Caption="Start D/T">
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ShiftEnd" DataType="System.DateTime" Format="MM/dd/yyyy HH:mm"
                    IsBound="True" Key="ShiftEnd" Width="140px">
                    <Header Caption="End D/T">
                        <RowLayoutColumnInfo OriginX="4" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="Person1" Hidden="True" IsBound="True" Key="Person1"
                    Width="135px">
                    <Header>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:TemplatedColumn BaseColumnName="Person1" IsBound="True" Key="Person1" Width="135px">
                    <CellTemplate>
                       <asp:DropDownList ID="ddlPerson1" runat="server" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID" BackColor="#DBCACA" AutoPostBack="false"
                       AppendDataBoundItems="true"  OnSelectedIndexChanged="GetCurrentPerson1Changed" OnDataBound="GetCurrentPerson1" Style="z-index: 100; width:100%;  position: absolute; top: 0px ">
                       </asp:DropDownList>
                    </CellTemplate>
                    <Header Caption="On Call1">
                        <RowLayoutColumnInfo OriginX="6" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Footer>
                </igtbl:TemplatedColumn>
                <igtbl:UltraGridColumn BaseColumnName="Person2" Hidden="True" IsBound="True" Key="Person2"
                    Width="135px">
                    <Header>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:TemplatedColumn BaseColumnName="Person2" IsBound="True" Key="Person2" Width="135px">
                    <CellTemplate>
                       <asp:DropDownList ID="ddlPerson2" runat="server" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID" BackColor="#DBCACA" AutoPostBack="false" 
                       AppendDataBoundItems="true"  OnSelectedIndexChanged="GetCurrentPerson2Changed" OnDataBound="GetCurrentPerson2" Style="z-index: 100; width:100%;  position: absolute; top: 0px ">
                     
                       </asp:DropDownList>
                    </CellTemplate>
                    <Header Caption="On Call2">
                        <RowLayoutColumnInfo OriginX="8" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="8" />
                    </Footer>
                </igtbl:TemplatedColumn>
                <igtbl:UltraGridColumn BaseColumnName="Person3" Hidden="True" IsBound="True" Key="Person3"
                    Width="135px">
                    <Header>
                        <RowLayoutColumnInfo OriginX="9" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="9" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:TemplatedColumn BaseColumnName="Person3" IsBound="True" Key="Person2" Width="135px">
                    <CellTemplate>
                       <asp:DropDownList ID="ddlPerson3" runat="server" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID" BackColor="#DBCACA" AutoPostBack="false"
                       AppendDataBoundItems="true"  OnSelectedIndexChanged="GetCurrentPerson3Changed" OnDataBound="GetCurrentPerson3" Style="z-index: 100; width:100%;  position: absolute; top: 0px ">
                       </asp:DropDownList>
                    </CellTemplate>
                    <Header Caption="On Call3">
                        <RowLayoutColumnInfo OriginX="10" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="10" />
                    </Footer>
                </igtbl:TemplatedColumn>
                <igtbl:UltraGridColumn BaseColumnName="Person4" Hidden="True" IsBound="True" Key="Person4"
                    Width="135px">
                    <Header>
                        <RowLayoutColumnInfo OriginX="11" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="11" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:TemplatedColumn BaseColumnName="Person4" IsBound="True" Key="Person2" Width="135px">
                    <CellTemplate>
                       <asp:DropDownList ID="ddlPerson4" runat="server" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID" BackColor="#DBCACA" AutoPostBack="false"
                       AppendDataBoundItems="true"  OnSelectedIndexChanged="GetCurrentPerson4Changed" OnDataBound="GetCurrentPerson4" Style="z-index: 100; width:100%;  position: absolute; top: 0px ">
                       </asp:DropDownList>
                    </CellTemplate>
                    <Header Caption="On Call4">
                        <RowLayoutColumnInfo OriginX="12" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="12" />
                    </Footer>
                </igtbl:TemplatedColumn>
                <igtbl:UltraGridColumn BaseColumnName="Person5" Hidden="True" IsBound="True" Key="Person5"
                    Width="135px">
                    <Header>
                        <RowLayoutColumnInfo OriginX="13" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="13" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:TemplatedColumn BaseColumnName="Person5" IsBound="True" Key="Person2" Width="135px">
                    <CellTemplate>
                       <asp:DropDownList ID="ddlPerson5" runat="server" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID" BackColor="#DBCACA" AutoPostBack="false"
                       AppendDataBoundItems="true"  OnSelectedIndexChanged="GetCurrentPerson5Changed" OnDataBound="GetCurrentPerson5" Style="z-index: 100; width:100%;  position: absolute; top: 0px ">
                       </asp:DropDownList>
                    </CellTemplate>
                    <Header Caption="On Call5">
                        <RowLayoutColumnInfo OriginX="14" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="14" />
                    </Footer>
                </igtbl:TemplatedColumn>
            </Columns>
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout Name="ctl00xgridSchedule" RowHeightDefault="20px" SelectTypeRowDefault="Single" AllowColSizingDefault="Free" AllowSortingDefault="OnClient" HeaderClickActionDefault="SortMulti"
        StationaryMarginsOutlookGroupBy="True" Version="4.00" CellSpacingDefault="1" BorderCollapseDefault="Separate" TableLayout="Fixed" UseFixedHeaders="True" StationaryMargins="Header">
        <FrameStyle BorderStyle="None" BorderWidth="1px"
            Font-Names="Verdana" Font-Size="8pt" ForeColor="#A37171" Cursor="Default" Height="350px" Width="1055px">
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
<igsch:WebCalendar ID="webCalendar" runat="server" style="z-index: 109; left: 10px; position: absolute; top: 550px" />
    
