<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsDisplayTriageFSControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsDisplayTriageFSControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<div class="ParamCheckBox" >
    <asp:CheckBox id="chkBoxDisplayTriage" runat="server" TextAlign="Left" Text="Display Triage:" EnableViewState="False" Checked="True"></asp:CheckBox>
</div>
<div class="ParamCheckBox">
    <asp:CheckBox id="chkBoxDisplayFamilyService" runat="server" EnableViewState="False" TextAlign="Left" Text="Display Family Services:" Checked="True"></asp:CheckBox>
</div>		   
