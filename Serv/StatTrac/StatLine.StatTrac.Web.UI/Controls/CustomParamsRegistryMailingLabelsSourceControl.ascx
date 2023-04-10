<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsRegistryMailingLabelsSourceControl.ascx.cs" Inherits="Statline.StatTac.Web.UI.Controls.CustomParamsRegistryMailingLabelsSourceControl" %>
<%@ Register assembly="Statline.StatTrac.Web" namespace="Statline.StatTrac.Web.UI.WebControls" tagprefix="StatTrac" %>
<div class="ParamLabeldAndControlWrapper">       
    <div class="ParamControlLabel">
        <asp:Label ID="lblSource" runat="server" Text="Source:"></asp:Label>
    </div>
    <div class="ParamControl">
        <StatTrac:DropDownListBase ID="ddlMailingLabelsSource" runat="server">
            <asp:ListItem>select one</asp:ListItem>
            <asp:ListItem Value="1">Web Registry</asp:ListItem>
            <asp:ListItem Value="2">State Registry</asp:ListItem>
            <asp:ListItem Value="3">Pending Registrants</asp:ListItem>
            <asp:ListItem Value="4">State Registry - Info Request</asp:ListItem>
        </StatTrac:DropDownListBase>
    </div>
</div>
    
