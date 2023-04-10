<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsScheduleLookupControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsScheduleLookupControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<div class="SectionSeperator">

    <div class="ParamControlLabel">
    Schdule Organization:
        </div>
    <div class="ParamControl">
            <igcmbo:webcombo id="ddlScheduleOrganization" runat="server" backcolor="White" bordercolor="Silver"
                borderstyle="Solid" borderwidth="1px" combotypeahead="Suggest" datasourceid="odsScheduleOrganization"
                editable="True" enablexmlhttp="True" forecolor="Black" selbackcolor="DarkBlue"
                selforecolor="White" version="4.00" Width="300px" OnSelectedRowChanged="ddlScheduleOrganization_SelectedRowChanged" DropImageXP1="/ig_common/images/ig_cmboDown1.bmp" DropImageXP2="/ig_common/images/ig_cmboDown2.bmp" OnInitializeLayout="ddlScheduleOrganization_InitializeLayout" DataTextField="OrganizationName" DataValueField="OrganizationID" OnDataBound="ddlScheduleOrganization_DataBound"><Columns>
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

<ExpandEffects ShadowColor="LightGray"></ExpandEffects>

<DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" RowSelectors="No" BaseTableName="">
<FrameStyle Cursor="Default" BackColor="Silver" BorderWidth="2px" BorderStyle="Ridge" Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="325px"></FrameStyle>

<HeaderStyle BackColor="LightGray" BorderStyle="Solid">
<BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
</HeaderStyle>

<RowStyle BackColor="White" BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid">
<BorderDetails WidthLeft="0px" WidthTop="0px"></BorderDetails>
</RowStyle>

<SelectedRowStyle BackColor="DarkBlue" ForeColor="White"></SelectedRowStyle>
</DropDownLayout>
</igcmbo:webcombo>
        </div>        
</div>
<div class="SectionSeperator">

    <div class="ParamControlLabel">
        Schedule Group:
            </div>
    <div class="ParamControl">
            <igmisc:webasyncrefreshpanel id="ajaxPanelScheduleGroup" runat="server" TriggerControlIDs="*$ddlScheduleOrganization"     >
            <igcmbo:webcombo id="ddlScheduleGroup" runat="server" backcolor="White"
                    bordercolor="Silver" borderstyle="Solid" borderwidth="1px" combotypeahead="Suggest"
                    datasourceid="odsScheduleGroup" editable="True" enablexmlhttp="True" forecolor="Black"
                    selbackcolor="DarkBlue" selforecolor="White" version="4.00" Width="300px" DropImageXP1="/ig_common/images/ig_cmboDown1.bmp" DropImageXP2="/ig_common/images/ig_cmboDown2.bmp" OnInitializeLayout="ddlScheduleGroup_InitializeLayout" DataTextField="ScheduleGroupName" DataValueField="ScheduleGroupID" OnDataBound="ddlScheduleGroup_DataBound"><Columns>
                        <igtbl:UltraGridColumn BaseColumnName="ScheduleGroupName" IsBound="True" Key="ScheduleGroupName">
                            <header caption="ScheduleGroupName"></header>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn BaseColumnName="ScheduleGroupID" IsBound="True" Key="ScheduleGroupID">
                            <header caption="ScheduleGroupID">
    <RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
    </header>
                            <footer>
    <RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
    </footer>
                        </igtbl:UltraGridColumn>
    </Columns>

    <ExpandEffects ShadowColor="LightGray"></ExpandEffects>

    <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" RowSelectors="No" BaseTableName="">
    <FrameStyle Cursor="Default" BackColor="Silver" BorderWidth="2px" BorderStyle="Ridge" Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="325px"></FrameStyle>

    <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"></BorderDetails>
    </HeaderStyle>

    <RowStyle BackColor="White" BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid">
    <BorderDetails WidthLeft="0px" WidthTop="0px"></BorderDetails>
    </RowStyle>

    <SelectedRowStyle BackColor="DarkBlue" ForeColor="White"></SelectedRowStyle>
    </DropDownLayout>
    </igcmbo:webcombo>    
        </igmisc:webasyncrefreshpanel> 

            </div>
        <asp:ObjectDataSource ID="odsScheduleGroup" runat="server" SelectMethod="FillScheduleGroupList"
                    TypeName="Statline.StatTrac.Schedule.ScheduleManager" OnSelected="odsScheduleGroup_Selected" OnSelecting="odsScheduleGroup_Selecting">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="" Name="OrgID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
</div>                
        <asp:ObjectDataSource ID="odsScheduleOrganization" runat="server" SelectMethod="FillOrganzationList"
        TypeName="Statline.StatTrac.Schedule.ScheduleManager" OnSelected="odsScheduleOrganization_Selected" OnSelecting="odsScheduleOrganization_Selecting">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="userOrgID" Type="Int32" />
        </SelectParameters>

</asp:ObjectDataSource> 
<igmisc:WebPageStyler ID="webPageStylerCustomParamsScheduleLookup" runat="server"
    EnableAppStyling="True" StyleSetName="StatlineReports" /> 
