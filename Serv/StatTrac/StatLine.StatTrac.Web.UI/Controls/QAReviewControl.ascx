<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAReviewControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAReviewControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
    
    <asp:ScriptManager ID="scriptManager" runat="server">
    </asp:ScriptManager>
    
<stattrac:sectionheader id="sectionHeaderQAReview" runat="server" text="QA Review"
    width="100%"></stattrac:sectionheader>
<div style="z-index: 106; left: 15px; width: 610px; position: relative;
    height: 95px; top: -13px;">
    <igcmbo:WebCombo ID="ddlOrganization" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 100; left: 110px; position: absolute; top: 15px"
        Version="4.00" DataSourceID="odsOrg" OnSelectedRowChanged="ddlOrganization_SelectedRowChanged" OnInitializeLayout="ddlOrganization_InitializeLayout" Width="245px" ComboTypeAhead="Suggest" Editable="True" EnableXmlHTTP="True" DataTextField="OrganizationName" DataValueField="OrganizationID" OnPreRender="ddlOrganization_PreRender">
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
    <asp:Label ID="lblOrganization" runat="server" Height="20px" Style="z-index: 101; left: 5px;
        position: absolute; top: 17px" Text="Organization:" Width="100px"></asp:Label>
    <asp:Label ID="lblTrackingNumberEnter" runat="server" Height="20px" Style="z-index: 102; left: 5px;
        position: absolute; top: 65px" Text="Tracking #:" Width="100px"></asp:Label>
    <asp:TextBox ID="txtTrackingNumber" runat="server" Style="z-index: 103; left: 110px; position: absolute;
        top: 65px" AutoPostBack="true" MaxLength="20"></asp:TextBox>
    <asp:Button ID="btnAddTracking" runat="server" Style="z-index: 104; left: 350px; position: absolute;
        top: 65px" Text="Add Tracking #" OnClick="btnAddTracking_Click" Width="130px" Enabled="False" />
    <asp:Button ID="btnSearch" runat="server" Style="z-index: 105; left: 275px; position: absolute;
        top: 65px" Text="Search" OnClick="btnSearch_Click" />
    <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Style="z-index: 106;
        left: 490px; position: absolute; top: 65px" Text="Reset" />
        <igcmbo:WebCombo ID="ddlTrackingType" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 107; left: 110px; position: absolute; top: 40px"
        Version="4.00" DataSourceID="odsTrackingType"  Width="245px" ComboTypeAhead="Suggest" Editable="True" EnableXmlHTTP="True" DataTextField="QATrackingTypeDescription" DataValueField="QATrackingTypeID" 
        OnInitializeLayout="ddlTrackingType_InitializeLayout">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="QATrackingTypeID" DataType="System.Int32"
                    IsBound="True" Key="QATrackingTypeID">
                    <header caption="QATrackingTypeID"></header>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="QATrackingTypeDescription" IsBound="True"
                    Key="QATrackingTypeDescription">
                    <header caption="QATrackingTypeDescription">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                    <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
                </igtbl:UltraGridColumn>
            </Columns>
            <ExpandEffects ShadowColor="LightGray" />
            <DropDownLayout Version="4.00" ColWidthDefault="245px" DropdownWidth="245px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                <FrameStyle Height="130px" Width="245px">
                </FrameStyle>
                <RowStyle BackColor="White" BorderColor="Gray" />
            </DropDownLayout>
        </igcmbo:WebCombo>
    <asp:Label ID="Label2" runat="server" Height="20px" Style="z-index: 109; left: 5px;
        position: absolute; top: 40px" Text="Tracking Type:" Width="100px"></asp:Label>
</div>
<hr color="#990000" style="z-index: 107; left: -300px; width: 985px; position: relative;
     height: 5px; top: -4px;" />
     <div style=" position: relative;
     top: 0px;">
         <asp:Label ID="lblTrackingNumber" runat="server" Font-Bold="True" Style="z-index: 102;
    left: 45px; position: relative; top:0px" Text="Tracking #" Width="80px"></asp:Label>
<asp:Label ID="lblTrackingNumberData" runat="server" Font-Bold="True" Style="z-index: 103;
    left: 50px; position: relative; top: 0px" Width="75px"></asp:Label>
     </div>
    
<asp:Panel ID="Panel2" runat="server" Height="60px" Style="z-index: 100; left: 35px;
    position: relative; top: 0px;" Width="605px" BorderStyle="Groove" Visible="False" >
<asp:Label ID="lblType" runat="server" Style="z-index: 104; left: 50px; position: absolute;
    top: 5px" Text="Type:" Width="40px"></asp:Label>
<asp:Label ID="lblTypeData" runat="server" Style="z-index: 105; left: 100px; position: absolute;
    top: 5px" Width="40px"></asp:Label>
<asp:Label ID="lblRefDateTime" runat="server" Style="z-index: 106; left: 245px; position: absolute;
    top: 5px" Width="115px"></asp:Label>
<asp:Label ID="lblRefType" runat="server" Style="z-index: 107; left: 270px; position: absolute;
    top: 30px" Text="Referral Type:" Width="90px"></asp:Label>
<asp:Label ID="lblSourceCode" runat="server" Style="z-index: 108; left: 5px; position: absolute;
    top: 30px" Text="Source Code:" Width="85px"></asp:Label>
<asp:Label ID="lblSourceCodeData" runat="server" Style="z-index: 109; left: 100px;
    position: absolute; top: 30px" Width="40px"></asp:Label>
<asp:Label ID="lblRefTypeData" runat="server" Style="z-index: 110; left: 380px; position: absolute;
    top: 30px" Width="105px"></asp:Label>
<asp:Label ID="lblRefDateTimeData" runat="server"  Style="z-index: 117; left: 380px;
    position: absolute; top: 5px" Width="175px"></asp:Label>
</asp:Panel>
<asp:Panel ID="Panel3" runat="server" Height="50px" Style="z-index: 101; left: 35px;
    position: relative; top: 0px;" Width="600px" Visible="False">
    <asp:Label ID="lblEventDateTime" runat="server" Style="z-index: 100; left: 35px; position: absolute;
        top: 10px" Text="Event date/time:" Width="100px" Visible="False"></asp:Label>
    <asp:Label ID="lblNotes" runat="server" Style="z-index: 101; left: 35px; position: absolute;
        top: 10px" Text="Notes:" Width="45px"></asp:Label>
        <input type="hidden" name="userComments1" value=" " style="position: absolute;top:30px; width: 20px; z-index: 106;" />
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp;  <span style="position: absolute;top:10px; left: 100px; z-index: 107;">You have</span> <span id="countdown" style="font-weight: bold;position: absolute;top:10px;left:160px ; z-index: 108;">1000</span> <span style="position: absolute;top:10px;left:240px ; z-index: 109;">remaining characters.</span>
    <asp:TextBox ID="txtNotes" runat="server" Height="35px" Style="z-index: 102; left: 100px;
        position: absolute; top: 30px" TextMode="MultiLine" Width="415px" onKeyUp="TrackCount(this, 1000,'countdown')"></asp:TextBox>
    <StatTrac:WebDateTime ID="dateEventDateTime" runat="server" Visible="False"
        Style="z-index: 103; left: 140px; position: absolute; top: 10px" Width="200px" WebCalendarID="webCalendar" EnableTheming="True" EditModeFormat="MM/dd/yyyy HH:mm" EnableAppStyling="True">
        <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
        </ButtonsAppearance>
        <SpinButtons Display="OnRight" />
    </StatTrac:WebDateTime>
    
</asp:Panel>
&nbsp;
<asp:Button ID="btnAdd" runat="server" OnClick="btn_Add_Click" Style="z-index: 102;
        left: 25px; position: relative; top: -233px" Text="Add" Enabled="False" />
<asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Style="z-index: 110;
        left: 30px; position: relative; top: -233px" Text="Save" Visible="False" />   
<fieldset ID="Panel1" runat="server"  Style="z-index: 108; left: 20px;
    position: relative;  border-right: thin solid; border-top: thin solid; border-left: thin solid; width: 535px; border-bottom: thin solid; height: 260px; top: 35px;" >
    <legend accesskey="I" style="font-weight: bold; z-index: 102; left: 0px; position: absolute; top: 0px;">
        Error Types by Employee</legend>
    <igtbl:UltraWebGrid ID="gridErrors" runat="server" Height="225px" Style="z-index: 103;
        left: 10px; position: absolute; top: 25px" Width="510px" DataSourceID="odsGrid" EnableAppStyling="True">
        <Bands>
            <igtbl:UltraGridBand BaseTableName="GridErrorTypesByEmployee" Key="GridErrorTypesByEmployee" AllowDelete="No">
                <Columns>
                    <igtbl:TemplatedColumn BaseColumnName="StatEmployeeName" IsBound="True" Key="StatEmployeeName" Width=190px>
                        <CellTemplate>
                           <asp:HyperLink ID="ErrorType" Enabled="true" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"StatEmployeeName") %> '
                             NavigateUrl='<%# "~/QAErrorLog.aspx?PersonName=" + DataBinder.Eval(Container.DataItem,"StatEmployeeName") + "&Location=" + DataBinder.Eval(Container.DataItem,"QAErrorLocationDescription") +  "&LocationID=" + DataBinder.Eval(Container.DataItem,"QAErrorLocationID") + "&PersonID=" + DataBinder.Eval(Container.DataItem,"PersonID") + "&TrackingNumber=" + txtTrackingNumber.Text + "&TrackingID=" + DataBinder.Eval(Container.DataItem,"QATrackingID") + "&New=" + 0 + "&TrackingTypeID=" + DataBinder.Eval(Container.DataItem,"QATrackingTypeID")  %>'/>
                        </CellTemplate>
                        <Header Caption="Employee">
                        </Header>
                    </igtbl:TemplatedColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLocationDescription" IsBound="True" Width=190px
                        Key="QAErrorLocationDescription">
                        <Header Caption="Location">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogNumberOfErrors" DataType="System.Int32" Width=125px
                        IsBound="True" Key="QAErrorLogNumberOfErrors">
                        <Header Caption="# Of Error Types">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                         <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    </igtbl:UltraGridColumn>
                    
                                      
                </Columns>
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
            </igtbl:UltraGridBand>
        </Bands>
       <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowDeleteDefault="Yes"
        AllowSortingDefault="OnClient" BorderCollapseDefault="Separate"
        HeaderClickActionDefault="SortMulti" Name="ctl00xgridErrors" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Extended" StationaryMargins="Header"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" ViewType="OutlookGroupBy">
        <FrameStyle BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="225px"
            Width="510px" Cursor="Default" ForeColor="#A37171">
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
</fieldset>

<div style="z-index: 109; left: 40px; width: 245px; position: absolute; top: 725px;
    height: 265px">
    &nbsp;<asp:ObjectDataSource ID="odsOrg" runat="server" SelectMethod="FillOrganzationList"
        TypeName="Statline.StatTrac.Schedule.ScheduleManager">
        <SelectParameters>
            <asp:Parameter DefaultValue="194" Name="userOrgID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsGrid" runat="server" SelectMethod="FillQAGridErrorTypesByEmployee"
        TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter Name="QATrackingNumber" Type="String" />
            <asp:Parameter Name="OrganizationID" Type="Int32" DefaultValue="194" />
            <asp:Parameter Name="TrackingTypeID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <igmisc:WebPageStyler ID="WebPageStyler1" runat="server" EnableAppStyling="True" StyleSetName="StatlineReports" />
    <asp:ObjectDataSource ID="odsTrackingType" runat="server" SelectMethod="FillTrackingType"
        TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager">
        <SelectParameters>
            <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>
<igsch:WebCalendar ID="webCalendar" runat="server" Style="z-index: 103; left: 335px;
        position: absolute; top: 750px" Visible=false>
    </igsch:WebCalendar>
<asp:Label ID="Label1" runat="server" Style="z-index: 104; left: 610px; position: absolute;
    top: 135px" Text="Label" Visible="False"></asp:Label>
    
