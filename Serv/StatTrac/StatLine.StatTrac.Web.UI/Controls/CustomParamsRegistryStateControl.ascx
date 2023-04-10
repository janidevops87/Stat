<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsRegistryStateControl.ascx.cs" Inherits="Statline.StatTac.Web.UI.Controls.CustomParamsRegistryStateControl" %>

<div class="ParamLabeldAndControlWrapper">       

    <div class="ParamControlLabel">
        <asp:Label ID="Label1" runat="server" Text="State:"></asp:Label>
    </div>
    <div class="ParamControl">                               
        <asp:CheckBoxList ID="chkBoxListState" runat="server" OnSelectedIndexChanged="chkBoxListState_SelectedIndexChanged" TextAlign="right" >
       </asp:CheckBoxList>

    </div>
</div>
