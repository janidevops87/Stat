<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsRegistryDonorStatusControl.ascx.cs" Inherits="Statline.StatTac.Web.UI.Controls.CustomParamsRegistryDonorStatusControl" %>
<div class="ParamLabeldAndControlWrapper">       
    <div class="ParamControlLabel">
        <asp:Label ID="lblDonorStatus" runat="server" Text="Donor Status:"></asp:Label>
    </div>
    <div class="ParamControl">
        <asp:DropDownList ID="ddlDonorStatus" runat="server">
            <asp:ListItem Selected="True" Value="All">- All -</asp:ListItem>
            <asp:ListItem Value="1">Yes</asp:ListItem>
            <asp:ListItem Value="0">No</asp:ListItem>
        </asp:DropDownList>
    </div>
</div>
    
