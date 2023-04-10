<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsMessageImportControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsMessageImportControl" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>

    <igmisc:WebAsyncRefreshPanel ID="ajaxPanelCallerOrganization" runat="server" Width="680px" >    
    <div class="SectionSeperator">
        <div class="ParamControlLabel">
            Caller Organization:            
        </div>
        <div class="ParamControl">
            <asp:TextBox ID="txtBoxCallerOrganization" runat="server" Width="500px"></asp:TextBox>
        </div>    
    </div>
    <div class="SectionSeperator">
        <div class="ParamControlLabel">
            Message For Organization:    
        </div>
        <div class="ParamControl">
            <igcmbo:WebCombo ID="ddlCallerOrganization" runat="server" BackColor="White" BorderColor="Gray" ForeColor="Black" SelBackColor="10, 36, 106"
                  SelForeColor="White" Version="3.00" ComboTypeAhead="Suggest" DataTextField="OrganizationName" DataValueField="OrganizationID" DropImageXP1="/ig_common/images/ig_cmboDown1.bmp" DropImageXP2="/ig_common/images/ig_cmboDown2.bmp" Editable="True" EnableXmlHTTP="True" Width="500px" DisplayValue="..." Height="20px" OnSelectedRowChanged="ddlCallerOrganization_SelectedRowChanged" OnInitializeLayout="ddlCallerOrganization_InitializeLayout" DataSourceID="odsOrganizationList" EnableAppStyling="True">
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
                <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="3.00" XmlLoadOnDemandType="Accumulative" ColHeadersVisible="No" RowSelectors="No" BaseTableName="">
                    <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                        Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="325px">
                    </FrameStyle>
                    <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                        <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                    </HeaderStyle>
                    <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px">
                        <BorderDetails WidthLeft="0px" WidthTop="0px" />
                    </RowStyle>
                    <SelectedRowStyle BackColor="#0A246A" ForeColor="White" />
                </DropDownLayout>
                </igcmbo:WebCombo>        
        </div>
    </div>            
    </igmisc:WebAsyncRefreshPanel>
    <div class="SectionSeperator">
    
                    <div class="ParamControlLabel" >
                        Message For:
                    </div>
                    <div class="ParamControl" >
                    <igmisc:WebAsyncRefreshPanel ID="ajaxPanelMessageFor" runat="server" >
                    <igcmbo:WebCombo ID="ddlPersonList" runat="server" BackColor="White" BorderColor="Gray" ForeColor="Black" SelBackColor="10, 36, 106"
                        SelForeColor="White" Version="3.00" ComboTypeAhead="Suggest" DataSourceID="odsPersonList" DataTextField="PersonName" DataValueField="PersonID" DisplayValue="..." DropImageXP1="/ig_common/images/ig_cmboDown1.bmp" DropImageXP2="/ig_common/images/ig_cmboDown2.bmp" Editable="True" EnableXmlHTTP="True" Width="500px" Height="20px" OnInitializeLayout="ddlPersonList_InitializeLayout" EnableAppStyling="True">
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
                        <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="3.00" ColHeadersVisible="No" RowSelectors="No" XmlLoadOnDemandType="Accumulative" BaseTableName="">
                            <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                                Font-Names="Verdana" Font-Size="10pt" Height="130px" Width="325px">
                            </FrameStyle>
                            <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                            </HeaderStyle>
                            <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px">
                                <BorderDetails WidthLeft="0px" WidthTop="0px" />
                            </RowStyle>
                            <SelectedRowStyle BackColor="#0A246A" ForeColor="White" />
                        </DropDownLayout>
                    </igcmbo:WebCombo>
                    </igmisc:WebAsyncRefreshPanel>
                    </div>
            	
                    <asp:ObjectDataSource ID="odsPersonList" runat="server" EnableCaching="True" SelectMethod="FillPersonList"
                        TypeName="Statline.StatTrac.Report.ReportReferenceManager" OnSelecting="odsPersonList_Selecting" OnSelected="odsPersonList_Selected">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="organizationId" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
  		            <asp:ObjectDataSource ID="odsOrganizationList" runat="server" OnSelected="odsOrganizationList_Selected"
                            OnSelecting="odsOrganizationList_Selecting" SelectMethod="FillOrganizationList"
                            TypeName="Statline.StatTrac.Report.ReportReferenceManager">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="..." Name="sourceCode" Type="String" />
                                <asp:Parameter DefaultValue="0" Name="sourceCodeType" Type="Int32" />
                                <asp:Parameter DefaultValue="0" Name="organizationID" Type="Int32" />
                            </SelectParameters>
                    </asp:ObjectDataSource>
                    <igmisc:WebPageStyler ID="WebPageStyler1" runat="server" EnableAppStyling="True"
                StyleSetName="StatlineReports" />
    </div>                