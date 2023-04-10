<%@ Register TagPrefix="uc1" TagName="MenuControl" Src="../Navigation/MenuControl.ascx" %>
<%@ Control CodeBehind="BasicRegisterMobileView.ascx.cs" Language="c#" AutoEventWireup="True" Inherits="Statline.Registry.Web.UI.Framework.Templates.BasicRegisterMobileView" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicMaster.ascx" runat="server">
	<mp:content id="bCR" runat="server">
		<div><!-- Region Header-->
		<mp:region id="headerRegion" runat="server"></mp:region>
			
		<mp:region id="breadCrumbRegion" runat="server">
			<cc1:BreadCrumb id="breadCrumb" runat="server" CssClass="BreadCrumb" ImageUrl='<%= ResolveUrl("~/images/Menu/Marker01.gif") %>'></cc1:BreadCrumb>
		</mp:region>
                                
		<mp:region id="validationErrorRegion" runat="server">
			<cc1:DataListMessageCollection id="dataListMessageCollection" runat="server"></cc1:DataListMessageCollection>
			<asp:ValidationSummary id="validationSummary" runat="server" ForeColor="" CssClass="Error"></asp:ValidationSummary>
		</mp:region>
        </div>
	<mp:region id="cR" runat="server">&nbsp;</mp:region>
</mp:content>
</mp:contentcontainer>