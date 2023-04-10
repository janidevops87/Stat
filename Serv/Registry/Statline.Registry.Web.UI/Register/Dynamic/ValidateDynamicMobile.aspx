<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ValidateDynamicMobile.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Dynamic.ValidateDynamicMobile" %>
<%@ Register Src="../../Controls/Dynamic/ValidateDynamicMobileControl.ascx" TagName="ValidateDynamicMobileControl"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterMobileView.ascx" runat="server">
    <mp:content id="cR" runat="server">
        <uc1:ValidateDynamicMobileControl id="ValidateDynamicMobileControl2" runat="server">
        </uc1:ValidateDynamicMobileControl>
    </mp:content>
</mp:contentcontainer>
