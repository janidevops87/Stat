<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAErrorDetailControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.QAErrorDetailControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<asp:ScriptManager ID="scriptManager1" runat="server">
</asp:ScriptManager>
<stattrac:sectionheader id="sectionHeaderErrorDetail" runat="server" text="Error Type Detail"
    width="100%"></stattrac:sectionheader>
<div style="z-index: 103; left: 5px; width: 565px; position: relative; 
    height: 550px; top: -8px;">
<asp:Label ID="lblEmployee" runat="server" Style="z-index: 100; left: 65px; position: absolute;
    top: 8px" Text="Employee:" Font-Italic="True"></asp:Label>
<asp:Label ID="lblEmployeeData" runat="server" Style="z-index: 101; left: 140px; position: absolute;
    top: 8px" Font-Italic="True"></asp:Label>
<asp:Label ID="lblErrorLocation" runat="server" Style="z-index: 102; left: 35px; position: absolute;
    top: 25px" Text="Error Location:" Font-Italic="True"></asp:Label>
<asp:Label ID="lblErrorLocationData" runat="server" Style="z-index: 103; left: 140px; position: absolute;
    top: 25px" Font-Italic="True"></asp:Label>
<asp:Label ID="lblDateTime" runat="server" Style="z-index: 104; left: 60px; position: absolute;
    top: 155px" Text="Date/Time:"></asp:Label>
<input type="hidden" name="userComments1" value=" " style="position: absolute;top:235px; left: 405px; width: 10px; z-index: 122;" />
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp;  <span style="position: absolute;top:240px; left: 140px; z-index: 123;">You have</span> <span id="countdown" style="font-weight: bold;position: absolute;top:240px;left:200px ; z-index: 124;">1000</span> <span style="position: absolute;top:240px;left:235px ; z-index: 125;">remaining characters.</span>    
<asp:Label ID="lblComment" runat="server" Style="z-index: 105; left: 60px; position: absolute;
    top: 260px" Text="Comment:"></asp:Label>
<asp:Label ID="lblTicketNumber" runat="server" Style="z-index: 106; left: 70px; position: absolute;
    top: 210px" Text="Ticket #:"></asp:Label>
<asp:Label ID="lblHowIdentified" runat="server" Style="z-index: 107; left: 30px; position: absolute;
    top: 180px" Text="How Identified:"></asp:Label>
<asp:Label ID="lblNumberofErrors" runat="server" Style="z-index: 108; left: 60px; position: absolute;
    top: 130px" Text="# of Errors:"></asp:Label>
<asp:Label ID="lblProcessStep" runat="server" Style="z-index: 109; left: 50px; position: absolute;
    top: 105px" Text="Process Step:"></asp:Label>
    <asp:Label ID="Label2" runat="server" Style="z-index: 109; left: 40px; position: absolute;
    top: 80px" Text="Tracking Type:"></asp:Label>
<asp:Label ID="lblError" runat="server" Style="z-index: 110; left: 55px; position: absolute;
    top: 56px" Text="Error Type:"></asp:Label>
<asp:TextBox ID="txtNumberofErrors" runat="server" Style="z-index: 111; left: 135px; position: absolute;
    top: 130px" MaxLength="3" Width="80px" TabIndex="2"></asp:TextBox>
<asp:Button ID="btnDelete" runat="server" Style="z-index: 112; left: 310px; position: absolute;
    top: 505px" Text="Delete" Width="60px" OnClick="btnDelete_Click" Enabled="False" />
<asp:Button ID="btnCancel" runat="server" Style="z-index: 113; left: 460px; position: absolute;
    top: 505px" Text="Cancel" OnClick="btnCancel_Click" />
<asp:Button ID="btnSave" runat="server" Style="z-index: 114; left: 385px; position: absolute;
    top: 505px" Text="Save" Width="60px" OnClick="btnSave_Click" TabIndex="8" />
<igcmbo:WebCombo ID="ddlError" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="335px"
    SelForeColor="White" Style="z-index: 119; left: 135px; position: absolute; top: 55px"
    Version="4.00" DataSourceID="odsErrorType" OnInitializeLayout="ddlError_InitializeLayout" DataTextField="QAErrorTypeDescription" DataValueField="QAErrorTypeID" OnPreRender="ddlError_PreRender" EnableAppStyling="True" TabIndex="-1" Height="20px">
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
    <DropDownLayout Version="4.00" ColWidthDefault="335px" DropdownWidth="335px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="335px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
<igcmbo:WebCombo ID="ddlTrackingType" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="335px"
    SelForeColor="White" Style="z-index: 119; left: 135px; position: absolute; top: 80px"
    Version="4.00" DataSourceID="odsTrackingType" OnInitializeLayout="ddlTrackingType_InitializeLayout" DataTextField="QATrackingTypeDescription" DataValueField="QATrackingTypeID" OnPreRender="ddlTrackingType_PreRender" EnableAppStyling="True" TabIndex="-1" Height="20px">
    <Columns>
        <igtbl:UltraGridColumn BaseColumnName="QATrackingTypeID" DataType="System.Int32"
            IsBound="True" Key="QATrackingTypeID">
            <header caption="QATrackingTypeID"></header>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="OrganizationID" DataType="System.Int32" IsBound="True"
            Key="OrganizationID">
            <header caption="OrganizationID">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
            <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="QATrackingTypeDescription" IsBound="True"
            Key="QATrackingTypeDescription">
            <header caption="QATrackingTypeDescription">
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</header>
            <footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="LastModified" DataType="System.DateTime" IsBound="True"
            Key="LastModified">
            <header caption="LastModified">
<RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
</header>
            <footer>
<RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
</footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="LastStatEmployeeID" DataType="System.Int32"
            IsBound="True" Key="LastStatEmployeeID">
            <header caption="LastStatEmployeeID">
<RowLayoutColumnInfo OriginX="4"></RowLayoutColumnInfo>
</header>
            <footer>
<RowLayoutColumnInfo OriginX="4"></RowLayoutColumnInfo>
</footer>
        </igtbl:UltraGridColumn>
        <igtbl:UltraGridColumn BaseColumnName="AuditLogTypeID" DataType="System.Int32" IsBound="True"
            Key="AuditLogTypeID">
            <header caption="AuditLogTypeID">
<RowLayoutColumnInfo OriginX="5"></RowLayoutColumnInfo>
</header>
            <footer>
<RowLayoutColumnInfo OriginX="5"></RowLayoutColumnInfo>
</footer>
        </igtbl:UltraGridColumn>
    </Columns>
    <ExpandEffects ShadowColor="LightGray" />
    <DropDownLayout Version="4.00" ColWidthDefault="335px" DropdownWidth="335px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="335px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
<igcmbo:WebCombo ID="ddlProcessStep" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="335px"
    SelForeColor="White" Style="z-index: 115; left: 135px; position: absolute; top: 105px"
    Version="4.00" DataSourceID="odsProcessStep" OnInitializeLayout="ddlProcessStep_InitializeLayout" DataTextField="QAProcessStepDescription" DataValueField="QAProcessStepID" OnPreRender="ddlProcessStep_PreRender" EnableAppStyling="True" TabIndex="1" Height="20px">
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
    <DropDownLayout Version="4.00" ColWidthDefault="335px" DropdownWidth="335px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="335px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
<igcmbo:WebCombo ID="ddlHowIndentified" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="335px"
    SelForeColor="White" Style="z-index: 116; left: 135px; position: absolute; top: 180px"
    Version="4.00" DataSourceID="odsHowID" OnInitializeLayout="ddlHowIndentified_InitializeLayout" DataTextField="QAErrorLogHowIdentifiedDescription" DataValueField="QAErrorLogHowIdentifiedID" OnPreRender="ddlHowIndentified_PreRender" EnableAppStyling="True" TabIndex="4">
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
    <DropDownLayout Version="4.00" ColWidthDefault="335px" DropdownWidth="335px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="335px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
<asp:TextBox ID="txtTicketNumber" runat="server" Style="z-index: 117; left: 135px; position: absolute;
    top: 210px" MaxLength="20" TabIndex="5"></asp:TextBox>
<asp:TextBox ID="txtComment" runat="server" Height="95px" Style="z-index: 118; left: 130px;
    position: absolute; top: 260px" TextMode="MultiLine" Width="350px" onKeyUp="TrackCount(this, 1000,'countdown')" TabIndex="6"></asp:TextBox>
<StatTrac:WebDateTime ID="dateErrorDateTime" runat="server" Style="z-index: 119; left: 140px;
    position: absolute; top: 150px" WebCalendarID="webCalendar1" Width="190px" EditModeFormat="MM/dd/yyyy HH:mm" TabIndex="3" >
    <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
    </ButtonsAppearance>
    <SpinButtons Display="OnRight" />
</StatTrac:WebDateTime>

<fieldset ID="Panel1" runat="server"  Style="z-index: 126; left: 10px;
    position: absolute; top: 360px; width: 510px; height: 140px;" >
    <legend accesskey="I" style="font-weight: bold; z-index: 103; left: 0px; position: absolute; top: 0px;">Correction</legend>
    <asp:Label ID="lblLastPersonSaved" runat="server" Style="z-index: 100; left: 10px; position: absolute;
        top: 25px" Width="120px" Font-Italic="True"></asp:Label>
    <asp:Label ID="lblLastDateSaved" runat="server" Style="z-index: 101; left: 160px; position: absolute;
        top: 25px" Width="130px" Font-Italic="True"></asp:Label>
    <input type="hidden" name="userComments1" value=" " style="position: absolute;top:40px; left: 280px; width: 10px;" />
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp;  <span style="position: absolute;top:50px; left: 5px;">You have</span> <span id="countdown1" style="font-weight: bold;position: absolute;top:50px;left:65px ">1000</span> <span style="position: absolute;top:50px;left:100px ">remaining characters.</span>   
    <asp:TextBox ID="txtCorrection" runat="server" Height="65px" Style="z-index: 104; left: 5px;
        position: absolute; top: 65px" TextMode="MultiLine" Width="480px" onKeyUp="TrackCount(this, 1000,'countdown1')" TabIndex="7"></asp:TextBox>
</fieldset>
    <asp:Label ID="Label1" runat="server" Font-Italic="True" Style="z-index: 119; left: 62px;
        position: absolute; top: 40px" Text="Tracking #:"></asp:Label>
    <asp:Label ID="lblTrackingNumberData" runat="server" Font-Italic="True" Style="z-index: 120; left: 140px;
        position: absolute; top: 40px"></asp:Label>
    <asp:CheckBox ID="cbxReviewed" runat="server" Style="z-index: 127; left: 355px; position: absolute;
        top: 210px" Text="QA Reviewed:" TextAlign="Left" />
</div>
    <igsch:WebCalendar ID="webCalendar1" runat="server" Visible="true" Style="z-index: 100; left: 285px; position: absolute; top: 595px;">
    </igsch:WebCalendar>

<igmisc:WebPageStyler ID="webPageStyler" runat="server" StyleSetName="StatlineReports" EnableAppStyling="True"  />
<asp:ObjectDataSource ID="odsErrorType" runat="server" SelectMethod="FillErrorType"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
    OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="QAErrorLocationID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="QATrackingTypeID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsProcessStep" runat="server"
    SelectMethod="FillProcessStep" 
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
    OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsHowID" runat="server" SelectMethod="FillQAErrorLogHowIdentified"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
    OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsTrackingType" runat="server" SelectMethod="FillTrackingType"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
    OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
