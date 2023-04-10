<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="Statline.Registry.Web.UI.Logout" %>
<%@ Register Src="Controls/LogoutControl.ascx" TagName="LogoutControl" TagPrefix="uc1" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages"
    TagPrefix="mp" %>

<mp:ContentContainer ID="cC" runat="server">
    <mp:Content ID="cR" runat="server">
        <uc1:LogoutControl ID="LogoutControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>

