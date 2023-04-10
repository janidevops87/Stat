<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsErrorInfoControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsErrorInfoControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
         <fieldset style="width:465px; height: 160px;">
            <legend>Error Information</legend>
             <div class="ParamControl"> 
             <asp:Label ID="Label5" runat="server"  Text="Tracking Type:"></asp:Label>

<igcmbo:WebCombo ID="ddlTrackingType" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Width="300px"
        Version="4.00" DataSourceID="odsTrackingType" OnInitializeLayout="ddlTrackingType_InitializeLayout" OnSelectedRowChanged="ddlTrackingType_SelectedRowChanged" DataTextField="QATrackingTypeDescription" DataValueField="QATrackingTypeID" Editable="True" EnableAppStyling="True">
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
        <DropDownLayout Version="4.00" ColWidthDefault="300px" DropdownWidth="300px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="300px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
    </igcmbo:WebCombo> 
<asp:Label ID="Label4" runat="server"  Text="Error Location:"></asp:Label>
<asp:CheckBox ID="ckboxNoErrors" runat="server" Text="No Errors" Visible="false"/> 
<igcmbo:WebCombo ID="ddlErrorLocation" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue"
        SelForeColor="White" Width="300px"
        Version="4.00" DataSourceID="odsErrorLocation" OnInitializeLayout="ddlErrorLocation_InitializeLayout" DataTextField="QAErrorLocationDescription" DataValueField="QAErrorLocationID" Editable="True" EnableAppStyling="True">
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
        <DropDownLayout Version="4.00" ColWidthDefault="300px" DropdownWidth="300px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="300px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
    </igcmbo:WebCombo>        
    
                 
<asp:Label ID="Label2" runat="server"  Text="Process Step:"></asp:Label>
<igcmbo:WebCombo ID="ddlProcessStep" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="300px"
    SelForeColor="White" 
    Version="4.00" DataSourceID="odsProcessStep" OnInitializeLayout="ddlProcessStep_InitializeLayout" DataTextField="QAProcessStepDescription" DataValueField="QAProcessStepID" EnableAppStyling="True" TabIndex="1" OnSelectedRowChanged="ddlProcessStep_SelectedRowChanged">
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
    <DropDownLayout Version="4.00" ColWidthDefault="300px" DropdownWidth="300px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="300px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
<asp:Label ID="Label3" runat="server"  Text="Error Type:"></asp:Label>
              <igcmbo:WebCombo ID="ddlError" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="300px"
    SelForeColor="White" 
    Version="4.00" DataSourceID="odsErrorType" OnInitializeLayout="ddlError_InitializeLayout"   DataTextField="QAErrorTypeDescription" DataValueField="QAErrorTypeID" EnableAppStyling="True" TabIndex="-1"> 
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
    <DropDownLayout Version="4.00" ColWidthDefault="300px" DropdownWidth="300px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="300px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
<asp:Label ID="Label1" runat="server"  Text="How Identified:"></asp:Label>
<igcmbo:WebCombo ID="ddlHowIndentified" runat="server" BackColor="White" BorderColor="Silver"
    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" SelBackColor="DarkBlue" Width="300px"
    SelForeColor="White" 
    Version="4.00" DataSourceID="odsHowID" OnInitializeLayout="ddlHowIndentified_InitializeLayout" DataTextField="QAErrorLogHowIdentifiedDescription" DataValueField="QAErrorLogHowIdentifiedID" EnableAppStyling="True" TabIndex="4">
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
    <DropDownLayout Version="4.00" ColWidthDefault="300px" DropdownWidth="300px" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" GridLines="None" RowSelectors="No" BaseTableName="">
                    <FrameStyle Height="130px" Width="300px"> </FrameStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" />
                </DropDownLayout>
</igcmbo:WebCombo>
                 &nbsp;
<asp:ObjectDataSource ID="odsHowID" runat="server" SelectMethod="FillQAErrorLogHowIdentified"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" OnSelecting="odsHowID_Selecting"></asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsProcessStep" runat="server" SelectMethod="FillProcessStep"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" OnSelecting="odsProcessStep_Selecting">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
                 <asp:ObjectDataSource ID="odsTrackingType" runat="server" SelectMethod="FillTrackingType"
                     TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" OnSelecting="odsTrackingType_Selecting">
                     <SelectParameters>
                         <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
                     </SelectParameters>
                 </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsErrorLocation" runat="server" SelectMethod="FillQAErrorLocation"
        TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" 
                     OnSelecting="odsErrorLocation_Selecting" 
                     OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="QAErrorLocationActive" Type="Int16" />
            <asp:Parameter DefaultValue="0" Name="QATrackingTypeID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsErrorType" runat="server" SelectMethod="FillErrorType"
    TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" OnSelecting="odsErrorType_Selecting" 
                     OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter DefaultValue="194" Name="OrganizationID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="QAErrorLocationID" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="QATrackingTypeID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<igmisc:WebPageStyler ID="webPageStyler" runat="server" EnableAppStyling="True" StyleSetName="StatlineReports" style="z-index: 92; left: 10px; position: absolute; top: 365px" />
    </div> 
        </fieldset>


