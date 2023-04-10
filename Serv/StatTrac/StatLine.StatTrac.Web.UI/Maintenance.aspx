<%@ Page Language="c#" AutoEventWireup="True" Codebehind="Maintenance.aspx.cs" Inherits="Statline.StatTrac.Web.UI.Maintenance" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<asp:Label id="applicationStatusLabel" runat="server" ForeColor="Red"></asp:Label>
	</mp:content>
</mp:contentcontainer>
