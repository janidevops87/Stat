<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAPendingReviewControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAPendingReviewControl" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls" TagPrefix="StatTrac" %>
<%@ Register Assembly="Infragistics4.Web.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.Web.UI.EditorControls" tagprefix="ig" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<stattrac:sectionheader id="sectionHeaderQAPendingReviewControl" runat="server" text="Pending Review"
    width="100%"></stattrac:sectionheader>
<div class="ParamControl" style="width: 367px">
     <br /> 
     <igtbl:UltraWebGrid ID="gridEmployees" runat="server" Height="335px" Style="z-index: 102;
        left: 15px; position: relative; top: 0px;" Width="248px" 
            DataSource="<%# dsRefData %>"  DataMember="PersonbyOrg">
        <Bands>
            <igtbl:UltraGridBand AllowUpdate="No" AllowDelete="No">
                <AddNewRow View="NotSet" Visible="NotSet" >
                </AddNewRow>
                <Columns>
                    <igtbl:UltraGridColumn AllowUpdate="Yes" BaseColumnName="checked" Width=30px
                    DataType="System.Boolean" Key="checked" Type="CheckBox">
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="PersonName" Key="PersonName" Width=210px>
                    <Header Caption="Person Name">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>

<Footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</Footer>
                </igtbl:UltraGridColumn> 
                <igtbl:UltraGridColumn BaseColumnName="PersonID" Key="PersonID" Width=190px 
                        Hidden="true">
<Header>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</Header>

<Footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</Footer>
                </igtbl:UltraGridColumn> 
                </Columns>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" BorderCollapseDefault="Separate" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Extended" StationaryMargins="Header"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" ViewType="OutlookGroupBy" AutoGenerateColumns="False">
        <FrameStyle BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="335px"
            Width="248px" Cursor="Default" ForeColor="#A37171">
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
        
        <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
        </SelectedRowStyleDefault>
            <GroupByBox Hidden="True">
            </GroupByBox>
    </DisplayLayout>
    </igtbl:UltraWebGrid> 
    <br />
        <asp:Label ID="Label1" runat="server" Text="From Date:"></asp:Label><br />
<StatTrac:WebDateTime ID="dateFrom" runat="server" WebCalendarID="webCalendar1" 
            Width="190px" EditModeFormat="MM/dd/yyyy HH:mm" TabIndex="3" >
    <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
    </ButtonsAppearance>
    <SpinButtons Display="OnRight" />
</StatTrac:WebDateTime><br />
        <asp:Label ID="Label2" runat="server" Text="To Date:"></asp:Label><br />
<StatTrac:WebDateTime ID="dateTo" runat="server" WebCalendarID="webCalendar1" 
            Width="190px" EditModeFormat="MM/dd/yyyy HH:mm" TabIndex="3" >
    <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
    </ButtonsAppearance>
    <SpinButtons Display="OnRight" />
</StatTrac:WebDateTime>
    <br />   <br />
    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="60px" 
             CausesValidation="False" onclick="btnSearch_Click" />
       
    </div>


<igtbl:UltraWebGrid ID="gridErrorsPendingReview" runat="server" Height="405px" Style="z-index: 102;
        left: 15px; position: relative; top: 0px;" Width="625px" DataSource="<%# dsQAData %>" OnDataBound="gridErrorsPendingReview_DataBound" DataMember="GridPendingReview" >
        <Bands>
            <igtbl:UltraGridBand AllowUpdate="No" AllowDelete="No">
                <AddNewRow View="NotSet" Visible="NotSet" >
                </AddNewRow>
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="TrackingType" IsBound="False" Key="TrackingType" Width=100px Type=HyperLink> 
                        
                        <Header Caption="Type">
                        </Header>
                    </igtbl:UltraGridColumn>
                    
                    <igtbl:UltraGridColumn BaseColumnName="QATrackingNumber" IsBound="False" Key="QATrackingNumber" Width=150px>
                        <Header Caption="Tracking Number">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QATrackingEventDateTimeString" IsBound="False" Key="QATrackingEventDateTime" Width=195px>
                        <Header Caption="Date/Time Entered">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="StatEmployeeName" IsBound="False" Width=150px
                        Key="StatEmployeeName">
                        <Header Caption="Completed By">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    </igtbl:UltraGridColumn>
                </Columns>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" BorderCollapseDefault="Separate" Name="ctl00xgridErrorsPendingReview" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Extended" StationaryMargins="Header"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" ViewType="OutlookGroupBy" AutoGenerateColumns="False">
        <FrameStyle BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="405px"
            Width="625px" Cursor="Default" ForeColor="#A37171">
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
        
        <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
        </SelectedRowStyleDefault>
            <GroupByBox Hidden="True">
            </GroupByBox>
    </DisplayLayout>
    </igtbl:UltraWebGrid>
    <igsch:WebCalendar ID="webCalendar1" runat="server" Visible="true" Style="z-index: 100; left: 285px; position: absolute; top: 595px;">
    </igsch:WebCalendar>
    <igmisc:WebPageStyler ID="webPageStyler" runat="server" StyleSetName="StatlineReports" EnableAppStyling="True"  />
        
         

