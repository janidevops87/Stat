<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginFailure.aspx.cs" Inherits="Statline.Registry.Web.UI.LoginFailure" %>
<%@ Register Src="Controls/LoginFailureControl.ascx" TagName="LoginFailureControl" TagPrefix="uc1" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages"
    TagPrefix="mp" %>
<mp:ContentContainer ID="cC" runat="server">
    <mp:Content ID="cR" runat="server">
        <uc1:LoginFailureControl id="LoginFailureControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>
