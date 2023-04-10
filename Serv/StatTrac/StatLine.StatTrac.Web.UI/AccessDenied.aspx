<%@ Page language="c#" Codebehind="AccessDenied.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.AccessDenied" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicView.ascx" runat="server">
	<mp:content id="cR" runat="server">
		Access Denied.<BR><BR>Please see your Administrative Manager. 
	</mp:content>
</mp:contentcontainer>
