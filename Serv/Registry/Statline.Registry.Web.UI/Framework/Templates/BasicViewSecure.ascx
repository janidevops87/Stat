<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Control CodeBehind="BasicViewSecure.ascx.cs" Language="c#" AutoEventWireup="True" Inherits="Statline.Registry.Web.UI.Framework.Templates.BasicViewSecure" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicView.ascx" runat="server">
	<mp:content id="cR" runat="server">SecureContent</mp:content>
</mp:contentcontainer>
