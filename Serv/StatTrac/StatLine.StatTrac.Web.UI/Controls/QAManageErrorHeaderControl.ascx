<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QAManageErrorHeaderControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.QAManageErrorHeaderControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<div style="z-index: 100; left: 0px; width: 500px; position: relative;   height: 75px; top: 0px;">
    
    <asp:Label ID="lblOrganization" runat="server" Style="z-index: 100; left: 95px; position: relative; top: 5px;" Text="Organization: " Width="80px"></asp:Label>
    <igcmbo:WebCombo ID="ddlOrganization" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 101; left: 180px; position: relative; top: -8px;"
        Version="4.00" DataSourceID="odsOrgs" OnSelectedRowChanged="ddlOrganization_SelectedRowChanged" DataTextField="OrganizationName" DataValueField="OrganizationID" Editable="True" EnableXmlHTTP="True" ComboTypeAhead="Suggest" Width="315px" OnInitializeLayout="ddlOrganization_InitializeLayout">
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
        <DropDownLayout Version="4.00" ColWidthDefault="315px" DropdownWidth="315px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No">
                    <FrameStyle Height="130px" Width="315px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
    </igcmbo:WebCombo>
    <asp:Label ID="lblQualityMonitoringForm" runat="server" Style="z-index: 102; left: 15px;
        position: relative; top: 0px;" Text="Quality Monitoring Form:" Width="160px" Visible="False"></asp:Label>
    <igcmbo:WebCombo ID="ddlQMF" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Style="z-index: 103; left: 180px; position: relative;top: -18px; "
        Version="4.00" Visible="False" Width="315px" DataSourceID="odsForms" DataTextField="QAMonitoringFormName" DataValueField="QAMonitoringFormID" OnInitializeLayout="ddlQMF_InitializeLayout" OnSelectedRowChanged="ddlQMF_SelectedRowChanged" >
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
       <DropDownLayout Version="4.00" ColWidthDefault="315px" DropdownWidth="315px"  BaseTableName="" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No">
                    <FrameStyle Height="75px" Width="315px" > </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
    </igcmbo:WebCombo>
    &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
    <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Style="z-index: 104;
        left: 180px; position: relative; top: -8px" Text="Add" Visible="False" />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/QA.aspx"
         Text="Back to QA" style="z-index: 105; left: 375px; position: relative; top: -8px"></asp:HyperLink>    
    <asp:CheckBox ID="cbxDisplayAll" runat="server" Style="z-index: 106; left: 160px;
        position: relative; top: -8px;" Text="Display All" Width="100px" />&nbsp;
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="z-index: 108;
        left: 45px; position: absolute; top: 75px" Text="Button" />
</div>
<asp:ObjectDataSource ID="odsOrgs" runat="server" SelectMethod="FillOrganzationList"
    TypeName="Statline.StatTrac.Schedule.ScheduleManager" EnableCaching="True">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="userOrgID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsForms" runat="server" SelectMethod="FillQAForm" TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager">
</asp:ObjectDataSource>
