<%@ Page Language="c#" AutoEventWireup="True" Codebehind="GeneralError.aspx.cs" Inherits="Statline.StatTrac.Web.UI.GeneralError" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicView.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<asp:LinkButton id="linkHome" runat="server" onclick="linkHome_Click">continue...</asp:LinkButton>
	</mp:content>
</mp:contentcontainer>
