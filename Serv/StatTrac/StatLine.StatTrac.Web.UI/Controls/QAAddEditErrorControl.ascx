<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAAddEditErrorControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAAddEditErrorControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDataInput.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<asp:ScriptManager ID="scriptManager" runat="server">
</asp:ScriptManager>

<stattrac:sectionheader id="sectionHeaderAddEditError" runat="server" text="Add/Edit Quality Monitoring Form"
    width="100%"></stattrac:sectionheader>
<asp:Label ID="lblTrackingNumber" runat="server" Font-Bold="True" Style="z-index: 100;
    left: 45px; position: relative; top:0px" Text="Tracking #" Width="80px"></asp:Label>
<asp:Label ID="lblTrackingNumberData" runat="server" Font-Bold="True" Style="z-index: 101;
    left: 45px; position: relative; top: 0px" Width="55px"></asp:Label>    
<asp:Image ID="imgLogo" runat="server" Style=" left: 200px; position: relative;
    " Width="175px" Height="40px"/>
<asp:Panel ID="Panel2" runat="server" Height="25px" Style="z-index: 103; left: 30px;
    position: relative; top: 0px" Width="615px" BorderColor="White" BorderStyle="Groove">
    <div style="left: 5px; width: 595px; position: relative; 
    height: 55px; top: 5px;">
<asp:Label ID="lblType" runat="server" Style="z-index: 100; left: 50px; position: absolute;
    top: 5px" Text="Type:" Width="40px"></asp:Label>
<asp:Label ID="lblTypeData" runat="server" Style="z-index: 101; left: 100px; position: absolute;
    top: 5px" Width="40px"></asp:Label>
<asp:Label ID="lblRefDateTime" runat="server" Style="z-index: 102; left: 240px; position: absolute;
    top: 5px; width: 101px;"></asp:Label>
<asp:Label ID="lblRefType" runat="server" Style="z-index: 103; left: 240px; position: absolute;
    top: 30px" Text="Referral Type:" Width="90px"></asp:Label>
<asp:Label ID="lblSourceCode" runat="server" Style="z-index: 104; left: 5px; position: absolute;
    top: 30px" Text="Source Code:" Width="85px"></asp:Label>
<asp:Label ID="lblSourceCodeData" runat="server" Style="z-index: 105; left: 100px;
    position: absolute; top: 30px" Width="115px"></asp:Label>
<asp:Label ID="lblRefTypeData" runat="server" Style="z-index: 106; left: 350px; position: absolute;
    top: 30px" Width="105px"></asp:Label>
<asp:Label ID="lblRefDateTimeData" runat="server"  Style="z-index: 107; left: 350px;
    position: absolute; top: 5px" Width="175px"></asp:Label>    
        <asp:Label ID="lblRefTypeID" runat="server" Style="z-index: 109; left: 475px; position: absolute;
            top: 30px" Visible="False" Width="1px"></asp:Label>
    </div>

</asp:Panel>
<div style="z-index: 105; left: 35px; width: 665px; position: relative; 
    height: 260px; top: 0px;">
    <asp:Panel ID="Panel3" runat="server" Height="15px" Style="z-index: 100; left: 5px;
    position: relative; top: 0px" Width="600px">
     <asp:Label ID="lblNotes" runat="server" Style="z-index: 100; left: -240px; position: relative;
        top: 0px" Text="Notes:"></asp:Label>
        &nbsp;<br>&nbsp; &nbsp;  &nbsp;  You have <span id="countdown" style="font-weight: bold;vertical-align:bottom">1000</span> remaining characters.
     <input type="hidden" name="userComments" value=" " style="top:0px;width: 5px; z-index: 103; left: 5px; position: absolute;">
    <asp:TextBox ID="txtNotes" runat="server" Height="150px" Style="z-index: 102; left: 10px;
        position: relative; top: 0px" TextMode="MultiLine" Width="650px" onKeyUp="TrackCount(this, 1000,'countdown')"></asp:TextBox>
    </asp:Panel>       
    <asp:Label ID="lblEmployee" runat="server" Style="z-index: 101; left: 35px; position: absolute;
        top: 190px" Text="Employee:"></asp:Label>&nbsp;
    <asp:Label ID="lblCAPA" runat="server" Style="z-index: 102; left: 300px; position: absolute;
        top: 190px" Text="CAPA #:"></asp:Label>
    <asp:Label ID="lblEmployeeData" runat="server" Style="z-index: 103; left: 105px; position: absolute;
        top: 190px" Width="155px"></asp:Label>
    
    <asp:Label ID="lblCompletedBy" runat="server" Style="z-index: 104; left: 15px; position: absolute;
        top: 210px" Text="Completed By:"></asp:Label>
   
    <asp:Label ID="lblProcessStep" runat="server" Style="z-index: 105; left: 15px; position: absolute;
        top: 235px" Text="Process Step:"></asp:Label>
    &nbsp;
    <asp:DropDownList ID="ddlProcessStep" runat="server" DataSourceID="odsProcessStep"
             Style="z-index: 106; left: 105px; position: absolute; top: 235px" DataTextField="QAProcessStepDescription" DataValueField="QAProcessStepID" Width="155px" OnPreRender="ddlProcessStep_PreRender">
    </asp:DropDownList>
    <asp:TextBox ID="txtCAPA" runat="server" Style="z-index: 107; left: 375px; position: absolute;
        top: 185px" Width="120px"></asp:TextBox>
    <asp:CheckBox ID="cbxQAApproved" runat="server" Style="z-index: 108; left: 300px;
        position: absolute; top: 210px" Text="QA Approved:" TextAlign="Left" />
    <asp:DropDownList ID="ddlCompletedBy" runat="server" Style="z-index: 109; left: 105px;
        position: absolute; top: 210px" Width="155px" DataSourceID="odsCompletedBy" DataTextField="PersonName" DataValueField="PersonID" OnPreRender="ddlCompletedBy_PreRender">
    </asp:DropDownList>
    <asp:Label ID="lblDateEvent" runat="server" Style=" left: 300px; position: absolute;
        top: 235px; z-index: 110;" Text="Event Date/Time:"></asp:Label>
        <StatTrac:WebDateTime ID="dateEvent" runat="server" EditModeFormat="MM/dd/yyyy HH:mm"
         style="z-index: 118; left: 385px; position: absolute; top: 235px" WebCalendarID="webCalendar" Width="170px" Height="15px">
        <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
    </StatTrac:WebDateTime>    <asp:CheckBox ID="cbxReviewed" runat="server" Style="z-index: 112; left: 415px;
        position: absolute; top: 210px" Text="QA Reviewed:" TextAlign="Left" />
</div>
<div style="z-index: 102; left: 5px; width: 595px; position: relative; 
    height: 300px; top: 0px;">

<asp:Label ID="lblFormName" runat="server" BackColor="WhiteSmoke" ForeColor="Black"
        Style="z-index: 111; left: 10px; position: relative; top: 0px" Width="250px"></asp:Label>
    
    <igtbl:UltraWebGrid ID="gridErrorsbyLocation" runat="server" Height="100%" Style="z-index: 100;
        left: 5px; position: relative; top: 0px" Width="885px" DataSource="<%# dsQAData %>" DataMember="GridAddEditQualityMonitoringForm" OnDataBound="gridErrorsbyLocation_DataBound" OnUpdateRowBatch="gridErrorsbyLocation_UpdateRowBatch" EnableAppStyling="True">
        <Bands>
        
            <igtbl:UltraGridBand BaseTableName="GridAddEditQualityMonitoringForm" Expandable="Yes"
                Key="GridAddEditQualityMonitoringForm" AllowSorting="No" AllowDelete="No">
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogID" DataType="System.Int32" Hidden="True"
                        IsBound="True" Key="QAErrorLogID">
                        <Header Caption="QAErrorLogID">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormTemplateOrder" IsBound="True"
                        Key="QAMonitoringFormTemplateOrder" Width="15px" AllowUpdate="No">
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                        <Header Caption="#">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="QAErrorTypeDescription" IsBound="True"
                        Key="QAErrorTypeDescription" Width="195px">
                        <Header Caption="Error Type">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="QAErrorTypeAssignedPoints"
                        IsBound="True" Key="QAErrorTypeAssignedPoints" Width="55px">
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Header Caption="Points">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:TemplatedColumn AllowUpdate="Yes" IsBound="True" Width="125px">
                        <CellTemplate>
                            <asp:RadioButtonList ID="CheckBox1" runat="server" EnableViewState=true RepeatDirection=Horizontal  OnDataBound="GetPointsType"  AutoPostBack="false" OnLoad="GetPointsTest"  OnSelectedIndexChanged="Status_Changed" >
                                
                            </asp:RadioButtonList>
                        </CellTemplate>
                        <Header Caption="Yes/No/NA">
                            <RowLayoutColumnInfo OriginX="4" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="4" />
                        </Footer>
                        <CellStyle VerticalAlign="Top">
                        </CellStyle>
                    </igtbl:TemplatedColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogPointsYes" DataType="System.Int16"
                        Hidden="True" IsBound="True" Key="QAErrorLogPointsYes" Width="35px">
                        <Header>
                            <RowLayoutColumnInfo OriginX="5" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="5" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogPointsNo" DataType="System.Int16"
                        Hidden="True" IsBound="True" Key="QAErrorLogPointsNo" Width="35px">
                        <Header>
                            <RowLayoutColumnInfo OriginX="6" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="6" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogPointsNA" DataType="System.Int16"
                        Hidden="True" IsBound="True" Key="QAErrorLogPointsNA" Width="35px">
                        <Header>
                            <RowLayoutColumnInfo OriginX="7" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="7" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogComments" IsBound="True" Key="QAErrorLogComments"
                        Width="475px" AllowUpdate="Yes">
                        <Header Caption="Comments">
                            <RowLayoutColumnInfo OriginX="8" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="8" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorTypeDisplayNA" Hidden="True" IsBound="True"
                        Key="QAErrorTypeDisplayNA" Type="CheckBox" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="9" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="9" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorTypeDisplayComments" Hidden="True"
                        IsBound="True" Key="QAErrorTypeDisplayComments" Type="CheckBox" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="10" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="10" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormCalculateScore" Hidden="True"
                        IsBound="True" Key="QAMonitoringFormCalculateScore">
                        <Header>
                            <RowLayoutColumnInfo OriginX="11" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="11" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorTypeAutomaticZeroScore" Hidden="True"
                        IsBound="True" Key="QAErrorTypeAutomaticZeroScore" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="12" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="12" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormID" Hidden="True" IsBound="True"
                        Key="QAMonitoringFormID" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="13" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="13" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLocationDescription" Hidden="True" IsBound="True"
                        Key="QAErrorLocationDescription" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="14" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="14" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAMonitoringFormName" Hidden="True" IsBound="True"
                        Key="QAMonitoringFormName" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="15" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="15" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="ImageName" Hidden="True" IsBound="True"
                        Key="ImageName" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="16" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="16" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="StatEmployeeID" Hidden="True" IsBound="True"
                        Key="ImageName" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="17" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="17" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorTypeGenerateLogIfNo" Hidden="True" IsBound="True"
                        Key="QAErrorTypeGenerateLogIfNo" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="18" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="18" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorLogNumberOfErrors" Hidden="True" IsBound="True"
                        Key="QAErrorLogNumberOfErrors" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="19" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="19" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="QAErrorTypeGenerateLogIfYes" Hidden="True" IsBound="True"
                        Key="QAErrorTypeGenerateLogIfNo" >
                        <Header>
                            <RowLayoutColumnInfo OriginX="20" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="20" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                </Columns>
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowDeleteDefault="Yes"
        AllowSortingDefault="OnClient" AllowUpdateDefault="Yes" BorderCollapseDefault="Separate"
        HeaderClickActionDefault="SortMulti" Name="ctl00xgridErrorsbyLocation" RowHeightDefault="20px"
        RowSelectorsDefault="No" SelectTypeRowDefault="Extended"
        StationaryMarginsOutlookGroupBy="True" Version="4.00" ViewType="OutlookGroupBy">
        <FrameStyle BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" Height="100%"
            Width="885px" Cursor="Default" ForeColor="#A37171">
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
            <GroupByBox Prompt="" Hidden="True">
            </GroupByBox>
    </DisplayLayout>
    </igtbl:UltraWebGrid>
    </div>
    <div style="z-index: 102; left: 5px; width: 695px; position: relative; 
    top: 0px; height: auto;">
    <asp:TextBox ID="txtComments" runat="server" Height="80px" Style="z-index: 101; left: 95px;
        position: absolute; top: 30px" TextMode="MultiLine" Width="240px" onKeyUp="TrackCount(this, 1000,'countdown1')"></asp:TextBox>
    <asp:Label ID="lblComments" runat="server" Style="z-index: 102; left: 25px; position: absolute;
        top: 30px" Text="Comments:"></asp:Label>
    <input type="hidden" name="userComments1" value=" " style="position: absolute;top:30px; width: 20px; left: 0px;" />
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp;  <span style="position: absolute;top:10px; left: 100px;">You have</span> <span id="countdown1" style="font-weight: bold;position: absolute;top:10px;left:160px ">1000</span> <span style="position: absolute;top:10px;left:195px ">remaining characters.</span>
    <asp:Button ID="btnSave" runat="server" Style="z-index: 103; left: 535px; position: absolute;
        top: 75px" Text="Save" Width="60px" OnClick="btnSave_Click" CausesValidation="False" UseSubmitBehavior="False" />
        <asp:Button ID="btnDelete" runat="server" Style="z-index: 105; left: 460px; position: absolute;
    top: 75px" Text="Delete" Width="60px" OnClick="btnDelete_Click" OnClientClick="var agree=confirm('Are you sure you wish to continue?');if (agree) return true ; else return false ; " />
    <asp:Button ID="btnCancel" runat="server" Style="z-index: 104;
        left: 615px; position: absolute; top: 75px" Text="Cancel" Width="60px" OnClick="btnCancel_Click" CausesValidation="False" UseSubmitBehavior="False" />
    <asp:Button ID="btnPrint" runat="server" Style="z-index: 105; left: 385px; position: absolute;
        top: 75px" Text="Print" Width="60px" OnClientClick="window.print()" CausesValidation="False" UseSubmitBehavior="False"/>
    <asp:Label ID="lblPointsEarned" runat="server" Style="z-index: 106; left: 405px; position: absolute;
        top: 5px" Text="Points Earned:" Width="100px"></asp:Label>
    <asp:Label ID="lblPointsEarnedData" runat="server" Style="z-index: 107; left: 515px; position: absolute;
        top: 5px" Width="160px"></asp:Label>
    <asp:Label ID="lblPointsAvailable" runat="server" Style="z-index: 108; left: 390px; position: absolute;
        top: 25px" Text="Points Available:" Width="115px"></asp:Label>
    <asp:Label ID="lblPointsAvailableData" runat="server" Style="z-index: 109; left: 515px; position: absolute;
        top: 25px"></asp:Label>
    <asp:Label ID="lblScore" runat="server" Style="z-index: 110; left: 470px; position: absolute;
        top: 50px" Text="Score:"></asp:Label>
    <asp:Label ID="lblScoreData" runat="server" Style="z-index: 113; left: 515px; position: absolute;
        top: 50px"></asp:Label>
         </div>


<div style="z-index: 107; left: 5px; width: 175px; position: relative; top: 5px;
    height: 205px">
    <igmisc:WebPageStyler ID="WebPageStyler1" runat="server" EnableAppStyling="True" StyleSetName="StatlineReports"  />
    &nbsp; &nbsp;&nbsp;
    <asp:ObjectDataSource ID="odsProcessStep" runat="server"
        SelectMethod="FillProcessStep" TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager">
        <SelectParameters>
            <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    &nbsp;
    <asp:ObjectDataSource ID="odsCompletedBy" runat="server" SelectMethod="FillPersonList"
        TypeName="Statline.StatTrac.Referral.ReferralManager">
        <SelectParameters>
            <asp:Parameter DefaultValue="194" Name="OrganizationId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
</div>
<igsch:WebCalendar ID="webCalendar" runat="server" style="z-index: 104; left: 235px; position: absolute; top: 755px" >
</igsch:WebCalendar>



