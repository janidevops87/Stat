<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsCAPANumberControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsCAPANumberControl" %>
<div class="ParamLabeldAndControlWrapper">
    <div class="ParamControlLabel" >
        <asp:Label id="capaNumberFieldLabel" runat="server">CAPA #:</asp:Label>&nbsp;
    </div>
    <div class="ParamControl" >
		<asp:textbox id="txtBoxCAPANumber" runat="server" EnableViewState="False" width="150px" />
	</div>	
</div>	
