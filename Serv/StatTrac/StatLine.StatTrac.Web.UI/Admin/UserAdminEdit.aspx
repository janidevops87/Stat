<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Page language="c#" Codebehind="UserAdminEdit.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Admin.UserAdminEdit" %>
<%@ Register TagPrefix="uc1" TagName="UserAdminEditControl" Src="~/Controls/Admin/UserAdminEditControl.ascx" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
<mp:content id="cR" runat="server">
<uc1:UserAdminEditControl id=userAdminEditControl runat="server"></uc1:UserAdminEditControl>
</mp:content>
</mp:contentcontainer>
