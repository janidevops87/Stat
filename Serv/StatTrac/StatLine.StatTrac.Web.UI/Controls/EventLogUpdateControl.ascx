<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EventLogUpdateControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.EventLogUpdateControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register TagPrefix="uc" TagName="callHeaderControl" Src="CallHeaderControl.ascx" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<stattrac:sectionheader id="sectionHeaderEventLog" runat="server" text="Update Referral"
    width="100%"></stattrac:sectionheader>
    <uc:callHeaderControl runat="server" ID="callHeaderCtl" />
<igsch:webcalendar id="webCalendar" runat="server" EnableAppStyling="True" style="z-index: 101; left: 255px; position: absolute; top: 550px">
</igsch:webcalendar>
<div style="position: relative; width: 920px; height: 175px; left: 0px; top: -3px; z-index: 102; border-right: thin solid; border-top: thin solid; border-left: thin solid; border-bottom: thin solid;" id="divMain">

            <asp:Label ID="lblCallDT" runat="server" Style=" position: absolute;
                 left: 5px; top: -23px; z-index: 100;" Text="Call D/T:"></asp:Label><asp:Label ID="lblCallDT1" runat="server" Style="position: absolute; z-index: 101; left: 60px; top: -23px;"></asp:Label>
            <asp:Label ID="lblName" runat="server" style=" LEFT: 85px; POSITION: absolute; TOP: 55px; z-index: 102;" Text="Select Name:"></asp:Label>
            <asp:Label ID="lblDT" runat="server" style="LEFT: 100px; POSITION: absolute; TOP: 15px; z-index: 103;" Text="Date/Time:"></asp:Label>
            <asp:Label ID="lblTZ" runat="server" Style="position: absolute;
                left: 430px; top: 15px; z-index: 104;"></asp:Label>
            <asp:Label ID="lblTZ1" runat="server" Style="position: absolute;
                left: 355px; top: 15px; z-index: 105;">Time Zone:</asp:Label>
            <StatTrac:WebDateTime ID="logDateTime" runat="server" WebCalendarID="webCalendar" Width="150px" style="left: 190px; position: absolute; top: 10px; z-index: 106;">
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>    
            <asp:DropDownList ID="ddlName" runat="server" Style=" 
                position: absolute; left: 190px; top: 50px; z-index: 107;" Width="320px" DataTextField="PersonName" DataValueField="PersonID" DataSourceID="odsPersonList" TabIndex="3">
            </asp:DropDownList>
            <asp:TextBox ID="txtOrganization" runat="server" Style=" position: absolute;
                left: 190px; top: 140px; z-index: 108;" Width="320px" Wrap="true" MaxLength="80" Height="25px" TabIndex="5"></asp:TextBox><asp:TextBox ID="txtName1" runat="server" style="z-index: 109; left: 190px; position: absolute; top: 95px" Height="25px" MaxLength="50" Width="320px" Wrap="true" TabIndex="4"></asp:TextBox>

<asp:TextBox ID="txtNoteDescription" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Inset" BorderWidth="1px"  ForeColor="Black" Height="70px"
    MaxLength="1000" Style=" position: absolute; left: 605px; top: 50px; z-index: 110;"
    TextMode="MultiLine" Width="295px" Wrap="true" TabIndex="5"></asp:TextBox><asp:Label ID="lblDesc" runat="server" Height="15px" Style="z-index: 111; left: 605px;
    position: absolute; top: 25px" Text="Description:" Width="205px"></asp:Label>
<asp:Label ID="lblLogType" runat="server" Height="15px" Style="z-index: 112; left: 605px;
    position: absolute; top: 0px" Text="Event Type:  Note" Width="290px"></asp:Label>

<asp:Label ID="lblName1" runat="server" Style=" left: 20px; position: absolute;
        top: 100px; z-index: 113;" Text="Enter Name Not in List:"></asp:Label>
<asp:Label ID="lblOrg" runat="server" Style="left: 85px; position: absolute;
    top: 145px; z-index: 114;" Text="Organization:"></asp:Label>

<asp:Label ID="lblOR" runat="server" Font-Bold="True" style="Z-INDEX: 115; LEFT: 110px; POSITION: absolute; TOP: 75px" Text="OR"></asp:Label>
<asp:Button ID="btnAddEvent" runat="server" Style=" left: 605px; position: absolute;
    top: 140px; z-index: 116;" Text="Add Event" OnClick="btnAddEvent_Click" TabIndex="6" />
    <asp:Label ID="lblAddEvent" runat="server" Font-Bold="True" Font-Italic="True" Style="z-index: 118;
        left: 0px; position: absolute; top: 0px" Text="Add an Event" Width="95px"></asp:Label>
</div>
<igtbl:UltraWebGrid ID="gridLogEventsList" runat="server" Height="280px"
    Width="935px" DataSourceID="odsLogEvents" OnInitializeRow="gridLogEventsList_InitializeRow" OnDataBound="gridLogEventsList_DataBound">
    <Bands>
        <igtbl:UltraGridBand AddButtonCaption="LogEventList" BaseTableName="LogEventList"
            Expandable="Yes" Key="LogEventList" RowSizing="Free" AllowDelete="No">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="LogEventNumber" DataType="System.Int32" IsBound="True"
                    Key="LogEventNumber" Width="45px">
                    <Header Caption="#">
                    </Header>
                    <CellStyle HorizontalAlign="Center" >
                    </CellStyle>
                    
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="LogEventDateTime" DataType="System.DateTime"
                    IsBound="True" Key="LogEventDateTime" Format="MM/dd/yyyy HH:mm" Width="175px">
                    <Header Caption="Date/Time">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="PersonInit" IsBound="True" Key="PersonInit"
                    Width="55px">
                    <CellStyle HorizontalAlign="Center" >
                    </CellStyle>
                    <Header Caption="By">
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="LogEventTypeName" IsBound="True" Key="LogEventTypeName">
                    <Header Caption="Event Type">
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="LogEventOrg" IsBound="True" Key="LogEventOrg">
                    <Header Caption="Organization">
                        <RowLayoutColumnInfo OriginX="4" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="LogEventName" IsBound="True" Key="LogEventName">
                    <Header Caption="To/From">
                        <RowLayoutColumnInfo OriginX="5" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="LogEventDesc" CellMultiline="Yes" IsBound="True"
                    Key="LogEventDesc" Width="300px">
                    <CellStyle Wrap="True" >
                    </CellStyle>
                    <Header Caption="Description">
                        <RowLayoutColumnInfo OriginX="6" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Footer>
                </igtbl:UltraGridColumn>
            </Columns>
            <RowEditTemplate>
                <br />
                <p align="center">
                    <input id="igtbl_reOkBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                        type="button" value="OK" />&nbsp;
                    <input id="igtbl_reCancelBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                        type="button" value="Cancel" /></p>
            </RowEditTemplate>
            <RowTemplateStyle BackColor="Window" BorderColor="Window" BorderStyle="Ridge">
                <BorderDetails WidthBottom="3px" WidthLeft="3px" WidthRight="3px" WidthTop="3px" />
            </RowTemplateStyle>
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout Name="ctl00xgridLogEventsList" RowHeightDefault="20px" SelectTypeRowDefault="Single"
        StationaryMarginsOutlookGroupBy="True" Version="4.00" CellSpacingDefault="1" AllowColSizingDefault="Free" AllowSortingDefault="Yes" BorderCollapseDefault="Separate" HeaderClickActionDefault="SortMulti">
        <FrameStyle BorderStyle="None"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="280px"
            Width="935px" Cursor="Default" ForeColor="#A37171">
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

<div style="position: relative; width: 225px; height: 155px; z-index: 103; left: -3px; top: -8px;">
            <asp:ObjectDataSource ID="odsPersonList" runat="server" SelectMethod="FillPersonList"
                TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsPersonList_Selected">
                <SelectParameters>
                    <asp:Parameter Name="OrganizationId" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsLogEvents" runat="server" SelectMethod="FillLogEventList" TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsLogEvents_Selected">
                <SelectParameters>
                    <asp:Parameter Name="CallID" Type="Int32" />
                    <asp:Parameter DefaultValue="" Name="timeZone" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
    &nbsp;
            <igmisc:WebPageStyler ID="webPageStyler" runat="server" StyleSetName="StatlineReports" />
     </div>