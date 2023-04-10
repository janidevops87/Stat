<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsTrackingNumberControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsTrackingNumberControl" %>
<div class="ParamLabeldAndControlWrapper">
    <div class="ParamControlLabel" >
        <asp:Label id="trackingNumberFieldLabel" runat="server">Tracking #:</asp:Label>&nbsp;
    </div>
    <div class="ParamControl" >
		<asp:textbox id="txtBoxTrackingNumber" runat="server" EnableViewState="False" width="150px" />
	</div>	
</div>	
