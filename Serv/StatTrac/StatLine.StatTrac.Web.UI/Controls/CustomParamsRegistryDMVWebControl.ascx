<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsRegistryDMVWebControl.ascx.cs" Inherits="Statline.StatTac.Web.UI.Controls.CustomParamsRegistryDMVWebControl" %>
<div class="ParamLabeldAndControlWrapper">       
    <div class="ParamControlLabel">
        <asp:Label ID="lblRegistry" runat="server" Text="Registry:"></asp:Label>
    </div>
    <div class="ParamControl">
        <asp:CheckBoxList ID="chkBoxListRegistry" runat="server" TextAlign="right">
           <asp:ListItem Selected="True" Text="State"></asp:ListItem>
           <asp:ListItem Selected="True" Text="Web"></asp:ListItem>
           <asp:ListItem Selected="True" Text="DLA"></asp:ListItem>
        </asp:CheckBoxList>
    </div>
</div>
    
