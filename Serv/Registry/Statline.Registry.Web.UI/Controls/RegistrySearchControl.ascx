<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RegistrySearchControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.RegistrySearchControl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac"%>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<div style="position: relative; height: 744px; left: 0px; top: 0px; width: 772px;">
<div id="Section1" style="position: relative; width: 750px; height: 715px; font-size: 10pt; font-family: Arial; left: 11px; top: 11px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;">
    &nbsp;
    <asp:Label ID="lblSection1" runat="server" Text="Section 1" style="z-index: 100; left: 8px; position: absolute; top: 11px" Font-Bold="True"></asp:Label>
    <asp:Label ID="lblSection1Description" runat="server" Font-Bold="True" Style="z-index: 101;
        left: 22px; position: absolute; top: 28px" Text="Registrant Specific Information"
        Width="210px"></asp:Label>
    <asp:Label ID="lblInstructions" runat="server" Font-Bold="True" Style="z-index: 102;
        left: 325px; position: absolute; top: 8px" Text="Use * for wildcard searches"
        Width="250px"></asp:Label>
    <asp:Label ID="lblFirstName" runat="server" Style="z-index: 103; left: 361px; position: absolute;
        top: 36px" Text="First Name:"></asp:Label>
    <asp:Label ID="lblMiddleName" runat="server" Style="z-index: 104; left: 347px; position: absolute;
        top: 64px" Text="Middle Name:"></asp:Label>
    <asp:TextBox ID="txtFirstName" runat="server" Style="z-index: 105; left: 433px; position: absolute;
        top: 33px" Width="200px" TabIndex="1"></asp:TextBox>
    <asp:TextBox ID="txtMiddleName" runat="server" Style="z-index: 106; left: 434px; position: absolute;
        top: 60px" Width="200px" TabIndex="2"></asp:TextBox>
    <asp:Label ID="lblLast" runat="server" Style="z-index: 107; left: 361px; position: absolute;
        top: 92px" Text="Last Name:"></asp:Label>
    <asp:TextBox ID="txtLastName" runat="server" Style="z-index: 108; left: 435px; position: absolute;
        top: 88px" Width="200px" TabIndex="3"></asp:TextBox>
    <asp:Label ID="lblCity" runat="server" Style="z-index: 109; left: 398px; position: absolute;
        top: 118px" Text="City:" Width="28px"></asp:Label>
    <asp:TextBox ID="txtCity" runat="server" Style="z-index: 110; left: 434px; position: absolute;
        top: 116px" Width="200px" TabIndex="4"></asp:TextBox>
    <asp:Label ID="lblState" runat="server" Style="z-index: 111; left: 392px; position: absolute;
        top: 146px" Text="State:"></asp:Label>
    &nbsp;
    <asp:Label ID="lblZipCode" runat="server" Style="z-index: 112; left: 373px; position: absolute;
        top: 173px" Text="Zip Code:"></asp:Label>
    <asp:TextBox ID="txtZipCode" runat="server" Style="z-index: 113; left: 435px; position: absolute;
        top: 171px" Width="200px" TabIndex="6"></asp:TextBox>
    <asp:Label ID="lblStateID" runat="server" Style="z-index: 114; left: 311px; position: absolute;
        top: 202px" Text="State ID /License #:" Width="116px"></asp:Label>
    <asp:TextBox ID="txtStateID" runat="server" Style="z-index: 115; left: 434px; position: absolute;
        top: 199px" Width="200px" TabIndex="7"></asp:TextBox>
    <asp:Label ID="Label1" runat="server" Style="z-index: 116; left: 332px; position: absolute;
        top: 232px" Text="Web Registry #:"></asp:Label>
    <asp:TextBox ID="txtWebRegistryID" runat="server" Style="z-index: 117; left: 435px;
        position: absolute; top: 228px" Width="200px" TabIndex="8"></asp:TextBox>
    <asp:Label ID="lblDateOfBirth" runat="server" Style="z-index: 118; left: 353px; position: absolute;
        top: 258px" Text="Date of Birth:"></asp:Label>
    <igsch:webdatechooser id="ddlDOB" runat="server" style="z-index: 119;
        left: 435px; position: absolute; top: 256px" width="200px" Value="" TabIndex="9" EnableAppStyling="False" NullDateLabel="" NullValueRepresentation="Null">
        <CalendarLayout DropDownYearsNumber="100">
        </CalendarLayout>
    </igsch:webdatechooser>
    <igcmbo:webcombo id="ddlState" runat="server" backcolor="White" bordercolor="Silver"
        borderstyle="Solid" borderwidth="1px" forecolor="Black" selbackcolor="DarkBlue"
        selforecolor="White" style="z-index: 121; left: 436px; position: absolute; top: 144px"
        version="4.00" width="90px" DataSourceID="odsState" ComboTypeAhead="Simple" DataTextField="RegistryOwnerStateAbbrv" DataValueField="RegistryOwnerStateAbbrv" OnInitializeLayout="ddlState_InitializeLayout" Font-Names="Arial" Font-Size="11pt" TabIndex="5"><Columns>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateConfigID" DataType="System.Int32"
                IsBound="True" Key="RegistryOwnerStateConfigID">
                <header caption="RegistryOwnerStateConfigID"></header>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerID" DataType="System.Int32" IsBound="True"
                Key="RegistryOwnerID">
                <header caption="RegistryOwnerID">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateID" DataType="System.Int32"
                IsBound="True" Key="RegistryOwnerStateID">
                <header caption="RegistryOwnerStateID">
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateAbbrv" IsBound="True" Key="RegistryOwnerStateAbbrv">
                <header caption="RegistryOwnerStateAbbrv">
<RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateName" IsBound="True" Key="RegistryOwnerStateName">
                <header caption="RegistryOwnerStateName">
<RowLayoutColumnInfo OriginX="4"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="4"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateVerificationForm" IsBound="True"
                Key="RegistryOwnerStateVerificationForm">
                <header caption="RegistryOwnerStateVerificationForm">
<RowLayoutColumnInfo OriginX="5"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="5"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateDMVDSN" IsBound="True" Key="RegistryOwnerStateDMVDSN">
                <header caption="RegistryOwnerStateDMVDSN">
<RowLayoutColumnInfo OriginX="6"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="6"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateActive" DataType="System.Boolean"
                IsBound="True" Key="RegistryOwnerStateActive" Type="CheckBox">
                <header caption="RegistryOwnerStateActive">
<RowLayoutColumnInfo OriginX="7"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="7"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="CreateDate" DataType="System.DateTime" IsBound="True"
                Key="CreateDate">
                <header caption="CreateDate">
<RowLayoutColumnInfo OriginX="8"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="8"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="LastModified" DataType="System.DateTime" IsBound="True"
                Key="LastModified">
                <header caption="LastModified">
<RowLayoutColumnInfo OriginX="9"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="9"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="LastStatEmployeeID" DataType="System.Int32"
                IsBound="True" Key="LastStatEmployeeID">
                <header caption="LastStatEmployeeID">
<RowLayoutColumnInfo OriginX="10"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="10"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="AuditLogTypeID" DataType="System.Int32" IsBound="True"
                Key="AuditLogTypeID">
                <header caption="AuditLogTypeID">
<RowLayoutColumnInfo OriginX="11"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="11"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStatelblStateIdText" IsBound="True"
                Key="RegistryOwnerStatelblStateIdText">
                <header caption="RegistryOwnerStatelblStateIdText">
<RowLayoutColumnInfo OriginX="12"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="12"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStatelblLimitationsText" IsBound="True"
                Key="RegistryOwnerStatelblLimitationsText">
                <header caption="RegistryOwnerStatelblLimitationsText">
<RowLayoutColumnInfo OriginX="13"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="13"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateContactInformationText"
                IsBound="True" Key="RegistryOwnerStateContactInformationText">
                <header caption="RegistryOwnerStateContactInformationText">
<RowLayoutColumnInfo OriginX="14"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="14"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateLegalHeaderText" IsBound="True"
                Key="RegistryOwnerStateLegalHeaderText">
                <header caption="RegistryOwnerStateLegalHeaderText">
<RowLayoutColumnInfo OriginX="15"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="15"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateLegalIntroText" IsBound="True"
                Key="RegistryOwnerStateLegalIntroText">
                <header caption="RegistryOwnerStateLegalIntroText">
<RowLayoutColumnInfo OriginX="16"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="16"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateLegalText" IsBound="True"
                Key="RegistryOwnerStateLegalText">
                <header caption="RegistryOwnerStateLegalText">
<RowLayoutColumnInfo OriginX="17"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="17"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateLegalDescriptionlText" IsBound="True"
                Key="RegistryOwnerStateLegalDescriptionlText">
                <header caption="RegistryOwnerStateLegalDescriptionlText">
<RowLayoutColumnInfo OriginX="18"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="18"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateWebLegalHeader" IsBound="True"
                Key="RegistryOwnerStateWebLegalHeader">
                <header caption="RegistryOwnerStateWebLegalHeader">
<RowLayoutColumnInfo OriginX="19"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="19"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateWebLegalIntroText" IsBound="True"
                Key="RegistryOwnerStateWebLegalIntroText">
                <header caption="RegistryOwnerStateWebLegalIntroText">
<RowLayoutColumnInfo OriginX="20"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="20"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateWebLegalText" IsBound="True"
                Key="RegistryOwnerStateWebLegalText">
                <header caption="RegistryOwnerStateWebLegalText">
<RowLayoutColumnInfo OriginX="21"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="21"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="RegistryOwnerStateWebLegalDescriptionlText"
                IsBound="True" Key="RegistryOwnerStateWebLegalDescriptionlText">
                <header caption="RegistryOwnerStateWebLegalDescriptionlText">
<RowLayoutColumnInfo OriginX="22"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="22"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
</Columns>

<ExpandEffects ShadowColor="LightGray"></ExpandEffects>

<DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" BaseTableName="" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" ColWidthDefault="75px" DropdownWidth="75px" GridLines="None" RowSelectors="No">
<FrameStyle Cursor="Default" BackColor="Silver" BorderWidth="2px" BorderStyle="Ridge" Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="75px"></FrameStyle>

<HeaderStyle BackColor="LightGray" BorderStyle="Solid">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</HeaderStyle>

<RowStyle BackColor="White" BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid" Font-Names="Arial" Font-Size="11pt">
<BorderDetails WidthLeft="0px" WidthTop="0px"></BorderDetails>
</RowStyle>

<SelectedRowStyle BackColor="DarkBlue" ForeColor="White"></SelectedRowStyle>
</DropDownLayout>
</igcmbo:webcombo>
</div>
<div style="position: absolute; width: 750px; height: 90px; font-size: 10pt; font-family: Arial; left: 11px; top: 314px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" id="Section2">
    <asp:Label ID="lblSection2" runat="server" Font-Bold="True" Style="z-index: 100;
        left: 10px; position: absolute; top: 8px" Text="Section 2"></asp:Label>
    <asp:Label ID="lblSection2Description" runat="server" Font-Bold="True" Style="z-index: 101;
        left: 29px; position: absolute; top: 25px" Text="Registry Options" Width="107px"></asp:Label>
    <asp:Label ID="lblRegistry" runat="server" Style="z-index: 102; left: 374px; position: absolute;
        top: 11px" Text="Registry:"></asp:Label>
    <asp:CheckBox ID="cboWeb" runat="server" Style="z-index: 103; left: 438px; position: absolute;
        top: 11px" Text="Web Registry" Width="150px" Checked="True" TabIndex="20" />
    <asp:CheckBox ID="cboDMV" runat="server" Style="z-index: 104; left: 439px; position: absolute;
        top: 34px" Text="DMV Registry" Width="150px" Checked="True" TabIndex="21" />
    <asp:CheckBox ID="cboWebPending" runat="server" Style="z-index: 106; left: 439px;
        position: absolute; top: 57px" Text="Pending Signature" Width="150px" Visible="False" TabIndex="22" />
</div>
<div style="position: absolute; width: 750px; height: 56px; font-size: 10pt; font-family: Arial; left: 11px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid; top: 670px;" id="Section5">
    <asp:Button ID="btnSearch" runat="server" Style="z-index: 100; left: 274px; position: absolute;
        top: 22px" Text="Search" Width="100px" OnClick="btnSearch_Click" TabIndex="50" />
    <asp:Button ID="btnReset" runat="server" Style="z-index: 102; left: 386px; position: absolute;
        top: 21px" Text="Reset" Width="98px" OnClick="btnReset_Click" TabIndex="51" />
    <asp:ObjectDataSource ID="odsState" runat="server" SelectMethod="FillRegistryOwnerStateConfig" TypeName="Statline.Registry.Common.RegistryCommonManager" OnSelecting="odsState_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="1" Name="RegistryOwnerID" SessionField="RegistryOwnerID"
                Type="Int32" />
            <asp:SessionParameter DefaultValue="1" Name="DisplayAllStates" SessionField="DisplayAllStates"
                Type="Int16" />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>
<div style="position: absolute; width: 750px; height: 117px; font-size: 10pt; font-family: Arial; left: 11px; top: 554px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" id="Section4">
    <asp:Label ID="lblSection4" runat="server" Font-Bold="True" Style="z-index: 100;
        left: 16px; position: absolute; top: 9px" Text="Section 4"></asp:Label>
    <asp:Label ID="lblSection4Description" runat="server" Font-Bold="True" Style="z-index: 101;
        left: 39px; position: absolute; top: 26px" Text="Sort options"></asp:Label>
    <asp:Label ID="lblSort1" runat="server" Style="z-index: 102; left: 377px; position: absolute;
        top: 14px" Text="Sort By:"></asp:Label>
    <asp:Label ID="lblSort2" runat="server" Style="z-index: 103; left: 375px; position: absolute;
        top: 44px" Text="Then By:"></asp:Label>
    <asp:Label ID="lblSort3" runat="server" Style="z-index: 104; left: 375px; position: absolute;
        top: 71px" Text="Then By:"></asp:Label>
    <igcmbo:WebCombo ID="ddlSort1" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" OnSelectedRowChanged="ddlSort1_SelectedRowChanged"
        SelBackColor="DarkBlue" SelForeColor="White" Style="z-index: 105; left: 443px;
        position: absolute; top: 12px" Version="4.00" Font-Names="Arial" Font-Size="11pt" OnInitializeLayout="ddlSort1_InitializeLayout" TabIndex="40">
        <Columns>
            <igtbl:UltraGridColumn BaseColumnName="SortBy1">
                <header caption="Column0"></header>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="SortField1" Hidden="True">
                <header>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
        </Columns>
        <ExpandEffects ShadowColor="LightGray" />
        <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" ColHeadersVisible="No" ColWidthDefault="200px" DropdownHeight="100px" DropdownWidth="200px" GridLines="None" RowSelectors="No" XmlLoadOnDemandType="Accumulative">
            <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                Font-Names="Verdana" Font-Size="10pt" Height="100px" Width="200px">
            </FrameStyle>
            <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </HeaderStyle>
            <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px" Font-Names="Arial" Font-Size="11pt">
                <BorderDetails WidthLeft="0px" WidthTop="0px" />
            </RowStyle>
            <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
        </DropDownLayout>
        <Rows>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Last Name"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="LastName"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="First Name"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="FirstName"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Zip Code"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="Zip"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Date of Birth"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="DOB"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="State"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="State"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
        </Rows>
    </igcmbo:WebCombo>
    <igcmbo:WebCombo ID="ddlSort2" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" OnSelectedRowChanged="ddlSort2_SelectedRowChanged"
        SelBackColor="DarkBlue" SelForeColor="White" Style="z-index: 106; left: 444px;
        position: absolute; top: 41px" Version="4.00" Font-Names="Arial" Font-Size="11pt" TabIndex="41">
        <Columns>
            <igtbl:UltraGridColumn BaseColumnName="SortBy2">
                <header caption="Column0"></header>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="SortField2" Hidden="True">
                <header>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
        </Columns>
        <ExpandEffects ShadowColor="LightGray" />
        <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" ColHeadersVisible="No" ColWidthDefault="200px" DropdownHeight="100px" DropdownWidth="200px" GridLines="None" RowSelectors="No" XmlLoadOnDemandType="Accumulative">
            <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                Font-Names="Verdana" Font-Size="10pt" Height="100px" Width="200px">
            </FrameStyle>
            <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </HeaderStyle>
            <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px" Font-Names="Arial" Font-Size="11pt">
                <BorderDetails WidthLeft="0px" WidthTop="0px" />
            </RowStyle>
            <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
        </DropDownLayout>
        <Rows>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Last Name"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="LastName"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="First Name"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="FirstName"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Zip Code"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="Zip"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Date of Birth"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="DOB"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="State"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="State"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
        </Rows>
    </igcmbo:WebCombo>
    <igcmbo:WebCombo ID="ddlSort3" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 108; left: 443px; position: absolute; top: 70px"
        Version="4.00" Font-Names="Arial" Font-Size="11pt" TabIndex="42">
        <Columns>
            <igtbl:UltraGridColumn BaseColumnName="SortBy3">
                <header caption="Column0"></header>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="SortField3" Hidden="True">
                <header>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
        </Columns>
        <ExpandEffects ShadowColor="LightGray" />
        <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" ColHeadersVisible="No" ColWidthDefault="200px" DropdownHeight="100px" DropdownWidth="200px" GridLines="None" RowSelectors="No" XmlLoadOnDemandType="Accumulative">
            <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                Font-Names="Verdana" Font-Size="10pt" Height="100px" Width="200px">
            </FrameStyle>
            <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </HeaderStyle>
            <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px" Font-Names="Arial" Font-Size="11pt">
                <BorderDetails WidthLeft="0px" WidthTop="0px" />
            </RowStyle>
            <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
        </DropDownLayout>
        <Rows>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Last Name"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="LastName"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="First Name"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="FirstName"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Zip Code"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="Zip"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="Date of Birth"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="DOB"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
            <igtbl:UltraGridRow Height="">
                <cells>
<igtbl:UltraGridCell Text="State"></igtbl:UltraGridCell>
<igtbl:UltraGridCell Text="State"></igtbl:UltraGridCell>
</cells>
            </igtbl:UltraGridRow>
        </Rows>
    </igcmbo:WebCombo>
</div>
<div id="divSection3" runat='server' style="position: absolute; width: 750px; height: 152px; font-size: 10pt; font-family: Arial; left: 11px; top: 403px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" >
    <asp:Label ID="lblSection3" runat="server" Font-Bold="True" Style="z-index: 100;
        left: 12px; position: absolute; top: 8px" Text="Section 3"></asp:Label>
    <asp:Label ID="lblStateOptions" runat="server" Font-Bold="True" Style="z-index: 101; left: 34px;
        position: absolute; top: 25px" Text="State Options"></asp:Label>
    <asp:Label ID="lblSection3State" runat="server" Style="z-index: 102; left: 389px; position: absolute;
        top: 11px" Text="State:"></asp:Label>
</div>
</div>