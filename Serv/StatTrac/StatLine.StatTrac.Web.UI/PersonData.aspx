<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonData.aspx.cs" Inherits="Statline.StatTrac.Web.UI.PersonData" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI"  TagPrefix="StatTrac" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register TagPrefix="stattrac" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<stattrac:sectionheader id="sectionHeaderQAConfig" runat="server" text="Add Person/Title/Organization" Style="z-index: 112;
            left: 0px; position: relative; top: 0px"
    width="100%"></stattrac:sectionheader>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Add Person to Organization Page</title>
</head>
<body >
    <form id="form1" runat="server">
    
        <asp:Button ID="Button1" runat="server" Style="z-index: 100; left: 285px; position: absolute;
            top: 245px" Text="Save" OnClick="Button1_Click" Width="49px" />
					<td style="HEIGHT: 25px"></td>
					<td style="WIDTH: 142px; HEIGHT: 25px" align="right">
    
        <asp:ObjectDataSource ID="odsPersonType" runat="server"
            OnSelecting="odsPersonType_Selecting" SelectMethod="FillPersonTitleListQA" TypeName="Statline.StatTrac.QAUpdate.QAUpdateManager" EnableCaching="True">
            <SelectParameters>
                <asp:Parameter DefaultValue="194" Name="organizationID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsOrgs" runat="server" EnableCaching="True" SelectMethod="FillOrganzationList"
            TypeName="Statline.StatTrac.Schedule.ScheduleManager">
            <SelectParameters>
                <asp:Parameter DefaultValue="194" Name="userOrgID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:Label ID="Label1" runat="server" Style="z-index: 101; left: 20px; position: absolute;
            top: 110px" Text="First Name:"></asp:Label>
                        &nbsp;
					<asp:textbox id="txtBoxFirstName" Width="200px" runat="server" MaxLength="50" style="z-index: 102; left: 100px; position: absolute; top: 105px"></asp:textbox>
						<asp:textbox id="txtBoxLastName" Width="200px" runat="server" MaxLength="50" style="z-index: 103; left: 100px; position: absolute; top: 135px"></asp:textbox>
                        &nbsp; &nbsp;
                        &nbsp;
						</td>
        &nbsp;
					&nbsp;
        <asp:Label ID="Label2" runat="server" Style="z-index: 104; left: 20px; position: absolute;
            top: 140px" Text="Last Name:"></asp:Label>
        <asp:Label ID="Label3" runat="server" Style="z-index: 105; left: 60px; position: absolute;
            top: 175px" Text="Title:"></asp:Label>
        <asp:Label ID="Label4" runat="server" Style="z-index: 106; left: 10px; position: absolute;
            top: 210px" Text="Organization:"></asp:Label>
        <igcmbo:WebCombo ID="ddlPersonType" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" DataSourceID="odsPersonType"
            DataTextField="PersonTypeName" DataValueField="PersonTypeID" Editable="True"
            EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue" SelForeColor="White"
            Style="z-index: 107; left: 100px; position: absolute; top: 170px" Version="4.00" Width="315px" OnInitializeLayout="ddlPersonType_InitializeLayout">
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
            <DropDownLayout BaseTableName="" ColHeadersVisible="No" ColWidthDefault="315px" DropdownWidth="315px"
            GridLines="None" RowSelectors="No" Version="4.00" XmlLoadOnDemandType="Accumulative">
            <FrameStyle Height="130px" Width="315px">
            </FrameStyle>
            <RowStyle BackColor="White" BorderColor="Gray" />
        </DropDownLayout>
        </igcmbo:WebCombo>
        <igcmbo:WebCombo ID="ddlOrganization" runat="server" BackColor="White" BorderColor="Silver"
            BorderStyle="Solid" BorderWidth="1px" ComboTypeAhead="Suggest" DataSourceID="odsOrgs"
            DataTextField="OrganizationName" DataValueField="OrganizationID" Editable="True"
            EnableXmlHTTP="True" ForeColor="Black" SelBackColor="DarkBlue"
            SelForeColor="White" Style="z-index: 108; left: 100px; position: absolute; top: 205px"
            Version="4.00" Width="315px">
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
             <DropDownLayout BaseTableName="" ColHeadersVisible="No" ColWidthDefault="315px" DropdownWidth="315px"
            GridLines="None" RowSelectors="No" Version="4.00" XmlLoadOnDemandType="Accumulative">
            <FrameStyle Height="130px" Width="315px">
            </FrameStyle>
            <RowStyle BackColor="White" BorderColor="Gray" />
        </DropDownLayout>
        </igcmbo:WebCombo>
        &nbsp;
        <asp:Button ID="Button2" runat="server" OnClientClick="window.close()" Style="z-index: 109;
            left: 365px; position: absolute; top: 245px" Text="Close" Width="49px" />
        <asp:Label ID="Label5" runat="server" ForeColor="Red" Style="z-index: 110; left: 30px;
            position: absolute; top: 80px" Text="Please fill out all of the fields." Visible="False"
            Width="325px"></asp:Label>
        
       
    </form>
</body>
</html>
