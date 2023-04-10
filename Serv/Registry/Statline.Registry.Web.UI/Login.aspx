<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Statline.Registry.Web.UI.Login" %>
<%@ Register Src="Controls/LoginControl.ascx" TagName="LoginControl" TagPrefix="uc1" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages"
    TagPrefix="mp" %>

<mp:ContentContainer ID="cC" runat="server">
    <mp:Content ID="cR" runat="server">
        <uc1:LoginControl ID="LoginControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>

