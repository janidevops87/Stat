<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsCallControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsCallControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" enableViewState="True"%>
<div class="ParamLabeldAndControlWrapper">
    <div class="ParamControlLabel" >
        <asp:Label id="callIDFieldLabel" runat="server"></asp:Label>&nbsp;#:
    </div>
    <div class="ParamControl" >
		<asp:textbox id="txtBoxCallID" runat="server" EnableViewState="False" width="150px" />
	</div>	
</div>	
